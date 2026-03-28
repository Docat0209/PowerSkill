---
name: biz-validate
description: "Runs iterative hypothesis validation loop. Triggers ONLY when: biz-think acid test fails, user explicitly asks to validate a business assumption, or user says to pivot. Do NOT trigger when: discussing business strategy casually or during product development."
---

# biz-validate: Business Hypothesis Validation Loop

A cyclical SOP based on Running Lean (Ash Maurya), Pretotyping (Alberto Savoia), and Hypothesis-Driven Entrepreneurship (HBS). This skill LOOPS — it does not run once and stop.

**Framework sources:**
- Running Lean 3rd Ed (Ash Maurya) — macro stages: Problem/Solution Fit → Product/Market Fit → Scale
- Pretotyping (Alberto Savoia, Google) — behavioral proof before building
- Reflect-Inquire-Learn (Eisenmann/Ries, HBS) — single experiment cycle

---

## Entry Conditions

Run this skill when:
- `biz-think` acid test fails (cannot complete the one-sentence answer)
- An assumption in the business model needs validation
- Pivoting after a failed experiment
- User says "validate this" or "test this idea"

---

## The Loop: Reflect → Hypothesize → Experiment → Learn → Update

```
     ┌─────────────────────────────────────┐
     │                                     │
     ▼                                     │
  REFLECT                                  │
  What is the riskiest assumption?         │
     │                                     │
     ▼                                     │
  HYPOTHESIZE                              │
  "At least X% of [target] will            │
   [action] if [condition]"                │
     │                                     │
     ▼                                     │
  EXPERIMENT                               │
  Run the cheapest possible test            │
  (hours, not weeks)                       │
     │                                     │
     ▼                                     │
  LEARN                                    │
  Did we hit the threshold?                │
     │                                     │
     ├── NO → Pivot or kill ──────────────►│
     │         Update canvas, re-enter     │
     │                                     │
     ├── YES → Next assumption ───────────►│
     │                                     │
     └── ALL VALIDATED → EXIT ─────────────┘
```

**Max iterations:** 5 per assumption. If an assumption cannot be validated in 5 cycles, kill the idea or pivot the fundamental approach.

---

## Step 1: REFLECT — Identify the Riskiest Assumption

List all assumptions the business model depends on. Rank by:
- **Impact if wrong:** would this kill the business? (High/Medium/Low)
- **Uncertainty:** how confident are we? (Guess/Belief/Tested)

Pick the assumption that is High-impact AND Guess/Belief. This is what you test first.

Common assumption categories:
- **Problem assumption:** "This problem exists and is painful enough to pay to solve"
- **Solution assumption:** "Our solution actually solves this problem"
- **Pricing assumption:** "They will pay $X for this"
- **Channel assumption:** "We can reach them through [channel]"
- **Retention assumption:** "They will keep using this after the first time"

---

## Step 2: HYPOTHESIZE — Write a Testable XYZ Hypothesis

