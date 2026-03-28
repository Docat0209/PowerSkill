---
name: staging-verify
description: "Staging environment verification gate for release merges. Triggers ONLY when: about to merge dev→main, or all milestone issues are closed and ready for release. Do NOT trigger for feature→dev merges or during development."
---

This skill is the automated release gate. It replaces human approval with Playwright-verified proof that all changes work on a deployed staging environment. If verification passes, proceed with the dev→main merge autonomously. If it fails, go back to the development flow to fix issues.

## Step 1: Identify the Delta

Run `git log main..dev --oneline` to list all changes since last release. Run `git diff main..dev --stat` to see files changed. Categorize each change: new feature (`feat:`), bug fix (`fix:`), or other. For each feat/fix commit, find the linked issue number and read its acceptance criteria.

Output a delta summary table:

| # | Type | Description | Issue # | AC Count |
|---|------|-------------|---------|----------|

## Step 2: Detect Staging URL

Check in this order (first match wins):

1. Project's `CLAUDE.md` — look for `## Environments` section with a Staging URL
2. `.vercel/project.json` or `vercel.json` — Vercel preview deployment
3. `.netlify/state.json` or `netlify.toml` — Netlify branch deploy
4. `railway.json` or `Procfile` — Railway/Render/Fly.io
5. Environment variable `STAGING_URL`

If no staging URL found: **STOP.** Tell the user to set up preview deployments. Reference the `project-init` skill for setup instructions.

## Step 3: Wait for Deployment

Get the latest dev commit hash: `git rev-parse dev`. Poll the staging URL to verify it reflects the latest commit (check meta tag, API endpoint, or deployment platform API). Poll interval: 15 seconds. Timeout: 5 minutes.

If timeout: STOP and report "Staging deployment not reflecting latest dev commit after 5 minutes."

## Step 4: Playwright Verification

This is the core verification step. Follow these anti-superficial testing rules strictly.

**QA Persona — "Trust Nothing":**

You are now a QA engineer, not a developer. Your job is to break things, not confirm they work. Test from the user's perspective only.

**Rules:**

1. **UI-only testing** — Use ONLY Playwright MCP tools (`browser_navigate`, `browser_click`, `browser_fill_form`, `browser_snapshot`, `browser_take_screenshot`, etc.). Do NOT read source code to determine if something works.
2. **Screenshot evidence required** — Every verification MUST produce at least one screenshot as proof. A claim without a screenshot is not a verification.
3. **Test the acceptance criteria exactly** — For each issue in the delta, read its acceptance criteria checkboxes. Test each one individually on the staging URL. Do not invent your own criteria.
4. **Test at multiple viewports** — Desktop (1280px) AND mobile (375px) for any UI change.
5. **Exercise the full user flow** — For new features, complete the entire user journey from entry point to success state. For bug fixes, reproduce the original bug scenario and confirm it no longer occurs.
6. **Check for regressions** — After verifying the delta, navigate to 3–5 core pages/flows to confirm nothing else broke.

**For each change in the delta:**

- Navigate to the relevant page on the staging URL
- Follow the acceptance criteria steps exactly
- Take a screenshot at each verification point
- Record result: PASS (with screenshot evidence) or FAIL (with screenshot + description of what went wrong)

**Fix-and-Retest Loop (when a test FAILS):**

If `fixAttempts < 3` for this issue:

1. Document the failure with screenshot evidence
2. Create a fix issue using the `issue-create` skill (prefix: `fix:`)
3. Return to the development flow: `pre-code` → implement fix → `self-review` → `test-gate` → `pre-commit` → push to dev
4. Dev will auto-redeploy to staging
5. Re-invoke `staging-verify` — the fix will be picked up in the next delta scan
6. Increment `fixAttempts` for this issue

If `fixAttempts >= 3`: Mark as `known_issue`, add to the report, STOP and escalate to the user. Do not attempt further fixes.

**Persisting fix attempt counts:** Record `fixAttempts` as a comment on the issue (`gh issue comment NUMBER -b "staging-verify: fixAttempts=N"`) so the count survives across agent sessions. On re-invocation, read issue comments to restore the counter.

## Step 5: Verdict and Report

Generate a verification report in this format:

```markdown
## Staging Verification Report
**Date**: YYYY-MM-DD | **Staging URL**: <url> | **Dev commit**: <hash>

### Delta Summary
| # | Type | Description | Issue |
|---|------|-------------|-------|
| 1 | feat | Add CSV export | #12 |
| 2 | fix  | Sidebar collapse on mobile | #15 |

### Verification Results
| # | Feature | Criteria | Status | Evidence | Fix Attempts |
|---|---------|----------|--------|----------|--------------|
| 1 | CSV export | File downloads correctly | ✅ PASS | screenshot-1.png | 0 |
| 2 | Sidebar | Collapses on mobile 375px | ✅ PASS | screenshot-2.png | 1 |

### Regression Check
| Page/Flow | Status | Evidence |
|-----------|--------|----------|
| Homepage | ✅ OK | screenshot-3.png |
| Login flow | ✅ OK | screenshot-4.png |

### Verdict
✅ ALL VERIFIED — Proceeding with dev→main merge and release
```

If failures exist, use this verdict block instead:

```markdown
### Verdict
❌ BLOCKED — [N] issues need fixes. Returning to development flow.
Known issues (fix attempts exhausted): [list if any]
```

**If ALL pass:** Proceed autonomously:

1. Create PR from dev→main with the verification report as the PR body
2. Merge the PR: `gh pr merge NUMBER --merge`
3. Invoke `post-merge` (which will create the GitHub release)

**If ANY fail with `fixAttempts < 3`:** Return to development flow. Do not merge.

**If ANY marked as `known_issue`:** STOP and report to user. Do not merge.

## Next Steps

After completing this skill, create tasks for applicable next steps using TaskCreate:

- All verified, PR merged → create task: "invoke `post-merge` — run post-merge verification and create release"
- Test failures found → create task: "invoke `issue-create` — create fix issue for staging failure, then `pre-code` to implement"
- Known issues escalated → create task: "report known issues to user for decision"
- No staging URL found → create task: "invoke `project-init` — set up staging/preview environment"

Only create tasks that are actually relevant.
