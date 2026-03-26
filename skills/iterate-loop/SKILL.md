---
name: iterate-loop
description: "Runs automatic product quality iteration. Triggers ONLY when: product-eval returns a score below 70, or user explicitly asks to iterate on product quality. Do NOT trigger during normal development or discussions about quality."
---

# Iterate Loop

Self-driving improvement loop: evaluate → prioritize → fix → re-evaluate → learn.
Continues automatically until score >= 70 or max 3 rounds.

## Entry Conditions

Activate when ANY of these are true:
- `product-eval` score is below 70
- User says "iterate", "improve this", "make it better", or similar
- `biz-think` identifies a gap between current product and business requirements

## The Loop

```
TARGET_SCORE = 70
MAX_ROUNDS = 3
```

### ROUND N (repeat until exit):

**Step 1 — EVALUATE**
- If no product-eval report exists from the last 10 minutes, invoke `Skill(product-eval)` now
- Read the report: total score, per-dimension scores, priority issues list
- Store the score as `previous_score` (first round) or compare against it (subsequent rounds)

**Step 2 — PRIORITIZE**
- Take the top 3 issues by severity from the evaluation report
- For each issue, determine:
  - What to change (concrete action, not vague)
  - Which files to touch
  - Expected impact on score
- Print a brief plan (2-3 lines per issue, not full plan mode)
- If any issue requires a user decision (business logic, design choice, API keys), STOP and ask

**Step 3 — FIX**
- Fix issues ONE AT A TIME, in priority order:
  1. Write or edit the code
  2. Invoke `Skill(self-review)` on the changed files
  3. Run tests via `Skill(test-gate)` to verify no regression
  4. If tests fail, REVERT the change immediately and move to the next issue
  5. Commit the fix via `Skill(pre-commit)` — one atomic commit per fix
- Never batch multiple fixes into one commit

**Step 4 — RE-EVALUATE**
- Invoke `Skill(product-eval)` on the updated product
- Compare: new score vs `previous_score`
- Log delta per dimension (e.g., "FTUE: 12 → 17 (+5)")

**Step 5 — LEARN**
- Store in Knowledge Graph MCP for each fixed issue:
  - Entity: the issue (e.g., "Missing loading state on dashboard")
  - Relation: `fixed_by` → the change made
  - Observation: score impact (e.g., "+5 points on FTUE dimension")
- This builds a reusable knowledge base of high-impact improvements

**Step 6 — CHECK**
- Score >= 70 → EXIT loop, produce exit report
- Score < 70 AND round < 3 → set `previous_score` = current score, CONTINUE
- Score < 70 AND round = 3 → EXIT loop, produce exit report with remaining issues

## Exit Report

Print this summary when the loop ends:

```
## Iteration Summary
Rounds completed: N
Starting score: X/100 → Final score: Y/100
Improvements made:
  1. [issue] → [fix] → [+/- score impact]
  2. ...
Remaining issues (if score still < 70):
  1. [issue] — reason it was not fixed (user decision / external dep / out of scope)
Knowledge Graph entries created: N
```

## Safety Rules

- **Max 3 rounds** — hard cap, no exceptions, prevents infinite loops
- **Self-review every fix** — no quality shortcuts even under automation
- **Revert on test failure** — if a fix breaks anything, undo it immediately
- **Stop on user-input issues** — business decisions, missing credentials, design choices require human input
- **Respect scope** — do not fix issues outside the current PR or feature boundary
- **No force pushes** — all commits go through normal flow

## Skill Dependencies

| Skill | Purpose |
|-------|---------|
| `product-eval` | Scoring before and after each round |
| `self-review` | Code quality gate on every fix |
| `test-gate` | Regression check after every fix |
| `pre-commit` | Atomic commits for each fix |
| Knowledge Graph MCP | Persistent learning across iterations |
