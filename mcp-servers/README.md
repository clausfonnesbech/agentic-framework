# MCP Server Guide for Agents

## What is MCP?

**Model Context Protocol (MCP)** is a standard that allows AI agents to access external tools, data sources, and services. Think of it as a way for agents to extend their capabilities beyond their training data.

## Available MCP Servers

### 🧭 Quick Server Inventory

- `microsoft-learn-config.json` - Microsoft documentation and implementation guidance
- `n8n-config.json` - workflow automation and integration capabilities
- `supabase-config.json` - Supabase database/auth/storage/realtime
- `postgresql-config.json` - advanced PostgreSQL patterns and optimization
- `python-docs-config.json` - Python/FastAPI/Django docs via GitHub MCP
- **`django-config.json`** - **Django framework documentation, security patterns, ORM best practices**  ⭐ NEW
- **`azure-config.json`** - **Azure App Service, Key Vault, deployment patterns, monitoring** ⭐ NEW
- **`semgrep-config.json`** - **Automated security scanning, vulnerability detection, OWASP Top 10** ⭐ NEW
- `openapi-config.json` - OpenAPI contract validation and API design quality checks
- `github-config.json` - GitHub issues/PR/project traceability
- `playwright-config.json` - browser-level UX flow validation

### � n8n Workflow Automation MCP

**Configuration:** `mcp-servers/n8n-config.json`

**What it provides:**
- Access to your n8n workflows and automation capabilities
- Query available integrations and nodes
- Trigger workflow executions
- Access workflow templates and best practices
- Check execution status

**When to use it:**

✅ **Use when:**
- Project involves automation or orchestration
- Need to integrate multiple services or APIs
- Looking for ways to reduce manual processes
- Building data pipelines or ETL workflows
- Creating scheduled or event-driven tasks
- Connecting business applications without custom code
- User mentions automation, workflows, or integration needs

❌ **Don't use when:**
- Simple one-time tasks
- No integration or automation requirements
- Project is purely frontend or content-focused

**How to use it in your agent workflow:**

1. **Identify automation opportunities**
   - Listen for keywords: automation, integration, workflow, scheduled tasks
   - Consider if n8n could simplify complex integrations
   - Think about repetitive processes that could be automated

2. **Query n8n capabilities**
   - "What workflows exist for [use case]?"
   - "Can n8n integrate [service A] with [service B]?"
   - "What are best practices for [automation scenario]?"
   - "Show templates for [workflow type]"

3. **Incorporate findings**
   - Add n8n as part of your technical approach
   - Highlight automation benefits (time savings, error reduction)
   - Reference specific workflows or templates that could be used
   - Include in "Technical Considerations" section

4. **Recommend automation**
   - Call out manual processes that could be automated
   - Estimate time/cost savings from automation
   - Suggest n8n for non-technical users (visual workflow builder)

**Example workflow snippet:**

```
User mentions: "We need to sync customer data from Salesforce to our 
database and send welcome emails"

Agent thinks: This involves integration and automation - perfect for n8n!

Agent queries n8n MCP:
- "n8n workflows for Salesforce integration"
- "How to send automated emails in n8n"
- "Database sync patterns in n8n"

Agent uses findings to:
- Propose n8n-based solution in technical approach
- Estimate setup time vs. custom code alternative
- Highlight visual workflow builder for maintenance
- Include cost/time savings in business case
```

### �📚 Microsoft Learn MCP

**Configuration:** `mcp-servers/microsoft-learn-config.json`

**What it provides:**
- Access to official Microsoft documentation
- Technical tutorials and learning paths
- API references and code examples
- Best practices and architectural patterns
- Information about Microsoft products and services

**When to use it:**

✅ **Use when:**
- User mentions Microsoft technologies (Azure, Power Platform, M365, .NET, Dynamics, etc.)
- You need to verify technical capabilities of Microsoft services
- Looking for implementation guidance or code examples
- Researching Microsoft-specific best practices
- Checking if a Microsoft service can solve a particular problem

❌ **Don't use when:**
- Project has no Microsoft technology involvement
- Generic programming questions not specific to Microsoft stack
- User explicitly wants non-Microsoft solutions

**How to use it in your agent workflow:**

1. **Identify the need**
   - Listen for Microsoft technology keywords in user requests
   - Assess if Microsoft solutions might be relevant

2. **Formulate queries**
   - Use natural language queries
   - Be specific about what you're looking for
   - Examples:
     * "How does Azure Functions handle authentication?"
     * "What are the rate limits for Microsoft Graph API?"
     * "Best practices for Power Automate error handling"

3. **Integrate findings**
   - Don't just dump search results
   - Synthesize the information
   - Incorporate into your proposal with context
   - Cite the source (e.g., "According to Microsoft Learn...")

