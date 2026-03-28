---
name: project-init
description: "Project initialization checklist. Triggers ONLY when: about to run git init, npm init, or creating a brand new repository. Do NOT trigger when: discussing project structure or working in an existing project."
---

# Project Initialization SOP

CI is the foundation that enforces everything else. Set it up FIRST, not last.

## 1. Git Setup

- [ ] `git init` (if not already a repo)
- [ ] Create initial commit on `main`
- [ ] Create `dev` branch from `main`: `git checkout -b dev`
- [ ] Push both branches: `git push -u origin main && git push -u origin dev`
- [ ] Set `dev` as the default working branch

## 2. First Issue

- [ ] Create GitHub Issue #1: "chore: project initialization" tracking all setup tasks
- [ ] Include acceptance criteria checkboxes for each step in this checklist
- [ ] Create branch `chore/project-init` from `dev`

## 3. Test Runner

- [ ] Detect project language and install the appropriate test runner:
  - JS/TS: Vitest (`vitest.config.ts`)
  - Python: pytest (`pyproject.toml` or `pytest.ini`)
  - Go: built-in `go test`
  - Other: use the community standard runner
- [ ] Add a sample passing test to verify the runner works
- [ ] Add test script to package manager (e.g., `"test": "vitest run"`)

## 4. E2E Setup

- [ ] Install Playwright: `npm init playwright@latest` (or equivalent)
- [ ] Create `tests/e2e/` directory
- [ ] Add a smoke test (e.g., app loads, returns 200)
- [ ] Ensure Playwright runs in CI (headless, with `npx playwright install --with-deps`)

## 5. CI/CD (GitHub Actions)

- [ ] Create `.github/workflows/ci.yml` with these steps:
  1. **Lint** (ESLint, ruff, golangci-lint, etc.)
  2. **Typecheck** (tsc --noEmit, mypy, etc.)
  3. **Unit + Integration tests** (vitest, pytest, go test)
  4. **E2E tests** (Playwright)
  5. **Build** (verify production build succeeds)
- [ ] Trigger on: push to `dev`, pull requests to `dev` and `main`
- [ ] Verify CI passes with a test push

## 6. Staging/Preview Environment

Set up automatic preview deployments for the `dev` branch. This enables automated verification via `staging-verify` before releasing to `main`.

- [ ] Detect or choose deployment platform:
  - **Vercel**: `vercel link` → enable Git Integration → preview deployments deploy automatically for all branches
  - **Netlify**: `netlify init` → Site settings → Build & deploy → Branch deploys → add `dev`
  - **Railway**: Create a service → add environment for `dev` branch
  - **Render**: Create a Preview Environment linked to `dev`
  - **Self-hosted**: Configure CI/CD to deploy `dev` branch to a staging subdomain
- [ ] Verify the `dev` branch has a stable preview URL (branch-level, not per-PR)
- [ ] Document the staging URL in the project's `CLAUDE.md`:
  ```markdown
  ## Environments
  - Production: <main-deploy-url>
  - Staging: <dev-preview-url>
  ```
- [ ] Verify staging deploys automatically on push to `dev`
- [ ] Smoke test: push a change to `dev`, confirm it appears at the staging URL

## 7. Branch Protection

- [ ] Protect `dev` branch via GitHub API or UI:
  - Require status checks to pass (CI workflow)
  - Require PR reviews (optional for solo projects)
- [ ] Verify protection works: a failing PR should be blocked

## 8. Project CLAUDE.md

- [ ] Create `CLAUDE.md` in project root with:
  - Project description and tech stack
  - How to run: dev server, tests, build, lint
  - Key directories and architecture notes
  - Environment variables needed (names only, no values)

## Completion

- [ ] Open PR from `chore/project-init` to `dev`
- [ ] Self-review the PR diff
- [ ] Merge, verify CI passes, close Issue #1, delete branch

## Learning

Store project metadata in auto memory (`memory/project_meta.md`):
- Project name
- Tech stack, test runner, CI setup, repo URL
- This enables cross-project pattern retrieval in future conversations.

## Next Steps
After completing this skill, create tasks for applicable next steps using TaskCreate:
- Project initialized → create task: "invoke `work-breakdown` — decompose initial features into atomic issues before coding"
- If deploying for first time → create task: "invoke `infra-ops` — set up monitoring and backup"
- If serving users → create task: "invoke `legal-guard` — create ToS and Privacy Policy"

Only create tasks that are actually relevant. Do not create tasks for steps that don't apply to the current situation.
