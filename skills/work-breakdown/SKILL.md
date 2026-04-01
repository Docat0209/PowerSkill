---
name: work-breakdown
description: "Decomposes a milestone into atomic GitHub issues with commit plans and test requirements. Triggers ONLY when: roadmap-steer has selected a feature/milestone to build next, biz-think acid test has passed and work is greenlit, or user explicitly asks to plan/decompose/break down work. Do NOT trigger when: implementation is already in progress, the task is a single-file quick fix requiring no planning, or issues already exist for the milestone."
---

# Work Breakdown

Decompose a milestone into atomic, independently-implementable issues — each with a commit plan, test plan, and dependency mapping — before any code is written.

## Input Requirements

Before starting, confirm you have both:

1. **Milestone**: An existing GitHub milestone (verify with `gh api repos/{owner}/{repo}/milestones` or `gh milestone list`). If it does not exist, create it first with `gh api repos/{owner}/{repo}/milestones -f title="..." -f description="..."`.
2. **Requirement description**: A clear statement of what the milestone delivers — user-facing behaviors, not implementation details. If this is vague, ask the user to clarify before proceeding.

If either is missing, stop and ask. Decomposing without a milestone or clear requirements produces orphaned issues that never ship.

## Decomposition Process

### Step 0: Read the Codebase First

**NEVER decompose based on imagination.** Before creating any issues:

- [ ] Read the project's file structure: `find . -type f -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.py" | head -50` (or the relevant language)
- [ ] Read key files: entry points, routing, database schema, existing components
- [ ] Identify what ALREADY EXISTS — do not create issues for features that are already built
- [ ] Identify which files would need to change for each planned feature
- [ ] If a feature touches only ONE existing file, it's likely smaller than you think

**Anti-pattern:** Decomposing a "dashboard" into 5 issues when the dashboard component already exists and just needs 3 lines changed. Read the code. Count the actual changes needed. Then decompose.

### Step 1: Identify User-Facing Behaviors

List every distinct thing a user can **do** or **observe** after the milestone is complete. Write these as behavior statements, not technical tasks.

Format:
```
Behaviors delivered by [Milestone Name]:
- B1: User can [action]
- B2: System [observable outcome]
- B3: User sees [UI state / response]
```

Do not conflate behaviors. "User can log in and see their dashboard" is two behaviors.

### Step 2: Break Each Behavior into Atomic Issues

For each behavior, identify the smallest independently-implementable unit of work. One issue = one concern.

Splitting rules:
- Backend logic and frontend rendering are separate issues
- Data model changes and business logic are separate issues
- A feature and its error handling are separate issues (unless the error path is one line)
- A new endpoint and its authentication guard are separate issues
- A UI component and the API call it triggers are separate issues

Name each issue: `[verb] [specific thing]` — e.g., "Add user authentication middleware", not "Auth stuff".

### Step 3: Granularity Check

Each issue must pass ALL four gates. If any gate fails, split the issue further.

| Gate | Limit | Fail condition |
|------|-------|----------------|
| Acceptance criteria | ≤ 5 items | More than 5 distinct verifiable outcomes |
| Files touched | ≤ 3 files | Implementation spans more than 3 files |
| Predicted commits | ≤ 3 commits | Requires more than 3 atomic commits |
| Estimated work | ≤ 4 hours | Honest estimate exceeds half a day |

A failing issue is not a problem — it is information. Split it and recheck.

- Each issue must reference SPECIFIC files to modify (not vague "implement X")
- If you can't name the files, you haven't read the codebase enough — go back to Step 0

## Commit Planning Per Issue

For each atomic issue, pre-plan every commit before writing a single line of code. This forces clarity on implementation sequence and catches hidden complexity early.

Rules:
- Implementation commits and test commits are always separate
- Each commit message must follow conventional commits format: `type(scope): description`
- Commit descriptions are present tense, imperative mood: "add", not "added" or "adds"
- 1–3 commits per issue maximum (if you need more, the issue failed the granularity check)

