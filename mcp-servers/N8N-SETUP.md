# n8n MCP Server Setup Guide

This guide helps you configure the n8n MCP server for use with this Agentic AI framework.

## What is the n8n MCP Server?

The n8n MCP (Model Context Protocol) server allows AI agents to:
- Query your n8n workflows and capabilities
- Understand available integrations (400+ services)
- Access workflow templates and best practices
- Trigger workflow executions (when needed)
- Identify automation opportunities in projects

## Prerequisites

- n8n instance (self-hosted or cloud)
- n8n API access enabled
- Node.js installed
- API key from your n8n instance

## Setup Steps

### Step 1: Get Your n8n API Key

**For n8n Cloud:**
1. Log into your n8n cloud account
2. Go to Settings → API Keys
3. Create a new API key
4. Copy and save it securely

**For Self-Hosted n8n:**
1. Access your n8n instance
2. Navigate to Settings → n8n API
3. Enable API access if not already enabled
4. Generate an API key
5. Copy and save it securely

### Step 2: Set Environment Variables

Add these to your environment:

**macOS/Linux (.zshrc or .bash_profile):**
```bash
export N8N_API_URL="https://your-n8n-instance.com"
export N8N_API_KEY="your-api-key-here"
```

**Windows (System Environment Variables):**
```
N8N_API_URL=https://your-n8n-instance.com
N8N_API_KEY=your-api-key-here
```

**For localhost:**
```bash
export N8N_API_URL="http://localhost:5678"
export N8N_API_KEY="your-api-key-here"
```

### Step 3: Install n8n MCP Server

```bash
npm install -g n8n-mcp
```

Or use npx (no installation required):
```bash
npx n8n-mcp
```

### Step 4: Configure in VS Code/Copilot

**VS Code Settings (settings.json):**
```json
{
  "mcp.servers": {
    "n8n": {
      "command": "npx",
      "args": ["-y", "n8n-mcp"],
      "env": {
        "N8N_API_URL": "https://your-n8n-instance.com",
        "N8N_API_KEY": "your-api-key-here"
      }
    }
  }
}
```

**GitHub Copilot:**
The n8n MCP server should be automatically available if configured globally.

### Step 5: Verify Connection

Test the connection:

```bash
# Using environment variables
npx n8n-mcp test-connection

# Or with inline config
N8N_API_URL=https://your-n8n.com N8N_API_KEY=your-key npx n8n-mcp test
```

## Usage in Agents

Once configured, the Business Analyst agent (and other agents) can automatically:

1. **Detect automation needs** in user requests
2. **Query n8n** for available capabilities
3. **Recommend workflows** that fit the use case
4. **Identify integrations** that connect required services
5. **Estimate time savings** from using n8n vs. custom code

### Example Agent Query

When a user says:
> "I need to sync customer data from Salesforce to our PostgreSQL database"

The agent can query n8n:
- "Show Salesforce to database sync workflows"
- "What n8n nodes connect Salesforce and PostgreSQL?"
- "Best practices for data synchronization in n8n"

## Common Use Cases

### Use Case 1: Integration Projects
**User Request:** "Connect our CRM to Slack for notifications"

**Agent Actions:**
1. Query n8n for CRM integrations
2. Check if Slack integration exists
3. Find similar workflow templates
4. Recommend n8n-based solution
5. Estimate setup time (hours vs. days of custom code)

### Use Case 2: Automation Opportunities
**User Request:** "We manually export reports every Monday"

**Agent Actions:**
1. Identify automation opportunity
2. Query n8n for scheduling capabilities
3. Find report generation workflows
4. Propose automated solution
5. Calculate time savings

### Use Case 3: Complex Workflows
**User Request:** "Employee onboarding with multiple systems"

**Agent Actions:**
1. Map out required integrations
2. Query n8n for each integration
3. Check for onboarding templates
4. Design multi-step workflow
5. Recommend n8n orchestration

## Configuration File Reference

Location: `mcp-servers/n8n-config.json`

Key sections:
- **capabilities**: What n8n can do
- **when_to_use**: Scenarios for using n8n
- **example_queries**: Sample queries agents can make
- **agent_instructions**: How agents should use n8n
- **common_use_cases**: Typical automation scenarios

## Troubleshooting

### Issue: "Connection failed"

**Check:**
- Is n8n running? (visit your N8N_API_URL in browser)
- Is the URL correct? (include http:// or https://)
- Is the API enabled in n8n settings?

**Solution:**
```bash
# Test direct connection
curl -H "X-N8N-API-KEY: your-key" https://your-n8n.com/api/v1/workflows
```

### Issue: "Authentication error"

**Check:**
- Is your API key valid and not expired?
- Does the API key have proper permissions?
- Is the key correctly set in environment variables?

**Solution:**
```bash
# Verify environment variables
echo $N8N_API_URL
echo $N8N_API_KEY

# Regenerate API key if needed
```

### Issue: "No workflows found"

**Check:**
- Have you created workflows in n8n?
- Are workflows active/published?
- Does your API key have access to workflows?

**Solution:**
- Create at least one workflow in n8n
- Ensure workflows are saved and active

### Issue: "MCP server not available in Copilot"

**Check:**
- Is the MCP server properly configured in settings?
- Are environment variables set in the right place?
- Try restarting VS Code/Copilot

**Solution:**
```bash
# Check if MCP server can run standalone
npx n8n-mcp --help

# Restart VS Code
# Reload window: Cmd+Shift+P → "Developer: Reload Window"
```

## Security Best Practices

1. **Never commit API keys** to version control
2. **Use environment variables** for credentials
3. **Rotate API keys** regularly
4. **Limit API key permissions** to what's needed
5. **Use HTTPS** for production n8n instances
6. **Monitor API usage** in n8n dashboard

## Benefits for Agents

When agents can access n8n:

✅ **Better recommendations** - Suggest proven automation solutions  
✅ **Time estimates** - Compare n8n setup vs. custom development  
✅ **Integration insights** - Know what connections are possible  
✅ **Best practices** - Reference n8n community workflows  
✅ **Cost savings** - Highlight automation ROI  
✅ **User empowerment** - Visual workflow builder for non-developers

## Testing the Setup

### Test 1: Basic Connection
```bash
npx n8n-mcp test-connection
```

Expected: "✓ Connected to n8n successfully"

### Test 2: List Workflows
```bash
npx n8n-mcp list-workflows
```

Expected: List of your n8n workflows

### Test 3: Agent Query
In your AI assistant:
1. Load the Business Analyst agent
2. Say: "I need to automate data synchronization between services"
3. Agent should mention n8n as an option

## Next Steps

1. ✅ Complete setup above
2. ✅ Test connection
3. ✅ Create a few workflows in n8n (if none exist)
4. ✅ Try using the Business Analyst agent
5. ✅ Mention automation needs in your requests
6. ✅ Agent will query n8n automatically

## Resources

- [n8n Documentation](https://docs.n8n.io/)
- [n8n Workflow Templates](https://n8n.io/workflows/)
- [n8n API Reference](https://docs.n8n.io/api/)
- [MCP Protocol Specification](https://modelcontextprotocol.io/)

---

**Configuration Status:** Follow steps above to enable  
**Required for:** Automation and integration projects  
**Optional:** Can skip if no automation needs
