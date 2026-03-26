#!/bin/bash
# UserPromptSubmit hook: forces visible skill evaluation before every task.
# Exit 0 = non-blocking, output injected as system context.

cat <<'EOF'
SKILL GATE — you MUST evaluate skills before working. Output your evaluation visibly.

Step 1: State which skills are relevant (skill-name: YES/NO + one-line reason).
        Only list YES skills. If none match, state "No skills matched" and proceed.
Step 2: For each YES, invoke Skill(name) before doing any work.
Step 3: Only after Step 2, proceed with the task.

Skip ONLY for pure conversation (no code, no git, no decisions, no business).
EOF
