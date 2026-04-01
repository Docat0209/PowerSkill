---
name: staging-verify
description: "Staging environment verification gate for release merges. Triggers ONLY when: about to merge dev→main, or all milestone issues are closed and ready for release. Do NOT trigger for feature→dev merges or during development."
---

This skill is the automated pre-merge structural check for release merges (dev → main). It verifies that all changes are accounted for, environment configuration is complete, and platform settings are correct. **Functional testing (Playwright + user testing) happens AFTER merge in post-merge, not here.**

## Step 1: Identify the Delta

Run `git log main..dev --oneline` to list all changes since last release. Run `git diff main..dev --stat` to see files changed. Categorize each change: new feature (`feat:`), bug fix (`fix:`), or other. For each feat/fix commit, find the linked issue number and read its acceptance criteria.

Output a delta summary table:

| # | Type | Description | Issue # | AC Count |
|---|------|-------------|---------|----------|

## Step 2: Environment and Platform Configuration Check

Verify the environment is correctly configured before merge:

- [ ] **Environment variables**: verify ALL required env vars are documented and set for the staging/production environment (not just localhost). Check `.env.example` or deployment config for any new vars introduced in this delta.
- [ ] **OAuth/Auth config**: if the app uses OAuth (Google, GitHub, Supabase Auth, etc.), verify the redirect URLs include the production/staging domain. A common failure: redirect URLs set to `localhost` or missing from the provider's allow list.
- [ ] **Payment/webhook config**: if the app has payment integration (Stripe, Polar, etc.), verify the webhook URL and API key mode (test vs. live) match the target environment.
- [ ] **Database**: verify any new migration files exist and are committed if schema changed.
- [ ] **Third-party services**: verify all external service integrations (email, storage, CDN) have the credentials and config required for the target environment.

If ANY configuration is missing: **STOP.** Fix the configuration gap first, then re-run this check.

## Step 3: Pre-Merge Structural Verification

For each change in the delta, verify WITHOUT running the app:

- [ ] **Code completeness**: every issue's acceptance criteria can be traced to committed code changes
- [ ] **Test coverage**: every feat/fix issue has corresponding test files (unit at minimum)
- [ ] **No debug artifacts**: grep for `console.log`, `debugger`, `TODO`, `FIXME` in changed files
- [ ] **No secrets**: grep for hardcoded API keys, tokens, passwords in changed files
- [ ] **Dependencies declared**: any new npm/pip/etc. packages are in the manifest files
- [ ] **Database migrations**: if schema changed, migration files exist and are committed

This is NOT functional testing — that happens in post-merge after deployment. This is a checklist to ensure nothing was forgotten before the code hits main.

## Step 4: Verdict and Report

Generate a verification report in this format:

```markdown
## Staging Verification Report
**Date**: YYYY-MM-DD | **Staging URL**: <url> | **Dev commit**: <hash>

### Delta Summary
| # | Type | Description | Issue |
|---|------|-------------|-------|
| 1 | feat | Add CSV export | #12 |
| 2 | fix  | Sidebar collapse on mobile | #15 |

### Structural Check Results
| # | Feature | Code Complete | Tests Exist | No Debug/Secrets | Status |
|---|---------|--------------|-------------|-----------------|--------|
| 1 | CSV export | ✅ | ✅ | ✅ | ✅ PASS |
| 2 | Sidebar fix | ✅ | ✅ | ✅ | ✅ PASS |

### Verdict
✅ ALL VERIFIED — Proceeding with dev→main merge and release
```

If any structural checks fail, use this verdict block instead:

```markdown
### Verdict
❌ BLOCKED — [N] structural issues found. Fix before merging.
```

**If ALL pass:** Proceed autonomously:

1. Create PR from dev→main with the verification report as the PR body
2. Merge the PR: `gh pr merge NUMBER --merge`
3. Invoke `post-merge` (which will deploy, run Playwright verification, and create the release)

**If ANY fail:** Fix the gap (missing tests, debug artifact, undeclared dependency, etc.), commit to dev, and re-run this check. Do not merge.

## Next Steps

After completing this skill, create tasks for applicable next steps using TaskCreate:

- All checks pass, PR merged → create task: "invoke `post-merge` — deploy, run Playwright verification, and create release"
- Structural failures found → create task: "invoke `issue-create` — create fix issue for the gap found, then `pre-code` to implement"
- Environment configuration missing → create task: "fix environment config gap identified in Step 2, then re-run staging-verify"

Only create tasks that are actually relevant.
