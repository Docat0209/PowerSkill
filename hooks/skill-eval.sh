#!/bin/bash
# UserPromptSubmit hook: lightweight skill gate reminder (~50 tokens).
# Fires before Claude processes each user message.
# Exit 0 = non-blocking, output injected as system context.

cat <<'EOF'
SKILL GATE: Before acting, check which skills apply:
1. EVALUATE — scan the skill list, decide which are relevant (YES/NO)
2. ACTIVATE — invoke relevant skills with Skill(name) before implementation
3. WORK — only after activation, proceed

Skip evaluation only for pure conversation (no code, no git, no decisions).
EOF
