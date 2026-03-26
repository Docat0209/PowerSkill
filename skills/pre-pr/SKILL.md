---
name: pre-pr
description: "Pull request quality gate. Triggers ONLY when: about to run gh pr create. Do NOT trigger when: discussing PR strategy or reviewing existing PRs."
---

# Pre-PR Quality Gate

Before creating any pull request, run through every section below. All items must pass.

## PR Size (Google Small CLs)

- **Ideal: 50-100 lines changed. Maximum: 200 lines.** Over 200 → split into stacked PRs.
- One PR = one concern — never bundle unrelated changes (Google).
- Separate refactoring PRs from feature/bugfix PRs — never mix formatting with logic (Google).
- If adding a new API, include a usage example in the same PR (Google).
- When in doubt, make the PR smaller — reviewers never complain about PRs too small (Google).

## PR Checklist

Every item must pass before creating the PR:

1. **All commits pushed to remote**
   - Run `git status` — confirm nothing unpushed
   - Never create a PR with local-only commits

2. **PR targets `dev` branch (NEVER directly to `main`)**
   - The only PRs to `main` are release merges from `dev`, approved by the user
   - If you are about to target `main`, STOP and ask the user

3. **PR links to issue**
   - Include `Closes #NUMBER` or `Fixes #NUMBER` in the PR body
   - Every PR must trace back to an issue — no orphan PRs

4. **PR description follows the standard format**
   ```
   ## Summary
   - What changed and why (1-3 bullet points)

   ## Test plan
   - How to verify this works
   ```

5. **Tests included in same PR as feature**
   - Unit tests at minimum; integration and E2E where appropriate
   - No "we'll add tests later" — an untested PR is an incomplete PR

6. **UI changes: include screenshots or recordings**
   - Before/after screenshots for visual changes
   - Screen recordings for interaction changes

7. **CI passing**
   - Run `gh pr checks NUMBER --watch --fail-fast`
   - Never merge a PR with failing checks

8. **Documentation updated if the PR changes how users build/test/interact (Google)**
   - README, API docs, setup guides — update in the same PR, not a follow-up

9. **Self-review: `git diff dev...HEAD` — read every line one more time**
   - Look for: debug code, TODO comments, unused imports, hardcoded values
   - Leave comments on non-obvious decisions

## PR Title

- Conventional format: `feat: add document upload` or `fix: sidebar collapse`
- Short, under 70 characters
- Details go in the body, not the title

## Critical Rules

- Never merge `dev` → `main` without explicit user approval
- Never force-push to a shared PR branch after review has started
- Every PR must leave the system in a working state (Google)

## Next Steps
After completing this skill, consider whether these are needed:
- PR created with UI changes → invoke `ux-audit` before merge
- PR created (backend only) → wait for CI, then merge
- After merge → invoke `post-merge`
