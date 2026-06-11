# MCP Server Guide for Agents

All MCP configurations in this folder are optional capability modules. Do not assume any specific server, infrastructure provider, language stack, or framework is active for a project unless it is explicitly selected in that project's context and enabled in its configuration.

## What is MCP?

**Model Context Protocol (MCP)** is a standard that allows AI agents to access external tools, data sources, and services. Think of it as a way for agents to extend their capabilities beyond their training data.

## Available MCP Servers

### 🧭 Quick Server Inventory

- Source control and project traceability servers
- Workflow automation and integration servers
- Data and backend capability servers
- Language/framework documentation servers
- Cloud/provider documentation servers
- Security scanning and vulnerability detection servers
- API contract validation servers
- Browser-level validation servers
- Analytics and experimentation servers
- Research and content retrieval servers

See the `mcp-servers/` directory for the exact optional server config files available in this repository.

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

### 📚 Vendor Documentation MCP

**Configuration:** Any documentation MCP in `mcp-servers/`

**What it provides:**
- Access to official vendor/platform documentation
- Technical tutorials and learning paths
- API references and code examples
- Best practices and architectural patterns
- Product and service capability information

**When to use it:**

✅ **Use when:**
- User mentions a specific vendor/platform and requests authoritative guidance
- You need to verify technical capabilities of selected services
- Looking for implementation guidance or code examples
- Researching vendor/platform-specific best practices
- Checking whether a selected service can solve a particular problem

❌ **Don't use when:**
- Project has no need for vendor/platform-specific documentation
- Generic questions that do not depend on selected vendor/platform behavior

**How to use it in your agent workflow:**

1. **Identify the need**
   - Listen for vendor/platform-specific keywords in user requests
   - Assess if vendor-specific documentation is needed

2. **Formulate queries**
   - Use natural language queries
   - Be specific about what you're looking for
   - Examples:
   * "How does this managed runtime handle authentication?"
   * "What are the API rate limits for this service?"
   * "Best practices for error handling in this integration tool"

3. **Integrate findings**
   - Don't just dump search results
   - Synthesize the information
   - Incorporate into your proposal with context
   - Cite the source documentation server in your summary

4. **Document in proposal**
   - Add findings to "Technical Considerations" section
   - Note any limitations or gotchas you discover
   - Include links to relevant documentation

**Example workflow snippet:**

```
User mentions: "I need to automate our employee onboarding process 
and integrate it with our selected productivity platform"

Agent thinks: This involves a specific vendor platform, so I should use the relevant documentation MCP

Agent queries MCP:
- "Onboarding automation options for this platform"
- "Provisioning capabilities in this integration service"
- "User management API guidance for this vendor"

Agent uses findings to:
- Inform technical approach in proposal
- Identify which selected services are appropriate
- Note any limitations or licensing requirements
- Provide relevant documentation links
```

### Framework-Specific MCP (Optional)

**Configuration:** Any framework MCP in `mcp-servers/`

Use when:
- A project has selected a specific framework and you need official patterns and implementation guidance
- You need framework-specific security and production-hardening recommendations

Do not use when:
- The project has not selected that framework
- The question is framework-agnostic

Example query patterns:
```
"How should [framework] structure authentication for this use case?"
"What are secure file upload patterns in [framework]?"
"What are production settings best practices for [framework]?"
```

### Cloud Provider MCP (Optional)

**Configuration:** Any cloud MCP in `mcp-servers/`

Use when:
- A project has selected that cloud provider
- You need deployment, security, or operations guidance tied to the selected provider

Do not use when:
- The project has not selected that provider
- You are making stack-agnostic decisions

Example query patterns:
```
"How do we deploy [selected runtime] to [selected cloud service]?"
"How should secrets be managed on [selected cloud]?"
"What monitoring setup is recommended for [selected cloud]?"
```

### 🔒 Semgrep Security Scanning MCP ⭐ NEW

**Configuration:** `mcp-servers/semgrep-config.json`

**What it provides:**
- Automated vulnerability detection (OWASP Top 10)
- SQL injection, XSS, command injection detection
- Secrets and credential exposure detection
- Optional stack-specific security rules when relevant
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

# Optional stack-specific scan
semgrep scan --config=<stack-policy> .

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
│ (Selected       │
│   source)       │
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

### New MCPs Added (how to configure)

- `analytics-config.json`
   - Purpose: Provide read-only access to product/web analytics (GA4, Amplitude, Mixpanel).
   - Setup: Create a service account or API key with read-only permissions for the analytics property. Place credentials in your agent runtime's secure store and update `analytics-config.json` with endpoint and auth type.
   - Use: Query funnel conversion, compare treatment vs control, fetch cohort behaviour over time.

- `optimizely-config.json`
   - Purpose: Control feature flags and roll out experiments programmatically.
   - Setup: Generate a scoped management API key (least privilege) from your experimentation platform. Configure baseUrl and auth in `optimizely-config.json`.
   - Use: Create flags for pilot rollouts, assign audiences and fetch variant results to correlate with analytics.

- `qualtrics-config.json`
   - Purpose: Run micro-surveys and collect qualitative feedback post-experiment.
   - Setup: Create an API token in Qualtrics or Typeform and store it securely; update `qualtrics-config.json` with the auth method.
   - Use: Deploy 1–2 question surveys to participants after treatment to surface motivations.

- `youtube-config.json`
   - Purpose: Fetch video metadata and transcripts for talks/interviews (e.g., Rory Sutherland TED talks).
   - Setup: Obtain a YouTube Data API key, record it in your secure store, and add to `youtube-config.json`.
   - Use: Retrieve transcripts for citation, extract memorable quotes and examples for challenge reports.


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
- Attribute information to the source documentation MCP when appropriate
- Be transparent about where information came from
- Maintain credibility

### 5. **Handle Failures Gracefully**
- MCP servers might not always be available
- Have a fallback if you can't access external resources
- Don't let MCP failures stop your work

## Technical Notes

### Enablement Steps (User)

1. Install packages or use `npx -y` in MCP settings.
2. Set only the `.env` variables required by the servers you enabled.
3. Add MCP servers to VS Code setting: `github.copilot.chat.experimental.mcpServers`.
4. Restart VS Code.
5. Run `npx playwright install` for Playwright MCP support.

Detailed setup is documented in `mcp-servers/SETUP-GUIDE.md`.

### For Developers Setting Up MCP

- Use the command and arguments defined in the specific `*-config.json` files you enable.
- Verify each server's environment variable requirements before startup.
- Test startup command resolution locally before adding the server to shared settings.

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
- Verify required runtime dependencies are installed
- Try running the command manually

**Issue: Query returns no results**
- Refine your query to be more specific
- Try alternative phrasing
- Verify the topic is covered by the selected documentation/source MCP

**Issue: Results aren't relevant**
- Make queries more specific
- Include technology names and versions
- Add context to your query

---

**For Agents:** Remember that MCP servers are tools to enhance your capabilities, not replace your thinking. Use them strategically to provide better, more informed outputs.

**For Developers:** This folder can be extended with additional MCP server configurations as needed. Each server should have clear documentation for agents to understand when and how to use it.