4. **Document in proposal**
   - Add findings to "Technical Considerations" section
   - Note any limitations or gotchas you discover
   - Include links to relevant documentation

**Example workflow snippet:**

```
User mentions: "I need to automate our employee onboarding process 
and integrate it with Microsoft 365"

Agent thinks: This involves Microsoft 365, so I should use Microsoft Learn MCP

Agent queries MCP:
- "Microsoft 365 onboarding automation options"
- "Power Automate capabilities for user provisioning"
- "Microsoft Graph API for user management"

Agent uses findings to:
- Inform technical approach in proposal
- Identify which Microsoft services are appropriate
- Note any limitations or licensing requirements
- Provide relevant documentation links
```

### � Django Framework MCP ⭐ NEW

**Configuration:** `mcp-servers/django-config.json`

**What it provides:**
- Django framework documentation and patterns
- Django REST Framework best practices
- Django ORM query optimization
- Security patterns (CSRF, SQL injection prevention, XSS)
- Authentication and authorization systems
- Production deployment configurations

**When to use it:**

✅ **Use when:**
- Implementing Django models, views, or serializers
- Creating REST APIs with Django REST Framework
- Setting up authentication or authorization
- Preventing Django-specific security vulnerabilities
- Optimizing database queries with Django ORM
- Configuring production Django settings
- Integrating Django with Supabase or PostgreSQL

❌ **Don't use when:**
- Project doesn't use Django
- Generic Python questions (use python-docs MCP instead)

**Agents who need this:**
- **Coding Agent:** Primary user for Django development
- **Security Agent:** Django security pattern validation
- **Tech Lead:** Architecture and framework decisions
- **Code Inspector:** Django code quality standards

**Example queries:**
```
"How to implement Row Level Security with Django and Supabase?"
"Secure file upload handling in Django?"
"Django REST Framework patterns for nested serializers?"
"Prevent SQL injection with Django ORM?"
"Production security settings for Django?"
```

### ☁️ Azure Cloud Platform MCP ⭐ NEW

**Configuration:** `mcp-servers/azure-config.json`

**What it provides:**
- Azure App Service configuration and deployment
- Azure Key Vault for secrets management
- Application Insights monitoring and logging
- CI/CD with GitHub Actions to Azure
- Sweden region compliance for GDPR
- HTTPS enforcement and security configuration

**When to use it:**

✅ **Use when:**
- Configuring Azure infrastructure (US-001)
- Setting up Azure App Service deployment
- Implementing Azure Key Vault integration
- Configuring Application Insights monitoring
- Ensuring Sweden region compliance
- Setting up CI/CD pipeline to Azure
- Troubleshooting Azure deployment issues

❌ **Don't use when:**
- Project doesn't use Azure hosting
- Infrastructure already configured and stable

**Agents who need this:**
- **Tech Lead:** Infrastructure architecture and planning
- **Coding Agent:** Azure SDK integration (Key Vault, App Insights)
- **Security Agent:** Azure security configuration validation

**Example queries:**
```
"Deploy Django to Azure App Service with Python 3.11?"
"Azure Key Vault integration in Python?"
"Configure Application Insights for Django logging?"
"GitHub Actions workflow for Azure deployment?"
"Enforce HTTPS and TLS 1.3 on Azure App Service?"
```

### 🔒 Semgrep Security Scanning MCP ⭐ NEW

**Configuration:** `mcp-servers/semgrep-config.json`

**What it provides:**
- Automated vulnerability detection (OWASP Top 10)
- SQL injection, XSS, command injection detection
- Secrets and credential exposure detection
- Django-specific security rules
- Insecure cryptography detection
- Authentication and authorization bypass patterns

**When to use it:**

✅ **Use when:**
- Security Agent performing security review
- Coding Agent doing self-review before completion
- Setting up CI/CD security gates
- Scanning for exposed secrets
- Detecting common vulnerabilities
- Validating secure coding practices

❌ **Don't use when:**
- Manual code review is sufficient
- Not doing security-sensitive work
- Semgrep not installed locally

**Agents who need this:**
- **Security Agent:** Primary tool for automated scanning
- **Coding Agent:** Self-review security checks
- **Tech Lead:** CI/CD security gate configuration

**Usage pattern:**
```bash
# Full security scan
semgrep scan --config=auto --json

# Django-specific scan
semgrep scan --config=p/django .

# Secrets detection
semgrep scan --config=p/secrets .

# OWASP Top 10
semgrep scan --config=p/owasp-top-ten .
```

**Blocking rules:**
- **ERROR severity:** MUST FIX (blocks commit)
- **WARNING severity:** SHOULD FIX (requires review)
- **INFO severity:** REVIEW (suggestions)

**Installation:**
```bash
pip install semgrep
# or
brew install semgrep

# Verify
semgrep --version
```