Format (Savoia's Pretotyping):
> "At least **X%** of **[target audience]** will **[desired action]** if **[condition/offering]**"

Rules:
- X must be a specific number, not "some" or "many"
- Target audience must be concrete, not "developers" but "DevOps engineers who use Terraform"
- Desired action must be behavioral (click, sign up, pay), not attitudinal (say they like it)
- Set the threshold BEFORE running the experiment, not after

**Also set fail conditions:** what result would KILL this hypothesis? Write it down. If you can't define failure, you can't learn.

---

## Step 3: EXPERIMENT — Run the Cheapest Possible Test

**Experiment types (ordered by cost, cheapest first):**

| Type | What | Time | Cost | Evidence Strength |
|---|---|---|---|---|
| **Fake Door** | Landing page with signup/buy button, no product behind it | 2 hours | $0 | Medium (interest, not commitment) |
| **Concierge** | Manually deliver the service to 3-5 people | 1-3 days | $0 | High (real usage data) |
| **Wizard of Oz** | Users think it's automated, but you do it manually behind the scenes | 3-5 days | $0 | High (real behavior) |
| **Pre-sell** | Take actual payments before the product exists | 1 day | $0 | Highest (money moved) |
| **Smoke Test** | Ads/posts pointing to a signup page, measure conversion | 1 day | $0-50 | Medium (intent, not usage) |

**Rules:**
- Always prefer skin-in-the-game data (money, time invested) over opinions (surveys, "I would use this")
- "Would you use this?" is worthless. "Here's the payment page, buy now" is data.
- If an experiment takes more than 1 week, it's too expensive. Simplify.
- Search the web for existing data before running your own experiment (someone may have already validated this)

---

## Step 4: LEARN — Evaluate Against Threshold

Compare results to your XYZ hypothesis threshold:

| Result | Action |
|---|---|
| **Exceeded threshold** | Assumption validated. Move to next riskiest assumption. |
| **Close to threshold (within 20%)** | Iterate: adjust offering, pricing, or messaging. Re-run experiment. |
| **Far below threshold** | Assumption invalidated. Decide: pivot or kill. |

**Pivot options (Steve Blank):**
- **Zoom-in pivot:** one feature of the product becomes the whole product
- **Zoom-out pivot:** the whole product becomes one feature of a larger product
- **Customer segment pivot:** same product, different audience
- **Customer need pivot:** same audience, different problem
- **Channel pivot:** same product, different distribution channel
- **Revenue model pivot:** same product, different pricing/monetization

**Kill criteria:** if 3+ pivots on the same core idea all fail, kill it entirely. Start fresh with a new idea through `biz-think`.

---

## Step 5: UPDATE — Revise the Lean Canvas

After each cycle, update these in Knowledge Graph MCP:
- `Experiment`: hypothesis, method, result, date, learning
- `AssumptionStatus`: which assumptions are now Validated/Invalidated/Untested
- `LeanCanvas`: updated customer segment, problem, solution, channels, revenue based on learnings
- `PivotHistory`: if pivoted, record what changed and why

---

## Exit Conditions

**Exit to development (invoke `pre-code`):**
- Problem assumption validated (people have this pain and will pay)
- Solution assumption validated (your approach solves it)
- At least 1 person has paid or committed to pay (pre-sale, LOI, deposit)
- `biz-think` acid test can now be completed in one sentence

**Exit by killing:**
- 3+ pivots failed on the same core idea
- No behavioral evidence of willingness to pay after 3 experiment cycles
- Store the kill decision and learnings in Knowledge Graph for future reference

**Do NOT exit because you're tired of iterating.** Exit only when evidence supports the decision.

---

## Macro Stages (Running Lean Traction Roadmap)

Track which stage you're in:

| Stage | Goal | How You Know You're Done |
|---|---|---|
| **1. Problem/Solution Fit** | Validate the problem is real and your solution concept resonates | 5+ people describe the problem unprompted; solution demo gets "when can I use this?" |
| **2. Product/Market Fit** | Validate people will pay and keep using it | Repeatable acquisition, activation rate >40%, monthly churn <5% |
| **3. Scale** | Grow the validated model | Not your concern until stages 1-2 are done |

**You are almost certainly at Stage 1.** Do not skip to Stage 2 thinking.

## Next Steps
After completing this skill, create tasks for applicable next steps using TaskCreate:
- All assumptions validated → create task: "invoke `brand-build` — define positioning, then `work-breakdown` to decompose into atomic issues"
- Kill criteria met (3+ pivots fail) → create task: "invoke `biz-think` — start fresh with a new idea"
- Validated and project already exists → create task: "invoke `work-breakdown` — decompose validated idea into atomic issues"
- Need to build experiment (landing page) → create task: "invoke `copy-craft` — write conversion copy for experiment landing page"
- Experiment needs distribution → create task: "invoke `community-engage` — distribute experiment to communities" or create task: "invoke `content-distribute` — cross-post experiment content"

Only create tasks that are actually relevant. Do not create tasks for steps that don't apply to the current situation.
