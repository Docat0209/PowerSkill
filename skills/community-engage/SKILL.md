---
name: community-engage
description: "Manages community presence and engagement strategy. Triggers ONLY when: user asks to find communities, plan community engagement, or draft community responses. Do NOT trigger when: creating content (use content-create) or distributing content (use content-distribute)."
---

# Community Engagement SOP

## Phase 1: Find Watering Holes

Reference: Etienne Garbugli, "Lean B2B" — go where your users already gather.

### Step 1: Map Potential Communities

Search the web for communities where the target audience discusses their problems. Check:

- **Reddit:** search for subreddits by topic keywords, check subscriber count and post frequency
- **Discord:** search Disboard, Discord.me, and Top.gg for relevant servers
- **Slack:** search Slofile, Standuply's Slack community list, and Google "[topic] slack community"
- **Forums:** product-specific forums, Stack Overflow tags, specialized communities (e.g., Indie Hackers, Elixir Forum)
- **Newsletters:** Substack, Beehiiv newsletters in the niche — comment sections are communities too
- **Twitter/X:** identify key accounts and their reply communities
- **LinkedIn Groups:** search for active groups (most are dead — verify activity before joining)

Output a table:

| Community | Platform | Members | Posts/Week | Audience Match | Commercial Tolerance |
|-----------|----------|---------|------------|----------------|---------------------|

### Step 2: Validate Each Community

For each candidate community, use Playwright MCP to browse and evaluate:

1. Read the last 50 posts/threads — are these actually your target users?
2. Check activity level — are posts getting responses? How old is the latest post?
3. Read the rules — is commercial activity tolerated, restricted, or banned?
4. Look for competitors — are similar products mentioned positively, negatively, or not at all?
5. Assess tone — technical, casual, meme-heavy, professional? You must match it.

Score each community 1-5 on: audience fit, activity, commercial tolerance, effort required.

### Step 3: Select 5-8 Communities

Pick based on:
- Audience fit score >= 4
- Activity level >= 3
- Commercial tolerance >= 2 (must allow SOME mention of tools/products)
- Manageable total time commitment (all communities combined <= 1 hour/day)

Quality over quantity. Being active in 5 communities beats being invisible in 20.

## Phase 2: Value-First Engagement

Reference: Mary Thengvall, "The Business Value of Developer Relations."

### Step 4: Weeks 1-4 — Pure Value, Zero Promotion

This phase is non-negotiable. For the first 2-4 weeks in each community:

1. **Answer questions** — find unanswered questions in your area of expertise. Write genuinely helpful, thorough responses.
2. **Share useful resources** — link to helpful articles, tools, tutorials (NOT your own product).
3. **Provide troubleshooting** — help people debug problems, even if unrelated to your product.
4. **Engage in discussions** — add thoughtful opinions, share relevant experiences.

Rules during this phase:
- ZERO product mentions. Not even subtle ones.
- Use your real name/identity — never create fake accounts
- Be genuinely helpful — if you're only helping to eventually promote, people will sense it
- Match the community's communication style (formal, casual, technical depth)

Use Playwright MCP to monitor communities daily and draft responses.

### Step 5: Build Reputation

Track your reputation in each community:
- Reddit: karma in specific subreddits
- Discord: role level, reaction count on your messages
- Stack Overflow: reputation score in relevant tags
- Forums: post count, thank-you reactions, moderator recognition
- Twitter/X: follower growth from community interactions

Milestones before graduating to Phase 3:
- At least 10 helpful responses in the community
- Positive feedback (upvotes, thanks, follows) on at least 5 responses
- Recognized by at least 2 community members as a regular contributor

### Step 6: Graduate to Mentioning Your Work

Only after meeting Phase 2 milestones. Rules:

- Mention your product ONLY when genuinely relevant to someone's specific question
- Frame it as "I built something that might help" — not "check out our product"
- Always disclose that you're the creator/affiliated
- If the community has rules about self-promotion, follow them exactly
- Never force a mention — if your product isn't the best answer, recommend what is

## Phase 3: Ongoing Operations

### Step 7: Daily Operations (20 min/day)

For the top 3 communities (highest engagement + conversion):
1. Check for new questions/discussions in your area
2. Respond to any replies to your previous comments
3. Upvote/react to other helpful content (reciprocity builds goodwill)
4. Draft responses — use Playwright MCP to browse, draft locally, post manually for Reddit/HN

### Step 8: Weekly Operations

Every week:
1. **Identify high-intent threads** — people actively asking for solutions you offer. Use web search and Playwright MCP to find phrases like "looking for", "any recommendations for", "alternative to [competitor]"
2. **Review engagement metrics** — which communities are you getting the most positive responses in?
3. **Content ideas** — note questions that keep coming up. These become content-create inputs.
4. **Respond to DMs/messages** — people who reach out directly are highest-intent leads

### Step 9: Monthly Review

Every month, evaluate each community:

| Community | Engagement Score | Referral Traffic | Signups | Conversion Rate | Time Invested |
|-----------|-----------------|------------------|---------|-----------------|---------------|

Decision rules:
- **Keep:** positive engagement trend + measurable referral traffic
- **Increase effort:** high conversion rate but low volume
- **Reduce effort:** high time investment, low conversion
- **Drop:** no engagement after 60 days of consistent effort

Replace dropped communities with new candidates. Always be testing.

### Step 10: Track in Auto Memory

Store in `memory/communities.md` for each community:
- Community name, platform, URL
- Join date
- Reputation/karma score (updated monthly)
- Number of posts/responses
- Referral traffic (from UTM or analytics)
- Conversions attributed
- Notes on tone, rules, best-performing content types

## Ethical Guidelines

- **Transparency:** if asked, always disclose you're affiliated with the product
- **Authenticity:** never create multiple accounts, fake reviews, or astroturf
- **Respect:** follow every community's rules, even inconvenient ones
- **The embarrassment test:** if you would be embarrassed to admit the response was AI-assisted or strategically motivated, don't post it
- **Reddit and HN:** NEVER automate posting. Draft content only. User posts manually.

Use Playwright MCP for:
- Browsing communities to find relevant threads
- Reading community rules and recent posts
- Monitoring for new discussions matching target keywords
- Drafting responses (saved locally, not posted automatically on Reddit/HN)

## Next Steps
After completing this skill, create tasks for applicable next steps using TaskCreate:
- Community engaged, leads identified → create task: "invoke `sales-close` — plan outreach to identified leads"
- Community asks questions → create task: "invoke `content-create` — create content answering common community questions"
- Community growing → create task: "invoke `growth-track` — track community acquisition metrics"

Only create tasks that are actually relevant. Do not create tasks for steps that don't apply to the current situation.
