#!/usr/bin/env bash
set -euo pipefail

# ── SoloForge Installer ─────────────────────────────────────────────
# Copies skills, hooks, claude.md, and hooks.json into ~/.claude/
# Works on macOS, Linux, and Windows (Git Bash / MSYS2)
# ─────────────────────────────────────────────────────────────────────

# ── Colors (degrade gracefully) ──────────────────────────────────────
if [ -t 1 ] && command -v tput >/dev/null 2>&1 && [ "$(tput colors 2>/dev/null || printf '0')" -ge 8 ]; then
  GREEN=$(tput setaf 2)
  YELLOW=$(tput setaf 3)
  RED=$(tput setaf 1)
  BOLD=$(tput bold)
  RESET=$(tput sgr0)
else
  GREEN="" YELLOW="" RED="" BOLD="" RESET=""
fi

info()  { printf "%s[INFO]%s  %s\n" "$GREEN"  "$RESET" "$1"; }
warn()  { printf "%s[WARN]%s  %s\n" "$YELLOW" "$RESET" "$1"; }
error() { printf "%s[ERROR]%s %s\n" "$RED"    "$RESET" "$1"; }
header(){ printf "\n%s%s%s\n" "$BOLD" "$1" "$RESET"; }

# ── Resolve script directory (works with symlinks) ───────────────────
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
BACKUP_DIR="$CLAUDE_DIR/backup-soloforge-$TIMESTAMP"
BACKUP_CREATED=false

ensure_backup_dir() {
  if [ "$BACKUP_CREATED" = false ]; then
    mkdir -p "$BACKUP_DIR"
    BACKUP_CREATED=true
  fi
}

# ── Preflight check ─────────────────────────────────────────────────
header "SoloForge Installer"

if [ ! -d "$CLAUDE_DIR" ]; then
  error "~/.claude/ directory not found."
  error "Please install Claude Code first: https://docs.anthropic.com/en/docs/claude-code"
  exit 1
fi

info "Found ~/.claude/ — proceeding with installation."

# ── Track what we install ────────────────────────────────────────────
SKILLS_INSTALLED=0
SKILLS_SKIPPED=0
HOOKS_INSTALLED=0
HOOKS_BACKED_UP=0

# ── Install skills ───────────────────────────────────────────────────
header "Installing skills..."

mkdir -p "$CLAUDE_DIR/skills"

