---
name: biz-think
description: "Evaluates business viability for a new product idea. Triggers ONLY when: the user asks to evaluate a business idea, asks what product to build, or says to run biz-think. Do NOT trigger when: discussing business concepts in passing, talking about existing product improvements, or during development work."
---

# biz-think: Business Direction Decision Skill

Use Sequential Thinking MCP to work through each phase as a separate thought. Store final decisions in auto memory (`memory/business_decisions.md`).

Before starting: read `memory/business_decisions.md` if it exists for continuity with past analyses.

---

## Phase -1: Opportunity Discovery (if no idea exists)

When the user says "help me find what to build" or "help me make money" — do NOT brainstorm from imagination. Go find where real people have real pain. Every method below produces first-hand signals, not second-hand listicles.

### Method A: First-Hand Observation (Reddit/Twitter/Forums)

Use WebSearch with `site:reddit.com` or `site:x.com` to find real user posts:

1. Search for IMPLICIT pain signals, not explicit wish-lists:
   - `site:reddit.com "[tool name] alternative" OR "switched from [tool]" OR "cancelled [tool]"` — users actively leaving tools
   - `site:reddit.com "I built a spreadsheet" OR "I wrote a script" OR "every week I manually"` — manual workarounds = proven need
   - `site:x.com "just spent 3 hours" OR "why is [tool] so" OR "finally gave up on"` — time-wasting frustration
2. For each signal found:
   - Is this a RECURRING problem (multiple unrelated users mention it)?
   - Is the person a PAYING professional (job title, company, context)?
   - Are they already PAYING for a bad solution? (strongest signal)
3. **Do NOT search for:** "micro saas ideas" "best saas ideas" "top 10" — these return SEO listicles, not real pain.
4. Collect at least 10 first-hand posts before concluding. Each must have: original URL, user quote, interaction count.

### Method B: Success Product Reverse Engineering

Pick 3-5 proven indie products (from IndieHackers, PH hall of fame, or GetLatka):

1. For each product, define its positioning: "[Category] but [Differentiation Angle]"
   - Plausible = "Analytics but privacy-first"
   - Carrd = "Website builder but one-page only"
   - Typefully = "Twitter client but writing-first"
   - Cal.com = "Calendly but open-source"
2. Ask: **what other angles in this category are NOT yet taken?**
   - "Analytics but [??]" — most minimal? Next.js specialized? E-commerce only?
   - Generate 3-5 untaken angles per category
3. For each untaken angle, quick-validate: search for competitors. If zero or only poor-quality competitors exist → potential opportunity.

### Method C: SOP Decomposition

Pick a specific role (indie developer, content creator, e-commerce operator, etc.):

