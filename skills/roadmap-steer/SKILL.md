---
name: roadmap-steer
description: "Prioritizes features and manages product roadmap. Triggers ONLY when: user asks to prioritize features, plan a roadmap, evaluate feature requests, or decide what to build next. Do NOT trigger during development or when implementing already-decided features."
---

# Roadmap-Steer SOP

## 1. RICE Scoring (Intercom Framework)

Score every feature request. Highest RICE score = build next.

**Formula:** `RICE = (Reach × Impact × Confidence) / Effort`

| Factor | How to measure | Scale |
|---|---|---|
| **Reach** | Users affected per quarter | Actual number (e.g., 500 users/quarter) |
| **Impact** | Effect on target metric per user | 3 = massive, 2 = high, 1 = medium, 0.5 = low, 0.25 = minimal |
| **Confidence** | How sure are you about estimates | 100% = high (data-backed), 80% = medium (some evidence), 50% = low (gut feel) |
| **Effort** | Person-weeks for solo dev (person-months for teams) | Actual estimate (e.g., 2 weeks) |

**Example:**
- Feature: "Add CSV export"
- Reach: 200 users/quarter, Impact: 1 (medium), Confidence: 80%, Effort: 1 week
- RICE = (200 × 1 × 0.8) / 1 = **160**

**When RICE isn't enough:** RICE optimizes for incremental value. For strategic bets (platform pivots, new markets), use judgment — RICE can't score vision.

> Source: [Intercom — RICE Prioritization](https://www.intercom.com/blog/rice-simple-prioritization-for-product-managers/), [ProductPlan — RICE Scoring Model](https://www.productplan.com/glossary/rice-scoring-model/)

## 2. Saying No to Feature Requests

Most requests won't make it. Have a framework, not an apology.

**Response template:**
> "Thank you for the suggestion. This doesn't fit our current direction because [specific reason]. I've noted it for future consideration."

**Valid reasons to say no:**
- Doesn't serve the core use case (scope creep)
- Effort far exceeds impact (low RICE)
- Only one user asked (not representative)
- Would add complexity that hurts the majority of users

**Never say:**
- "Maybe later" without meaning it — it creates false expectations
- Nothing at all — silence is worse than a polite no

## 3. Feature Request Management

Track in a single place. Keep it simple.

**Spreadsheet/issue tracker columns:**
| Column | Purpose |
|---|---|
| Requester | Who asked (customer name or support ticket) |
| Request | What they want (in their words) |
| Frequency | How many different users asked for this |
| RICE score | Calculated priority |
| Status | `noted` → `evaluating` → `planned` → `building` → `shipped` / `declined` |

**Process:**
- Log every request when it comes in (takes 30 seconds)
- Review the full list monthly
- Re-score top 10 items with fresh data
- Pick the highest-RICE item that aligns with current strategy

## 4. Build vs Buy vs Integrate

**Decision rule:** build only if it's your core differentiator AND no existing solution is 80%+ good enough.

| Question | Build | Buy/Integrate |
|---|---|---|
| Is this your competitive advantage? | Yes | No |
| Does an 80%+ solution exist? | No | Yes |
| Will maintaining this distract from core product? | No | Yes |
| Is time-to-market critical? | No | Yes |

**For solo devs:** bias heavily toward buy/integrate. Your time is your scarcest resource. Use APIs, SaaS tools, and open-source before building anything that isn't your core product.

> Source: [TheCodev — Build vs Buy Framework](https://thecodev.co.uk/build-vs-buy-framework/), [Vadim Kravcenko — Build vs Buy](https://vadimkravcenko.com/shorts/build-vs-buy-vs-nocode/)

## 5. Public Roadmap

**Benefits:**
- Transparency builds user trust
- Reduces "when will you add X?" support tickets
- Creates accountability and momentum

**Risks:**
- Competitors see your plans
- Creates user expectations you may not meet
- Pressure to ship dates instead of quality

**Recommendation:** share themes and directions, not specific features or dates.
- Good: "Q2 focus: collaboration features"
- Bad: "Shipping real-time multiplayer editing on March 15"

**Tools:** GitHub Projects (free, public), Linear public roadmap, Canny (feedback + roadmap).

## 6. Anti-Patterns — Do Not Fall Into These

**Feature parity with competitors:**
Compete on your differentiator, not their feature list. You will always lose a feature count war against a larger team. Instead, be 10x better at one thing.

**Building for the loudest customer:**
The most vocal user is often not representative. One enterprise customer demanding a feature does not mean your 500 other users want it. Check the frequency column.

**Roadmap by committee:**
Gathering input is good. Deciding by vote is bad. Users can tell you their problems (valuable). They cannot design your product (that's your job).

**Planning too far ahead:**
A 12-month roadmap is fiction for an early-stage product. Plan 6 weeks in detail, 3 months in themes, beyond that in bets.

> Source: [Intercom Blog](https://www.intercom.com/blog/rice-simple-prioritization-for-product-managers/), [SaaSFunnelLab — RICE Guide](https://www.saasfunnellab.com/essay/rice-scoring-prioritization-framework/)

## Next Steps
After completing this skill, create tasks for applicable next steps using TaskCreate:
- Next feature decided → create task: "invoke `pre-code` — start implementation of prioritized feature"
- Feature request from community → create task: "invoke `community-engage` — respond to community feature request"
- Deprioritized request → create task: "invoke `support-ops` — communicate deprioritization to requester"

Only create tasks that are actually relevant. Do not create tasks for steps that don't apply to the current situation.
