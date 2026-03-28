---
name: infra-ops
description: "Manages infrastructure, monitoring, backups, and incident response. Triggers ONLY when: user asks to set up monitoring, plan backup strategy, handle an incident, or review infrastructure security. Do NOT trigger during normal development."
---

# Infra-Ops SOP

## 1. Monitoring

Set up monitoring BEFORE you need it. Three layers, in priority order:

**Uptime monitoring (must-have day 1):**
- UptimeRobot (free, checks every 5 min) or BetterStack
- Monitor: main app URL, API health endpoint, database connectivity
- Alert chain: Slack/email for P1-P3 → phone call for P0

**Error tracking (must-have day 1):**
- Sentry free tier — captures stack traces with user context
- Set up source maps for frontend, proper error grouping
- Alert on new error types, not every occurrence

**Performance baselines (set up by launch):**
- Track p50/p95/p99 response times for key endpoints
- Set alerts when p95 > 2x baseline for 5+ minutes
- Database query time monitoring (slow query log)

> Source: [CloudEagle SaaS Security Checklist](https://www.cloudeagle.ai/blogs/ultimate-saas-security-checklist), [DesignRevision SaaS Security Checklist](https://designrevision.com/blog/saas-security-checklist)

## 2. Staging/Preview Environments

Staging environments are required for the automated release gate (`staging-verify`). The `dev` branch must auto-deploy to a preview URL.

**Platform Configuration:**

| Platform | How to Enable Dev Preview | Stable Branch URL Pattern |
|---|---|---|
| Vercel | Automatic for all branches via Git Integration | `<project>-git-dev-<scope>.vercel.app` |
| Netlify | Site settings → Branch deploys → add `dev` | `dev--<site-name>.netlify.app` |
| Railway | Create environment per branch | Custom domain per environment |
| Render | Dashboard → Preview Environments | `<service>-dev.onrender.com` |
| Fly.io | Separate `fly.staging.toml` config | Custom staging subdomain |

**Staging must have:**
- Same monitoring as production (uptime checks, error tracking)
- Isolated data (separate database, separate API keys)
- Separate secrets from production

**Troubleshooting:**
- Not deploying: check platform dashboard and CI/CD logs
- URL returning 404: verify the build succeeded on the platform
- Out of date: compare deployed commit with `git rev-parse dev`

## 3. Backup Strategy — 3-2-1 Rule

**3** copies, **2** different media, **1** offsite. Non-negotiable.

| Data type | Backup method | Frequency | Retention |
|---|---|---|---|
| Database | Automated pg_dump / mysqldump to object storage | Daily | 30 days rolling + weekly for 90 days |
| User uploads | Replicated cloud storage (e.g., S3 cross-region) | Real-time replication | Match user data retention policy |
| Code | Git (already distributed) | Every push | Indefinite |
| Config/secrets | Encrypted export to separate secure store | On change | Last 10 versions |

**Critical:** test restore monthly. A backup you've never restored is not a backup — it's a hope.

> Source: [Cohesity — 3-2-1 Backup Rule](https://www.cohesity.com/glossary/321-backup-rule/), [Rewind — 3-2-1 for SaaS](https://rewind.com/321-backup-rule/)

## 4. Incident Response

Follow the NIST framework adapted for solo/small teams:

**Severity levels:**
- **P0** — Service down, all users affected → drop everything, fix now
- **P1** — Major feature broken, many users affected → fix within 4 hours
- **P2** — Minor feature broken, workaround exists → fix within 24 hours
- **P3** — Cosmetic/low-impact issue → fix in next sprint

**Response playbook:**

1. **Detect** — monitoring alert fires or user reports
2. **Triage** — assign severity (P0-P3), estimate blast radius
3. **Communicate** — update status page within 15 min for P0/P1
   - Template: "We're aware of [issue]. Impact: [who's affected]. ETA: [time or 'investigating']."
4. **Fix** — contain first (rollback, feature flag off), then root-cause fix
5. **Post-mortem** (required for P0/P1, within 48 hours):
   - What happened (timeline)
   - Why it happened (root cause, not blame)
   - How to prevent it (concrete action items with owners and deadlines)

> Source: [TechTarget — Incident Response Plan](https://www.techtarget.com/searchsecurity/feature/5-critical-steps-to-creating-an-effective-incident-response-plan), [Sygnia — SaaS Incident Response](https://www.sygnia.co/blog/saas-incident-response/)

## 5. Security Checklist

**Transport & access:**
- [ ] HTTPS everywhere (no mixed content, HSTS enabled)
- [ ] Secrets in env vars or secret manager — NEVER in code or git
- [ ] MFA for admin accounts and cloud provider console
- [ ] CORS configured to allow only your domains

**Application:**
- [ ] Rate limiting on auth endpoints (login, signup, password reset)
- [ ] CSP (Content Security Policy) headers configured
- [ ] Input validation and parameterized queries (prevent SQLi/XSS)
- [ ] Dependency audit weekly (`npm audit` / `pip audit` / `cargo audit`)

**Infrastructure:**
- [ ] Minimal open ports — only 80/443 publicly accessible
- [ ] Database not publicly accessible (VPC/private network only)
- [ ] Automated security updates for OS packages
- [ ] Logging enabled for all access and auth events

> Source: [DesignRevision — SaaS Security Checklist](https://designrevision.com/blog/saas-security-checklist)

## 6. Disaster Recovery

Define targets early, revisit quarterly:

- **RTO (Recovery Time Objective):** max acceptable downtime. Solo SaaS target: < 4 hours.
- **RPO (Recovery Point Objective):** max acceptable data loss. Solo SaaS target: < 24 hours (daily backups).

**DR plan essentials:**
1. Documented runbook: "if X dies, do Y" for each critical component
2. Database: can restore from backup to new instance in < 2 hours
3. App server: infrastructure-as-code so you can spin up a new one in < 1 hour
4. DNS: low TTL (300s) so failover propagates fast
5. Test the full DR plan quarterly — actually do a restore drill

> Source: [ATOZDEBUG — Disaster Recovery for SaaS](https://atozdebug.com/disaster-recovery-for-saas/), [MightyID — Optimizing RPO & RTO](https://www.mightyid.com/how-to-optimize-rpo-and-rto-in-disaster-recovery-plans/)

## 7. Maintenance Schedule

| Frequency | Task |
|---|---|
| **Weekly** | Check error logs and alert trends, run dependency audit, review uptime reports |
| **Monthly** | Test backup restore, review access logs, update dependencies, check infrastructure costs |
| **Quarterly** | Full security audit, DR drill (test restore to new environment), review RTO/RPO targets, infrastructure cost optimization |
| **Annually** | Rotate all credentials/API keys, review and update incident response plan, evaluate monitoring stack |

## Next Steps
After completing this skill, create tasks for applicable next steps using TaskCreate:
- Monitoring set up → create task: "continue normal development flow"
- Incident occurred → create task: "invoke `data-decide` — analyze incident impact with data"
- Security audit done → create task: "invoke `legal-guard` — create compliance documentation"

Only create tasks that are actually relevant. Do not create tasks for steps that don't apply to the current situation.
