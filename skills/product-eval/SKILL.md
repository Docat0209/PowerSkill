---
name: product-eval
description: "Scores product quality from user perspective (/100) and auto-iterates if below threshold. Triggers ONLY when: user explicitly asks to evaluate the product, after ux-audit completes, or score is below 70 and iteration is needed. Do NOT trigger during development or when discussing product quality conceptually."
---

# Product Evaluation Skill

Evaluate the product from a real user's perspective. Produce a numerical score across 4 dimensions (total /100). Threshold to pass: **70/100**.

## Prerequisites

1. If `ux-audit` has already been run for this PR, use its results (screenshots, performance metrics, interaction findings) as input. Do NOT re-run the same checks — build on what ux-audit already verified.
2. Start the dev server or confirm the deployed app URL is accessible.
2. Use **Playwright MCP** to navigate, interact, and screenshot every screen evaluated.
3. Adopt the **target user's persona** — their technical level, goals, context. Do NOT evaluate as a developer.

## Phase 0: User Research (before scoring)

Conduct user research BEFORE scoring dimensions. Real user data prevents you from evaluating in a vacuum.

### The Mom Test (Rob Fitzpatrick)
Never ask "Would you use this?" or "Do you think this is a good idea?" — people lie to be polite. Instead, ask about their life, their problems, their current behavior. Talk about specifics in the past, not hypotheticals about the future. Talk less, listen more.

### 5 Interview Questions That Work
1. "What's the hardest part about [task this product solves]?"
2. "Tell me about the last time that happened — walk me through it"
3. "What have you tried so far to solve it?"
4. "What don't you love about [their current solution]?"
5. "If you had a magic wand, what would it do?"

Avoid: generic claims ("I usually..."), future promises ("I would..."), and hypothetical maybes ("I might..."). These are worthless signals.

### Guerrilla Usability Testing
Give 3-5 users a specific task (e.g., "sign up and create your first project"). Watch silently — do not help. Note where they hesitate, click wrong things, or ask questions. Each confusion point = a usability issue. Sessions should be under 15 minutes. You only need 3-5 participants to surface the most critical problems.

### When to Run User Research
- **Before product-eval scoring** — use findings to inform dimension scores
- **After major feature releases** — validate that the feature solves the intended problem
- **When churn spikes** — exit interviews reveal why users leave

Store all findings in **Knowledge Graph MCP** under entity type `UserResearch` with: date, participant count, method (interview/usability test), and top 3 findings.

## Dimension 1: Usability (30 points) — Nielsen's 10 Heuristics

Source: Jakob Nielsen, "10 Usability Heuristics for User Interface Design" (1994, updated 2020).

For each heuristic, navigate the app, check for violations, and rate severity on Nielsen's 0-4 scale:
- 0 = not a problem, 1 = cosmetic, 2 = minor, 3 = major, 4 = catastrophe

| # | Heuristic | What to check |
|---|-----------|---------------|
| 1 | Visibility of system status | Loading indicators, progress bars, state feedback |
| 2 | Match between system and real world | Jargon-free labels, familiar icons, logical ordering |
| 3 | User control and freedom | Undo/redo, cancel, back navigation, exit points |
| 4 | Consistency and standards | Same action = same result everywhere, platform conventions |
| 5 | Error prevention | Confirmations on destructive actions, input constraints, defaults |
| 6 | Recognition rather than recall | Visible options, contextual info, no memorization required |
| 7 | Flexibility and efficiency of use | Shortcuts for experts, customizable workflows |
| 8 | Aesthetic and minimalist design | No irrelevant info, clear visual hierarchy, whitespace |
| 9 | Help users recognize, diagnose, recover from errors | Plain-language errors, specific cause, constructive suggestion |
| 10 | Help and documentation | Searchable, task-oriented, concise, accessible when needed |

**Score:** 30 minus the sum of all severity ratings. If any single heuristic scores severity 4 (catastrophe), the entire dimension scores **0/30** regardless of the sum.

## Dimension 2: Learnability (25 points) — Cognitive Walkthrough

Source: Wharton, Rieman, Lewis & Polson, "The Cognitive Walkthrough Method" (1994).

1. Pick **3-5 critical user tasks** (the tasks a new user must complete to get value).
2. For each task, list every discrete step a novice user must take.
3. At each step, answer these 4 questions:
   - Q1: Will the user try to achieve the right effect?
   - Q2: Will the user notice the correct action is available?
   - Q3: Will the user associate the correct action with the desired effect?
   - Q4: Will the user see that progress is being made toward their goal?
4. A step **passes** only if all 4 answers are Yes.

**Score:** (passing steps / total steps) x 25. Target: 80%+ steps pass.

## Dimension 3: First-Time Experience (25 points) — FTUE Audit

