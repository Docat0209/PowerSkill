---
name: retro
description: "Milestone retrospective for continuous improvement. Triggers ONLY when: a milestone is complete (all issues closed), or user explicitly asks for a retrospective. Do NOT trigger after individual PRs or during development."
---

Every completed milestone deserves a retrospective. This skill analyzes hard data from git history and GitHub to identify what went well, what went wrong, and what to change. No vague observations — every finding must be backed by data, and every recommendation must be actionable.

## Step 1: Gather Data

Run these commands to collect metrics for the milestone period:

```bash
git log --oneline --since="MILESTONE_START" --until="now"
```
```bash
git shortlog -sn --since="MILESTONE_START"
```
```bash
gh issue list --state closed --milestone "MILESTONE_NAME"
```
```bash
gh pr list --state merged --search "milestone:MILESTONE_NAME"
```

For each PR:
```bash
gh pr view NUMBER --json additions,deletions,changedFiles,commits
```

## Step 2: Analyze Metrics

Calculate and report these metrics in tables.

**Velocity Metrics:**

| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| Issues completed | N | — | — |
| Total commits | N | — | — |
| Avg commits per issue | N | 3-5 | ✅/⚠️ |
| Avg PR size (lines) | N | 50-100 | ✅/⚠️ |
| PRs over 200 lines | N | 0 | ✅/⚠️ |

**Quality Metrics:**

| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| Bug fix issues (fix:) | N | — | — |
| Bug ratio (fix / total) | N% | <20% | ✅/⚠️ |
| Avg time issue open→close | N days | — | — |
| Commits with "fix:" after merge | N | 0 | ✅/⚠️ |

**Process Health:**

| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| Issues without AC | N | 0 | ✅/⚠️ |
| Commits not following conventional format | N | 0 | ✅/⚠️ |
| PRs without linked issue | N | 0 | ✅/⚠️ |

## Step 3: Identify Patterns

Based on the data, answer these questions:

1. **What worked well?** — Which practices produced the best metrics? (e.g., "Issues created via work-breakdown had 40% smaller PRs")
2. **What went wrong?** — Where did metrics deviate from targets? (e.g., "3 PRs exceeded 200 lines — scope creep on feature X")
3. **Root causes** — For each "went wrong" item, ask WHY twice. Do not stop at symptoms.

## Step 4: Generate Action Items

For each root cause identified, produce ONE specific, actionable improvement.

Format:

```markdown
### Action Items
1. **[Problem]**: [Root cause] → **Action**: [Specific change to make]
   - Owner: [skill to update / process to change]
   - Measure: [How to verify this improved next milestone]
```

Rules:
- Maximum 3 action items per retro (focus beats breadth)
- Each must be implementable within the framework (update a skill, add a hook, change a threshold)
- Each must have a measurable success criteria for the next retro to verify
- If a skill's SOP contributed to a problem, propose a specific edit to that skill

## Step 5: Store and Compare

- Store the retro report in Knowledge Graph MCP for cross-conversation reference
- If a previous retro exists, compare: did the action items from last time improve the metrics?
- Track improvement trends across milestones

## Output Format

```markdown
## Retrospective: [Milestone Name]
**Period**: YYYY-MM-DD to YYYY-MM-DD | **Issues**: N closed | **PRs**: N merged

### Velocity
[table from Step 2]

### Quality
[table from Step 2]

### Process Health
[table from Step 2]

### What Worked Well
1. [Data-backed observation]

### What Went Wrong
1. [Data-backed observation] — Root cause: [why]

### Action Items
1. [Specific actionable improvement with measurement]

### Comparison with Previous Retro
[If exists: did prior action items improve metrics?]
```

## Next Steps

After completing this skill, create tasks for applicable next steps using TaskCreate:

- Action items require skill updates → create task: "implement retro action items — update affected skills"
- Ready for next milestone → create task: "invoke `roadmap-steer` — prioritize features for next milestone"
- Quality metrics below target → create task: "invoke `product-eval` — deep-dive product quality assessment"

Only create tasks that are actually relevant. Do not create tasks for steps that don't apply to the current situation.
