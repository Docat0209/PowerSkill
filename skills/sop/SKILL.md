---
name: sop
description: "Prints the complete SOP flowchart. Triggers when: user asks to see the SOP, asks 'where are we?', asks 'what's next?', or says '/sop'. Always available."
---

# SoloForge SOP — You are the commander. Agent is the executor.

Print this flowchart for the user. If you know the current position, mark it with ➤.

Every step = one skill = one thing. You follow the steps, agent executes each skill and reports back.

```
═══════════════════════════════════════════════════════════════
  PHASE 1: DISCOVER — Find what to build
═══════════════════════════════════════════════════════════════

Step 1.1 │ biz-think (Phase -1)
         │ You say: "幫我找產品機會"
         │ Agent: browses Reddit/Twitter/PH for pain signals
         │ Report: 3-5 opportunities with data + competitor analysis
         │ You: pick one / reject all
         │
         ↓
═══════════════════════════════════════════════════════════════
  PHASE 2: VALIDATE — Confirm it's worth building
═══════════════════════════════════════════════════════════════

Step 2.1 │ biz-think (Phase 0-5)
         │ You say: "評估這個方向"
         │ Agent: acid test, anti-patterns, revenue model, distribution
         │ Report: "Acid test [PASS/FAIL]. Recommend: [build/pivot/kill]"
         │ You: build → go to Phase 3
         │      pivot → go to Step 2.2
         │      kill  → back to Step 1.1
         │
         ↓ (if pivot or fail)

Step 2.2 │ biz-validate
         │ You say: "驗證假設"
         │ Agent: hypothesis → experiment → learn loop (max 5 rounds)
         │ Report: "Validation [PASS/FAIL]. Evidence: [summary]"
         │ You: validated → Phase 3
         │      kill → back to Step 1.1
         │
         ↓ (optional)

Step 2.3 │ brand-build
         │ You say: "幫我定品牌"
         │ Agent: positioning statement, voice, Build in Public strategy
         │ Report: "Positioning: [one sentence]. Voice: [3 adjectives]"
         │
         ↓
═══════════════════════════════════════════════════════════════
  PHASE 3: PLAN — Break it down
═══════════════════════════════════════════════════════════════

Step 3.1 │ project-init (new project only)
         │ You say: "初始化專案"
         │ Agent: git setup, CI/CD, staging env, CLAUDE.md
         │ Report: "Project [name] initialized. Git ✅ CI ✅ Staging ✅"
         │
         ↓

Step 3.2 │ work-breakdown
         │ You say: "拆解這個產品"
         │ Agent: read codebase → atomic issues → commit plans → test plans
         │ Report: "Milestone [name], [N] issues, test env needs: [list]"
         │ You: confirm / adjust issue list
         │
         ↓
═══════════════════════════════════════════════════════════════
  PHASE 4: BUILD — Code it (per issue, inner loop is autonomous)
═══════════════════════════════════════════════════════════════

You say: "做 Issue #N" or "build the milestone"
Agent runs the following automatically for each issue:

Step 4.1 │ issue-create
         │ Agent: create issue with AC, commit plan, test plan
         │ (skip if already created by work-breakdown)
         │
Step 4.2 │ pre-code
         │ Agent: issue check, branch check, scope boundaries, platform config
         │
Step 4.3 │ [write code]
         │ Agent: implement according to commit plan
         │
Step 4.4 │ self-review
         │ Agent: read diff, correctness, design, security, scope, output verification
         │
Step 4.5 │ test-gate
         │ Agent: verify unit + integration + E2E tests exist and pass
         │
Step 4.6 │ pre-commit
         │ Agent: atomic commit check, conventional format, no debug/secrets
         │
Step 4.7 │ pre-pr
         │ Agent: PR size check, links issue, targets dev
         │ If UI changes → ux-audit before merge
         │
Step 4.8 │ [merge to dev]
         │
Step 4.9 │ post-merge (partial)
         │ Agent: verify fix works, check AC boxes, close issue, delete branch
         │ Report: "Issue #N done. [N/total] complete. Changes: [summary]"
         │
         │ Repeat 4.1-4.9 for each issue until milestone complete
         │
         ↓
═══════════════════════════════════════════════════════════════
  PHASE 5: VERIFY — Deploy + test
═══════════════════════════════════════════════════════════════

Step 5.1 │ staging-verify
         │ You say: "準備發布"
         │ Agent: delta analysis, env vars check, platform config, structural check
         │ Report: "Structural check [PASS/FAIL]. Config: [complete/gaps]"
         │ If fail → fix gaps → re-run Step 5.1
         │
         ↓

Step 5.2 │ [merge dev → main]
         │ Agent: create PR, merge to main, wait for deploy
         │
         ↓

Step 5.3 │ post-merge (production testing)
         │ Agent: Playwright tests on production URL (full user journey)
         │ Report: "Production test: [N] bugs found. Please test [URL]."
         │
         ↓

Step 5.4 │ [You test]
         │ You: test the product yourself at production URL
         │ You: report bugs / feedback
         │ Agent: creates issues for all bugs → back to Phase 4 if needed
         │
         ↓ (when you're satisfied)

Step 5.5 │ product-eval (optional)
         │ You say: "評估產品品質"
         │ Agent: Nielsen heuristics, cognitive walkthrough, FTUE, HEART
         │ Report: "Score: [N]/100. Grade: [letter]. Top issues: [list]"
         │
         ↓
═══════════════════════════════════════════════════════════════
  PHASE 6: SHIP — Release + retrospective
═══════════════════════════════════════════════════════════════

Step 6.1 │ post-merge (release)
         │ You say: "發布"
         │ Agent: create GitHub release with semantic versioning
         │ Report: "v[X.Y.Z] released. [link]"
         │
         ↓

Step 6.2 │ retro
         │ Agent: analyze git metrics, identify improvements
         │ Report: "Retro: [metrics]. Action items: [list]"
         │
         ↓

Step 6.3 │ roadmap-steer
         │ You say: "下一步做什麼"
         │ Agent: RICE scoring, prioritize next feature
         │ Report: "Next feature: [name]. RICE: [score]"
         │ You: approve → back to Step 3.2
         │
         ↓ (cycle repeats)

═══════════════════════════════════════════════════════════════
  AVAILABLE ANYTIME (you can invoke these at any point)
═══════════════════════════════════════════════════════════════

  "幫我寫文案"     → copy-craft        "幫我寫內容"    → content-create
  "幫我看定價"     → finance-ops       "幫我看法律"    → legal-guard
  "幫我看品牌"     → brand-build       "幫我做社群"    → community-engage
  "幫我看數據"     → data-decide       "幫我做銷售"    → sales-close
  "幫我看基礎設施"  → infra-ops        "幫我看客服"    → support-ops
  "幫我發佈內容"   → content-distribute "幫我看增長"    → growth-track
  "幫我排優先級"   → roadmap-steer     "幫我看搜尋結果" → search-eval
  "流程圖" / "/sop" → this flowchart
```

## Next Steps
After printing, tell the user where you think they currently are (if you can infer it from context), and suggest what they might want to do next.