Evaluate as a brand-new user arriving with zero context.

| Criteria | Scoring |
|----------|---------|
| **Time-to-Value** — how long until the user gets real value | <=2 min: 10 pts, <=5 min: 7 pts, >5 min: 3 pts |
| **Value proposition clarity** — does the user immediately understand what this does and why it matters | Immediately obvious: 5 pts, Requires reading: 3 pts, Unclear: 0 pts |
| **Steps to first success** — count clicks/inputs to complete the primary task once | <=3 steps: 5 pts, 4-6 steps: 3 pts, >6 steps: 1 pt |
| **Onboarding quality** — how is the user guided through their first experience | Contextual guidance: 5 pts, Generic walkthrough: 3 pts, None: 0 pts |

**Score:** Sum of all four criteria (max 25).

## Dimension 4: Engagement Signals (20 points) — Google HEART Framework

Source: Google HEART framework (Rodden, Hutchinson & Fu, 2010). This is a design-time assessment, not analytics-based.

Rate each signal 1-5 based on what you observe in the product:

- **Happiness (1-5):** Would a user feel satisfied after using this? Would they recommend it?
- **Engagement (1-5):** Is there a reason to come back? Is the core loop compelling?
- **Adoption (1-5):** Would new users complete onboarding? Is the barrier low enough?
- **Retention (1-5):** What would bring users back tomorrow? Next week? Is there a hook?
- **Task Success (1-5):** Can users complete their primary task without frustration or confusion?

**Score:** (sum of all 5 ratings / 25) x 20. Max 20 points.

## Scoring and Grading

**Total: Usability + Learnability + FTUE + Engagement = X / 100**

| Score | Grade | Action |
|-------|-------|--------|
| 90-100 | A | Ship with confidence |
| 80-89 | B | Ship, minor polish recommended |
| 70-79 | C | Ship with known issues documented |
| 60-69 | D | Do NOT ship — fix priority issues first |
| < 60 | F | Major rework needed — re-run iteration protocol below after fixes |

**Pass threshold: 70/100.** Below 70 → enter the Iteration Protocol below.

## Output Format

```
## Product Evaluation Report
Dimension 1: Usability — X/30
  [list each violated heuristic with severity rating and evidence]
Dimension 2: Learnability — X/25
  [list each task, steps, and which steps failed with reason]
Dimension 3: First-Time Experience — X/25
  [time-to-value measurement, steps to first success count, onboarding assessment]
Dimension 4: Engagement Signals — X/20
  [each HEART signal with rating and justification]

TOTAL: X/100 (Grade: X)
Priority issues: [top 3 by severity — what to fix first]
```

## After Scoring

Store the evaluation result in **Knowledge Graph MCP** with: timestamp, total score, per-dimension scores, grade, and the top 3 priority issues.

---

## Iteration Protocol (if score < 70)

When the score is below 70, enter this auto-fix loop. **Max 3 rounds.**

### Each Round:

1. **PRIORITIZE** — Take top 3 issues by severity from the evaluation report. For each: concrete action, files to touch, expected score impact.

2. **FIX** — One issue at a time:
   - Write/edit the code
   - Invoke `self-review` on changed files
   - Run `test-gate` to verify no regression
   - If tests fail → revert immediately, move to next issue
   - Commit via `pre-commit` — one atomic commit per fix

3. **RE-EVALUATE** — Re-run the 4 dimensions above on the updated product. Compare: new score vs previous. Log delta per dimension.

4. **LEARN** — Store in Knowledge Graph MCP: issue fixed, change made, score impact (e.g., "+5 on FTUE"). Builds a reusable knowledge base of high-impact improvements.

5. **CHECK** — Score ≥ 70 → exit. Score < 70 AND round < 3 → continue. Round = 3 → exit with remaining issues listed.

### Exit Report
```
## Iteration Summary
Rounds completed: N
Starting score: X/100 → Final score: Y/100
Improvements made:
  1. [issue] → [fix] → [score impact]
Remaining issues (if still < 70):
  1. [issue] — reason not fixed
```

### Safety Rules
- Max 3 rounds — hard cap, prevents infinite loops
- Self-review every fix — no quality shortcuts under automation
- Revert on test failure — undo immediately if anything breaks
- Stop on user-input issues — business decisions, missing credentials require human input

## Next Steps
After completing this skill, create tasks for applicable next steps using TaskCreate:
- Score >= 70, product ready for users → create task: "invoke `copy-craft` — write landing page conversion copy"
- Ready to announce → create task: "invoke `content-create` — create launch content"
- Need to decide what to build next → create task: "invoke `roadmap-steer` — prioritize next features"

Only create tasks that are actually relevant. Do not create tasks for steps that don't apply to the current situation.
