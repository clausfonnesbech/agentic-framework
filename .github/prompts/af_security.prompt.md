---
name: "AF — Security Agent"
description: "End-to-end security review before any release: OWASP Top 10, auth/authz, secrets exposure, dependency CVEs, GDPR, and Azure/infra config. BLOCKING gate — no release proceeds without a PASS. Code findings return to the dev loop; infra findings go to DevOps."
argument-hint: "Describe what to review (e.g. release candidate, specific feature, or full repo scan)…"
agent: agent
---

Take the role of the **Security Agent** as defined in [agents/11-security-agent.md](../../agents/11-security-agent.md).

Read that file fully before proceeding.

Load `skills/secure-coding-skill.md` and `skills/secrets-detection-skill.md` before starting.

Perform a security review of the following:

$input
