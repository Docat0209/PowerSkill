---
name: finance-ops
description: "Manages finances, pricing strategy, and tax compliance. Triggers ONLY when: user asks to set up pricing, track finances, plan budget, or handle tax/billing issues. Do NOT trigger during development or marketing."
---

# Finance-Ops SOP

## 1. Pricing Strategy

**Value-based pricing:** price as a percentage of value delivered, not based on cost. Industry benchmark: 5-20% of the quantifiable value your product delivers to the customer.

**Three-tier structure (standard SaaS pattern):**

| Tier | Purpose | Pricing guidance |
|---|---|---|
| Free / Starter | Acquisition — get users in the door | Free or < $10/mo. Enough to be useful, limited enough to create upgrade desire |
| Pro (target tier) | Revenue — this is where most paying customers land | 3-5x the Starter price. Include everything most users need |
| Business / Scale | Expansion — for power users and teams | 3-5x the Pro price. Add team features, priority support, higher limits |

**The middle tier is your target.** Design the other tiers to make it look like the best value (decoy effect).

> Source: [FastSpring — Three-Tier Pricing](https://fastspring.com/blog/three-tier-pricing-strategy-for-saas-is-it-still-ideal/), [Maxio — SaaS Tiered Billing](https://www.maxio.com/blog/tiered-pricing-examples-for-saas-businesses)

## 2. Pricing Psychology (Cialdini, Ariely)

**Anchoring:** show the most expensive plan first (left to right or top to bottom). The high price anchors perception, making the middle tier feel reasonable.

**Charm pricing:**
- Consumer products: $9.99 beats $10 (left-digit bias)
- SaaS: use $49, $99, $199 — the 9-ending signals value, but round-ish numbers signal quality
- Avoid: $47, $97 (looks like an info-product scam)

**Decoy effect (Ariely, "Predictably Irrational"):**
Add a "bad deal" tier that makes the target tier obviously superior. Classic example: The Economist's print-only subscription at the same price as print+web made 84% choose the combo.

**Annual discount:** offer 2 months free for annual billing (e.g., "$49/mo or $490/year — save $98").
- Improves cash flow (money upfront)
- Reduces churn (commitment locks users in)
- Show the monthly-equivalent price for annual plans ("$40.83/mo billed annually")

> Source: [NetSuite — Psychological Pricing](https://www.netsuite.com/portal/resource/articles/ecommerce/psychological-pricing.shtml), [Omniaretail — Psychological Pricing](https://www.omniaretail.com/blog/psychological-pricing)

## 3. Financial Tracking

**Day 1:** open a separate business bank account. Do not mix personal and business finances.

**Track monthly:**
| Metric | Formula | Target |
|---|---|---|
| MRR | Number of paying customers x average price | Growing month over month |
| Expenses | Sum of all costs (infra, tools, domains, marketing) | < 40% of MRR once profitable |
| Profit | MRR - expenses | Positive within 12 months |
| Runway | Cash in bank / monthly burn rate | > 6 months |

**Tools:** Wave (free accounting), or a simple spreadsheet with: date, category, amount, recurring (y/n). Do a monthly P&L review (takes 30 minutes).

## 4. Key SaaS Metrics

| Metric | Formula | Why it matters |
|---|---|---|
| **MRR** | Paying customers x avg price | Core health metric |
| **Net MRR** | New MRR + Expansion MRR - Churned MRR | Shows real growth trajectory |
| **ARR** | MRR x 12 | Annual perspective, useful for valuations |
| **Gross margin** | (Revenue - COGS) / Revenue | Target > 80% for SaaS |
| **LTV** | ARPU / monthly churn rate | How much a customer is worth over their lifetime |
| **CAC** | Total acquisition spend / new customers | How much it costs to get a customer |
| **LTV:CAC ratio** | LTV / CAC | Target > 3:1 (you earn 3x what you spend to acquire) |

> Source: [Baremetrics — Calculate MRR](https://baremetrics.com/academy/saas-calculate-mrr), [SaaS Academy — ARR vs MRR](https://www.saasacademy.com/blog/arr-vs-mrr-how-to-calculate)

## 5. Tax Basics

**Set aside money immediately:** reserve 25-30% of profit for taxes. Put it in a separate savings account so you don't accidentally spend it.

**Quarterly estimated payments (US):** if you expect to owe > $1,000 in taxes, pay quarterly (Apr 15, Jun 15, Sep 15, Jan 15). Penalties for underpayment are real.

**International sales tax:**
- US: sales tax varies by state; use Stripe Tax or TaxJar for automation
- EU: VAT collection required above threshold; use Paddle or Lemon Squeezy as Merchant of Record (they handle VAT for you)
- Simplest path: use a Merchant of Record (Paddle, Lemon Squeezy) — they handle all tax collection and remittance globally

**Keep receipts:** every business expense needs documentation. Use a folder in cloud storage, organized by month. Deductible: hosting, domains, tools, home office percentage, equipment.

## 6. Dunning Management (Failed Payment Recovery)

Involuntary churn (failed payments) accounts for 20-40% of all subscription churn. This is pure recoverable revenue.

**Retry schedule:**
| Day | Action |
|---|---|
| Day 0 | Payment fails → automatic retry in 4 hours |
| Day 1 | Email: "Your payment failed. Please update your card." (include direct link to billing page) |
| Day 3 | Retry payment + email reminder |
| Day 5 | Retry payment + email with urgency ("service may be interrupted") |
| Day 7 | Final retry + email warning ("last chance before downgrade") |
| Day 14 | **Downgrade to free tier** (never delete data — they may come back) |
| Day 30 | Win-back email: "We miss you — here's 20% off to come back" |

**Key principle:** downgrade, never delete. Deleting a user's data over a failed payment destroys trust and eliminates any chance of recovery.

> Source: [Baremetrics — Dunning Management Guide](https://baremetrics.com/blog/ultimate-dunning-management-guide), [QuantLedger — Stripe Dunning](https://www.quantledger.app/blog/how-to-automate-dunning-stripe)

## 7. Budget Allocation

**Early stage (pre-revenue to $1K MRR):**
| Category | % of budget | Examples |
|---|---|---|
| Product | 70% | Your time building |
| Infrastructure | 15% | Hosting, domain, essential tools |
| Marketing | 10% | Content, community, one paid experiment |
| Reserve | 5% | Emergency fund |

**Growth stage ($1K+ MRR):**
| Category | % of budget | Examples |
|---|---|---|
| Product | 60% | Development, design, UX improvements |
| Marketing | 20% | Ads, content, partnerships |
| Infrastructure | 10% | Scaling, monitoring, backups |
| Reserve | 10% | 3-month runway minimum |

Revisit allocation quarterly. As traction increases, shift from product-heavy to marketing-heavy.

## Next Steps
After completing this skill, create tasks for applicable next steps using TaskCreate:
- Pricing set → create task: "invoke `copy-craft` — write pricing page conversion copy"
- Payment system set up → create task: "invoke `legal-guard` — create ToS and refund policy"
- Budget allocated → create task: "invoke `growth-track` — set up experiment tracking within budget"

Only create tasks that are actually relevant. Do not create tasks for steps that don't apply to the current situation.
