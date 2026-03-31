---
name: self-review
description: "Reviews code quality before staging. Triggers ONLY when: implementation of a feature or fix is complete and code is ready to stage. Do NOT trigger after every small edit — only when a logical unit of work is done."
---

# Self-Review: Code Quality Gate

**When this triggers:** implementation complete, code written/modified, about to `git add`, or sub-agent returns code changes.

**Non-negotiable:** Never skip. Never assume correctness. Every line could contain a bug.

---

## Step 1: Read Your Own Diff

Run `git diff` and `git diff --staged` — read EVERY line.

- [ ] Read each hunk as if reviewing someone else's PR — do not skim
- [ ] Flag lines you did NOT intend to change (accidental whitespace, unrelated modifications)
- [ ] If diff is large, read file by file — never skip files
- [ ] Confirm every changed line is intentional and necessary

---

## Step 2: Correctness

- [ ] **Solves the stated problem?** Re-read issue/request, compare against acceptance criteria
- [ ] **Edge cases handled?** Empty input, null/undefined, zero-length arrays, negative numbers, Unicode, concurrent access
- [ ] **Off-by-one errors?** Loop boundaries, array indexing, string slicing, pagination offsets
- [ ] **Null checks present?** Function params, API responses, DB results, optional chaining — every nullable value checked before use
- [ ] **Race conditions?** Missing `await`, shared mutable state, async operations that assume ordering
- [ ] **Return values checked?** Non-void function return values must be used or explicitly discarded — never silently ignored (NASA Power of 10, Rule 7)

---

## Step 3: Design & Complexity (Google Engineering Practices + Clean Code + SOLID)

- [ ] **Functions do ONE thing**, max ~20 lines (Clean Code, Ch. 3)
- [ ] **Function arguments:** 0 ideal, 1 good, 2 acceptable, 3+ requires refactoring (Clean Code, Ch. 3)
- [ ] **No boolean/flag arguments** — they prove the function does more than one thing (Clean Code, Ch. 3)
- [ ] **"Too complex" test:** if a reader can't understand it quickly, simplify (Google: "too complex")
- [ ] **No over-engineering** — solve the problem NOW, not speculative future needs (Google: YAGNI)
- [ ] **Single Responsibility:** if you describe a class/module with "and", split it (SOLID-S)
- [ ] **New API?** Include a usage example so reviewers see how it's called (Google: small CLs)
- [ ] **Names are intention-revealing** — reader knows what it does from name alone (Clean Code, Ch. 2)
- [ ] **Comments explain WHY, never WHAT** — if code needs a "what" comment, simplify the code (Google)

---

## Step 4: Code Hygiene (Clean Code + Boy Scout Rule)

- [ ] **Delete dead code** — don't comment it out, VCS has history (Clean Code, Ch. 4)
- [ ] **Delete all unused imports, variables, functions** — zero tolerance
- [ ] **No silently swallowed errors:** empty `catch {}`, `.catch(() => {})`, ignored rejections — every error must be logged or re-thrown
- [ ] **No backward-compat hacks, alias re-exports, redundant naming** (v2/New/Old prefixes)
- [ ] **No copy-pasted code** — if same logic appears twice, extract it (DRY)
- [ ] **Types are correct and specific** — no `any` in TypeScript unless truly unavoidable, no overly broad types
- [ ] **Boy Scout Rule:** leave the code cleaner than you found it (Clean Code, Ch. 1)

---

## Step 5: Security (OWASP Top 10 2021)

- [ ] **No hardcoded secrets** — tokens, API keys, passwords, connection strings — not in code, comments, or config literals
- [ ] **A03 Injection:** parameterized queries for ALL database access — never string concatenation for SQL/NoSQL
- [ ] **A03 XSS:** escape/sanitize all user-supplied content before rendering in HTML
- [ ] **A01 Broken Access Control:** deny by default, enforce authorization on every endpoint/action
- [ ] **A09 Security Logging:** log auth attempts and access control failures, but NEVER log sensitive data (passwords, tokens, PII)
- [ ] **No command injection:** never pass user input to `exec()`, `eval()`, `child_process`, or shell commands
- [ ] **Input validation at system boundaries:** API endpoints, form handlers, webhooks — validate and sanitize before processing

---

### 6. Scope Check

- [ ] Run `git diff --stat` — are ALL changed files within the scope identified in pre-code?
- [ ] If any file was modified that is NOT in the expected scope: justify it or revert it.
- [ ] Out-of-scope improvements spotted during development belong in new issues, not this PR.

---

### 7. Agent Output Verification

- [ ] **"Build passes" ≠ "product works."** If the build/tests pass, that verifies CODE correctness, not PRODUCT correctness.
- [ ] Have you actually SEEN the output? Not read the code — seen the rendered result, clicked the buttons, observed the behavior?
- [ ] If a sub-agent reported success: verify it yourself. Agents can write code but cannot judge product quality.
- [ ] **Rule:** Never trust "it should work." Run it. See it. Click it. If you can't verify it visually, flag it for staging-verify or manual testing.

---

## Step 8: Verdict

**If ANY issue was found:**
1. Fix it immediately — do not proceed with staging or committing
2. Re-run self-review from Step 1 on the new diff
3. Repeat until review is clean

**When clean, report:**
- Which steps completed, issues found and fixed
- State: **"Self-review passed. Ready to stage/commit."**

**If uncertain about correctness:**
- Run the code, write a test, or verify — do not guess
- "It should work" is NOT acceptable — prove it works

## Next Steps
After completing this skill, create tasks for applicable next steps using TaskCreate:
- Self-review passed → create task: "invoke `test-gate` — verify test coverage before PR"
- If code touches UI → create task: "invoke `ux-audit` — run visual and functional UX audit after PR"

Only create tasks that are actually relevant. Do not create tasks for steps that don't apply to the current situation.
