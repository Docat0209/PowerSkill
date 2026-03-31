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

This applies even when:
- Resuming from a previous session or summary
- A sub-agent failed and you're taking over manually
- The task feels urgent or simple
- You've already evaluated skills in text

No exceptions. No shortcuts. The process exists because skipping it causes real failures.
EOF