### �🔎 OpenAPI MCP

**Configuration:** `mcp-servers/openapi-config.json`

Use when you need to validate API contracts, endpoint consistency, request/response schemas, and error model quality.

### 🐙 GitHub MCP

**Configuration:** `mcp-servers/github-config.json`

Use when you need issue/PR/project traceability, especially for Task Manager execution handoff.

### 🎭 Playwright MCP

**Configuration:** `mcp-servers/playwright-config.json`

Use when UX flows need browser-level validation (keyboard navigation, state transitions, interaction checks).

## How MCP Servers Work (Conceptual)

```
┌─────────────────┐
│   Your Agent    │
│  (Instructions) │
└────────┬────────┘
         │
         │ Needs external information
         │
         ▼
┌─────────────────┐
│  MCP Server     │
│ Configuration   │
└────────┬────────┘
         │
         │ Executes query
         │
         ▼
┌─────────────────┐
│  External       │
│  Data Source    │
│ (Microsoft      │
│   Learn)        │
└────────┬────────┘
         │
         │ Returns results
         │
         ▼
┌─────────────────┐
│   Your Agent    │
│  Synthesizes &  │
│  Uses Info      │
└─────────────────┘
```

## Adding More MCP Servers

In the future, you might add servers for:
- 🌐 **Web Search** - For general research
- 💾 **Database Access** - For querying project data
- 📁 **File System** - For reading/writing files
- 🐙 **GitHub** - For accessing code repositories
- 📊 **Analytics** - For data insights
- 🎨 **Design Systems** - For UI component libraries

Each would have its own configuration file in this directory.

## Best Practices for Using MCP Servers

### 1. **Use Judiciously**
- Only query when you genuinely need external information
- Don't query just because you can
- Consider if you already have sufficient knowledge

### 2. **Be Specific**
- Formulate clear, targeted queries
- Don't make vague requests
- Ask for specific features, capabilities, or guidance

### 3. **Synthesize, Don't Regurgitate**
- Process the information you receive
- Integrate it naturally into your work
- Don't just copy-paste documentation

### 4. **Cite Your Sources**
- Attribute information to Microsoft Learn when appropriate
- Be transparent about where information came from
- Maintain credibility

### 5. **Handle Failures Gracefully**
- MCP servers might not always be available
- Have a fallback if you can't access external resources
- Don't let MCP failures stop your work

## Technical Notes

### Enablement Steps (User)

1. Install packages or use `npx -y` in MCP settings.
2. Set required `.env` variables (`SUPABASE_*`, `MCP_API_KEY`, `POSTGRES_CONNECTION_STRING`, `GITHUB_PERSONAL_ACCESS_TOKEN`, `N8N_*`).
3. Add MCP servers to VS Code setting: `github.copilot.chat.experimental.mcpServers`.
4. Restart VS Code.
5. Run `npx playwright install` for Playwright MCP support.

Detailed setup is documented in `mcp-servers/SETUP-GUIDE.md`.

### For Developers Setting Up MCP

**Microsoft Learn MCP Server Installation:**
```bash
# Package name may vary by environment/distribution.
# If @modelcontextprotocol/server-microsoft-learn returns E404,
# use your environment's configured Microsoft Learn MCP source.
npx -y @modelcontextprotocol/server-microsoft-learn
```

**Requirements:**
- Node.js 16 or higher
- Internet connection
- No authentication required for Microsoft Learn

**Testing MCP Server:**
```bash
# Test that the server can be invoked (if package resolves in your environment)
npx @modelcontextprotocol/server-microsoft-learn --help
```

### Configuration Structure

All MCP configurations in this folder follow this pattern:

```json
{
  "mcpServers": {
    "server-id": {
      "name": "Human-readable name",
      "description": "What this server provides",
      "command": "Command to execute",
      "args": ["arguments"],
      "capabilities": {
        "capability": "description"
      },
      "when_to_use": ["scenario 1", "scenario 2"],
      "example_queries": ["query 1", "query 2"],
      "agent_instructions": {
        "activation": "When to activate",
        "usage": "How to use",
        "integration": "How to integrate findings"
      }
    }
  }
}
```

## Troubleshooting

**Issue: MCP server not responding**
- Check internet connection
- Verify Node.js is installed
- Try running the command manually

**Issue: Query returns no results**
- Refine your query to be more specific
- Try alternative phrasing
- Verify the topic is covered by Microsoft Learn

**Issue: Results aren't relevant**
- Make queries more specific
- Include technology names and versions
- Add context to your query

---

**For Agents:** Remember that MCP servers are tools to enhance your capabilities, not replace your thinking. Use them strategically to provide better, more informed outputs.

**For Developers:** This folder can be extended with additional MCP server configurations as needed. Each server should have clear documentation for agents to understand when and how to use it.
