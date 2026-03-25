#!/bin/bash
# Stop hook: checks if the assistant's response contains rationalization patterns.
# Reads the transcript and checks the last assistant message.
# Exit 0 = allow stop. Exit 2 = block (send back to work).

INPUT=$(cat)
TRANSCRIPT=$(echo "$INPUT" | jq -r '.transcript_path // ""' 2>/dev/null)

# If no transcript available, allow
[ -z "$TRANSCRIPT" ] || [ ! -f "$TRANSCRIPT" ] && exit 0

# Get the last ~2000 chars of the transcript (the final response)
TAIL=$(tail -c 2000 "$TRANSCRIPT" 2>/dev/null)

# Check for rationalization patterns
FOUND=""

echo "$TAIL" | grep -qi "pre-existing\|pre existing" && FOUND="claiming issues are pre-existing"
echo "$TAIL" | grep -qi "out of scope" && FOUND="deferring as out of scope"
echo "$TAIL" | grep -qi "follow.up task\|future improvement\|follow-up" && echo "$TAIL" | grep -qiv "post-merge\|post_merge\|checklist" && FOUND="deferring to follow-up without doing the work"
echo "$TAIL" | grep -qi "too many issues\|too many problems" && FOUND="using 'too many issues' as excuse"
echo "$TAIL" | grep -qi "good enough for now\|good enough as" && FOUND="accepting low quality"

if [ -n "$FOUND" ]; then
  echo "Rationalization detected: $FOUND. Go back and finish the work properly." >&2
  exit 2
fi

exit 0
