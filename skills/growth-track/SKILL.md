---
name: growth-track
description: "Business metrics dashboard: defines WHAT to track (AARRR funnel, North Star, budget, experiments). Triggers ONLY when: user asks to check metrics, plan growth experiments, manage budget, or review funnel performance. Do NOT trigger during development or content creation."
---

# Growth Tracking SOP

## Boundary

**This skill (growth-track)** = WHAT to track. The business metrics dashboard: defines metrics (AARRR, North Star), manages budgets, designs experiments, and generates weekly reports.

**Not this skill — use `data-decide` instead** for HOW to interpret data: cohort analysis methodology, A/B test statistical rigor, vanity vs actionable metric evaluation, event taxonomy design, and data-driven decision frameworks.

## Section 1: AARRR Funnel Tracking

Reference: Dave McClure, "Pirate Metrics."

Define each stage metric for the specific product. If metrics are not yet defined, work with the user to set them.

### Acquisition
- **Primary metric:** new signups per week/month
- **CAC by channel:** cost to acquire one user from each source (organic search, social, paid, referral, direct)
- **Channel breakdown:** what % of signups come from each channel?
- **Tracking:** analytics dashboard (Google Analytics, Plausible, PostHog) + UTM parameters from content-distribute

### Activation
- **Primary metric:** % of signups who complete the key activation action
- **Define "activated":** the moment a user first experiences core value (e.g., first project created, first query run, first integration connected)
- **Time-to-value:** median time from signup to activation — shorter is better
- **Tracking:** product analytics events (PostHog, Mixpanel, or custom)

### Retention
- **Primary metrics:** Day 1, Day 7, Day 30 return rates
- **Churn rate:** % of users who stop using the product per month
- **Tracking:** product analytics cohort reports
- For cohort analysis methodology and interpretation, use `data-decide`

### Revenue
- **MRR (Monthly Recurring Revenue):** total recurring revenue
- **ARPU (Average Revenue Per User):** MRR / paying users
- **Free-to-paid conversion:** % of free users who convert to paid
- **Expansion revenue:** upgrades, add-ons, usage-based growth
- **Tracking:** payment provider dashboard (Stripe, Lemon Squeezy, etc.)

### Referral
- **Invite rate:** % of users who invite at least one other person
- **Viral coefficient (k):** invites sent per user x conversion rate of invites. k > 1 = viral growth.
- **Referral channel:** word of mouth, share feature, affiliate program
- **Tracking:** referral tracking system or UTM-tagged invite links

Use Playwright MCP to pull metrics from analytics dashboards, payment providers, and other tools. Take screenshots for user review.

## Section 2: North Star Metric

Reference: Sean Ellis, "Hacking Growth."

### Define the North Star

Choose ONE metric that captures the core value users get from the product. This is NOT revenue — it's the thing that, when it grows, means users are getting more value.

Examples:
- Slack: daily active users who send messages
- Airbnb: nights booked
- Spotify: time spent listening

Format: "[Metric name]: [number] per [time period]"

### Define Input Metrics

Identify 3-4 metrics that directly feed into the North Star:

| Input Metric | Current Value | Target | Owner |
|-------------|---------------|--------|-------|
| | | | |

### Track Daily/Weekly

- Update North Star metric daily (automated if possible)
- Review input metrics weekly
- If North Star stalls for 2+ weeks, investigate which input metric is the bottleneck

## Section 3: Budget Management

### Track All Spending

Maintain a running cost table:

| Category | Item | Monthly Cost | Annual Cost | Notes |
|----------|------|-------------|-------------|-------|
| Infrastructure | Hosting | | | |
| Infrastructure | Domain | | | |
| Infrastructure | API costs | | | |
| Tools | Analytics | | | |
| Tools | Email/CRM | | | |
| Marketing | Ads | | | |
| Marketing | Content tools | | | |
| **Total** | | **$X/mo** | **$X/yr** | |

### Monthly Burn Rate

- Total monthly spend (infrastructure + tools + marketing + other)
- Months of runway remaining (if bootstrapped: revenue - costs = net)
- Flag if burn rate increases >20% month-over-month without proportional revenue growth

### CAC by Channel

For each acquisition channel:

| Channel | Time Invested (hrs) | Time Cost ($50/hr) | Direct Spend | Total Cost | Users Acquired | CAC |
|---------|--------------------|--------------------|-------------|------------|----------------|-----|
| Organic content | | | | | | |
| Social media | | | | | | |
| Paid ads | | | | | | |
| Community | | | | | | |
| Referral | | | | | | |

