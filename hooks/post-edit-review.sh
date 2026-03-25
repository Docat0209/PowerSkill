#!/bin/bash
# PostToolUse hook for Write/Edit: runs quality checks after edits.
# Cannot block (edit already happened), but provides feedback to Claude.

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""' 2>/dev/null)
[ -z "$FILE" ] && exit 0

ISSUES=""

# --- Source code checks ---
if echo "$FILE" | grep -qE '\.(ts|tsx|js|jsx|py|go|rs|java|kt|cs|c|cpp|rb|php|swift|vue|svelte)$'; then

  # Debug statements
  if grep -qE '(console\.log|console\.debug|print\(|debugger|binding\.pry|pdb\.set_trace|breakpoint\(\))' "$FILE" 2>/dev/null; then
    ISSUES="${ISSUES}\n- Debug statements detected in $FILE"
  fi

  # TODO/FIXME left behind
  if grep -qE '(TODO|FIXME|HACK|XXX):' "$FILE" 2>/dev/null; then
    ISSUES="${ISSUES}\n- TODO/FIXME comments found in $FILE"
  fi

  # Hardcoded secrets (expanded patterns)
  if grep -qEi '(password|secret|api_key|apikey|token|private_key|access_key|client_secret|database_url|connection_string)\s*[:=]\s*["\x27][^"\x27]{8,}' "$FILE" 2>/dev/null; then
    ISSUES="${ISSUES}\n- Possible hardcoded secret in $FILE"
  fi

  # Bearer tokens in code
  if grep -qE 'Bearer [A-Za-z0-9_\-\.]{20,}' "$FILE" 2>/dev/null; then
    ISSUES="${ISSUES}\n- Possible hardcoded Bearer token in $FILE"
  fi
fi

# --- Config/env file checks ---
if echo "$FILE" | grep -qE '(\.env|\.env\..+|\.secret|credentials)$'; then
  ISSUES="${ISSUES}\n- WARNING: Sensitive config file modified: $FILE — ensure it is in .gitignore"
fi

if [ -n "$ISSUES" ]; then
  echo -e "Post-edit quality check:$ISSUES" >&2
fi

exit 0
