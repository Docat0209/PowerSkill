---
name: pre-commit
description: "Pre-commit quality gate. Triggers ONLY when: about to run git commit or git add to stage files. Do NOT trigger when: discussing commit strategy or mentioning commits in conversation."
---

# Pre-Commit Quality Gate

## Atomic Commit Rules

- Each commit = **EXACTLY ONE** logical change (Google: never mix formatting with logic).
- **Self-contained:** the project must build and pass existing tests after every commit (new tests may come in the next commit).
- Implementation and tests are **TWO separate commits** — implementation first, then tests. The implementation commit must not break any existing tests.
- Never bundle unrelated changes in a single commit.
- **Sweet spot:** 3-5 atomic commits per feature.

## Commit Message Format (Chris Beams + Conventional Commits)

Format: `<type>[scope]: <description>`

**Types:** `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `perf`, `ci`

**Rules:**
- Subject line: max 50 chars, imperative mood ("Add feature" not "Added feature"), no period at end.
- Separate subject from body with a blank line.
- Body (if needed): wrap at 72 chars, explain WHAT and WHY — not HOW.
- Breaking changes: append `!` after type or add `BREAKING CHANGE:` footer.

**Bad:** `git commit -m "add upload feature and fix sidebar and update tests"`
**Good:** Three separate commits:
1. `feat: add document upload API`
2. `fix: sidebar not collapsing on mobile`
3. `test: add upload API integration tests`

## Pre-Commit Checklist

Before every commit, run through ALL of these:

1. **`git diff --staged`** — read every line. Is this ONE logical change?
2. **Multiple logical changes staged?** → split (unstage with `git reset HEAD <file>`, commit separately).
3. **Commit message follows format?** Imperative mood, ≤50 chars, correct type?
4. **Dead code deleted?** (Clean Code: don't comment out code — VCS has the history.)
5. **No debug statements?** (`console.log`, `print`, `debugger`, `binding.pry`)
6. **No secrets, `.env` files, or credentials staged?**
7. **No TODO/FIXME comments left behind?**
8. **All compiler/linter warnings addressed?** (NASA Rule 10)
9. **Project still builds and passes tests with this commit?**
10. **Push immediately after commit** — never accumulate unpushed commits.

## Splitting Oversized Commits

If `git diff --staged` shows multiple logical changes:

1. `git reset HEAD .`
2. `git add <specific-files>` for the first logical change.
3. `git diff --staged` to verify only the intended change is staged.
4. Commit with the appropriate message.
5. Repeat for each remaining logical change.

## When Asking the User to Commit

After completing work, proactively ask: "Would you like to commit these changes?"
Present what will be committed and the proposed commit message. If the changes span multiple logical units, propose multiple atomic commits with their respective messages.
