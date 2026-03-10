# Security Review Report Template

**Document Status:** Draft / In Progress / Complete  
**Report ID:** SR-XXX  
**Created by:** Security Agent  
**Date:** [Date]  
**Project:** [Project Name]  
**Sprint/Story:** [Sprint/Story ID]  
**Review Type:** Pre-Commit / Sprint Review / Full Audit

---

## Executive Summary

**Verdict:** ✅ PASS / ❌ FAIL / ⚠️ CONDITIONAL PASS

**Overall Security Posture:** Excellent / Good / Needs Improvement / Critical Issues Found

[2-3 sentence summary of the security review findings and verdict]

### Critical Metrics

- **CRITICAL Issues:** [Count] ❌ Must fix before commit
- **HIGH Issues:** [Count] ⚠️ Should fix soon
- **MEDIUM Issues:** [Count] ℹ️ Plan to fix
- **LOW Issues:** [Count] 📝 Good to fix

**Recommendation:** [BLOCK COMMIT / APPROVE WITH CONDITIONS / APPROVE]

---

## Review Scope

**Files Reviewed:**
- [file1.py]
- [file2.py]
- [file3.py]
- [Total: X files, Y lines of code]

**Review Areas:**
- [✅] Secrets Detection
- [✅] Vulnerability Scanning (Semgrep)
- [✅] GDPR Compliance
- [✅] Dependency Security
- [✅] Secure Coding Practices
- [✅] Authentication/Authorization
- [✅] Input Validation
- [✅] Cryptography Usage
- [✅] Configuration Security

**Tools Used:**
- Semgrep v[version]
- Manual code review with secure-coding-skill.md
- Secrets detection patterns from secrets-detection-skill.md
- Dependency scan with [tool]

---

## Automated Scan Results

### Semgrep Security Scan

**Command:** `semgrep scan --config=auto --json`

**Summary:**
- Rules executed: [Count]
- Files scanned: [Count]
- Total findings: [Count]
- ERROR severity: [Count]
- WARNING severity: [Count]
- INFO severity: [Count]

**Scan Duration:** [X seconds]

### Breakdown by Category

