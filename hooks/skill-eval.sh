#!/bin/bash
# UserPromptSubmit hook: forces visible skill evaluation before every task.
# Exit 0 = non-blocking, output injected as system context.

cat <<'EOF'
SKILL GATE — MANDATORY. Violations are process failures.

Step 1: List relevant skills (skill-name: YES + reason). If none, say "No skills matched."
Step 2: For EACH YES skill, call the Skill tool: Skill(name="skill-name")
        ⚠️  Writing "pre-code: YES" as text is NOT invoking it. You MUST use the Skill() tool call.
        ⚠️  If you skip this step, every downstream action (code, commit, PR) is invalid.
Step 3: Only AFTER all Skill() calls complete, proceed with work.

After completing work: REPORT results to the user using the skill's standard format.
Then SUGGEST the next step — but do NOT auto-execute it. The user decides what's next.

Exception: Phase 4 BUILD inner loop (pre-code → code → self-review → test-gate → pre-commit → pre-pr → merge) runs autonomously when the user asks to build an issue. Report after each issue completes.

Skip ONLY for pure conversation (no code, no git, no decisions).
EOF
