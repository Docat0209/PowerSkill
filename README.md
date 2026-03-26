# SoloForge

**Full-lifecycle SOP system for Claude Code — from idea validation to development to marketing to growth**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

SoloForge turns Claude Code from a code generator into an autonomous business operating system. It enforces quality gates across the entire lifecycle — business strategy, development, marketing, growth, and operations — through automated SOP skills, safety hooks, and a critical thinking protocol that forces adversarial reasoning before conclusions.

---

## The Problem

AI coding agents don't check their own output. They claim work is done without testing, rationalize away quality issues ("pre-existing", "out of scope", "follow-up task"), and produce inconsistent results across sessions. Beyond code, they lack any structured approach to business decisions, marketing, or growth.

SoloForge solves this with **enforced quality gates at every workflow stage** -- a layered skill and hook system where each layer reinforces the others, covering the full journey from idea to revenue.

---

## Philosophy

- **Adversarial reasoning**: AI should argue both sides before concluding. The thinking protocol requires searching the web, finding contradictions, and synthesizing -- not just pattern-matching from training data.
- **Quality through process, not filtering**: Enforcement happens through skill SOPs at each workflow stage, not post-hoc output filtering. Every action has a checklist; every checklist has verification steps.
- **Critical thinking is structural**: Epistemic discipline, verification over assumption, and quality intolerance are built into the CLAUDE.md principles that sit in context permanently -- not bolted on as afterthoughts.

---

## How It Works

SoloForge is a 3-layer architecture where each layer reinforces the others:

```
Layer 1: CLAUDE.md  (133 lines)  -- Principles always in context
Layer 2: Skills     (26 SOPs)    -- Auto-triggered at workflow stages, loaded on-demand
Layer 3: Hooks      (3 hooks)    -- Deterministic enforcement, runs outside the LLM
```

- **Layer 1** sets the ground rules: epistemic discipline, verification over assumption, quality intolerance.
- **Layer 2** provides step-by-step SOPs that Claude invokes before each action (coding, committing, reviewing, pricing, marketing, etc.).
- **Layer 3** runs outside the model entirely -- shell scripts that block dangerous operations and flag common mistakes in edited files.

---

## The Workflow

```mermaid
flowchart TD
    A[biz-think] -->|Acid test pass| B[brand-build]
    A -->|Acid test fail| A2[biz-validate]
    A2 -->|Validated| B
    B --> C[project-init]
    C --> D[pre-code]
    D --> E[Code + self-review]
    E --> F[test-gate]
    F --> G[pre-commit]
    G --> H[pre-pr]
    H --> I{UI changes?}
    I -->|Yes| J[ux-audit]
    I -->|No| K[Merge]
    J --> K
    K --> L[post-merge]
    L --> M[product-eval]
    M -->|Score >= 70| N[copy-craft + content-create]
    M -->|Score < 70| M
    N --> O[content-distribute]
    O --> P[community-engage + sales-close]
    P --> Q[growth-track]
    Q -->|Next feature| D

    style A fill:#4a9eff,color:#fff
    style M fill:#4a9eff,color:#fff
    style Q fill:#2ecc71,color:#fff
```

Every stage has a skill. Every skill has a checklist. Skipping a stage means skipping its checks -- and the principles in CLAUDE.md push back against that.

### Skill Chain

Every skill ends with **Next Steps** linking to related skills. This creates a natural chain: `biz-think` points to `brand-build` and `project-init`, `post-merge` points to `product-eval`, `product-eval` points to `copy-craft` and `content-create`, and so on. You never have to remember what comes next -- each skill tells you.

---

## Quick Install

```bash
git clone https://github.com/Docat0209/SoloForge.git
cd SoloForge && ./install.sh
```

The installer copies skills, hooks, and the CLAUDE.md template into your `~/.claude/` directory.

To install into an existing project manually:

```bash
# Copy the CLAUDE.md template
cp claude.md ~/.claude/CLAUDE.md

# Copy hooks
cp hooks/safety-guard.sh ~/.claude/hooks/
cp hooks/post-edit-review.sh ~/.claude/hooks/
cp hooks/skill-eval.sh ~/.claude/hooks/

# Copy skills
cp -r skills/* ~/.claude/skills/

# Copy hook configuration
cp settings/hooks.json ~/.claude/settings.json
```

