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

## 6. Branch Protection

- [ ] Protect `dev` branch via GitHub API or UI:
  - Require status checks to pass (CI workflow)
  - Require PR reviews (optional for solo projects)
- [ ] Verify protection works: a failing PR should be blocked

## 7. Project CLAUDE.md

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

Store project metadata in Knowledge Graph MCP:
- Entity: project name
- Observations: tech stack, test runner, CI setup, repo URL
- This enables cross-project pattern retrieval in future conversations.
