#!/bin/bash
# PreToolUse hook for Bash: blocks destructive/irreversible operations.
# Exit 2 = block. Uses python for JSON parsing (jq not guaranteed on Windows).

INPUT=$(cat)
CMD=$(echo "$INPUT" | python -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('command',''))" 2>/dev/null)
[ -z "$CMD" ] && exit 0

# --- force push (allow --force-with-lease) ---
if echo "$CMD" | grep -qiE 'git push.*(--force| -f\b)' && ! echo "$CMD" | grep -qi 'force-with-lease'; then
  echo "BLOCKED: Force push prohibited. Use --force-with-lease if necessary, confirm with user first." >&2
  exit 2
fi

# --- reset --hard ---
if echo "$CMD" | grep -qiE 'git reset --hard'; then
  echo "BLOCKED: git reset --hard destroys uncommitted work. Confirm with user first." >&2
  exit 2
fi

# --- discard all changes (checkout/restore) ---
if echo "$CMD" | grep -qiE 'git (checkout|restore) (--staged )?\.$|git checkout -- \.'; then
  echo "BLOCKED: Discards all local changes. Confirm with user first." >&2
  exit 2
fi

# --- delete repo ---
if echo "$CMD" | grep -qiE 'gh repo delete'; then
  echo "BLOCKED: Repository deletion is never allowed." >&2
  exit 2
fi

# --- clean -f ---
if echo "$CMD" | grep -qiE 'git clean.*-f'; then
  echo "BLOCKED: git clean removes untracked files permanently. Confirm with user first." >&2
  exit 2
fi

# --- branch -D (force delete) ---
if echo "$CMD" | grep -qiE 'git branch -D'; then
  echo "BLOCKED: Use git branch -d (lowercase). -D skips merge checks." >&2
  exit 2
fi

# --- --no-verify / --no-gpg-sign (only match as flags, not inside commit messages) ---
# Strip everything after -m "..." to avoid matching text inside commit messages
CMD_FLAGS=$(echo "$CMD" | sed 's/ -m .*//; s/ -m".*//; s/ --message .*//; s/ --message=.*//')
if echo "$CMD_FLAGS" | grep -qiE '\-\-no-verify|\-\-no-gpg-sign'; then
  echo "BLOCKED: Do not skip hooks or signing. Remove the flag." >&2
  exit 2
fi

exit 0
