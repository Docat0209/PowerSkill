---
name: content-distribute
description: "Distributes one piece of content across multiple platforms. Triggers ONLY when: content-create has produced a piece and user wants to distribute it, or user says to cross-post content. Do NOT trigger when: creating original content (use content-create instead)."
---

# Content Distribution SOP

## Step 1: Receive Source Content

Take the source content (blog post, article, tutorial, etc.) and identify:
- **Core message:** the single main takeaway in one sentence
- **Key insights:** 5-8 distinct points or data points worth highlighting
- **Target audience:** who this is for (same audience, different platform behavior)
- **Links:** all URLs that need UTM tracking added

If source content doesn't exist yet, STOP and invoke `content-create` first.

## Step 2: Adapt for Each Platform

NEVER copy-paste the same content across platforms. Each adaptation must feel native to its platform.

### Dev.to / Hashnode
- Add `canonical_url` pointing to the original blog post (critical for SEO)
- Reformat code blocks to use platform syntax highlighting (triple backticks with language)
- Add a series tag if part of a content series
- Add 3-5 relevant tags from the platform's tag list
- Include a brief author bio at the end with one relevant link
- Use Playwright MCP to navigate to the editor, fill fields, and publish

### Medium
- Import using Medium's import tool (preserves formatting) OR reformat manually
- Set canonical URL to original post
- Add to relevant Medium publication if available
- Select 3-5 topic tags
- Use Playwright MCP to publish via the web editor

### Twitter/X Thread
- Extract 5-8 key insights as a numbered thread
- Tweet 1: hook — the most surprising or contrarian point (no links)
- Tweets 2-N: one insight per tweet, concrete and specific
- Final tweet: summary + link to full article with UTM
- Each tweet must stand alone — valuable even without context
- Use Playwright MCP to post the thread

### LinkedIn
- Rewrite as a professional reflection with a personal angle
- Open with a hook line (question or bold statement)
- Use short paragraphs (1-2 sentences each) — LinkedIn mobile formatting
- End with a question to drive comments
- Add link to full article in first comment, NOT in the post body (LinkedIn suppresses posts with links)
- Use Playwright MCP to post

### Reddit
- **NEVER automate posting.** Draft content only; user posts manually.
- Identify 2-3 relevant subreddits by searching for related discussions
- Read each subreddit's rules before drafting — some ban self-promotion entirely
- Write as an answer to a question that already exists in the subreddit
- Format: helpful context first, link to article only if the subreddit allows it
- Output: draft text + target subreddit + relevant existing thread (if replying)

### Hacker News
- **NEVER automate.** User must submit manually.
- Only submit if it's a Show HN with a working product or genuinely novel technical content
- Write a factual, non-promotional title (no superlatives, no marketing language)
- Output: suggested title + URL to submit

## Step 3: Platform Rules Compliance

Automation permissions:
| Platform | Automated Posting | Method |
|----------|-------------------|--------|
| Dev.to | ALLOWED | Playwright MCP or API |
| Hashnode | ALLOWED | Playwright MCP or API |
| Medium | ALLOWED | Playwright MCP or API |
| Twitter/X | ALLOWED | Playwright MCP |
| LinkedIn | ALLOWED (company page) | Playwright MCP |
| Reddit | NEVER | Draft only, user posts manually |
| Hacker News | NEVER | Draft only, user posts manually |

For any platform not listed: default to manual posting (draft only).

## Step 4: UTM Tracking

Add UTM parameters to ALL links back to owned properties:

```
?utm_source={platform}&utm_medium=social&utm_campaign={content-slug}
```

Examples:
- `?utm_source=devto&utm_medium=social&utm_campaign=how-to-deploy-nextjs`
- `?utm_source=twitter&utm_medium=social&utm_campaign=how-to-deploy-nextjs`
- `?utm_source=linkedin&utm_medium=social&utm_campaign=how-to-deploy-nextjs`

Never use UTM on links to third-party sites — only on links to YOUR properties.

## Step 5: Stagger Publishing Schedule

Do NOT publish everywhere simultaneously. Stagger over 3-5 days:

| Day | Platform | Reason |
|-----|----------|--------|
| Day 0 | Original blog | Establish canonical source |
| Day 1 | Dev.to / Hashnode | Technical audience, canonical URL set |
| Day 2 | Twitter/X thread | Drive engagement and discussion |
| Day 3 | LinkedIn | Professional audience, different time zone peak |
| Day 4 | Reddit (manual) | After other platforms validate the content resonates |
| Day 5 | Medium | Broader audience reach |

Adjust based on audience and time zones. Post during each platform's peak hours.

## Step 6: Track Performance

After publishing on each platform, store in Knowledge Graph:
- Platform name
- Published URL
- Date and time published
- Views (check at 24h, 72h, 7d)
- Engagement (likes, comments, shares, upvotes)
- Click-throughs (from UTM data in analytics)
- Conversions (signups, trials, purchases attributed)

## Step 7: Post-Distribution Review

After 7 days, review performance across all platforms:
- Which platform drove the most traffic?
- Which platform drove the most conversions (not just views)?
- What was the engagement rate (engagement / views) per platform?
- Were there comments or questions that suggest follow-up content?
- Update the Knowledge Graph with findings to inform future distribution decisions.

## Next Steps
After completing this skill, consider whether these are needed:
- Content distributed → consider `growth-track` to measure performance
- Need community engagement beyond content → consider `community-engage`
