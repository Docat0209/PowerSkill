---
name: search-eval
description: "Deep evaluation of search results and dependencies. Triggers ONLY when: about to install a dependency, evaluating a GitHub project for adoption, or search results are contradictory and need structured credibility analysis. Do NOT trigger for routine searches — CLAUDE.md contains always-on search quality principles for everyday use."
---

# Search Result Quality Evaluation

Every time you process search results, evaluate before using. Do NOT treat search results as truth.
Apply these filters to every source before citing, recommending, or acting on it.

## Source Credibility (check every result)

- **Official docs / GitHub (stars > 1K) / academic papers** → trustworthy
- **Known media (TechCrunch, HN, Verge, official blogs)** → reference-worthy
- **Personal blog / Medium / content farm** → must cross-verify with at least one other independent source
- **SEO articles ("Top 10 Best...", "Ultimate Guide to...")** → assume untrustworthy unless backed by verifiable data
- **Forum answers (Stack Overflow, Reddit)** → check vote count, date, and whether the answer was accepted; cross-verify for critical decisions

## Evidence Check

- Has code / has data / has verifiable claims → trustworthy
- Pure opinions / pure advice / no concrete examples → lower weight
- Claims about a tool or project → verify by checking the actual repo (stars, activity, issues)
- Benchmarks without methodology → treat as anecdotal
- "Works for me" without reproduction steps → not evidence

## Multi-Source Consistency

- Only one source says it → treat as unverified, flag it
- 2 sources agree → plausible but not confirmed
- 3+ independent sources agree → can be trusted
- If sources contradict each other → flag the contradiction, present both sides

## Freshness

- Tech articles older than 2 years → may be outdated, check for newer alternatives
- GitHub repos with no updates in 6+ months → flag as potentially abandoned
- API documentation → always prefer the latest version; old docs may reference deprecated endpoints
- Framework guides → check which version they target; a React 16 guide is not valid for React 19

## GitHub Project Evaluation (before recommending or installing)

Run this checklist before recommending any library, tool, or dependency:

- **Stars < 500** → flag as unproven, warn the user explicitly
- **No recent commits (6+ months)** → flag as potentially abandoned
- **README has no real usage examples** → suspicious; may be vaporware
- **Open issues with no maintainer response** → sign of an unmaintained project
- **Always check:** stars, last commit date, number of contributors, open issues count
- **Compare alternatives** → never recommend the first result; check if there is a more popular or better-maintained option
- **License** → verify the license is compatible with the project's needs

## When in Doubt

Say "I couldn't find enough trustworthy information" — do NOT fabricate an answer from low-quality sources. It is always better to be honest about uncertainty than to present unreliable information as fact.

## Dependency Installation Rule

Before installing any dependency:
1. Run the GitHub evaluation checklist above
2. Check if the standard library or an existing dependency already solves the problem
3. Justify why this dependency is necessary — "it's popular" is not justification
4. Prefer dependencies with zero or minimal transitive dependencies

## Learning

After evaluating a dependency or tool, store the decision in auto memory (`memory/dependency_decisions.md`):
- Tool/library name
- Verdict (adopted/rejected), reason, date, alternatives considered
- This prevents re-evaluating the same tool in future conversations.

## Next Steps
After completing this skill, create tasks for applicable next steps using TaskCreate:
- Dependency approved → create task: "resume implementation — return to `pre-code` or calling context"
- Dependency rejected, need alternative → create task: "re-invoke `search-eval` — evaluate alternative dependency"

Only create tasks that are actually relevant. Do not create tasks for steps that don't apply to the current situation.
