---
name: biz-think
description: "Business direction and model validation. Triggers when: deciding what product to build, evaluating a business idea, discussing pricing/monetization, planning customer acquisition, analyzing competition, or any question about commercial viability."
---

# biz-think: Business Direction Decision Skill

Use Sequential Thinking MCP to work through each phase as a separate thought. Store final decisions in Knowledge Graph MCP under entity type `BusinessDecision`.

Before starting: retrieve any prior `BusinessDecision` entities from Knowledge Graph MCP to maintain continuity with past analyses.

---

## Phase 1: Industry Position (Porter's Value Chain)

**Core question:** "Where in the value chain do we sit, and does this position allow us to capture revenue?"

**Framework source:** Michael Porter, *Competitive Advantage* (1985) — Value Chain Analysis

Checklist:
- [ ] Map the full industry chain: who creates input -> who builds -> who distributes -> who serves end user. Where are WE?
- [ ] Classify our position: infrastructure (low margin, high scale), platform (medium margin, network effects), or end-user tool (higher margin, direct relationship)?
- [ ] Disintermediation risk: can suppliers go direct to our customers? Can customers build this themselves?
- [ ] Decide: integrate vertically or specialize in one slice? (Solo devs: almost always specialize)

Output: one sentence stating our value chain position and why it can capture revenue.

---

## Phase 2: Revenue Source (Lean Canvas + JTBD + Van Westendorp)

**Core question:** "Who specifically pays, what job do they hire us for, and at what price?"

**Framework sources:** Ash Maurya, *Running Lean* (Lean Canvas); Clayton Christensen, *Competing Against Luck* (JTBD); Peter Van Westendorp, Price Sensitivity Meter (1976)

Checklist:
- [ ] State the Job to Be Done in customer language: "When I [situation], I want to [motivation], so I can [outcome]"
- [ ] What do they currently "hire" for this job? What gets "fired" when they hire us?
- [ ] 4 Forces of Progress: Push (dissatisfaction) + Pull (attraction) must outweigh Anxiety (switching fear) + Inertia (habit)
- [ ] Unit economics: price per customer per month minus cost to serve. Is it positive?
- [ ] Emotional dimension: what does completing this job make the customer FEEL?

Output: customer segment, JTBD statement, price point, and unit economics estimate.

---

## Phase 3: Distribution (Channel-Product Fit + Indie Hacker Validation)

**Core question:** "How do users find us, and can we get a stranger to pay within 30 days?"

**Framework sources:** Brian Balfour, Channel-Product Fit (Reforge); Rob Walling, *Start Small, Stay Small* (indie validation)

Checklist:
- [ ] Pick ONE primary channel for 90 days: SEO, Product Hunt, community (Reddit/HN), app marketplace, or PLG (freemium)
- [ ] Channel economics: CAC < 1/3 of LTV?
- [ ] Channel-product fit: SEO works when people search for solutions, communities when problem is discussed publicly, PLG when product demos value instantly
- [ ] Build distribution INTO the product: shareable outputs, "powered by" badges, referral mechanics
- [ ] Acid test: can you get 10 paying customers from this channel in 30 days?

Output: primary channel, CAC/LTV ratio, and the specific 30-day acquisition plan.

---

## Phase 4: Competitive Advantage (5 Moat Types)

**Core question:** "Why can't someone copy this in a weekend?"

**Framework source:** Hamilton Helmer, *7 Powers* (2016) — adapted to 5 moat types for early-stage

Rate each moat type (None / Weak / Strong) with feasibility notes:

1. **Network Effects** — hard initially, but data network effects are achievable
2. **Switching Costs** — achievable: customization, data lock-in, integrations, learned habits
3. **Scale Economics** — natural for software: marginal cost approaches 0
4. **Brand** — buildable: micro-niche category ownership, build in public
5. **IP/Proprietary Tech** — domain expertise, unique datasets, hard-to-replicate algorithms

Rules:
- At day 1: moat = speed + focus. Build switching costs deliberately from the start.
- Quarterly audit: could someone rebuild this in a weekend? If yes, no moat.

Output: strongest moat type, how to build it in 90 days, and the weekend-rebuild honest assessment.

---

## Phase 5: Validation (Sean Ellis PMF Survey + AARRR Pirate Metrics)

**Core question:** "Do real users consider this a must-have, and where is the funnel leaking?"

**Framework sources:** Sean Ellis, PMF Survey (2010); Dave McClure, AARRR Pirate Metrics (2007)

Checklist:
- [ ] Sean Ellis test: "How would you feel if you could no longer use this?" — target 40%+ "very disappointed"
- [ ] AARRR funnel: Acquisition -> Activation -> Retention -> Revenue -> Referral. Find biggest drop-off, fix it first.
- [ ] Define YOUR "aha moment" — the single action correlating with long-term retention
- [ ] Optimize retention before acquisition (do not pour into a leaky bucket)

Output: current PMF score (or expected), biggest funnel gap, and the one metric to fix first.

---

## Acid Test

> If you cannot answer "where does the money come from" in ONE sentence — naming the **specific customer**, the **specific job**, the **specific price**, and the **specific channel** — you do not have a business model yet.

Format the answer as: "[Customer] pays [price] via [channel] because we [job fulfilled]."

If this sentence cannot be completed, state what is missing and what must be validated next.

---

## After Completing

Store these entities in Knowledge Graph MCP:
- `BusinessDecision`: the acid test sentence, date, and context
- `ValueChainPosition`: phase 1 output
- `RevenueModel`: phase 2 output (customer, JTBD, price, unit economics)
- `DistributionPlan`: phase 3 output (channel, CAC/LTV, 30-day plan)
- `MoatAssessment`: phase 4 output (moat type, 90-day build plan)
- `ValidationStatus`: phase 5 output (PMF score, funnel gap, priority metric)

Link all entities to the relevant project entity for future retrieval.

## Next Steps — Handoff to Development

If the acid test passes (one-sentence answer exists):
1. Break the validated idea into MVP scope — the smallest set of features that test the core JTBD
2. Create GitHub issues for each MVP feature using `issue-create` skill
3. Proceed to `pre-code` → normal development flow
4. After MVP ships, invoke `product-eval` to score from user perspective

If the acid test fails:
- Do NOT start coding. Iterate on the business model until the acid test passes.
- Re-run phases with gaps. Store revised decisions in Knowledge Graph.