1. Map their complete daily/weekly SOP step by step
2. For each step, ask: is there a tool? Is it good enough? Is it affordable?
3. The opportunity is NOT "which step hurts most" (that's already being solved) but "which step hurts most AND current solutions have an angle gap"
4. Combine with Method B: for the pain step, define "[Category] but [Differentiation Angle]"

### Method D: Founder Pain Priority

If the user has a specific pain they experience in their own work:

1. This is the highest-quality signal — skip straight to Acid Test
2. Founder-user fit dramatically increases chance of success
3. Validate by checking: do OTHER people have this same pain? (search Reddit/Twitter)

### Method E: Migration Wave Search

Search for SaaS companies that recently raised prices significantly:

1. Search: `"[tool name] pricing increase" OR "[tool name] price hike" OR "leaving [tool name]"` — within last 6 months
2. SaaS price surges (8-25% annually in 2025-2026) create migration windows where users are actively seeking alternatives
3. For each migration wave found:
   - How angry are users? (Reddit threads, Twitter complaints, HN posts)
   - What are they switching TO? Are the alternatives good enough?
   - Is there a "[Category] but [cheaper/simpler/specific-niche]" angle?
4. Time-sensitive opportunity — migration waves close within 6-12 months as users settle into new tools.

### Search Quality Check (mandatory after search)

Before presenting results, verify:
1. **Source quality**: how many results are "Top N SaaS Ideas 2026" listicles? If >30% → discard, redo search with better queries
2. **First-hand vs second-hand**: every idea must trace to a real user's original post (URL + quote), not a blogger's summary
3. **Differentiation angle**: every idea must have a "[Category] but [Angle]" positioning. Category alone = not complete

### Output

Present to user: 3-5 ranked opportunity candidates:

| # | Positioning ("[Category] but [Angle]") | Differentiation | Gates Pass? | Segment | Moat | Wow | Score |
|---|---------------------------------------|-----------------|-------------|---------|------|-----|-------|

Each entry must have a one-sentence positioning that includes the differentiation angle. If you can't write it, the idea isn't clear enough.

---

## Phase 0: Reality Check — Who Are We?

State this upfront in every analysis: **We have no audience, no brand, no capital.** This constrains everything.

Our advantages:
- AI-powered development speed (10x a normal solo dev)
- Near-zero build cost (time + API fees only)
- Ability to experiment fast and kill losers without sunk-cost pain

Every decision below must be evaluated through this lens. Skip strategies that require fame, funding, or a team.

---

## Phase 0.5: Devil's Advocate (mandatory before Acid Test)

Before running ANY evaluation, force yourself to argue AGAINST the idea:

1. **State your initial gut feeling** about this idea in one sentence
2. **Spawn a Devil's Advocate sub-agent** with this exact instruction:
   > "You are a skeptic. Your job is to DESTROY this idea: [one-sentence idea description]. Find 3 specific, evidence-backed reasons it will fail. Search the web for each reason. Do not accept the idea's premise — challenge it. Report: 3 kill reasons with evidence URLs."
3. **Review the counter-arguments.** For each kill reason:
   - Can you refute it with CONCRETE evidence (not rationalization)?
   - If yes → note the refutation with source
   - If no → this is a REAL risk. Carry it forward into the Acid Test
4. **Confidence check:** After reviewing all counter-arguments:
   - All 3 refuted with evidence → proceed to Acid Test with high confidence
   - 1-2 unrefuted → proceed but flag risks explicitly in the report
   - All 3 unrefuted → STOP. This idea has fundamental problems. Report to user: "Devil's Advocate found 3 unrefuted risks: [list]. Recommend: kill or pivot."

This step exists because humans (and agents) naturally seek confirming evidence. The Devil's Advocate forces disconfirming evidence to the surface BEFORE time is invested.

---

## Phase 1: Acid Test (Gate + Score)

Run every idea through this framework. Gates are binary (KILL/PASS). Scoring only happens after all gates pass.

### ═══ Gates (binary — fail = KILL) ═══

**Gate 1: Platform Test**
> "If OpenAI/Google/the dominant player built this as a free feature tomorrow, would we survive?"

- PASS: product requires persistent data, hosted infrastructure, workflow integration, embedded widgets, visual rendering, real-time notifications, or other capabilities that a chat interface cannot replicate
- KILL: core value is text generation, text rewriting, text analysis, content summarization, or translation — ChatGPT already does this for free

**Gate 2: Cost Gate**
> "Can we launch on free-tier infrastructure? Monthly operating cost < $50?"

- PASS: Vercel/Supabase/Railway free tier + pay-per-use API calls
- KILL: requires fixed high-cost API (e.g., Twitter API $200/mo), heavy compute infrastructure, or a platform license that can be revoked at any time (e.g., Reddit commercial API)

**Gate 3: Self-Test Gate**
> "Can we fully test and demo this product ourselves? Any geographic restrictions?"

- PASS: fully usable and testable from our location, with accessible test/sandbox environments
- KILL: requires region-locked services, payment processors we can't access, or real data we can't obtain for testing

All three gates must PASS. Any KILL → stop evaluating, move to next idea.

### ═══ Scoring (after all gates pass, 0-5 scale) ═══

**Market Segment (0-1 point):**
> "In this crowded market, is there an UNSERVED ANGLE?"

- 0: competing head-on with existing products, no differentiation
- 1: clear segment positioning — can express as "[Category] but [Angle]"

Validation: write the positioning sentence. If you can't → 0 points.

**Moat (0-2 points):**
> "The longer users use this, the harder it is to leave?"

- 0: zero switching cost (change a URL, swap a snippet)
- 1: one moat type present
- 2: two or more moat types, strengthening over time

Moat types that survive AI (2026):
- **Accumulated data** — user's history is here, moving is painful
- **Integration depth** — embedded in user's product/workflow
- **Network/community effects** — more users = more valuable
- **Brand trust** — open-source community, Build in Public credibility
- **SEO/content authority** — time-dependent ranking compound

Dead moats (AI killed these): feature count, UI polish, backend complexity.

**Wow Factor (0-2 points):**
> "First time seeing this, would someone share it with a friend?"

- 0: "Oh, another X tool"
- 1: "This is nice, solves my problem"
- 2: "Holy shit, this changes how I work"

Validation:
- Can value be explained in one sentence + one screenshot?
- Is there a natural sharing mechanism? ("Powered by", public dashboard, shareable output)
- Would this spark discussion on PH homepage?

### ═══ Score Interpretation ═══

| Score | Grade | Meaning |
|-------|-------|---------|
| 4-5 | A | Strong candidate ($1M+ ARR potential) → proceed to Phase 2-5 |
| 2-3 | B | Viable lifestyle business ($100K-$500K ARR) → proceed if aligned with goals |
| 0-1 | C | Likely painful struggle → suggest moving to next idea |

### Acid Test Sentence

Write one sentence: "We are building [product] for [who] that [does what differently from alternatives] because [why now]."

If you cannot fill in every blank with concrete specifics, the idea needs more work.

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

### Mandatory First Filter
Before ANY analysis: "This saves WHO how much TIME?" or "This earns WHO how much MONEY?"
Name a specific person + specific amount. Can't answer concretely = STOP.

### Product Thinking Traps

**Visible Need Trap**
Widely expressed needs (high-vote Reddit posts, viral Twitter complaints) look like gold mines but are traps. High visibility = everyone saw it = everyone is building it. The real opportunity is IMPLICIT needs: things people do daily without realizing it could be better. Search for manual workarounds, not explicit complaints.

**Head-On Competition Trap**
"A cheaper version of X" is NOT differentiation. All 8 validated success cases entered crowded markets, but NONE were "cheaper X." They were all "[X] but [different angle]." Cheaper is a tactic. Angle is a strategy.
- **Check:** Is your differentiation a PRICE or an ANGLE? If price only → reject.

**ChatGPT Substitution Blindspot**
If core value can be replicated with a prompt → dead on arrival.
- Safe core values: persistent data, hosted services, embedded components, workflow integration, visual rendering, real-time notifications
- Unsafe core values: text generation, text rewriting, text analysis, content summarization, translation
- **Check:** Can someone get 80% of this value by pasting a prompt into ChatGPT? If yes → KILL.

**Platform Dependency Risk**
If your product depends on a third-party API's commercial license, that platform can kill you overnight.
- **Check:** Before writing one line of code, verify: (1) API license allows commercial use, (2) pricing is sustainable, (3) no recent history of revoking access or dramatic price hikes.

**Assumed Need Without Observation**
NEVER assume users want something. Go LOOK at what they actually do on the platforms where they're active. Find 10 real examples or the need doesn't exist.

**Capability ≠ Need**
"We CAN build X with [technology]" ≠ "We SHOULD build X." Start from need, not capability.

**Rationalizing Weak Ideas**
Find counter-evidence FIRST. List 3 reasons this idea will fail. If you can't, you're not thinking critically enough.

**Ignoring Opportunity Cost**
Is this the BEST use of the next 3 days compared to all alternatives? Not "worth doing" — the HIGHEST value thing.

---

## Next Steps
Report to user: "Acid test result: [PASS/FAIL]. Recommended: [build/pivot/kill]. Reason: [one line]"

Suggested next steps (user decides):
- Acid test passes → "Run work-breakdown to decompose into issues"
- Acid test fails → "Run biz-validate to test assumptions"
- Pricing defined → "Run finance-ops to set up pricing"
- Distribution chosen → "Run community-engage or content-create"
