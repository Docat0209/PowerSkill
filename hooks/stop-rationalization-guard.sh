#!/bin/bash
# Stop hook: checks if the assistant's response contains rationalization patterns.
# Uses python for JSON parsing (jq not guaranteed on Windows).
# Exit 0 = allow stop. Exit 2 = block (send back to work).

INPUT=$(cat)
TRANSCRIPT=$(echo "$INPUT" | python -c "import sys,json; d=json.load(sys.stdin); print(d.get('transcript_path',''))" 2>/dev/null)

[ -z "$TRANSCRIPT" ] || [ ! -f "$TRANSCRIPT" ] && exit 0

TAIL=$(tail -c 2000 "$TRANSCRIPT" 2>/dev/null)

FOUND=""
echo "$TAIL" | grep -qi "pre-existing\|pre existing" && FOUND="claiming issues are pre-existing"
echo "$TAIL" | grep -qi "out of scope" && FOUND="deferring as out of scope"
echo "$TAIL" | grep -qi "too many issues\|too many problems" && FOUND="using 'too many issues' as excuse"
echo "$TAIL" | grep -qi "good enough for now\|good enough as" && FOUND="accepting low quality"

if [ -n "$FOUND" ]; then
  echo "Rationalization detected: $FOUND. Go back and finish the work properly." >&2
  exit 2
fi

exit 0
