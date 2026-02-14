# Dependency Security Skill

## Overview

This skill provides guidance on managing third-party dependencies securely, identifying vulnerabilities, and maintaining a secure software supply chain.

## When to Use This Skill

- Reviewing requirements.txt, package.json, or other dependency files
- Security audits of dependencies
- Dependency updates and upgrades
- Supply chain security reviews
- CI/CD pipeline security

## Understanding Dependency Vulnerabilities

### What Are CVEs?

**CVE (Common Vulnerabilities and Exposures)** are publicly disclosed security vulnerabilities:
- Unique identifier (e.g., CVE-2023-12345)
- Severity rating (Critical, High, Medium, Low)
- Description of vulnerability
- Affected versions
- Patched versions

### Severity Levels

**Critical** (9.0-10.0 CVSS):
- Remote code execution
- Authentication bypass
- Complete system compromise
- **Action**: Fix immediately

**High** (7.0-8.9 CVSS):
- Significant data exposure
- Privilege escalation
- **Action**: Fix within 7 days

**Medium** (4.0-6.9 CVSS):
- Limited information disclosure
- Moderate impact
- **Action**: Fix within 30 days

**Low** (0.1-3.9 CVSS):
- Minor issues
- Requires specific conditions
- **Action**: Fix when convenient

## Python Dependency Security

### Checking Requirements Files

```bash
# requirements.txt
Django==3.2.0          # Check for CVEs
requests==2.25.0       # Check for CVEs
cryptography==3.4.0    # Check for CVEs
Pillow==8.0.0          # Check for CVEs
```

### Tools for Python

**Safety:**
```bash
# Install
pip install safety

# Check dependencies
safety check

# Check specific file
safety check -r requirements.txt

# Output JSON
safety check --json
```

**Pip-audit:**
```bash
# Install
pip install pip-audit

# Audit installed packages
pip-audit

# Audit requirements file
pip-audit -r requirements.txt

# Fix automatically (where possible)
pip-audit --fix
```

**Bandit (code security):**
```bash
# Install
pip install bandit

# Scan code
bandit -r src/

# With configuration
bandit -r src/ -c bandit.yaml
```

### Common Python Vulnerability Patterns

**Insecure Package Versions:**
```python
# ❌ BAD: Old Django version with known CVEs
Django==2.2.0  # Has multiple security vulnerabilities

# ✅ GOOD: Latest stable version
Django==4.2.0  # Or latest LTS
```

**Deprecated Packages:**
```python
# ❌ BAD: Unmaintained packages
pkg_resources==0.0.0  # Part of setuptools, often outdated
pycrypto==2.6.1      # Deprecated, use cryptography

# ✅ GOOD: Maintained alternatives
setuptools>=65.0.0
cryptography>=41.0.0
```

##JavaScript/Node.js Dependency Security

### Checking Package Files

```json
// package.json
{
  "dependencies": {
    "express": "^4.17.1",     // Check for CVEs
    "lodash": "^4.17.20",     // Check for CVEs
    "axios": "^0.21.1"        // Check for CVEs
  }
}
```

### Tools for Node.js

**npm audit:**
```bash
# Audit dependencies
npm audit

# Fix automatically
npm audit fix

# Fix including breaking changes
npm audit fix --force

# Output JSON
npm audit --json
```

**Snyk:**
```bash
# Install
npm install -g snyk

# Authenticate
snyk auth

# Test project
snyk test

# Monitor project
snyk monitor
```

## Dependency Management Best Practices

### 1. Pin Dependency Versions

**Python:**
```python
# ❌ BAD: Unpinned versions
Django>=3.0
requests

# ✅ GOOD: Pinned versions
Django==4.2.7
requests==2.31.0
```

**Node.js:**
```json
{
  "dependencies": {
    // ❌ BAD: Loose version ranges
    "express": "^4.x",
    
    // ✅ GOOD: Exact versions
    "express": "4.18.2"
  }
}
```

### 2. Use Lock Files

**Python:**
- Use `requirements.txt` with exact versions
- Or use `Pipfile.lock` with Pipenv
- Or use `poetry.lock` with Poetry