---

## What's Included

### Skills (26 SOPs)

#### Development Workflow (10)
| Skill | What It Does |
|---|---|
| `pre-code` | Issue + branch + SOLID design check before coding |
| `issue-create` | Enforces issue templates (feat/fix/chore) |
| `project-init` | Git + CI/CD + test runner + branch protection |
| `self-review` | 6-step code review (Google, Clean Code, OWASP) |
| `test-gate` | 3-layer testing (Fowler Pyramid, AAA pattern) |
| `pre-commit` | Atomic commits (Chris Beams, Conventional Commits) |
| `pre-pr` | PR quality ≤200 lines (Google Small CLs) |
| `ux-audit` | Visual + UX + Performance audit via Playwright |
| `post-merge` | 4-step verification after merge |
| `search-eval` | Source credibility + dependency evaluation |

#### Business & Strategy (5)
| Skill | What It Does |
|---|---|
| `biz-think` | 5 viability tests + success decomposition + zero-audience playbook |
| `biz-validate` | Hypothesis → experiment → learn loop (Running Lean + Pretotyping) |
| `product-eval` | 4-dimension scoring /100 (Nielsen, HEART) + auto-iteration if <70 |
| `roadmap-steer` | RICE scoring, feature prioritization, saying no |
| `finance-ops` | Value-based pricing, pricing psychology, MRR tracking, tax basics |

#### Marketing & Growth (7)
| Skill | What It Does |
|---|---|
| `brand-build` | Positioning, voice definition, Build in Public, tribe identity |
| `content-create` | Platform-optimized articles from customer perspective (They Ask You Answer) |
| `content-distribute` | One piece → 15+ platform-adapted versions |
| `community-engage` | Watering holes strategy, value-first engagement |
| `copy-craft` | Conversion copy: PAS/AIDA, Cialdini persuasion, landing pages |
| `sales-close` | Dream 100, cold email, SPIN selling, pipeline management |
| `growth-track` | AARRR funnel, North Star metric, budget, partnerships |

#### Operations (4)
| Skill | What It Does |
|---|---|
| `support-ops` | P0-P3 triage, churn prevention, onboarding sequences |
| `infra-ops` | Monitoring, 3-2-1 backups, incident response, security |
| `data-decide` | Event taxonomy, cohort analysis, A/B testing, decision framework |
| `legal-guard` | ToS, Privacy Policy, GDPR/CCPA, cookie consent |

### Hooks (3 guards)

| Hook | Event | What It Does |
|---|---|---|
| `skill-eval.sh` | UserPromptSubmit | Lightweight skill gate reminder (~50 tokens) — forces evaluate → activate → work sequence |
| `safety-guard.sh` | PreToolUse (Bash) | Blocks: `--force` push, `reset --hard`, `checkout .`, `clean -f`, `branch -D`, `--no-verify`, credential dir access |
| `post-edit-review.sh` | PostToolUse (Write/Edit) | Detects: debug statements, TODO/FIXME comments, hardcoded secrets, Bearer tokens, `.env` modifications |

---

## Recommended Agents

SoloForge's agent prompts are built on top of [Agency Agents](https://github.com/msitarzewski/agency-agents) -- a collection of 100+ specialized agent definitions for Claude Code. Install them to get the full roster of sub-agents (Backend Architect, Frontend Developer, UX Researcher, Growth Hacker, etc.) that the orchestrator delegates to.

```bash
git clone https://github.com/msitarzewski/agency-agents.git
cp -r agency-agents/agents/* ~/.claude/agents/
```

---

## Recommended MCP Servers

These optional MCP servers enhance specific skills:

