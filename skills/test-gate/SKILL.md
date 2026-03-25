---
name: test-gate
description: "Testing completeness gate. Triggers when: feature implementation is complete, about to create a PR, code changes have no accompanying tests, discussing test coverage, or after self-review passes. Enforces three-layer testing requirements."
---

# Test Gate — Testing Completeness Check

Before proceeding (PR creation, merge, or marking a feature as done), verify ALL three testing layers are satisfied.

## Testing Pyramid (Martin Fowler)

- **Base:** Many fast unit tests — the foundation of confidence
- **Middle:** Fewer integration tests — verify real system interactions
- **Top:** Very few E2E tests — validate complete user flows

If the pyramid is inverted (more E2E than unit), refactor tests downward.

---

## Three Layers — ALL Required

### Layer 1: Unit Tests (mocked, isolated)
- [ ] Every function with logic gets a test — no exceptions
- [ ] Colocated with source files (`foo.test.ts` next to `foo.ts`)
- [ ] Must NOT depend on external systems (DB, network, filesystem) — use mocks/stubs to isolate
- [ ] Cover happy path AND edge cases, error conditions, boundary values
- [ ] **Trigger:** every feature, every PR

### Layer 2: Integration Tests (real services)
- [ ] Hit real databases, real APIs, real auth — mocks hide real bugs
- [ ] Stored in `tests/integration/` directory
- [ ] Cover: DB queries, external API calls, webhooks, service interactions
- [ ] **Trigger:** the moment code connects to ANY external service (DB, third-party API, storage, auth)
- [ ] If API keys or env setup is needed — **STOP and ask the user immediately**. Do not silently skip.

### Layer 3: E2E Tests (browser)
- [ ] Full user flow in a real browser (Playwright)
- [ ] Stored in `tests/e2e/` directory
- [ ] If the user can't click through it successfully, the feature is broken
- [ ] **Trigger:** the moment a user-facing flow can be completed end-to-end

**Do NOT defer any layer to "a testing phase." Each layer is written at its trigger point.**

---

## Test Quality Rules (AAA + Isolation)

### Structure: Arrange-Act-Assert
- [ ] **Arrange** — set up test data and preconditions
- [ ] **Act** — execute the single behavior under test
- [ ] **Assert** — verify the expected outcome
- [ ] Every test follows this three-phase structure explicitly

### Isolation Principles
- [ ] Each test is fully isolated — no shared mutable state between tests
- [ ] No order dependency — tests pass in any sequence
- [ ] Each test tests ONE behavior — if the test name contains "and", split it
- [ ] Tests must be deterministic — no randomness, no time-dependency, no flaky tests
- [ ] Clean up after yourself — reset state, close connections, remove temp files

### Naming & Readability
- [ ] Test names describe scenario and expected outcome: `shouldReturnEmpty_whenNoItems`
- [ ] Tests are production code — maintained, readable, no unnecessary complexity
- [ ] Avoid test helpers that obscure what is being tested

### Verification (Google Engineering Practices)
- [ ] Tests must actually fail when code is broken — verify no false positives
- [ ] Mutation check: temporarily break the code and confirm the test catches it
- [ ] Never write a test that passes regardless of implementation correctness

---

## What to Test

- [ ] Business logic and data transformations
- [ ] API endpoints: success cases, auth failures, validation errors, edge cases
- [ ] Integration points: DB queries, external APIs, webhooks
- [ ] User interactions: form submissions, navigation, error states
- [ ] **ALL variants, not just the happy path** — missing one variant = not tested
- [ ] Bug fixes: write a failing test FIRST that reproduces the bug, then fix, then verify the test passes

## What NOT to Test

- Framework internals (Next.js routing, React rendering mechanics)
- Pure configuration files
- Third-party library behavior

---

## Rules — Non-Negotiable

1. **No test = no feature.** Code without tests is unfinished code. Do not proceed.
2. **Tests in same PR as feature.** NEVER create a standalone "testing issue" to defer writing tests.
3. **Unit tests passing ≠ feature works.** Must verify by running the actual app (dev server + browser or Playwright).
4. **Bug fix verification protocol:**
   - Before fixing: reproduce the bug — prove it exists
   - Write a failing test that captures the bug
   - Write the fix
   - After fixing: reproduce again with the SAME steps — prove it's gone
   - If you can't complete all steps, the bug is NOT fixed
5. **Test fixtures** (sample input files, seed data) must be created alongside the feature, not deferred.

---

## Pre-PR Checklist

Before creating a PR, answer each question. If any answer is "no", go back and fix it.

- [ ] Do unit tests exist for every new/changed function with logic?
- [ ] Do integration tests exist for every external service interaction?
- [ ] Do E2E tests exist for every completable user-facing flow?
- [ ] Are all test variants covered (not just happy path)?
- [ ] Does every test follow Arrange-Act-Assert structure?
- [ ] Is every test isolated (no shared state, no order dependency)?
- [ ] Do all tests pass locally?
- [ ] Have you verified tests actually fail when code is broken (no false positives)?
- [ ] Have you verified the feature works by actually running the app?
- [ ] Are test fixtures included (not deferred)?
- [ ] If integration tests need API keys, have you asked the user for them?

**If any check fails, the feature is not ready for PR. Go back and complete it.**
