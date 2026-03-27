---
name: pre-code
description: "Pre-coding readiness gate. Triggers ONLY when: about to write implementation code for a feature or fix. Do NOT trigger when: writing config files, documentation, scripts, or making quick single-line edits."
---

# Pre-Code Readiness Gate

Run this checklist BEFORE writing any implementation code. Every item must pass. If any item fails, STOP and resolve it before proceeding.

---

## 1. Issue Check

- [ ] A GitHub issue exists for this work.
- Run `gh issue list --state open` and confirm a matching issue exists.
- If NO issue exists: **STOP.** Create one first using the issue-create skill. Do not write code without a tracking issue.
- Note the issue number for branch naming and PR linking.

## 2. Branch Check

- [ ] The current branch is a feature branch created from `dev`.
- Run `git branch --show-current` to check.
- Valid branch prefixes: `feat/`, `fix/`, `chore/`, `refactor/`, `test/`, `docs/`
- If on `main`: **STOP.** Never branch from main. Switch to `dev` first, then create a feature branch.
- If on `dev`: **STOP.** Do not commit directly to `dev`. Create a feature branch:
  ```
  git checkout dev && git pull origin dev
  git checkout -b <type>/<short-name>
  ```
- If on an incorrectly named branch: rename it to follow the `<type>/<short-name>` convention.

## 3. Branch Pushed

- [ ] The branch has been pushed to the remote.
- Run `git log --oneline @{u}.. 2>/dev/null` to check tracking status.
- If the branch has no upstream: push immediately:
  ```
  git push -u origin <branch-name>
  ```
- Every subsequent commit must also be pushed right after creation. Never accumulate unpushed commits.

## 4. Requirements Clear

- [ ] Acceptance criteria are understood and unambiguous.
- Read the linked GitHub issue body. Check for acceptance criteria checkboxes.
- If criteria are vague or missing: **STOP.** Ask the user to clarify before writing code. Do not guess at requirements.
- If the issue lacks technical notes on approach: confirm the intended approach with the user for non-trivial changes.

## 5. Design Considerations (SOLID + Clean Code + NASA)

- [ ] Design principles have been reviewed for this change.
- **Dependency Inversion (SOLID-D):** High-level modules depend on abstractions, not concrete implementations. Inject dependencies; never instantiate collaborators directly inside business logic.
- **Simple control flow (NASA Rule 1):** Avoid deep nesting, no goto, minimize recursion. Every function should be readable top-to-bottom with obvious flow.
- **No dynamic memory after init (NASA Rule 3):** Allocate resources (connections, buffers, pools) at startup. Avoid runtime allocation in hot paths — prefer pre-allocated structures.
- **Single Responsibility (SOLID-S):** Each module/class has ONE reason to change. If a module serves two masters, split it.
- **Threat model during design (OWASP A04):** For security-sensitive features, identify threat vectors before coding. Consider: auth bypass, injection, data exposure, privilege escalation.
- **Input validation at system boundaries:** Identify where untrusted data enters the system. Validate and sanitize at those boundaries, not deep inside business logic.

## 6. Test Plan

- [ ] A test plan has been identified for this work.
- **Unit tests**: always required. Identify what logic needs unit tests.
- **Integration tests**: required if the code touches any external service (database, API, auth, storage). If API keys or env vars are needed, ask the user NOW — not after implementation.
- **E2E tests**: required if the change completes a user-facing flow. Confirm Playwright is set up.
- Tests go in the SAME branch and PR as the implementation. Never defer testing to a separate issue.

---

## All Clear

Once every box is checked, proceed with implementation. Reference the issue number in commits using Conventional Commits format: `<type>: <description> (#issue)`

## Next Steps
After completing this skill, create tasks for applicable next steps using TaskCreate:
- No issue exists → create task: "invoke `issue-create` — create tracking issue before coding"
- Implementation complete → create task: "invoke `self-review` — review code quality before staging"

Only create tasks that are actually relevant. Do not create tasks for steps that don't apply to the current situation.