**Node.js:**
- Commit `package-lock.json`
- Or `yarn.lock` for Yarn
- Ensures consistent installations

### 3. Regular Updates

```bash
# Check outdated packages (Python)
pip list --outdated

# Check outdated packages (Node.js)
npm outdated

# Update strategy:
# 1. Review changelogs
# 2. Update in development
# 3. Test thoroughly
# 4. Deploy to production
```

### 4. Minimal Dependencies

```python
# ❌ BAD: Unnecessary dependencies
# Installing large frameworks for single utility

# ✅ GOOD: Only what's needed
# Use standard library when possible
# Choose lightweight alternatives
```

### 5. Dependency Review Process

For each new dependency:
- [ ] Is it actively maintained? (Recent commits)
- [ ] How many dependencies does it have? (Fewer is better)
- [ ] Is it well-documented?
-[ ] Does it have good test coverage?
- [ ] Are there known security issues?
- [ ] Is there a more secure alternative?
- [ ] Do we really need it?

## Common Vulnerable Packages

### Python

**Django:**
- Check against: https://www.djangoproject.com/weblog/
- Security releases often
- Always use stable/LTS versions

**Requests:**
- CVE-2023-32681: Proxy-Authorization header leak
- Update to >=2.31.0

**Pillow:**
- Frequent image processing vulnerabilities
- Keep updated to latest

**PyYAML:**
- CVE-2020-14343: Code execution via yaml.load()
- Use yaml.safe_load() instead

**Cryptography:**
- Multiple CVEs over time
- Keep current with latest version

### JavaScript/Node.js

**Express:**
- Check for qs vulnerability (CVE-2022-24999)
- Update middleware regularly

**Lodash:**
- Prototype pollution vulnerabilities
- Update to >=4.17.21

**Axios:**
- SSRF vulnerabilities in older versions
- Update to >=1.6.0

**socket.io:**
- Various authentication bypass issues
- Keep updated

## Supply Chain Attacks

### What to Watch For

**Typosquatting:**
- `reqeusts` instead of `requests`
- `pillaw` instead of `pillow`
- Always verify package names

**Compromised Packages:**
- Legitimate package taken over
- Malicious code added in update
- Monitor package maintainer changes

**Dependency Confusion:**
- Private package name conflicts with public
- Attacker publishes malicious public package
- Use private registries with authentication

### Prevention

**1. Verify Package Names:**
```bash
# Double-check spelling
pip install requests  # NOT reqeusts

# Check package info
pip show requests
```

**2. Use Hash Verification:**
```python
# requirements.txt with hashes
requests==2.31.0 \
    --hash=sha256:942c5a758f98d9519f59a0e3f9...
```

**3. Use Private Registries:**
```bash
# Configure pip to use private registry
pip config set global.index-url https://private-pypi.company.com

# Or in requirements.txt
--index-url https://private-pypi.company.com
```

**4. Software Composition Analysis (SCA):**
- Automated dependency scanning
- SBOM (Software Bill of Materials) generation
- Continuous monitoring

## GitHub Dependabot

### Configuration

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "pip"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 10
    
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 10
```

### Handling Dependabot PRs

1. **Review the PR:**
   - Check what changed (version bump)
   - Review changelog
   - Look for breaking changes

2. **Check CI:**
   - Ensure tests pass
   - Review security scan results

3. **Test locally:**
   - Pull branch
   - Run full test suite
   - Test functionality

4. **Merge or postpone:**
   - Merge if safe
   - Postpone if needs investigation
   - Document decision

## Vulnerability Scanning in CI/CD

### GitHub Actions

```yaml
# .github/workflows/security.yml
name: Security Scan

on: [push, pull_request]

jobs:
  dependency-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      
      - name: Install dependencies
        run: |
          pip install safety pip-audit
          pip install -r requirements.txt
      
      - name: Run Safety check
        run: safety check
      
      - name: Run pip-audit
        run: pip-audit
      
      - name: Fail on critical vulnerabilities
        run: |
          safety check --json | jq '.vulnerabilities[] | select(.severity=="critical")' | jq -e 'length == 0'
