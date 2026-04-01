---
name: post-merge
description: "Post-merge verification checklist. Triggers ONLY when: a PR has just been merged via gh pr merge. Do NOT trigger when: discussing merge strategy or planning future merges."
---

# Post-Merge Verification Checklist

After every PR merge, execute ALL FIVE steps. Every time. No exceptions.
Skipping any step is a process failure, not a shortcut.

## Step 1: Production Functional Testing (after deployment)

After merging to main and deployment is live, run dual-track testing:

### Agent Testing (Playwright on production URL)

Use Playwright MCP to test the deployed production site. This is where functional testing happens — NOT in staging-verify.

- [ ] **Walk the complete user journey**: landing page → signup/login → main feature → key action → result
- [ ] **Test every feature in the delta**: for each issue merged, exercise the feature on production
- [ ] **Test at multiple viewports**: desktop (1280px) + mobile (375px)
- [ ] **Click every button**: "button exists" ≠ "button works." Test the FUNCTION, not the EXISTENCE
- [ ] **Screenshot everything**: take screenshots as evidence of each verification
- [ ] **Check for regressions**: navigate 3-5 core pages/flows beyond the delta

Report format:
```
## Production Test Report
| Feature | User Journey | Desktop | Mobile | Status |
|---------|-------------|---------|--------|--------|
```

### User Testing

After agent testing completes, invite the user to test:
- [ ] Tell the user: "Production is deployed at [URL]. Please test the new features and report any issues."
- [ ] User tests at their own pace — this is NOT a blocker for the current merge
- [ ] When user provides feedback: create issues immediately for each bug/improvement
- [ ] Do NOT argue "technically correct" — if the user says it doesn't work, it doesn't work

### Consolidate Bugs

After both rounds of testing:
- [ ] Combine agent-found and user-found issues into a prioritized list
- [ ] Create GitHub issues for each bug using `issue-create` skill
- [ ] These issues enter the NEXT development cycle — they do not block the current release

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

**Milestone Completion Check:**
After closing the issue, check if the milestone is now complete:
1. Get the issue's milestone: `gh issue view NUMBER --json milestone --jq '.milestone.title'`
2. If a milestone exists, check for remaining open issues: `gh issue list --milestone "MILESTONE_NAME" --state open`
3. If **0 open issues remain** → this milestone is complete. **Immediately invoke `retro`** — do not wait for the user to ask.
4. This check is mandatory, not optional. Every closed issue could be the last one in a milestone.

## Step 4: Delete the Branch

- Remote: use `--delete-branch` flag when merging PR, or `git push origin --delete <branch-name>`
- Local: `git branch -d <branch-name>`
- **Delete IMMEDIATELY after merge — do not defer.** If the PR was squash-merged, git loses merge tracking. The longer you wait, the harder it is to delete with `-d` (safe delete). Deleting right after merge avoids this entirely.
- Verify deletion: `git branch -a` should no longer show the branch

## Step 5: Create GitHub Release (main merges only)

This step applies ONLY when the merged PR was `dev` → `main` (a release merge). Skip for feature → `dev` merges.

**Determine version bump** by analyzing commits since the last release tag:
- Run: `git log $(git describe --tags --abbrev=0 2>/dev/null || echo HEAD~50)..HEAD --oneline`
- Contains `feat:` or `feat(` → **minor** bump (new functionality)
- Contains only `fix:` or `fix(` → **patch** bump (bug fixes only)
- Contains `BREAKING CHANGE` or `!:` → **major** bump
- If no prior tag exists, start at `v0.1.0`

**Create the release:**
```
gh release create vX.Y.Z --title "vX.Y.Z" --generate-notes --latest
```
- `--generate-notes` auto-generates release notes from merged PR titles
- Tags the current `main` HEAD

**Verify the release:**
- Run `gh release view vX.Y.Z` to confirm it was created
- Verify the tag: `git tag -l vX.Y.Z`

## Reminder

All five steps. Every merge. No shortcuts. If you skip branch cleanup today, you will have 50 stale branches next month. If you skip verification, you will ship broken features. The process exists because it works.

## Next Steps
After completing this skill, create tasks for applicable next steps using TaskCreate:
- Feature complete (all issues closed) → create task: "invoke `product-eval` — score product quality from user perspective"
- First deployment ever → create task: "invoke `infra-ops` — set up monitoring and backups"
- First users expected → create task: "invoke `support-ops` — set up support system"
- Need legal docs before launch → create task: "invoke `legal-guard` — create ToS and Privacy Policy"
- Release created (main merge) → create task: "verify production deployment is live, then invoke `growth-track` — track release impact on metrics"
- Milestone complete (all issues in milestone closed) → create task: "invoke `retro` — run milestone retrospective before starting next cycle"

Only create tasks that are actually relevant. Do not create tasks for steps that don't apply to the current situation.