### LTV:CAC Ratio

- **LTV (Lifetime Value):** ARPU x average customer lifespan in months
- **Target ratio:** 3:1 or higher
- **Decision rules:**
  - LTV:CAC > 3:1 — scale this channel, invest more
  - LTV:CAC 1:1 to 3:1 — optimize before scaling
  - LTV:CAC < 1:1 — kill this channel after 30-day test confirms the ratio

## Section 4: Experiment Tracking

### Experiment Format

For every growth experiment, define BEFORE running:

```
Experiment: [Name]
Hypothesis: If we [specific action], then [metric] will [direction] by [amount]
Duration: [max 2 weeks]
Success Criteria: [metric] reaches [target] by end of experiment
Effort: [hours estimated]
```

### Running Experiments

1. Only run 1-2 experiments simultaneously (more = confounding variables)
2. Measure the specific metric defined in the hypothesis — not vanity metrics
3. Don't stop early on positive results (survivorship bias) — run for full duration
4. Document result immediately after completion:

```
Result: PASS / FAIL
Actual outcome: [metric] changed by [amount] (expected [amount])
Learning: [what we now know that we didn't before]
Next action: [scale it / iterate / kill it / new experiment]
```

### Store All Experiments

In Knowledge Graph, store:
- Experiment name, hypothesis, duration
- Result (pass/fail)
- Actual vs expected outcome
- Key learning
- Follow-up action taken

This prevents re-running failed experiments and builds institutional knowledge.

## Section 5: Weekly Growth Review

Every Monday, generate a growth report:

### 1. Funnel Snapshot

| Stage | This Week | Last Week | Change | Trend |
|-------|-----------|-----------|--------|-------|
| Acquisition (signups) | | | | |
| Activation (%) | | | | |
| Retention (D7) | | | | |
| Revenue (MRR) | | | | |
| Referral (k) | | | | |

### 2. Biggest Drop-Off

Identify the funnel stage with the worst conversion rate or biggest decline. This is the focus for the week.

Format: "This week focus on **[stage]** because [specific data point showing the problem]."

### 3. Experiment Status

- Active experiments: status update
- Completed experiments: result summary
- Proposed experiments: for user approval

### 4. Budget Check

- Monthly spend vs budget
- Any unexpected cost increases
- CAC trend by channel

Use Playwright MCP to pull data from analytics dashboards, payment providers, and ad platforms. Compile into the report format above.

## Section 6: Partnership & Channel Growth

### Integration Partnerships
Build integrations with complementary products and list on their marketplace or directory. Each integration = a distribution channel you don't own but benefit from. Prioritize platforms with active marketplaces (Zapier, Slack, Notion, etc.) — being listed puts you in front of users already looking for solutions.

### Affiliate Program
Offer 20-30% recurring commission on referred customers. Tools: Rewardful, FirstPromoter, or simple Stripe referral links. **Only launch after product-market fit** — don't pay to acquire users for a leaky bucket. Start with a small group of aligned affiliates (power users, niche bloggers) rather than opening to everyone.

### Co-Marketing
Find non-competing products serving the same audience. Tactics: guest blog posts, shared webinars, newsletter swaps, joint case studies. Zero cost, mutual benefit. The best co-marketing partners are products your users already use alongside yours.

### Marketplace & Directory Listings
Submit to every relevant directory: Product Hunt, AlternativeTo, G2, Capterra, SaaSHub, and niche-specific directories. Each listing = a permanent SEO backlink + discovery channel. Maintain listings actively — update screenshots, respond to reviews, keep descriptions current.

### Partnership Qualification
Only pursue partnerships where the partner's audience is your target user. "They're big" is not a reason to partner. Before committing time, verify: (1) their users have the problem you solve, (2) there's a natural integration point or shared workflow, (3) the partnership is mutually beneficial, not one-sided.

Store active partnerships and their performance in **Knowledge Graph MCP** with: partner name, type (integration/affiliate/co-marketing/listing), date started, and referral metrics.

## Next Steps
After completing this skill, consider whether these are needed:
- Biggest drop-off identified → invoke the relevant skill to fix it:
  - Acquisition problem → `community-engage` or `content-create`
  - Activation problem → `product-eval` (FTUE dimension)
  - Retention problem → `support-ops` (churn prevention)
  - Revenue problem → `finance-ops` (pricing) or `sales-close`
  - Referral problem → `copy-craft` (referral copy)
- First paying customer achieved → consider `support-ops` and `legal-guard`
