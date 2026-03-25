#!/bin/bash
# PreToolUse hook for Bash: blocks destructive/irreversible operations.
# Exit 2 = block. Non-dangerous workflow enforcement is in CLAUDE.md + Skills.

INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // ""' 2>/dev/null)
[ -z "$CMD" ] && exit 0

# --- force push (allow --force-with-lease) ---
if echo "$CMD" | grep -qE 'git push.*(--force|[ ]-f)' && ! echo "$CMD" | grep -q 'force-with-lease'; then
  echo "BLOCKED: Force push prohibited. Use --force-with-lease if necessary, confirm with user first." >&2
  exit 2
fi

# --- reset --hard ---
if echo "$CMD" | grep -qE 'git reset --hard'; then
  echo "BLOCKED: git reset --hard destroys uncommitted work. Confirm with user first." >&2
  exit 2
fi

# --- discard all changes (checkout/restore) ---
if echo "$CMD" | grep -qE 'git (checkout|restore) (--staged )?\.$|git checkout -- \.'; then
  echo "BLOCKED: Discards all local changes. Confirm with user first." >&2
  exit 2
fi

# --- delete repo ---
if echo "$CMD" | grep -qE 'gh repo delete'; then
  echo "BLOCKED: Repository deletion is never allowed." >&2
  exit 2
fi

# --- clean -f ---
if echo "$CMD" | grep -qE 'git clean.*-f'; then
  echo "BLOCKED: git clean removes untracked files permanently. Confirm with user first." >&2
  exit 2
fi

# --- branch -D (force delete) ---
if echo "$CMD" | grep -qE 'git branch -D'; then
  echo "BLOCKED: Use git branch -d (lowercase). -D skips merge checks." >&2
  exit 2
fi

# --- --no-verify ---
if echo "$CMD" | grep -qE -- '--no-verify|--no-gpg-sign'; then
  echo "BLOCKED: Do not skip hooks or signing. Remove the flag." >&2
  exit 2
fi

# --- touch sensitive dirs ---
if echo "$CMD" | grep -qE '(~|/home/|/Users/).*(/\.ssh/|/\.gnupg/|/\.aws/|/\.kube/)'; then
  echo "BLOCKED: Do not touch credential directories." >&2
  exit 2
fi

exit 0
