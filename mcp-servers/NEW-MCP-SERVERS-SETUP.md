# New MCP Servers Setup & Configuration

**Date:** February 14, 2026  
**Purpose:** Enhanced agent capabilities with Django, Azure, and Security scanning

---

## Summary

Added **3 new MCP servers** to strengthen development agents for the WW Information and Task Site project:

1. **Django MCP** - Framework-specific documentation and patterns
2. **Azure MCP** - Cloud infrastructure and deployment
3. **Semgrep MCP** - Automated security scanning

---

## Files Created

### 1. MCP Configuration Files

✅ **[mcp-servers/django-config.json](mcp-servers/django-config.json)**
- Django framework documentation
- Django REST Framework patterns
- ORM best practices and security
- Authentication/authorization systems
- Production deployment configurations

✅ **[mcp-servers/azure-config.json](mcp-servers/azure-config.json)**
- Azure App Service deployment
- Azure Key Vault integration
- Application Insights monitoring
- CI/CD with GitHub Actions
- Sweden region compliance (GDPR)

✅ **[mcp-servers/semgrep-config.json](mcp-servers/semgrep-config.json)**
- Automated vulnerability scanning
- OWASP Top 10 detection
- Secrets exposure detection
- Django-specific security rules
- CI/CD security gate patterns

### 2. Agent Updates

✅ **[agents/06-tech-lead.md](agents/06-tech-lead.md)** - Added:
- Django MCP section (architecture decisions)
- Azure MCP section (infrastructure coordination)
- Semgrep MCP section (security gate management)

✅ **[agents/07-coding-agent.md](agents/07-coding-agent.md)** - Added:
- Django MCP section (development patterns)
- Azure MCP section (SDK integration)
- Semgrep MCP section (self-review security checks)

✅ **[agents/08-code-inspector.md](agents/08-code-inspector.md)** - Added:
- Django MCP section (framework best practices)

✅ **[agents/10-security-agent.md](agents/10-security-agent.md)** - Added:
- Django MCP section (security patterns)
- Semgrep MCP section (automated scanning - PRIMARY TOOL)

### 3. Documentation Updates

✅ **[mcp-servers/README.md](mcp-servers/README.md)** - Added:
- Quick inventory updated with 3 new MCPs
- Detailed sections for Django, Azure, and Semgrep
- Usage examples and agent assignments

---

## Setup Instructions

### Prerequisites

- Node.js 16+ (for Django and Azure MCP via GitHub)
- Python 3.8+ (for Semgrep)
- GitHub Personal Access Token (already configured)

### 1. Django MCP Setup

**No additional installation needed!**

Django MCP reuses the GitHub MCP server to access Django documentation repositories.

#### Configuration:
```bash
# Uses existing GITHUB_PERSONAL_ACCESS_TOKEN
# No new environment variables required
```

#### Verify access:
```bash
# Django MCP will access these repositories:
# - django/django
# - encode/django-rest-framework
# - jazzband/django-allauth
```

#### Agent Usage:
```markdown
Coding Agent: "Reference Django MCP for secure ORM patterns"
Security Agent: "Check Django security documentation for CSRF protection"
Tech Lead: "Review Django deployment best practices"
```

---

### 2. Azure MCP Setup

**No additional installation needed!**

Azure MCP also reuses the GitHub MCP server for Azure documentation.

#### Configuration:
```bash
# Uses existing GITHUB_PERSONAL_ACCESS_TOKEN
# No new environment variables required

# For actual Azure operations (optional):
az login  # If using Azure CLI
```

#### Verify access:
```bash
# Azure MCP will access these repositories:
# - Azure/azure-sdk-for-python
# - Azure-Samples/app-service-python-configure-deployment
```

#### Agent Usage:
```markdown
Tech Lead: "Query Azure MCP for App Service configuration patterns"
Coding Agent: "Reference Azure Key Vault integration examples"
Security Agent: "Validate Azure security configurations"
```

---

### 3. Semgrep MCP Setup ⚠️ Requires Installation

**Installation required:**

```bash
# Option 1: pip (recommended for Python projects)
pip install semgrep

# Option 2: Homebrew (macOS)
brew install semgrep

# Option 3: Docker
docker pull returntocorp/semgrep
```

#### Verify installation:
```bash
semgrep --version
# Expected: 1.x.x or higher
```

#### Test Semgrep:
```bash
# Run a quick security scan on current directory
semgrep scan --config=auto .

# Scan for secrets only
semgrep scan --config=p/secrets .

# Django-specific scan
semgrep scan --config=p/django .
```

