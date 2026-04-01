---
name: sop
description: "Prints the complete SOP flowchart. Triggers when: user asks to see the SOP, asks 'where are we?', asks 'what's next?', or says '/sop'. Always available."
---

# SoloForge SOP — You are the commander. Agent is the executor.

Print this flowchart for the user. If you know the current position, mark it with ➤.

## Complete Flow

```
Phase 1: DISCOVER — Find what to build
  You say: "幫我找產品機會" / "help me find opportunities"
  Agent runs: biz-think Phase -1 (browse Reddit/Twitter/PH for pain signals)
  Agent reports: 3-5 opportunities with data + competitor analysis
  You decide: pick one / reject all

Phase 2: VALIDATE — Confirm it's worth building
  You say: "評估這個方向" / "evaluate this direction"
  Agent runs: biz-think Phase 0-5 (acid test, anti-patterns, revenue model)
  Agent reports: "Acid test [PASS/FAIL]. Recommend: [build/pivot/kill]"
  You decide: build / pivot / kill
  If fail → you say: "驗證假設" → Agent runs biz-validate

Phase 3: PLAN — Break it down
  You say: "拆解這個產品" / "break this down"
  Agent runs: work-breakdown (read codebase → atomic issues → commit plans → test plans)
  Agent reports: "Milestone [name], [N] issues, test env needs: [list]"
  You decide: confirm / adjust

Phase 4: BUILD — Code it (autonomous inner loop)
  You say: "做 Issue #N" / "build the milestone"
  Agent runs per issue: pre-code → code → self-review → test-gate → pre-commit → pre-pr → merge
  Agent reports per issue: "Issue #N done. [N/total] complete. Changes: [summary]"
  You: don't need to participate (unless agent gets stuck)

Phase 5: VERIFY — Deploy + test
  You say: "準備發布" / "prepare for release"
  Agent runs: staging-verify (structural check) → merge to main → wait for deploy
  Agent runs: Playwright tests on production URL
  Agent reports: "Production deployed. Agent found [N] bugs. Please test [URL]."
  You: test the product yourself, report bugs
  Agent: consolidates all bugs → creates issues → back to Phase 4

Phase 6: SHIP — Release + retrospective
  You say: "發布" / "release"
  Agent runs: create GitHub release + retro (git metrics analysis)
  Agent reports: "v[X.Y.Z] released. Retro: [metrics] + [action items]"
  You decide: next direction → back to Phase 1 or Phase 3

Available anytime:
  "幫我寫文案" → copy-craft    "幫我寫內容" → content-create
  "幫我看定價" → finance-ops   "幫我看法律" → legal-guard
  "幫我看品牌" → brand-build   "幫我做社群" → community-engage
  "幫我看數據" → data-decide   "幫我做銷售" → sales-close
  "幫我看基礎設施" → infra-ops  "幫我看客服" → support-ops
  "幫我發佈內容" → content-distribute
  "幫我看增長" → growth-track   "幫我排優先級" → roadmap-steer
  "流程圖" / "/sop" → this flowchart
```

## Next Steps
After printing, tell the user where you think they currently are (if you can infer it from context), and suggest what they might want to do next.
