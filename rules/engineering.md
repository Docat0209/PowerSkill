# Engineering Axioms

- No code without an issue and branch from `dev`
- No feature without tests (unit + integration + E2E)
- Every commit does exactly one thing (conventional commits format)
- CI is mandatory from project init — set it up FIRST
- Full cycle: Issue → Branch → Code+Test → Atomic Commits → PR → UX Audit → Merge → Verify
- Never merge `dev` → `main` without passing `staging-verify` (Playwright verification on staging)
- `main` ← `dev` ← feature branches. No shortcuts.