Embed in the issue body under `## Commit Plan`:

```markdown
## Commit Plan

1. `feat(scope): add [thing]` — implement the core logic
2. `test(scope): add unit tests for [thing]` — cover happy path and edge cases
3. `feat(scope): wire [thing] to [integration point]` — only if a separate wiring step exists
```

## Test Planning Per Issue

For each atomic issue, identify what must be tested and at which layer. Apply these rules without exception:

| Condition | Required test type |
|-----------|-------------------|
| Touches an external service (API, DB, queue) | Integration test required |
| Completes a user-facing flow end-to-end | E2E test required |
| Contains pure logic (transformations, calculations, guards) | Unit test required |
| Modifies shared state or a data model | Integration test required |
| Renders a UI component | Component/unit test required |

An issue with no test requirement is a red flag — investigate whether it is truly atomic or whether it is glue code hiding inside a larger issue.

Embed in the issue body under `## Test Plan`:

```markdown
## Test Plan

- [ ] Unit: [what function/module, what cases]
- [ ] Integration: [what service interaction, what scenarios]
- [ ] E2E: [what user flow, what assertion]
```

Omit rows that do not apply. Never write "N/A" — if a test type is not needed, omit the row entirely.

## Dependency Ordering

After all issues are drafted, map which issues must complete before others can start.

Dependency rules:
- Data model issues block all issues that read or write that model
- API endpoint issues block frontend issues that call them
- Auth/middleware issues block all issues that require authentication
- Shared utility issues block all issues that import them

Produce a topological sort — a numbered implementation order with dependency annotations:

```
Implementation Order:

1. [Issue title] — no dependencies
2. [Issue title] — no dependencies
3. [Issue title] — depends on #1
4. [Issue title] — depends on #2, #3
5. [Issue title] — depends on #4
```

Verify there are no cycles. A cycle means two issues each depend on the other — this indicates a design problem. Resolve by extracting the shared dependency into a new issue that both can depend on.

## Batch Issue Creation

Create all issues in dependency order (create blockers first so you have their issue numbers when writing dependents).

For each issue, run:

```bash
gh issue create \
  --title "[verb] [specific thing]" \
  --milestone "[Milestone Name]" \
  --body "$(cat <<'EOF'
## Context

[1–2 sentences: why this issue exists and what it unblocks]

## Acceptance Criteria

- [ ] [Verifiable outcome 1]
- [ ] [Verifiable outcome 2]
- [ ] [Verifiable outcome 3]

## Dependencies

Depends on: #[issue number] — [brief reason]
(omit this section if no dependencies)

## Commit Plan

1. `type(scope): description`
2. `test(scope): description`

## Test Plan

- [ ] Unit: [what, which cases]
- [ ] Integration: [what, which scenarios]
EOF
)"
```

After all issues are created, update dependents that reference predecessors to include the actual issue numbers. Use `gh issue edit #N --body "..."` if a placeholder was used during creation.

## Verification Checklist

Before marking this skill complete, verify every item:

- [ ] Every issue has ≤ 5 acceptance criteria items
- [ ] Every issue has a `## Commit Plan` section with 1–3 conventional commit messages
- [ ] Every issue has a `## Test Plan` section with at least one test requirement
- [ ] Dependency graph is a DAG — run a mental topological sort and confirm no cycles exist
- [ ] Sum of all issue scopes covers the full milestone — no behavior from Step 1 is unaddressed
- [ ] No issue is a catch-all ("misc cleanup", "other tasks", "finishing touches") — every issue has a single, named concern
- [ ] All issues are assigned to the correct milestone (`gh issue list --milestone "[Name]"` to verify)

## Next Steps

After completing this skill, create tasks for applicable next steps using TaskCreate:

- If issues were created and need quality review before work starts → create task: "invoke `issue-create` for each issue that needs quality review — verify labels, assignees, and body completeness"
- If dependency order is confirmed and the team is ready to start → create task: "invoke `pre-code` — start implementation of first issue in dependency order"
