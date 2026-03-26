---
name: content-create
description: "Creates platform-optimized content from customer perspective. Triggers ONLY when: user asks to create content, write an article, or prepare marketing material for a specific platform. Do NOT trigger when: writing code documentation, README files, or technical docs."
---

# Content Creation SOP

## Step 1: Identify the Customer's Question

Use "They Ask, You Answer" (Marcus Sheridan). Every piece of content must answer a REAL question the target audience is already asking.

Prioritize the **Big 5** content types:
1. **Pricing/cost** — "How much does X cost?" "What affects the price of X?"
2. **Problems** — "What are the downsides of X?" "Problems with X"
3. **Comparisons** — "X vs Y" "How does X compare to Y?"
4. **Best-of lists** — "Best tools for X" "Top X solutions in 2025"
5. **Reviews** — "Is X worth it?" "Honest review of X"

Action: Ask the user what question they want to answer. If unclear, search the web for common questions in the target niche using forums, Reddit, Quora, and "People Also Ask" on Google.

## Step 2: Choose Platform and Format

Each platform has specific constraints. Match format to platform:

| Platform | Format | Length | Style |
|----------|--------|--------|-------|
| Dev.to / Hashnode | Technical tutorial | 800-1500 words | Code blocks, step-by-step, practical outcomes |
| Medium | Narrative essay | 1000-2000 words | Storytelling, personal experience, clear takeaways |
| Twitter/X | Thread | 5-10 tweets | Data-driven, opinionated, one idea per tweet |
| LinkedIn | Professional insight | 300-500 words | Lessons learned, career relevance, formatted for mobile |
| Reddit | Answer-format | 200-800 words | Genuinely helpful, zero self-promotion in the post body |
| Hacker News | Show HN only | Brief description | Working product required, factual, non-promotional |
| Blog (SEO) | Long-form guide | 1500-3000 words | Topic cluster model, keyword-optimized |

Action: Confirm platform with user before writing. If blog/SEO, identify the target keyword first.

## Step 3: Write from the Customer Perspective

This is the most common failure mode. Content must use the CUSTOMER'S vocabulary, not the developer's.

- **Wrong:** "Our microservices architecture enables horizontal scaling"
- **Right:** "Your app won't crash when 10,000 users show up at once"

Rules:
- Address their pain in their words — search forums/Reddit to learn their exact phrasing
- Show outcomes they care about (time saved, money saved, problems avoided)
- Use second person ("you") not first person ("we")
- Include specific, concrete examples — not abstract benefits

## Step 4: Apply the 95/5 Rule

- **95%** of the content must be pure, standalone value
- **5%** (at most) can mention the product — and only if naturally relevant
- Litmus test: would this content be valuable if the product didn't exist? If NO, rewrite.
- Product mentions go at the END, never the opening
- Never use phrases like "our solution" or "we built" in the first 80% of the content

## Step 5: SEO Optimization (Blog Content Only)

If the content targets search traffic:

1. **Topic cluster model:** identify the pillar page and where this piece fits as a cluster page
2. **Target keyword:** include in title, at least one H2, and first paragraph
3. **Search intent match:** read the top 5 Google results for the keyword — match the FORMAT they use (listicle, how-to, comparison, etc.)
4. **Internal linking:** link to pillar page and 2-3 related cluster pages
5. **Meta description:** write a compelling 150-160 character description with the keyword
6. **Headers:** use H2/H3 hierarchy, include keyword variations in subheadings

Use web search to verify keyword volume and competition before committing to a keyword.

## Step 6: Quality Check

Before delivering the content, verify ALL of the following:

- [ ] Answers a real question the audience is asking (not a question we wish they'd ask)
- [ ] Uses the customer's vocabulary, not internal jargon
- [ ] Would get upvoted/shared on its own merit with zero product mention
- [ ] Follows the platform's format and length constraints
- [ ] 95/5 rule: product mention is minimal and at the end (if present at all)
- [ ] Includes specific examples, numbers, or code — not just abstract advice
- [ ] Has a clear, compelling title that promises a specific outcome
- [ ] No fluff paragraphs — every paragraph earns its place

If any check fails, rewrite the failing section before delivering.

## Step 7: Store in Knowledge Graph

After content is created and approved, store:
- Topic and target keyword
- Platform and format
- Date created
- Target audience segment
- Links to published version (added after distribution)
- Performance metrics (added after tracking — views, clicks, conversions)

This builds a content library for future reference and prevents duplicate topics.

## Playwright MCP Usage

When publishing to API-allowed platforms (Dev.to, Medium, Hashnode):
1. Use Playwright to navigate to the platform's editor
2. Fill in title, body, tags, and canonical URL
3. Preview before publishing — take a screenshot for user review
4. Only publish after user confirms the preview looks correct

For platforms where automation is NOT allowed (Reddit, HN): draft the content in a local file and instruct the user to post manually.
