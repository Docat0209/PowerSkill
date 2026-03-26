---
name: issue-create
description: "Enforces GitHub issue quality standards. Triggers ONLY when: about to run gh issue create, or pre-code skill identifies a missing issue. Do NOT trigger when: discussing issues conceptually or referencing existing issues."
---

# Issue Creation Quality Gate

A one-liner issue body is NEVER acceptable. Every issue must be detailed enough that someone unfamiliar with the project can understand and implement it. Write it once, write it right.

## Templates by Type

### Feature (`feat:` prefix)

```markdown
## Context
Why this feature is needed. What user problem does it solve?

## Acceptance Criteria
- [ ] (Observable, testable user-facing behavior)
- [ ] (NOT implementation tasks — describe what the user sees/experiences)

## Technical Notes
Implementation hints, relevant files, API contracts, architectural decisions.

## Dependencies
List issue numbers that must be completed first, or "None".

## Out of Scope
What this issue explicitly does NOT cover.
```

### Bug (`fix:` prefix)

```markdown
## Bug Description
What is broken, in one paragraph.

## Steps to Reproduce
1. Go to ...
2. Click on ...
3. Observe ...

## Expected Behavior
What should happen.

## Actual Behavior
What actually happens. Include error messages, logs, screenshots if available.

## Technical Notes
Likely root cause, relevant files, related issues.

## Severity
Critical / High / Medium / Low
```

### Chore / Refactor / Test / Docs (`chore:`, `refactor:`, `test:`, `docs:` prefix)

```markdown
## Context
Why this work is needed (tech debt, performance, maintainability, coverage gap).

## Scope
What is included in this issue.
What is NOT included (to prevent scope creep).

## Acceptance Criteria
- [ ] (Testable checkboxes: tests pass, no regression, build succeeds, etc.)

## Technical Notes
Files to modify, approach, migration steps if any.
```

## Organization Rules

- Use **milestones** for time-based grouping (sprints, phases, releases).
- Use **labels** for categorization. Standard priority labels: `P0-critical`, `P1-high`, `P2-medium`, `P3-low`.
- Apply priority label after creation: `gh issue edit NUMBER --add-label P1-high`
- Labels like `week-1`, `sprint-3` are anti-patterns — use milestones instead.
- Link related issues with `Depends on #X` or `Blocked by #X`.
- Every issue title uses Conventional Commits prefix: `feat:`, `fix:`, `chore:`, `refactor:`, `test:`, `docs:`.

## Next Steps
After completing this skill, consider whether these are needed:
- Issue created → invoke `pre-code` to start implementation
