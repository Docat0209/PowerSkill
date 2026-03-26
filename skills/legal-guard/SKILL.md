---
name: legal-guard
description: "Generates legal documents and compliance checklists for SaaS products. Triggers ONLY when: user asks to create Terms of Service, Privacy Policy, handle GDPR compliance, or set up legal structure. Do NOT trigger during development or business planning."
---

# Legal Guard SOP

> **Disclaimer**: This is a starting framework, not legal advice. Consult a qualified lawyer for your specific jurisdiction and business. Laws change — verify requirements against current regulations before relying on this checklist.

## 1. Required Documents Checklist

Every SaaS product needs these before accepting users (source: TOS Lawyer, SaaS Law Firm Andrew S. Bosin LLC):

- [ ] **Terms of Service (ToS)** — governs the user-product relationship
- [ ] **Privacy Policy** — required by law if you collect any personal data
- [ ] **Cookie Policy** — required in EU/UK; recommended everywhere
- [ ] **Data Processing Addendum (DPA)** — required if handling EU customer data or selling to enterprise
- [ ] **Acceptable Use Policy (AUP)** — can be embedded in ToS or standalone
- [ ] **SLA (Service Level Agreement)** — expected by B2B/enterprise customers
- [ ] **Refund/Cancellation Policy** — can be embedded in ToS

## 2. Privacy Policy Essentials

Must clearly disclose (source: SecurePrivacy, Pandectes, Cookie-Script):

- **What data is collected** — list specific categories (name, email, usage data, payment info, device info)
- **Why it's collected** — state the legal basis for each category (consent, legitimate interest, contractual necessity)
- **How it's stored** — encryption, hosting location, retention periods
- **How it's deleted** — process for user-requested deletion and automatic purging
- **Third parties** — name every sub-processor (Stripe, analytics, email provider) and their purpose
- **GDPR rights** (for EU users) — access, rectification, deletion, portability, restriction, objection
- **CCPA/CPRA rights** (for California users) — right to know, delete, opt-out of sale/sharing, non-discrimination
- **Children's data** — state minimum age; if under 13, COPPA applies (US)
- **Contact information** — data protection officer or contact email for privacy requests

## 3. Terms of Service Essentials

Must include (source: TOS Lawyer, NJ Business Attorney SaaS Contracts Guide 2026):

- **Service description** — what the product does and doesn't do
- **Acceptable use** — prohibited activities (abuse, scraping, illegal use, reselling)
- **Account responsibilities** — user must secure credentials, accurate info
- **Payment terms** — pricing, billing cycle, currency, tax responsibility
- **Refund policy** — conditions, timeframe, process (be specific)
- **Intellectual property** — who owns what (your IP, user-generated content, data)
- **Liability limitations** — cap liability, disclaim warranties (to extent permitted by law)
- **Termination** — how either party can end the agreement, what happens to data
- **Governing law & dispute resolution** — jurisdiction, arbitration vs. courts
- **Modification clause** — how you'll notify users of ToS changes

## 4. GDPR Compliance Checklist

Required if you have any EU/UK users (source: Feroot Security, SecurePrivacy):

- [ ] Consent mechanism — opt-in before collecting non-essential data
- [ ] Records of Processing Activities (ROPA) — document what data, why, how long
- [ ] DPA signed with every sub-processor (hosting, analytics, email, payments)
- [ ] Right to deletion implemented — user can request and you execute within 30 days
- [ ] Right to data portability — export user data in machine-readable format (JSON/CSV)
- [ ] Data Subject Access Request (DSAR) process — documented, tested, under 30-day response
- [ ] Breach notification process — notify supervisory authority within 72 hours, affected users without undue delay
- [ ] Privacy by design — data minimization, pseudonymization where possible
- [ ] Lawful basis documented for each processing activity
- [ ] International data transfers — use Standard Contractual Clauses (SCCs) if transferring outside EU

## 5. Cookie Consent

Requirements by region (source: UserCentrics, CookieChimp, SecurePrivacy):

**Cookie categories:**
- **Necessary** — session, security, load balancing (no consent needed)
- **Analytics** — usage tracking, heatmaps (consent required in EU)
- **Marketing** — ad targeting, retargeting pixels (consent required everywhere)
- **Functional** — preferences, language settings (consent varies by jurisdiction)

**EU/UK (GDPR + ePrivacy Directive):**
- Opt-in required BEFORE setting non-essential cookies
- Accept All and Reject All buttons must have equal visual prominence
- Granular control — users must be able to accept/reject by category
- Consent valid for 6 months, then re-prompt
- No cookie walls (blocking content until consent) — regulators penalize this

**US (CCPA/CPRA + state laws):**
- Opt-out model — can set cookies but must provide "Do Not Sell/Share" link
- As of Jan 2026, opt-out confirmation must be visible (no silent acceptance)
- Honor Global Privacy Control (GPC) browser signals

**Implementation:** Use a Consent Management Platform (CMP) — Cookiebot, CookieYes, or similar. Never roll your own.

## 6. Business Entity

When and where to incorporate (source: SaaS Law Firm, general startup practice):

- **When**: Before accepting payments or signing contracts. An LLC protects personal assets from business liability.
- **Where (US founders)**: Delaware LLC or C-Corp is standard for startups (investor-friendly, well-established case law). File in your home state too if you operate there.
- **Where (non-US founders)**: Incorporate in your home country first. Consider a US entity (Delaware/Wyoming) only when US revenue justifies it.
- **Sole proprietor risk**: Without an entity, YOUR personal assets are on the line for any lawsuit, data breach, or debt.
- **Cost**: LLC formation is $100-500 depending on state. Far cheaper than a single lawsuit.