| Category | ERROR | WARNING | INFO | Total |
|----------|-------|---------|------|-------|
| SQL Injection | [#] | [#] | [#] | [#] |
| XSS | [#] | [#] | [#] | [#] |
| Secrets | [#] | [#] | [#] | [#] |
| Auth/Authz | [#] | [#] | [#] | [#] |
| Crypto | [#] | [#] | [#] | [#] |
| Injection | [#] | [#] | [#] | [#] |
| **Total** | **[#]** | **[#]** | **[#]** | **[#]** |

---

## Critical Issues (MUST FIX) ❌

### Issue #1: [Title]

**Severity:** CRITICAL  
**Category:** [SQL Injection / XSS / Auth Bypass / Secrets Exposure / etc.]  
**CVSS Score:** [If applicable]

**Location:**
- **File:** [filepath]
- **Line:** [line number]
- **Function/Class:** [context]

**Description:**
[Clear explanation of the vulnerability]

**Vulnerable Code:**
```python
# Current code (VULNERABLE)
[code snippet]
```

**Attack Scenario:**
[How this could be exploited]

**Impact:**
- **Confidentiality:** High / Medium / Low
- **Integrity:** High / Medium / Low
- **Availability:** High / Medium / Low

**Remediation:**
```python
# Secure code (FIXED)
[corrected code snippet]
```

**References:**
- [OWASP link or secure-coding-skill.md section]
- [CVE if applicable]

**Status:** ⬜ Open / ⬜ In Progress / ⬜ Fixed / ⬜ Verified

---

### Issue #2: [Title]

[Repeat structure for each critical issue]

---

## High Priority Issues (SHOULD FIX) ⚠️

### Issue #3: [Title]

**Severity:** HIGH  
**Category:** [Category]

**Location:** [file:line]

**Description:**
[Explanation]

**Recommendation:**
[How to fix]

**Status:** ⬜ Open / ⬜ Scheduled / ⬜ Fixed

---

## Medium/Low Priority Issues ℹ️

### Issue #4: [Title]

**Severity:** MEDIUM / LOW  
**Category:** [Category]  
**Location:** [file:line]

**Description:**
[Brief explanation]

**Recommendation:**
[Suggested improvement]

---

## Secrets Detection

### Scan Results

**Status:** ✅ CLEAN / ❌ SECRETS FOUND

**Files Scanned:** [Count]

**Patterns Checked:**
- [✅] AWS Access Keys
- [✅] GitHub Tokens
- [✅] API Keys
- [✅] Database Credentials
- [✅] Private Keys
- [✅] OAuth Secrets
- [✅] JWT Tokens
- [✅] Generic Passwords

### Findings

**[If secrets found:]**

#### Secret #1: [Type]

**File:** [filepath:line]  
**Pattern Matched:** [e.g., AWS_ACCESS_KEY_ID]  
**Severity:** CRITICAL

**Exposed Value (partial):**
```
[First 4 and last 4 characters, rest masked]
```

**Remediation Required:**
1. Rotate the secret immediately
2. Move to environment variable or Azure Key Vault
3. Add pattern to .gitignore
4. Clean git history if committed

---

## GDPR Compliance Review

**Status:** ✅ COMPLIANT / ⚠️ ISSUES FOUND / ❌ NON-COMPLIANT

### Data Protection Checks

- [✅/❌] Personal data properly encrypted at rest
- [✅/❌] Personal data encrypted in transit (HTTPS/TLS)
- [✅/❌] Access controls on personal data endpoints
- [✅/❌] Data minimization principle followed
- [✅/❌] User consent mechanisms in place
- [✅/❌] Data export capability implemented
- [✅/❌] Data deletion capability implemented
- [✅/❌] Audit logging for data access
- [✅/❌] Data retention policies defined

### Findings

[List any GDPR compliance issues]

---

## Dependency Security

### Scan Results

**Tool:** [safety / pip-audit / npm audit / snyk]  
**Scan Date:** [Date]

**Summary:**
- Total dependencies: [Count]
- Vulnerable dependencies: [Count]
- Critical CVEs: [Count]
- High CVEs: [Count]
- Medium CVEs: [Count]
- Low CVEs: [Count]

### Vulnerable Dependencies

#### Dependency #1: [package-name]

**Current Version:** [version]  
**CVE:** [CVE-YYYY-XXXXX]  
**Severity:** CRITICAL / HIGH / MEDIUM / LOW  
**CVSS Score:** [score]

**Vulnerability:**
[Description of the vulnerability]

**Fix Available:**
- **Fixed in:** [version]
- **Action:** Update to [version] or higher

**Command:**
```bash
pip install package-name==[version]
# or
npm install package-name@[version]
```

---

## Secure Coding Review

### Authentication & Authorization

**Status:** ✅ SECURE / ⚠️ ISSUES / ❌ VULNERABLE

**Checks:**
- [✅/❌] Password hashing uses bcrypt/argon2
- [✅/❌] Session security properly configured
- [✅/❌] JWT tokens properly validated
- [✅/❌] Authorization checks on all endpoints
- [✅/❌] RBAC/ABAC properly implemented
- [✅/❌] No authentication bypass vulnerabilities

**Findings:**
[List issues]

---

### Input Validation

**Status:** ✅ SECURE / ⚠️ ISSUES / ❌ VULNERABLE

**Checks:**
- [✅/❌] All user inputs validated
- [✅/❌] SQL queries use parameterization
- [✅/❌] XSS prevention in templates
- [✅/❌] Command injection prevented
- [✅/❌] Path traversal prevented
- [✅/❌] File upload validation (type, size, content)

**Findings:**
[List issues]

---

### Cryptography

**Status:** ✅ SECURE / ⚠️ ISSUES / ❌ VULNERABLE

**Checks:**
- [✅/❌] Strong algorithms used (AES-256, RSA-2048+)
- [✅/❌] No hardcoded encryption keys
- [✅/❌] Proper key management
- [✅/❌] Secure random number generation
- [✅/❌] TLS 1.2+ enforced
- [✅/❌] No deprecated crypto (MD5, SHA1, DES)

**Findings:**
[List issues]

---

### Configuration Security

**Status:** ✅ SECURE / ⚠️ ISSUES / ❌ VULNERABLE

**Checks:**
- [✅/❌] DEBUG mode disabled in production
- [✅/❌] HTTPS enforced
- [✅/❌] Security headers configured (CSP, HSTS, etc.)
- [✅/❌] CORS properly configured
- [✅/❌] Error messages don't leak sensitive info
- [✅/❌] Default credentials changed
- [✅/❌] Unnecessary services disabled

**Findings:**
[List issues]

---

## Recommendations

### Immediate Actions (Before Commit)

1. **[Action 1]** - CRITICAL
   - [Specific remediation steps]

2. **[Action 2]** - CRITICAL
   - [Specific remediation steps]

### Short-term Improvements (Next Sprint)

1. **[Improvement 1]** - HIGH
   - [What needs to be done]

2. **[Improvement 2]** - HIGH
   - [What needs to be done]

### Long-term Enhancements

1. **[Enhancement 1]**
   - [Strategic security improvement]

2. **[Enhancement 2]**
   - [Strategic security improvement]

---

## Security Best Practices Applied

✅ **Good Practices Found:**
- [Practice 1]
- [Practice 2]
- [Practice 3]

📚 **Skills Referenced:**
- `skills/secure-coding-skill.md`
- `skills/secrets-detection-skill.md`
- `skills/dependency-security-skill.md`

---

## Verdict & Decision

### Final Verdict

**⚠️ VERDICT: [PASS / FAIL / CONDITIONAL PASS]**

### Justification

**PASS:** ✅
- No critical or high-severity issues found
- All security checks passed
- Dependencies are up-to-date and secure
- Code follows secure coding practices
- Ready for commit and deployment

**FAIL:** ❌
- [Count] critical issues must be fixed
- [Count] high-severity issues require immediate attention
- Security risks are too high to merge
- Code must be reworked before resubmission

**CONDITIONAL PASS:** ⚠️
- Minor issues found but not blocking
- Issues documented and tracked for future sprint
- Code can be committed with risk acceptance
- Follow-up story created: [Story ID]

---

### Next Steps

**If PASS:**
- ✅ Security review complete
- ✅ Ready for deployment
- ✅ Return to Tech Lead for final approval

**If FAIL:**
- ❌ Return to Coding Agent with findings
- ❌ Remediation required before resubmission
- ❌ Reference security skills for guidance

**If CONDITIONAL PASS:**
- ⚠️ Create follow-up story for tracked issues
- ⚠️ Document risk acceptance
- ⚠️ Proceed with deployment with stakeholder approval

---

## Iteration Tracking

**Review Iteration:** [#] of 5 maximum

**Previous Reviews:**
1. [Date] - [Outcome] - [Key issues]
2. [Date] - [Outcome] - [Key issues]

**If iteration > 5:**
- ⚠️ Escalate to user for decision
- Document systemic issues requiring architectural changes

---

## Appendices

### Appendix A: Full Semgrep Report

[Link to or embed full JSON output]

### Appendix B: Dependency Scan Details

[Link to or embed full scan results]

### Appendix C: Security Skills Referenced

- [Link to secure-coding-skill.md]
- [Link to secrets-detection-skill.md]
- [Link to dependency-security-skill.md]

---

## Review Team

**Security Agent:** [Agent name/session]  
**Review Date:** [Date]  
**Review Duration:** [Time]

---

## Sign-off

**Reviewed by:** Security Agent  
**Status:** [APPROVED / REJECTED / CONDITIONAL]  
**Date:** [Date]  
**Signature:** [If applicable]