for skill_dir in "$SOURCE_DIR"/skills/*/; do
  [ -d "$skill_dir" ] || continue
  skill_name=$(basename "$skill_dir")

  if [ -d "$CLAUDE_DIR/skills/$skill_name" ]; then
    warn "Skill '$skill_name' already exists — skipping."
    SKILLS_SKIPPED=$((SKILLS_SKIPPED + 1))
  else
    cp -r "$skill_dir" "$CLAUDE_DIR/skills/$skill_name"
    info "Installed skill: $skill_name"
    SKILLS_INSTALLED=$((SKILLS_INSTALLED + 1))
  fi
done

# ── Install hooks ────────────────────────────────────────────────────
header "Installing hooks..."

mkdir -p "$CLAUDE_DIR/hooks"

for hook_file in "$SOURCE_DIR"/hooks/*; do
  [ -f "$hook_file" ] || continue
  hook_name=$(basename "$hook_file")

  if [ -f "$CLAUDE_DIR/hooks/$hook_name" ]; then
    ensure_backup_dir
    cp "$CLAUDE_DIR/hooks/$hook_name" "$BACKUP_DIR/$hook_name"
    warn "Backed up existing hook: $hook_name → backup-soloforge-$TIMESTAMP/"
    HOOKS_BACKED_UP=$((HOOKS_BACKED_UP + 1))
  fi

  cp "$hook_file" "$CLAUDE_DIR/hooks/$hook_name"
  chmod +x "$CLAUDE_DIR/hooks/$hook_name"
  info "Installed hook: $hook_name"
  HOOKS_INSTALLED=$((HOOKS_INSTALLED + 1))
done

# ── Install rules ────────────────────────────────────────────────────
header "Installing rules..."

RULES_INSTALLED=0
mkdir -p "$CLAUDE_DIR/rules"

for rule_file in "$SOURCE_DIR"/rules/*.md; do
  [ -f "$rule_file" ] || continue
  rule_name=$(basename "$rule_file")
  cp "$rule_file" "$CLAUDE_DIR/rules/$rule_name"
  info "Installed rule: $rule_name"
  RULES_INSTALLED=$((RULES_INSTALLED + 1))
done

# ── Install claude.md ────────────────────────────────────────────────
header "Installing CLAUDE.md..."

if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
  ensure_backup_dir
  cp "$CLAUDE_DIR/CLAUDE.md" "$BACKUP_DIR/CLAUDE.md"
  warn "Existing CLAUDE.md backed up to backup-soloforge-$TIMESTAMP/"
  warn "Your existing CLAUDE.md was NOT overwritten."
  warn "Please merge manually: diff ~/.claude/CLAUDE.md $SOURCE_DIR/claude.md"
else
  cp "$SOURCE_DIR/claude.md" "$CLAUDE_DIR/CLAUDE.md"
  info "Installed CLAUDE.md"
fi

# ── Merge hooks.json into settings.json ──────────────────────────────
header "Merging hooks config into settings.json..."

SETTINGS_FILE="$CLAUDE_DIR/settings.json"
HOOKS_JSON="$SOURCE_DIR/settings/hooks.json"

if [ ! -f "$HOOKS_JSON" ]; then
  error "hooks.json not found at $HOOKS_JSON — skipping hooks config merge."
else
  # Use python3 or python, whichever is available
  PYTHON=""
  if command -v python3 >/dev/null 2>&1; then
    PYTHON="python3"
  elif command -v python >/dev/null 2>&1; then
    PYTHON="python"
  fi

  if [ -z "$PYTHON" ]; then
    error "Python not found. Cannot merge hooks.json into settings.json."
    error "Please manually merge $HOOKS_JSON into $SETTINGS_FILE"
  else
    if [ -f "$SETTINGS_FILE" ]; then
      ensure_backup_dir
      cp "$SETTINGS_FILE" "$BACKUP_DIR/settings.json"
      warn "Backed up existing settings.json → backup-soloforge-$TIMESTAMP/"
    fi

    "$PYTHON" - "$SETTINGS_FILE" "$HOOKS_JSON" <<'PYEOF'
import json
import sys
import os

settings_path = sys.argv[1]
hooks_path = sys.argv[2]

# Load existing settings or start fresh
if os.path.exists(settings_path):
    with open(settings_path, "r", encoding="utf-8") as f:
        try:
            settings = json.load(f)
        except json.JSONDecodeError:
            print("Warning: existing settings.json is invalid JSON — creating fresh.", file=sys.stderr)
            settings = {}
else:
    settings = {}

# Load hooks config
with open(hooks_path, "r", encoding="utf-8") as f:
    hooks_data = json.load(f)

# Merge: overwrite the "hooks" key, preserve everything else
settings["hooks"] = hooks_data["hooks"]

with open(settings_path, "w", encoding="utf-8") as f:
    json.dump(settings, f, indent=2, ensure_ascii=False)
    f.write("\n")

PYEOF

    info "Merged hooks config into settings.json"
  fi
fi

# ── Clean up empty backup dir ────────────────────────────────────────
if [ "$BACKUP_CREATED" = false ] && [ -d "$BACKUP_DIR" ]; then
  rmdir "$BACKUP_DIR" 2>/dev/null || true
fi

# ── Recommended MCP servers ──────────────────────────────────────────
header "Recommended MCP servers (install manually):"
printf "  claude mcp add sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking\n"
printf "  claude mcp add playwright -- npx @playwright/mcp@latest\n"

# ── Summary ──────────────────────────────────────────────────────────
header "Installation complete!"
info "Skills installed: $SKILLS_INSTALLED"
if [ "$SKILLS_SKIPPED" -gt 0 ]; then
  warn "Skills skipped (already exist): $SKILLS_SKIPPED"
fi
info "Rules installed: $RULES_INSTALLED"
info "Hooks installed: $HOOKS_INSTALLED"
if [ "$HOOKS_BACKED_UP" -gt 0 ]; then
  info "Hooks backed up: $HOOKS_BACKED_UP"
fi
if [ "$BACKUP_CREATED" = true ]; then
  info "Backups saved to: $BACKUP_DIR"
fi
printf "\n"