```

## Dependency Security Checklist

### Before Adding New Dependency
- [ ] Package name verified (no typosquatting)
- [ ] Package is actively maintained
- [ ] Recent activity (commits, releases)
- [ ] Good documentation
- [ ] Reasonable number of sub-dependencies
- [ ] No known critical vulnerabilities
- [ ] License compatible with project
- [ ] Package actually needed (not over-engineering)

### During Development
- [ ] Dependencies pinned to specific versions
- [ ] Lock files committed
- [ ] Minimal dependencies used
- [ ] Regular vulnerability scanning
- [ ] Automated security checks in CI/CD

### Before Release
- [ ] All dependencies scanned for CVEs
- [ ] No critical or high vulnerabilities
- [ ] Medium/low vulnerabilities documented
- [ ] Dependencies up to date (within reason)
- [ ] SBOM generated
- [ ] Security scan results reviewed

### Ongoing Maintenance
- [ ] Weekly Dependabot checks
- [ ] Monthly manual review
- [ ] Quarterly dependency updates
- [ ] Immediate response to critical CVEs
- [ ] Documentation of exceptions/accepted risks

## Handling Vulnerable Dependencies

### Immediate Actions for Critical CVEs

1. **Assess Impact:**
   - Is vulnerability exploitable in our context?
   - What data/systems are at risk?
   - Attack complexity (easy or hard)?

2. **Quick Fix Options:**
   ```bash
   # Option 1: Update to patched version
   pip install package==patched_version
   
   # Option 2: Pin safe version
   echo "package==safe_version" >> requirements.txt
   
   # Option 3: Remove if not needed
   pip uninstall package
   ```

3. **Mitigation if No Fix Available:**
   - Disable affected functionality
   - Add WAF rules
   - Network segmentation
   - Monitor for exploitation attempts

4. **Document Decision:**
   ```markdown
   # docs/security/dependency-vulnerabilities.md
   
   ## Active Vulnerabilities
   
   ### CVE-2023-12345 in package v1.0.0
   - **Severity**: High
   - **Impact**: SQL injection in admin panel
   - **Mitigation**: Admin panel disabled, not publicly accessible
   - **Fix Timeline**: Waiting for v1.0.1 release (expected next week)
   - **Tracking**: Issue #123
   ```

### When Update Breaks Things

1. **Test thoroughly first**
2. **Review breaking changes**
3. **Update code to match new API**
4. **Consider alternatives:**
   - Stay on current version with workarounds?
   - Switch to different package?
   - Fork and patch ourselves?

## Transitive Dependencies

**Problem:**
Your direct dependencies have their own dependencies (transitive), which may have vulnerabilities.

**Example:**
```
your-app
└── django (4.2.0)
    └── sqlparse (0.4.0)  ← Transitive dependency
        └── vulnerable!
```

**Solutions:**
```python
# Explicitly pin transitive dependency
# requirements.txt
Django==4.2.0
sqlparse==0.4.4  # Override Django's transitive dependency
```

## Resources

### Tools
- **Safety**: https://pyup.io/safety/
- **pip-audit**: https://github.com/pypa/pip-audit
- **Snyk**: https://snyk.io/
- **OWASP Dependency-Check**: https://owasp.org/www-project-dependency-check/

### Vulnerability Databases
- **National Vulnerability Database**: https://nvd.nist.gov/
- **GitHub Advisory Database**: https://github.com/advisories
- **PyPI Advisory Database**: https://github.com/pypa/advisory-database

### Best Practices
- **OWASP Dependency Management**: https://owasp.org/www-community/Component_Analysis
- **npm Security Best Practices**: https://docs.npmjs.com/about-security-audits

## Skill Metadata

**Skill Name:** Dependency Security
**Version:** 1.0
**Last Updated:** February 14, 2026
**Applicable To:** Security Agent, Code Inspector, Tech Lead
**Dependencies:** None
**Related Skills:** secure-coding-skill.md, secrets-detection-skill.md