#### Agent Usage:
```bash
# Security Agent automated scanning:
semgrep scan --config=auto --json > security-report.json

# Coding Agent self-review:
semgrep scan --config=p/security-audit .

# Check specific issue:
semgrep scan --config=p/sql-injection path/to/file.py
```

---

## Agent Usage Guide

### Tech Lead Agent

**When to use new MCPs:**
- **Django MCP:** Making framework architecture decisions, evaluating technical approaches
- **Azure MCP:** Planning infrastructure (US-001), coordinating deployment strategy
- **Semgrep MCP:** Setting up CI/CD security gates, reviewing systemic security issues

**Example session:**
```markdown
Tech Lead Session Start:

1. Load skills:
   - Read: skills/sprint-planning-skill.md
   - Read: skills/story-readiness-verification-skill.md

2. Planning US-001 (Infrastructure):
   "Reference Azure MCP for App Service configuration in Sweden Central"
   "Check Azure MCP for Key Vault setup patterns"
   "Review Django MCP for production security settings"

3. Setting up security pipeline:
   "Configure Semgrep in GitHub Actions for security gates"
   "Set ERROR threshold to block commits"
```

---

### Coding Agent

**When to use new MCPs:**
- **Django MCP:** Implementing models, views, serializers, APIs (PRIMARY TOOL)
- **Azure MCP:** Integrating Azure SDK (Key Vault, Application Insights)
- **Semgrep MCP:** Self-review before marking story complete

**Example session:**
```markdown
Coding Agent implementing US-XXX (Django API):

1. Load skills:
   - Read: skills/secure-coding-skill.md
   - Read: skills/secrets-detection-skill.md

2. During implementation:
   "Query Django MCP: How to implement team-scoped queryset filtering?"
   "Query Django MCP: Secure file upload validation patterns?"
   "Query Django MCP: Django REST Framework nested serializer patterns?"

3. Azure integration:
   "Query Azure MCP: Retrieve secrets from Key Vault in Python?"
   "Query Azure MCP: Send telemetry to Application Insights?"

4. Before completing (REQUIRED):
   Run: semgrep scan --config=p/security-audit .
   Run: semgrep scan --config=p/secrets .
   Fix all ERROR findings
   Document WARNING findings if false positive

5. Report completion with clean scan
```

---

### Code Inspector Agent

**When to use new MCPs:**
- **Django MCP:** Validating Django code quality and conventions

**Example session:**
```markdown
Code Inspector reviewing Django code:

1. Load skills:
   - Read: skills/code-review-checklist-skill.md
   - Read: skills/secure-coding-skill.md (awareness)

2. During review:
   "Query Django MCP: Is this ORM query optimized?"
   "Query Django MCP: Does this serializer follow DRF conventions?"
   "Query Django MCP: Are these model constraints sufficient?"

3. Review findings:
   - Code quality: PASS/FAIL
   - Testing: PASS/FAIL
   - Django conventions: PASS/FAIL
```

---

### Security Agent

**When to use new MCPs:**
- **Django MCP:** Validating Django security configurations
- **Semgrep MCP:** Automated vulnerability scanning (PRIMARY SCANNING TOOL)

**Example session:**
```markdown
Security Agent security review:

1. Load skills:
   - Read: skills/secure-coding-skill.md
   - Read: skills/secrets-detection-skill.md
   - Read: skills/dependency-security-skill.md

2. FIRST: Run Semgrep automated scan
   semgrep scan --config=auto --json > security-report.json
   semgrep scan --config=p/owasp-top-ten .
   semgrep scan --config=p/django .
   semgrep scan --config=p/secrets .

3. Parse Semgrep results:
   - ERROR findings = IMMEDIATE FAIL (block commit)
   - WARNING findings = Review and document
   - INFO findings = Note for improvement

4. Manual review with Django MCP:
   "Query Django MCP: Is CSRF protection properly configured?"
   "Query Django MCP: Secure session settings for production?"
   "Query Django MCP: File upload security patterns followed?"

5. Generate security report:
   - Automated findings (Semgrep)
   - Manual review findings (Django patterns)
   - GDPR compliance check
   - Dependency vulnerabilities
   
6. Verdict:
   - PASS: No ERROR findings, clean security review
   - FAIL: Any ERROR findings OR critical security issues
   - CONDITIONAL PASS: Warnings documented, low risk
```

---

## Integration with Workflow

### Enhanced Development Flow

