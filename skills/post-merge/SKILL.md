---
name: post-merge
description: "Post-merge verification checklist. Triggers ONLY when: a PR has just been merged via gh pr merge. Do NOT trigger when: discussing merge strategy or planning future merges."
---

# Post-Merge Verification Checklist

After every PR merge, execute ALL FOUR steps. Every time. No exceptions.
Skipping any step is a process failure, not a shortcut.

## Step 1: Verify the Fix Actually Works

- Start the dev server or run the app
- Test the feature/fix manually or with Playwright
- Reproduce the original bug or exercise the new feature end-to-end
- **Unit tests passing is NOT verification** — the app must work in practice
- If you cannot prove it works, **DO NOT close the issue**
- The issue stays open until real verification is complete

## Step 2: Check Acceptance Criteria Boxes

- Go to the linked GitHub issue
- Update the issue body: replace `- [ ]` with `- [x]` for all completed criteria
- Use the GitHub API to update:
  ```
  gh api repos/OWNER/REPO/issues/NUMBER -X PATCH -f body="..."
  ```
- If any acceptance criteria are NOT met, do not close the issue — go back and fix

## Step 3: Close the Issue

- Run: `gh issue close NUMBER`
- **Important:** `Closes #X` in the PR body only auto-closes issues when merging to the default branch (`main`), not `dev`
- Since we merge to `dev` first, you must close issues manually
- Only close after Steps 1 and 2 are complete

## Step 4: Delete the Branch

- Local: `git branch -d <branch-name>`
- Remote: `git push origin --delete <branch-name>`
- Keep the workspace clean — stale branches create confusion
- Verify deletion: `git branch -a` should no longer show the branch

## Reminder

All four steps. Every merge. No shortcuts. If you skip branch cleanup today, you will have 50 stale branches next month. If you skip verification, you will ship broken features. The process exists because it works.

## Next Steps
After completing this skill, consider whether these are needed:
- Feature complete (all issues closed) → invoke `product-eval` for quality scoring
- First deployment ever → consider `infra-ops` for monitoring
- First users expected → consider `support-ops` for support setup
- Need legal docs before launch → consider `legal-guard`
