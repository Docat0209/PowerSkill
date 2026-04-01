---
name: data-decide
description: "Data analyst: HOW to interpret data and make decisions (event taxonomy, cohort analysis, A/B test statistical rigor, vanity vs actionable metrics, decision frameworks). Triggers ONLY when: user asks to set up analytics, interpret metrics, design an A/B test, or make a data-driven decision. Do NOT trigger during development or casual metric discussion."
---

# Data-Decide SOP

## Boundary

**This skill (data-decide)** = HOW to interpret data. The data analyst: event taxonomy design, cohort analysis methodology, A/B test statistical rigor, vanity vs actionable metric evaluation, and decision frameworks for acting on data.

**Not this skill — use `growth-track` instead** for WHAT to track: AARRR funnel metrics, North Star metric definition, budget management, experiment design templates, and weekly growth reports.

## 1. Event Taxonomy

Design events before writing code. Use `object_action` naming convention consistently.

**Core events to track (minimum viable analytics):**
- Authentication: `user_signed_up`, `user_logged_in`, `user_logged_out`
- Activation: `onboarding_started`, `onboarding_completed`, `feature_first_used`
- Engagement: `project_created`, `item_edited`, `search_performed`
- Monetization: `plan_selected`, `payment_completed`, `subscription_cancelled`
- Retention: `session_started`, `user_returned` (after 7+ day absence)

**Naming rules (Amplitude taxonomy best practices):**
- Always `object_action`, never `action_object` — keeps autocomplete useful
- Past tense for completed events (`payment_completed`), not gerunds
- Properties use snake_case: `plan_name`, `referral_source`, `time_to_activate_seconds`
- Never put PII (email, name) in event properties — use anonymous user IDs
- Document every event in a tracking plan (living doc, reviewed monthly)

> Source: [Amplitude — Plan Your Taxonomy](https://amplitude.com/docs/data/data-planning-playbook), [PostHog SaaS Guide](https://bix-tech.com/posthog-for-saas-a-practical-guide-to-product-analytics-and-event-tracking/)

## 2. Vanity vs Actionable Metrics (Eric Ries, Lean Startup)

**The test:** if the metric doesn't change your next action, stop tracking it.

| Vanity (feels good) | Actionable (drives decisions) |
|---|---|
| Total registered users | Activation rate (% completing onboarding) |
| Page views | Conversion rate (visitor → signup) |
| Total revenue (cumulative) | MRR growth rate (week over week) |
| App downloads | Day-7 retention rate |

**Three A's of actionable metrics (Ries):**
1. **Actionable** — clear cause and effect; you know what lever moved it
2. **Accessible** — simple enough that the whole team understands it
3. **Auditable** — you can trace the number back to raw data

> Source: [Eric Ries on Tim Ferriss blog](https://tim.blog/2009/05/19/vanity-metrics-vs-actionable-metrics/), [Lean Startup Co.](http://2015.leanstartup.co/day-1830-vanity-metrics-vs-actionable-metrics/)

## 3. Cohort Analysis

Group users by signup week. Track retention at day 1, day 7, day 30.

**How to read cohort curves:**
- Flattening curve = users who stay are sticky (good)
- Newer cohorts retaining better than older = product is improving (great)
- All cohorts dropping to zero = you have a leaky bucket (fix retention before growth)

**Implementation (minimal):**
1. Store `signup_date` with every user
2. Query: for each signup week, count active users at +1d, +7d, +30d
3. Plot as a retention table or curve chart
4. Compare curves across cohorts — the shape matters more than absolute numbers

## 4. A/B Test Design

**Before running any test:**

1. **Write the hypothesis:** "If [change], then [metric] will [direction] by [amount]"
   - Bad: "The new button will be better"
   - Good: "If we change CTA from 'Start Free' to 'Try It Now', signup rate will increase by 10%"
2. **Calculate sample size BEFORE running** — use [Evan Miller's calculator](https://www.evanmiller.org/ab-testing/sample-size.html)
   - Inputs: baseline conversion rate, minimum detectable effect (MDE), power (0.80), significance (0.05)
3. **Run for full weeks** — minimum 14 days to avoid day-of-week bias
4. **Do not peek** — checking results early inflates false positive rate
5. **Statistical significance: p < 0.05 minimum** (95% confidence)
6. **Practical significance matters too** — a statistically significant 0.1% improvement may not be worth implementing

> Source: [Statsig — Determine Sample Size](https://www.statsig.com/perspectives/determine-sample-size-abtest), [GuessTheTest — Sample Size Guide](https://guessthetest.com/calculating-sample-size-in-a-b-testing-everything-you-need-to-know/)

## 5. Decision Framework

Data informs, doesn't decide. Use this ladder:

| Data clarity | Action |
|---|---|
| High confidence (>95%, large effect) | Follow the data |
| Moderate (80-95%, small effect) | Data + qualitative signals (user interviews, support tickets) |
| Ambiguous (<80% or conflicting) | Use judgment, acknowledge uncertainty |
| No data at all | Run the smallest possible experiment first |

**When data and intuition conflict:** favor data for incremental decisions, favor vision for strategic bets. Document why you overrode data when you do.

## 6. Tools (Solo/Small Team)

| Need | Recommendation | Why |
|---|---|---|
| Product analytics | PostHog (self-hosted, free) | Full-featured, privacy-friendly, no data caps |
| Web analytics | Plausible | Privacy-focused, lightweight, GDPR-compliant |
| A/B testing | GrowthBook (free tier) or PostHog feature flags | Proper statistical engine, integrates with your data |
| Error tracking | Sentry (free tier) | Stack traces + user context |
| Avoid unless necessary | Google Analytics | Privacy tradeoff, complex, overkill for early stage |

## Next Steps
Report to user: "Analysis complete. Key finding: [one line]. Recommendation: [action]"

Suggested next steps (user decides):
- Product issue found → "Run product-eval"
- Acquisition issue → "Run growth-track"
