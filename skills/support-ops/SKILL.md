---
name: support-ops
description: "Manages customer support and churn prevention. Triggers ONLY when: user asks to set up support system, handle customer complaints, reduce churn, or build a knowledge base. Do NOT trigger during development or marketing."
---

# Support Ops SOP

## 1. Support Triage

Prioritize by impact and urgency (source: Freshworks, general SaaS support practice):

| Priority | Category | Response time | Examples |
|----------|----------|---------------|----------|
| **P0** | Data loss / security breach | < 1 hour | Data leak, account compromise, payment breach, complete outage |
| **P1** | Broken core feature | < 4 hours | Cannot log in, cannot complete primary workflow, billing errors |
| **P2** | Question / how-to | < 24 hours | Feature usage questions, setup help, integration support |
| **P3** | Feature request / enhancement | Weekly batch | Nice-to-haves, UI preferences, non-critical suggestions |

**Solo founder rules:**
- P0/P1: Drop everything. Set up alerts (email + phone notification) for these.
- P2: Batch and respond twice daily (morning + afternoon). Don't context-switch for every question.
- P3: Log in a feature request tracker. Review weekly. Reply with "Noted, added to our roadmap" — then actually track it.
- Template responses for common P2 questions save 60%+ of support time. Build these from day one.

## 2. Knowledge Base

Build proactively, not reactively (source: UserPilot, Paddle, Pylon):

**What to write first:**
- Top 20 questions from support tickets → articles. Use actual ticket data to prioritize.
- Getting started guide — the single path from signup to first value
- Common error messages → causes and fixes
- Integration/setup guides for each supported platform
- Billing FAQ (pricing, upgrades, cancellations, refunds)

**Article structure:**
1. Problem statement — "You're seeing X when trying to Y"
2. Step-by-step solution — numbered steps, one action per step
3. Screenshots / GIFs — show, don't just tell
4. Related articles — link to next likely question
5. "Did this help?" feedback widget — track which articles fail

**Maintenance rules:**
- Same question asked 3+ times → write an article immediately
- Review all articles quarterly — outdated help docs are worse than no docs
- Link knowledge base articles in onboarding emails, in-app help, and support replies
- Organize by user task ("How do I..."), not by product feature ("Settings page")

## 3. Onboarding Sequence

The first 14 days determine retention (source: ProsperStack, Vitally, CloudBlue):

| Touchpoint | Timing | Content | Goal |
|------------|--------|---------|------|
| Welcome email | Instant | Confirm account, set expectations, link to quick-start guide | Reduce uncertainty |
| Quick win guide | Day 1 | Guide to completing ONE meaningful action (Time to First Value) | First "aha" moment |
| Check-in | Day 3 | "How's it going? Need help with anything?" + link to top KB article | Catch stuck users early |
| Value reminder | Day 7 | Show what they've accomplished + what they haven't tried yet | Reinforce value, expand usage |
| Feature discovery | Day 14 | Introduce an advanced feature or integration they haven't used | Deepen engagement |

**Key metric**: Time to First Value (TTFV). Customers who experience real value in the first few days are 2x more likely to retain and spend 30% more over their lifetime (source: ProsperStack). Measure and optimize ruthlessly.

**Behavioral triggers** (supplement the time-based sequence):
- User hasn't completed setup after 48 hours → send "Need help getting started?" email
- User completed first workflow → send congratulations + "Here's what to try next"
- User invited a team member → send collaboration tips

## 4. Churn Prevention

Average B2B SaaS churn is 3.5% monthly. Reducing churn by 5% can increase profits 25-95% (source: Vitally, QuantLedger, ProsperStack):

**Usage monitoring (most reliable churn predictor):**
- Track login frequency, feature adoption, activity levels
- Alert when usage drops >30% month-over-month — this is your churn signal
- No login for 7+ days → trigger automated re-engagement email
- No login for 14+ days → personal outreach from founder

**Exit survey (when they cancel):**
- Keep it to 3-5 questions max. Required before cancellation completes.
- Ask: "What's the primary reason you're leaving?" with options: too expensive, not using it enough, missing features, switched to competitor, other
- This data is gold — review monthly, act on top reasons

**Save offers (in cancellation flow):**
- **Discount**: 20-30% off for 3 months (for price objections)
- **Pause**: Freeze account for 1-3 months instead of canceling
- **Downgrade**: Offer a cheaper plan if one exists
- Show what they'll lose ("You have 47 saved reports that will be deleted")
- Never guilt-trip — respect the decision while offering alternatives

**Win-back sequence:**
| Email | Timing | Content |
|-------|--------|---------|
| 1 | Day 30 | "We've improved [thing they complained about]. Take another look?" |
| 2 | Day 60 | Share a relevant customer success story |
| 3 | Day 90 | Final offer — special comeback deal or new feature announcement |

**Involuntary churn (failed payments):**
- Averages 0.8% but fixing it lifts revenue 8.6% in year one (source: Vitally)
- Implement: automated card updaters, smart retry logic (retry on days 1, 3, 5, 7), dunning emails, grace period before account suspension

## 5. Feedback Loop

Close the loop between support and product (source: general SaaS practice, UserPilot):

**Ticket tagging:**
- Tag every support ticket by category: bug, how-to, feature-request, billing, onboarding
- Sub-tag by feature area when possible

**Monthly review:**
- Pull top 3 ticket categories by volume
- For each: Is this a product problem (fix it), a docs problem (write an article), or a UX problem (redesign the flow)?
- Assign action items with owners and deadlines

**Close the loop with customers:**
- When you fix an issue that was reported, email the customers who reported it: "You told us about X. We fixed it. Here's what changed."
- This single action converts frustrated users into loyal advocates
- Track NPS quarterly (or after key milestones). Score < 30 = urgent product/support problem.

**NPS implementation:**
- Send NPS survey at day 30, day 90, and every 90 days after
- Question: "How likely are you to recommend [product] to a colleague? (0-10)"
- Follow up: Promoters (9-10) → ask for referral/review. Detractors (0-6) → personal outreach to understand why.
- Benchmark: SaaS average NPS is 30-40. Below 30 means systemic issues.
