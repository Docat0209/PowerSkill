---
name: ux-audit
description: "Visual and UX quality audit using Playwright. Triggers ONLY when: PR has passed pre-pr and is ready to merge with UI/UX changes, or user explicitly asks for UX audit. Do NOT trigger for backend-only changes or during development."
---

# UX Audit — Visual & Functional Quality Gate

Run this audit AFTER pre-pr passes and BEFORE merging. The goal is to verify the product works correctly **from a user's perspective**, not just from a code perspective.

**Tools required:** Playwright MCP (`browser_navigate`, `browser_take_screenshot`, `browser_click`, `browser_type`, `browser_snapshot`, `browser_evaluate`)

---

## Phase 1: Visual Review (Screenshots)

Take screenshots of every page or component affected by this PR.

**For each screenshot, verify:**
- [ ] **Layout integrity** — elements are properly aligned, no overlapping, no overflow, spacing is consistent
- [ ] **Visual hierarchy** — primary actions are visually prominent, secondary actions are subordinate, information flows logically top-to-bottom / left-to-right
- [ ] **Color and contrast** — text is readable against its background, interactive elements are visually distinct from static content, disabled states are visually differentiated
- [ ] **Responsive behavior** — take screenshots at mobile (375px), tablet (768px), and desktop (1280px) widths. Layout adapts without breaking, no horizontal scrolling, touch targets are ≥44px on mobile
- [ ] **Empty states** — pages with no data show helpful guidance, not blank screens or raw error messages
- [ ] **Loading states** — skeleton screens or spinners appear during async operations, not frozen UI
- [ ] **Error states** — invalid inputs show clear, contextual error messages near the relevant field

**How to screenshot:**
```
browser_navigate → target URL
browser_take_screenshot → review the image
browser_resize → change viewport → browser_take_screenshot again
```

---

## Phase 2: Discoverability Test

Approach the interface as a **first-time user with zero prior knowledge**. Do not reference the code, issue description, or implementation details.

- [ ] **Can you find the new/changed feature?** Navigate from the app's entry point using only visible UI elements. If the feature requires more than 3 clicks or is hidden behind non-obvious navigation, flag it.
- [ ] **Are interactive elements recognizable?** Buttons look clickable, links look like links, inputs have placeholders or labels, drag targets have affordances.
- [ ] **Is the flow self-explanatory?** Without reading documentation, can you understand what each step does and what comes next? If you feel lost at any point, that is a UX failure.
- [ ] **Are labels and copy clear?** No developer jargon in user-facing text, no ambiguous button labels (e.g., "Submit" without context), no placeholder text left in production.

---

## Phase 3: Functional UX Test

Interact with every feature affected by this PR. Test both the **functionality** and the **experience** of using it.

**For each interaction, verify:**
- [ ] **Immediate feedback** — every user action produces a visible response within 100ms (button press effect, input character appears, loading indicator starts). No "dead clicks" where nothing happens.
- [ ] **State transitions** — UI updates correctly after actions: form submits → success message, item deleted → removed from list, toggle switched → state reflected everywhere it appears
- [ ] **Input behavior** — text fields accept input and display it in real time, selections are reflected immediately, multi-step forms preserve state between steps
- [ ] **Undo/recovery** — destructive actions have confirmation dialogs, accidental navigation away from unsaved work triggers a warning, errors are recoverable without data loss
- [ ] **Boundary conditions** — extremely long text wraps or truncates gracefully, rapid repeated clicks don't cause duplicate submissions, concurrent actions don't corrupt state
- [ ] **Keyboard navigation** — critical flows are completable with keyboard alone (Tab, Enter, Escape). Focus indicators are visible. Modal dialogs trap focus.
- [ ] **Cross-browser basics** — if feasible, test in both Chromium and Firefox (Playwright supports both)

**How to test interactions:**
```
browser_click → interact with element
browser_take_screenshot → verify visual response
browser_type → input text
browser_take_screenshot → verify real-time feedback
browser_snapshot → verify accessibility tree reflects correct state
```

---

## Phase 4: Performance Measurement

Use Playwright's `browser_evaluate` to run Performance API calls and measure Core Web Vitals.

**Metrics to collect:**

| Metric | Target | How to measure |
|--------|--------|----------------|
| **TTFB** (Time to First Byte) | < 200ms | `performance.getEntriesByType('navigation')[0].responseStart` |
| **FCP** (First Contentful Paint) | < 1.8s | `performance.getEntriesByType('paint').find(e => e.name === 'first-contentful-paint').startTime` |
| **LCP** (Largest Contentful Paint) | < 2.5s | `PerformanceObserver` with type `largest-contentful-paint` |
| **CLS** (Cumulative Layout Shift) | < 0.1 | `PerformanceObserver` with type `layout-shift`, sum entries without recent input |
| **Total page weight** | < 1MB initial | `performance.getEntriesByType('resource').reduce((sum, r) => sum + r.transferSize, 0)` |

**Process:**
1. Navigate to each affected page
2. Collect all metrics via `browser_evaluate`
3. Compare against targets
4. If any metric exceeds its target, flag it and investigate:
   - TTFB high → server/API latency
   - FCP high → render-blocking resources
   - LCP high → large images, slow fonts, heavy JS
   - CLS high → elements shifting after load (missing dimensions on images/embeds)
   - Page weight high → uncompressed assets, unnecessary dependencies

---

## Verdict

**Report format:**
```
## UX Audit Report

### Visual Review
- [PASS/FAIL] Layout, color, responsive, empty/loading/error states

### Discoverability
- [PASS/FAIL] Feature findable within 3 clicks, labels clear, flow self-explanatory

### Functional UX
- [PASS/FAIL] Immediate feedback, state transitions, input behavior, keyboard nav

### Performance
- TTFB: Xms (target <200ms) [PASS/FAIL]
- FCP: Xs (target <1.8s) [PASS/FAIL]
- LCP: Xs (target <2.5s) [PASS/FAIL]
- CLS: X (target <0.1) [PASS/FAIL]

### Issues Found
1. [severity] description — screenshot reference
```

**If ANY phase fails:** fix the issues before merging. Re-run the failing phase to verify the fix.
**If ALL phases pass:** state "UX audit passed. Ready to merge."

## Next Steps
After completing this skill, consider whether these are needed:
- Audit passed → merge the PR, then invoke `post-merge`
- Audit failed → fix issues, re-run `self-review`
