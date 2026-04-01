---
name: biz-think
description: "Evaluates business viability for a new product idea. Triggers ONLY when: the user asks to evaluate a business idea, asks what product to build, or says to run biz-think. Do NOT trigger when: discussing business concepts in passing, talking about existing product improvements, or during development work."
---

# biz-think: Business Direction Decision Skill

Use Sequential Thinking MCP to work through each phase as a separate thought. Store final decisions in auto memory (`memory/business_decisions.md`).

Before starting: read `memory/business_decisions.md` if it exists for continuity with past analyses.

---

## Phase -1: Opportunity Discovery (if no idea exists)

When the user says "help me find what to build" or "help me make money" — do NOT brainstorm. Go LOOK at where real people express real pain. Ideas from imagination are worthless. Ideas from observed pain are gold.

### Method A: Reddit Pain Signal Mining

Use Playwright MCP to browse Reddit. Search for threads where people describe problems, frustrations, or manual workarounds:

1. Search queries: `[niche] "I wish there was" OR "anyone know a tool" OR "I've been manually" OR "this is so frustrating" OR "waste of time"` in relevant subreddits
2. For each pain thread found:
   - Is this person describing a REAL workflow problem (not a casual complaint)?
   - Are there replies saying "same here" or "I have this problem too"? (multiple signals > single signal)
   - Is the person currently using a manual workaround? (manual workaround = proven need)
   - Would they PAY to solve this? (look for mentions of time wasted, money lost, or existing paid tools they're unhappy with)
3. Collect at least 10 pain threads before drawing any conclusions. Fewer than 10 = insufficient data.

### Method B: Twitter/X Complaint Mining

Search Twitter for complaints about existing tools or workflows:

1. Search: `"[tool name] sucks" OR "[tool name] is broken" OR "why can't [tool]" OR "looking for alternative to [tool]"`
2. Look for patterns: same complaint from multiple unrelated users = real market signal
3. Check if the complainers have money (business accounts, job titles, company names in bio) — complaints from students ≠ market opportunity

### Method C: Product Hunt Trend Analysis + Viability Check

1. Browse https://www.producthunt.com/leaderboard/yearly/2026 — what categories are winning?
2. For trending categories, ask: is there a SPECIFIC underserved niche within this category?
3. Check hunted.space for launch history data — which types of products consistently get traction?
4. **PH viability filter:** Would this product be INTERESTING to the PH audience? PH rewards:
   - Novel approach to known problem (not "another X")
   - Beautiful, polished UX (demos well in a 1-minute video)
   - Clear value proposition in one sentence
   - Developer/maker tools, productivity, AI applications
5. If the product wouldn't be interesting on PH, it can still be viable — but you lose a distribution channel

### Method D: Competitor Gap Analysis

For each pain point discovered in Methods A-C:

1. Search for existing solutions: Google the pain point, check G2/Capterra reviews, check alternatives
2. For each competitor found:
   - Visit the ACTUAL product (don't just read about it)
   - Read pricing page — is there a pricing gap? (e.g., competitors charge $50+/mo but the problem could be solved for $10/mo)
   - Read negative reviews on G2/Capterra — what do users hate about existing solutions?
   - Check their tech stack — could we build something simpler/cheaper with modern tools?
3. **Differentiation test:** Can you beat competitors on:
   - **Price** (10x cheaper using AI/automation) — strongest for solo dev
   - **Simplicity** (do one thing 10x better while they do 10 things poorly)
   - **Speed** (faster time-to-value, no enterprise onboarding)
   - **Focus** (serve a specific niche they ignore)
4. If you can't clearly articulate your advantage in one sentence, move to the next pain point

### Method E: "Boring Problem" Niche Discovery

The best solo-dev opportunities are often in unsexy, underserved industries:

1. Browse industry-specific subreddits (r/smallbusiness, r/freelance, trade-specific forums)
2. Look for manual processes that haven't been digitized: spreadsheet workflows, email-based processes, paper forms
3. Target users who HAVE money and FEEL urgency: businesses (not consumers), professionals (not hobbyists), regulated industries (compliance = willingness to pay)
4. "Invoice software for tattoo studios" beats "another AI writing assistant" — the former has a specific customer, the latter has a million competitors

### Red Ocean Check

Before proceeding with any opportunity:
- Search "[idea] alternative" and count results — if there are 50+ alternatives, you need a VERY clear differentiator
- Search "[idea] shut down" or "[idea] failed" — learn from the dead
- Check if big companies (Google, Microsoft, etc.) offer this for free — if yes, move on
- **If it's a red ocean:** you can still win IF you have a concrete pricing, simplicity, or niche advantage. But you must name it NOW, not "figure it out later."

### Output

Present to the user: 3-5 ranked opportunity candidates, each with:
| # | Pain Point | Source (links) | Competitor Landscape | Your Advantage | PH Viable? |
|---|-----------|----------------|---------------------|---------------|------------|

Pick the top one (or let the user choose) and proceed to Phase 0.

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

Store these decisions in auto memory (`memory/business_decisions.md`) and update `MEMORY.md` index:
- `BusinessDecision`: the acid test sentence, date, and context
- `IdeaFilter`: which of the 5 tests passed/failed, with reasoning
- `SuccessDecomposition`: analysis of 3 competitors with factor ratings
- `RevenueModel`: buyer, JTBD, price, unit economics
- `DistributionPlan`: channel, 30-day plan, 10-customer target

Link all entities to the relevant project entity for future retrieval.

## Handoff to Development

If acid test passes:
1. Break the validated idea into MVP scope — the smallest set of features that test the core JTBD
2. Create a GitHub Milestone for the MVP (e.g., "MVP v0.1") with an optional deadline: `gh api repos/{owner}/{repo}/milestones -f title="MVP v0.1" -f due_on="YYYY-MM-DDTHH:MM:SSZ"`
3. Invoke `work-breakdown` — decompose the milestone into atomic issues with commit plans and test plans, assigned to the milestone
4. Proceed to `pre-code` for the first issue in dependency order → normal development flow
5. After MVP ships, invoke `product-eval` to score from user perspective

If acid test fails:
- Do NOT start coding. Invoke `biz-validate` to enter the validation loop.
- `biz-validate` will cycle through hypothesize → experiment → learn → pivot until the model is validated or killed.

## Anti-Patterns — Mistakes That Cost Days

These are proven failure patterns. Every idea evaluation MUST check for these. If you catch yourself doing any of these, STOP.

### Mandatory First Filter
Before ANY analysis, answer these two questions:
1. **"This saves WHO how much TIME?"** — Name a specific person and a specific time amount. "[Role] saves [N] hours/week on [task]" is valid. "It's useful" is not.
2. **"This earns WHO how much MONEY?"** — Name a specific revenue mechanism. If you can't answer either question concretely, **STOP. Do not proceed.**

### Product Thinking Traps

**"Pretty" ≠ "Valuable"**
- A product succeeds because it saves time or makes money, not because the output looks good. Visual appeal is a side effect of value, not the cause.
- If users share your product's output, ask WHY they share it. "The result is useful to them" ≠ "the design is nice."
- **Check:** Remove all visual polish from the concept. Does it still solve a problem? If no, you're building decoration.

**Assumed Need Without Observation**
- NEVER assume users want something. Go to the platforms where your target users are active and LOOK at what they actually do.
- If building for "[persona] who do [behavior]" — search for real examples RIGHT NOW and confirm they actually exhibit that behavior.
- **Check:** Find 10 real examples of your target users doing the thing you think they need help with. Can't find 10? The need doesn't exist.

**Wrong User Persona**
- Users with no revenue have no budget and no pressing needs. Don't build for them.
- Study users who already have revenue — they have real pain points AND money to pay for solutions.
- **Check:** Does your target user have budget to pay for this? If their budget is $0, they're the wrong target.

**Rationalizing Weak Ideas**
- You can find supporting evidence for ANY idea. This proves nothing.
- **Find counter-evidence FIRST.** Actively search for why this idea will FAIL. If you can only find supporting evidence, you haven't looked hard enough.
- **Check:** List 3 specific reasons this idea will fail. If you can't, you're not thinking critically enough.

**Lead Magnet ≠ Revenue Product**
- A great free tool (lead magnet) does NOT mean it should be a paid product. Free tools attract users; paid products solve expensive problems. Different logic entirely.
- **Check:** Would someone pay $X/month for this? Not "would they use it for free" — would they PAY?

**Capability ≠ Need**
- "We CAN build X with [technology]" does NOT mean "we SHOULD build X."
- Start from NEED ("users need Y"), then ask "can we build it?" Never reverse this: "we have technology Z, what can we build with it?"
- **Check:** Did this idea originate from a user need or from a technology capability? If capability → reject and reframe from the user's perspective.

**Pattern Matching ≠ Causation**
- "Product A has feature X and succeeds" does NOT mean "feature X causes success."
- Ask: "If feature X didn't exist, would Product A still succeed?" If yes, X is incidental, not causal.
- **Check:** For every "because" in your analysis, invert it. Does the conclusion still hold? If not, the causal link is weak.

**Ignoring Opportunity Cost**
- Every day building the wrong thing = one less day building the right thing.
- Before committing time, ask: is this the HIGHEST value activity right now? Not just "is this worth doing" but "is this THE BEST thing to do?"
- **Check:** "Is building this the BEST use of the next 3 days compared to all alternatives?"

**Scale Blindness**
- Large numbers (volume, impressions, activities) sound impressive but mean nothing without conversion data.
- Quantity ≠ quality. One conversation with a paying customer outweighs hundreds of automated interactions.
- **Check:** What's the expected conversion from this activity to revenue? If you can't estimate it, the activity is vanity metrics.

**Unverified Technical Dependencies**
- BEFORE planning features that depend on third-party APIs or platforms: verify they actually work for your use case.
- Check: rate limits, TOS restrictions, platform blocks, authentication requirements.
- **Check:** Run a proof-of-concept API call RIGHT NOW. Don't design a product around an API you haven't tested.

---

## Next Steps
Report to user: "Acid test result: [PASS/FAIL]. Recommended: [build/pivot/kill]. Reason: [one line]"

Suggested next steps (user decides):
- Acid test passes → "Run work-breakdown to decompose into issues"
- Acid test fails → "Run biz-validate to test assumptions"
- Pricing defined → "Run finance-ops to set up pricing"
- Distribution chosen → "Run community-engage or content-create"
