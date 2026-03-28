#!/usr/bin/env bash
set -euo pipefail

# ── SoloForge Uninstaller ────────────────────────────────────────────
# Removes only SoloForge-managed files from ~/.claude/
# Does NOT touch CLAUDE.md (user may have customized it)
# ──────────────────────────────────────────────────────────────────────

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

CLAUDE_DIR="$HOME/.claude"

header "SoloForge Uninstaller"

if [ ! -d "$CLAUDE_DIR" ]; then
  error "~/.claude/ directory not found. Nothing to uninstall."
  exit 1
fi

REMOVED=0

# ── Remove SoloForge skills ─────────────────────────────────────────
header "Removing skills..."

SKILLS=(
  biz-think
  biz-validate
  brand-build
  community-engage
  content-create
  content-distribute
  copy-craft
  data-decide
  finance-ops
  growth-track
  infra-ops
  issue-create
  legal-guard
  post-merge
  pre-code
  pre-commit
  pre-pr
  product-eval
  project-init
  roadmap-steer
  sales-close
  search-eval
  self-review
  staging-verify
  support-ops
  test-gate
  ux-audit
  work-breakdown
)

for skill in "${SKILLS[@]}"; do
  if [ -d "$CLAUDE_DIR/skills/$skill" ]; then
    rm -rf "$CLAUDE_DIR/skills/$skill"
    info "Removed skill: $skill"
    REMOVED=$((REMOVED + 1))
  else
    warn "Skill not found (already removed?): $skill"
  fi
done

# ── Remove SoloForge hooks ──────────────────────────────────────────
header "Removing hooks..."

HOOKS=(
  safety-guard.sh
  post-edit-review.sh
)

for hook in "${HOOKS[@]}"; do
  if [ -f "$CLAUDE_DIR/hooks/$hook" ]; then
    rm "$CLAUDE_DIR/hooks/$hook"
    info "Removed hook: $hook"
    REMOVED=$((REMOVED + 1))
  else
    warn "Hook not found (already removed?): $hook"
  fi
done

# ── Remove hooks config from settings.json ───────────────────────────
header "Cleaning settings.json..."

SETTINGS_FILE="$CLAUDE_DIR/settings.json"

if [ ! -f "$SETTINGS_FILE" ]; then
  warn "settings.json not found — nothing to clean."
else
  PYTHON=""
  if command -v python3 >/dev/null 2>&1; then
    PYTHON="python3"
  elif command -v python >/dev/null 2>&1; then
    PYTHON="python"
  fi

  if [ -z "$PYTHON" ]; then
    error "Python not found. Cannot clean settings.json."
    error "Please manually remove the \"hooks\" key from $SETTINGS_FILE"
  else
    "$PYTHON" - "$SETTINGS_FILE" <<'PYEOF'
import json
import sys
import os

settings_path = sys.argv[1]

if not os.path.exists(settings_path):
    sys.exit(0)

with open(settings_path, "r", encoding="utf-8") as f:
    try:
        settings = json.load(f)
    except json.JSONDecodeError:
        print("Warning: settings.json is invalid JSON — leaving it alone.", file=sys.stderr)
        sys.exit(0)

if "hooks" not in settings:
    sys.exit(0)

del settings["hooks"]

if settings:
    with open(settings_path, "w", encoding="utf-8") as f:
        json.dump(settings, f, indent=2, ensure_ascii=False)
        f.write("\n")
else:
    # If settings is now empty, write empty object
    with open(settings_path, "w", encoding="utf-8") as f:
        f.write("{}\n")

PYEOF

    info "Removed hooks config from settings.json"
    REMOVED=$((REMOVED + 1))
  fi
fi

# ── Summary ──────────────────────────────────────────────────────────
header "Uninstall complete!"
info "Items removed: $REMOVED"
warn "CLAUDE.md was NOT touched (may contain your customizations)."
printf "\n"