| Server | Purpose | Used By | Install |
|---|---|---|---|
| [Knowledge Graph Memory](https://github.com/modelcontextprotocol/servers/tree/main/src/memory) | Cross-conversation learning | All skills | `claude mcp add knowledge-graph -- npx -y @modelcontextprotocol/server-memory` |
| [Sequential Thinking](https://github.com/modelcontextprotocol/servers/tree/main/src/sequentialthinking) | Structured multi-step reasoning | `biz-think`, `product-eval` | `claude mcp add sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking` |
| [Playwright](https://github.com/microsoft/playwright-mcp) | Browser automation for visual review | `ux-audit` | `claude mcp add playwright -- npx @playwright/mcp@latest` |

---

## Customization

### Add a new skill

1. Create a directory under `skills/` with your skill name:
   ```bash
   mkdir skills/my-skill
   ```
2. Add a `SKILL.md` file with the SOP checklist. Follow the pattern of existing skills.
3. Register the trigger in `claude.md` under the **Skill Gate Protocol** section:
   ```
   - Before [action] → invoke `my-skill`
   ```

### Modify CLAUDE.md

Edit `claude.md` directly. The 133-line template is intentionally concise -- every line earns its place in the context window. Add principles sparingly.

### Add a new hook

1. Write a shell script in `hooks/`. Use exit code `2` to block (PreToolUse) or `0` to allow.
2. Register it in `settings/hooks.json` under the appropriate event (`PreToolUse` or `PostToolUse`).

---

## Uninstall

```bash
./uninstall.sh
```

This removes all SoloForge files from `~/.claude/` and restores your previous configuration if a backup exists.

---

## Credits

SoloForge synthesizes practices from established engineering, product, and business frameworks:

- **[Google Engineering Practices](https://google.github.io/eng-practices/)** -- code review standards, small CLs
- **[Clean Code](https://www.oreilly.com/library/view/clean-code/9780136083238/)** (Robert C. Martin) -- self-review principles
- **[SOLID Principles](https://en.wikipedia.org/wiki/SOLID)** -- design constraints in pre-code
- **[NASA Power of 10](https://en.wikipedia.org/wiki/The_Power_of_10:_Rules_for_Developing_Safety-Critical_Code)** -- pre-commit verification rules
- **[OWASP Top 10](https://owasp.org/www-project-top-ten/)** -- security checks in self-review
- **[Chris Beams on Git Commits](https://cbea.ms/git-commit/)** -- commit message format
- **[Conventional Commits](https://www.conventionalcommits.org/)** -- commit type enforcement
- **[Martin Fowler Testing Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html)** -- 3-layer test strategy
- **[Nielsen Usability Heuristics](https://www.nngroup.com/articles/ten-usability-heuristics/)** -- product evaluation dimensions
- **[Google HEART Framework](https://research.google/pubs/pub36299/)** -- metrics in product-eval
- **[Cognitive Walkthrough](https://en.wikipedia.org/wiki/Cognitive_walkthrough)** -- FTUE evaluation method
- **[Porter's Value Chain](https://en.wikipedia.org/wiki/Value_chain)** -- business analysis in biz-think
- **[Jobs to Be Done](https://hbr.org/2016/09/know-your-customers-jobs-to-be-done)** (Clayton Christensen) -- customer lens
- **[Lean Canvas](https://leanstack.com/lean-canvas)** (Ash Maurya) -- business model validation
- **[AARRR Pirate Metrics](https://www.slideshare.net/daboross/startup-metrics-for-pirates)** -- growth funnel analysis
- **[Sean Ellis PMF Survey](https://www.startup-marketing.com/the-startup-pyramid/)** -- product-market fit signal
- **[They Ask, You Answer](https://marcussheridan.com/they-ask-you-answer/)** (Marcus Sheridan) -- content creation
- **[SPIN Selling](https://www.amazon.com/SPIN-Selling-Neil-Rackham/dp/0070511136)** (Neil Rackham) -- sales methodology
- **[Dream 100](https://www.chethomes.com/)** (Chet Holmes) -- outbound sales
- **[Influence](https://www.influenceatwork.com/)** (Robert Cialdini) -- persuasion in copy and pricing
- **[Running Lean](https://leanstack.com/running-lean)** (Ash Maurya) -- business validation loop
- **[Pretotyping](https://www.pretotyping.org/)** (Alberto Savoia) -- hypothesis testing
- **[Intercom on Product Management](https://www.intercom.com/books/product-management)** -- RICE scoring
- **[Tribes](https://www.sethgodin.com/tribes/)** (Seth Godin) -- community and brand
- **[The Mom Test](https://momtestbook.com/)** (Rob Fitzpatrick) -- customer interview validation

---

## License

[MIT](LICENSE) -- Copyright (c) 2026 Shane Ho
