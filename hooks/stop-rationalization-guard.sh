#!/bin/bash
# Stop hook: blocks responses that rationalize incomplete work.
# Uses python for JSON parsing. Exit 0 = allow. Exit 2 = block.
# Requires 2+ rationalization patterns to trigger (single match may be a quote/reference).

INPUT=$(cat)
TRANSCRIPT=$(echo "$INPUT" | python -c "import sys,json; d=json.load(sys.stdin); print(d.get('transcript_path',''))" 2>/dev/null)

[ -z "$TRANSCRIPT" ] || [ ! -f "$TRANSCRIPT" ] && exit 0

TAIL=$(tail -c 2000 "$TRANSCRIPT" 2>/dev/null)

COUNT=0
echo "$TAIL" | grep -qi "pre-existing\|pre existing" && COUNT=$((COUNT+1))
echo "$TAIL" | grep -qi "out of scope" && COUNT=$((COUNT+1))
echo "$TAIL" | grep -qi "too many issues\|too many problems" && COUNT=$((COUNT+1))
echo "$TAIL" | grep -qi "good enough for now\|good enough as" && COUNT=$((COUNT+1))
echo "$TAIL" | grep -qi "follow.up task\|future improvement" && COUNT=$((COUNT+1))
echo "$TAIL" | grep -qi "not worth fixing\|leave it for now\|skip for now" && COUNT=$((COUNT+1))

if [ "$COUNT" -ge 2 ]; then
  echo "Rationalization detected ($COUNT patterns matched). Go back and finish the work properly." >&2
  exit 2
fi

exit 0