```
┌─────────────────────────────────────────────────────────┐
│                     TECH LEAD                            │
│  • Uses Django MCP for architecture decisions           │
│  • Uses Azure MCP for infrastructure planning (US-001)  │
│  • Uses Semgrep MCP for CI/CD security gate setup       │
└─────────────┬───────────────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────────────┐
│                   CODING AGENT                           │
│  • Uses Django MCP for implementation patterns          │
│  • Uses Azure MCP for SDK integration                   │
│  • Uses Semgrep MCP for self-review security check      │
└─────────────┬───────────────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────────────┐
│                 CODE INSPECTOR                           │
│  • Uses Django MCP for quality standards                │
└─────────────┬───────────────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────────────┐
│             SECURITY AGENT                               │
│  • Uses Semgrep MCP for automated scanning (PRIMARY)    │
│  • Uses Django MCP for framework security validation    │
│  • Blocks commit if ERROR findings exist                │
└──────────────────────────────────────────────────────────┘
```

### Semgrep in CI/CD

Add to `.github/workflows/security-scan.yml`:

```yaml
name: Security Scan

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Run Semgrep
        uses: returntocorp/semgrep-action@v1
        with:
          config: >-
            p/security-audit
            p/owasp-top-ten
            p/django
            p/secrets
      
      - name: Block on ERROR findings
        run: |
          if grep -q '"severity":"ERROR"' semgrep-report.json; then
            echo "ERROR severity findings detected - blocking merge"
            exit 1
          fi
```

---

## Benefits Summary

### Django MCP Benefits
✅ Framework-specific guidance (vs generic Python docs)  
✅ Security patterns tailored to Django  
✅ ORM best practices and optimization  
✅ Production deployment configurations  
✅ Django REST Framework conventions  

### Azure MCP Benefits
✅ Infrastructure patterns for Sweden region (GDPR)  
✅ Azure Key Vault integration examples  
✅ Application Insights monitoring setup  
✅ CI/CD deployment patterns  
✅ Security configuration guidance  

### Semgrep MCP Benefits
✅ **Automated** vulnerability detection (vs manual only)  
✅ Catches issues manual review might miss  
✅ Consistent security standards  
✅ Fast execution (seconds)  
✅ OWASP Top 10 coverage  
✅ Django-specific security rules  
✅ Secrets detection without regex maintenance  

---

## Next Steps

### Immediate
1. ✅ Django MCP configured (uses existing GitHub token)
2. ✅ Azure MCP configured (uses existing GitHub token)
3. ⚠️ **Install Semgrep:** `pip install semgrep`
4. ✅ All agents updated with MCP references

### To Enable CI/CD Security Gate
1. Create `.github/workflows/security-scan.yml`
2. Configure Semgrep action
3. Set ERROR threshold to block merges
4. Test with sample Django code

### To Use in Development
1. **Start any agent session** - new MCPs automatically available
2. **Coding Agent** - Reference Django MCP during Django development
3. **Security Agent** - Run Semgrep as first step in security review
4. **Tech Lead** - Use Azure MCP when planning infrastructure

---

## Troubleshooting

### Django MCP Issues
**Problem:** "Cannot access Django documentation"  
**Solution:** Verify GITHUB_PERSONAL_ACCESS_TOKEN is set and valid

**Problem:** "Repository not found"  
**Solution:** Check internet connection, verify GitHub API access

### Azure MCP Issues
**Problem:** "Cannot access Azure documentation"  
**Solution:** Same as Django - uses GitHub token

### Semgrep Issues
**Problem:** "semgrep: command not found"  
**Solution:** Install Semgrep: `pip install semgrep` or `brew install semgrep`

**Problem:** "Semgrep scan too slow"  
**Solution:** Scan specific directories: `semgrep scan --config=auto src/`

**Problem:** "Too many false positives"  
**Solution:** Configure custom rules or use `--config=p/security-audit` (lighter ruleset)

---

## Related Documentation

- [MCP Server Configuration Guide](mcp-servers/SETUP-GUIDE.md)
- [Development Agents Enhancement Summary](DEVELOPMENT-AGENTS-ENHANCEMENT-SUMMARY.md)
- [Security Agent Definition](agents/10-security-agent.md)
- [Secure Coding Skill](skills/secure-coding-skill.md)
- [Dependency Security Skill](skills/dependency-security-skill.md)

---

## Summary

You now have **3 powerful new MCP servers** enhancing your development workflow:

1. **Django MCP** - Django-specific development patterns and security
2. **Azure MCP** - Cloud infrastructure and deployment guidance
3. **Semgrep MCP** - Automated security scanning and vulnerability detection

**Only Semgrep requires installation** - Django and Azure MCPs work immediately using your existing GitHub token.

The Security Agent is now significantly stronger with **automated scanning** via Semgrep, catching vulnerabilities that manual review might miss while maintaining fast execution times.

**Ready to build secure, production-ready Django applications on Azure! 🚀🔒☁️**
