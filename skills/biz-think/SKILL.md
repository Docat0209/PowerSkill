---
name: biz-think
description: "Business direction and model validation. Triggers when: deciding what product to build, evaluating a business idea, discussing pricing/monetization, planning customer acquisition, analyzing competition, or any question about commercial viability."
---

# biz-think: Business Direction Decision Skill

Use Sequential Thinking MCP to work through each phase as a separate thought. Store final decisions in Knowledge Graph MCP under entity type `BusinessDecision`.

Before starting: retrieve any prior `BusinessDecision` entities from Knowledge Graph MCP to maintain continuity with past analyses.

---

## Phase 0: Reality Check — Who Are We?

State this upfront in every analysis: **We have no audience, no brand, no capital.** This constrains everything.

Our advantages:
- AI-powered development speed (10x a normal solo dev)
- Near-zero build cost (time + API fees only)
- Ability to experiment fast and kill losers without sunk-cost pain

Every decision below must be evaluated through this lens. Skip strategies that require fame, funding, or a team.

---

## Phase 1: Idea Filter — The 5 Viability Tests

Every product idea must pass ALL 5. If any fails, pivot or kill.

### 1. OpenAI Test
If OpenAI shipped this feature inside ChatGPT tomorrow for free, would we still exist? If the answer is no, it's a wrapper, not a product. Wrappers die when the platform expands. (Source: Andrew Chen, a16z — "The Commoditization Trap")

### 2. Moat Test
Does this product accumulate something competitors can't easily copy? Rate each:
- **Proprietary data from usage** — user-generated, not public data
- **Integration depth** — embedded in workflows, high switching cost
- **Domain expertise baked into product logic** — not just prompting an LLM
- **Network effects** — value increases with more users

If all are "None" → kill the idea.

### 3. Market Proof Test
Are competitors already making money in this space? Search for: existing products, their pricing, their revenue (use SimilarWeb, store rankings, public revenue data). No competitors making money = no validated demand. Competitors making money = proven market.

### 4. Wow Test
Would this make someone say "holy shit" on Product Hunt? Clarity in first second, specific outcome, visually demonstrable. If you can't describe what it does in 6 words, it's not clear enough.

### 5. AI Cost Advantage Test
Can we build this to a quality that would normally require a $200K/year team, for under $1K/month in operating costs? If yes, our pricing can undercut everyone while maintaining margins. If no, we have no structural advantage.

---

## Phase 2: Success Decomposition — Why Do Successful Products Win?

Before building, analyze 3 successful products in the target space. For EACH one, decompose:

```
Product: [name]
Revenue: [verified number or estimate]
WHY it succeeds — separate the components:
  - Product quality factor: [1-5] (is the product itself excellent?)
  - Distribution factor: [1-5] (does the founder have fame/audience/partnerships?)
  - Timing factor: [1-5] (did they catch a wave?)
  - Luck factor: [1-5] (right place right time, viral moment?)

Can WE replicate each factor?
  - Product quality: [yes/no — we can build]
  - Distribution: [yes/no — do we have their audience? If no, this is the gap]
  - Timing: [yes/no — is the wave still rising?]

CONCLUSION: Which factors are replicable and which are not?
```

**Key rule:** If a product succeeds primarily because the founder is famous (distribution factor = 5), we CANNOT replicate their success by copying their product. We need a different distribution strategy.

**Second key rule:** Open-source popularity ≠ monetizability. Free GitHub stars do not prove willingness to pay. Always ask: "Would this person's COMPANY pay for this?" not "Would a developer star this?"

---

## Phase 3: Revenue Model — Follow the Money

Answer these in order:
1. **Who is the buyer?** Not "developers" — specific: "DevOps engineers at 50-200 person SaaS companies"
2. **What job do they hire us for?** JTBD format: "When I [situation], I want to [motivation], so I can [outcome]"
3. **What do they currently use?** Every job is already being done somehow
4. **Why would they switch?** Push (dissatisfaction) + Pull (attraction) must exceed Anxiety (switching fear) + Inertia (habit)
5. **What price?** Anchor against what they pay now, not what you think is fair. If they pay $0 now, you need extraordinary pull.
6. **Unit economics:** Revenue per customer/month minus cost to serve. Must be positive.

---

## Phase 4: Distribution — Zero-Audience Playbook

Since we have no fame and no money, our ONLY viable channels are:

| Channel | How | Timeline | Cost |
|---|---|---|---|
| **Community embedding** | 20 min/day in 5-8 relevant subreddits/Discord/Slack. Help, don't pitch. | 3-6 weeks to first customer | $0 |
| **Product Hunt launch** | 50-120 hours prep. Self-hunt. Focus on comment quality, not upvote count. | Single launch event | $0 |
| **Product-led growth** | Free tier that demonstrates value instantly. Built-in sharing mechanics. | Ongoing | $0 |
| **SEO / comparison pages** | "[Competitor] alternative" pages. Target long-tail keywords. | 3-6 months to compound | $0 |

Channels that DON'T work for us:
- Paid ads (no money)
- Influencer partnerships (no connections)
- Enterprise sales (no credibility)
- Content marketing to 0 followers (no audience)

**Acid test:** Can we get 10 PAYING customers from our chosen channel in 30 days?

---

## Phase 5: Funding Path (if needed)

If the product validates but needs capital to scale:

| Option | Stage Required | Best For |
|---|---|---|
| **Entrepreneur First** | Pre-idea, solo founder OK | Finding co-founder + initial capital |
| **Antler** | Pre-idea to early | Solo founders, multiple global locations |
| **TinySeed** | Post-revenue B2B SaaS | Bootstrappers who want to stay bootstrapped |
| **Earnest Capital** | Post-launch | Founders who want optionality |

Do NOT apply before having traction. Even 5-10 passionate users substitute for fame.

---

## Acid Test

> "[Customer] pays [price] via [channel] because we [job fulfilled] better than [current alternative], and they can't easily switch because [moat]."

If this sentence cannot be completed → do NOT start coding. Iterate on the model.

---

## After Completing

Store these entities in Knowledge Graph MCP:
- `BusinessDecision`: the acid test sentence, date, and context
- `IdeaFilter`: which of the 5 tests passed/failed, with reasoning
- `SuccessDecomposition`: analysis of 3 competitors with factor ratings
- `RevenueModel`: buyer, JTBD, price, unit economics
- `DistributionPlan`: channel, 30-day plan, 10-customer target

Link all entities to the relevant project entity for future retrieval.

## Handoff to Development

If acid test passes:
1. Break the validated idea into MVP scope — the smallest set of features that test the core JTBD
2. Create GitHub issues for each MVP feature using `issue-create` skill
3. Proceed to `pre-code` → normal development flow
4. After MVP ships, invoke `product-eval` to score from user perspective

If acid test fails:
- Do NOT start coding. Invoke `biz-validate` to enter the validation loop.
- `biz-validate` will cycle through hypothesize → experiment → learn → pivot until the model is validated or killed.
