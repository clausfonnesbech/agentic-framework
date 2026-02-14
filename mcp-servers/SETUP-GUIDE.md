# MCP Server Setup Guide for Agent Workflow

## Overview

This guide explains how to enable MCP servers used by your agents, including the new servers added for UX/UI validation and delivery planning:
- OpenAPI MCP
- GitHub MCP
- Playwright MCP

It also covers the existing Supabase, PostgreSQL, Python Docs, Microsoft Learn, and n8n MCPs.

---

## MCPs in This Project

### Core MCPs
1. **Supabase MCP** (`mcp-servers/supabase-config.json`)
2. **PostgreSQL MCP** (`mcp-servers/postgresql-config.json`)
3. **Python Docs MCP** (`mcp-servers/python-docs-config.json`)
4. **Microsoft Learn MCP** (`mcp-servers/microsoft-learn-config.json`)
5. **n8n MCP** (`mcp-servers/n8n-config.json`)

### Newly Added MCPs
6. **OpenAPI MCP** (`mcp-servers/openapi-config.json`)  
   - Validates and inspects API contracts and schemas
7. **GitHub MCP** (`mcp-servers/github-config.json`)  
   - Supports issue/PR/project traceability from stories
8. **Playwright MCP** (`mcp-servers/playwright-config.json`)  
   - Enables browser-level UX flow checks and interaction validation

---

## Prerequisites

- Node.js 18+ (recommended)
- npm
- VS Code with GitHub Copilot Chat MCP support enabled
- Supabase credentials (if using Supabase/PostgreSQL MCP)
- GitHub Personal Access Token (for Python Docs/GitHub MCP)
- n8n API URL + key (if using n8n MCP)

---

## Step 1: Install MCP Packages

```bash
# Core MCPs
npm install -g supabase-mcp
npm install -g @modelcontextprotocol/server-postgres
npm install -g @modelcontextprotocol/server-github
npm install -g n8n-mcp

# New MCPs
npm install -g openapi-mcp-server
npm install -g @playwright/mcp
```

If your environment prefers `npx -y ...`, you can skip global installs and use `npx` in VS Code settings.

Microsoft Learn MCP package names vary by environment and may not currently resolve from npm with `@modelcontextprotocol/server-microsoft-learn`. If this entry fails with `E404`, keep the server disabled until you confirm a valid package/source in your runtime.

---

## Step 2: Configure Environment Variables

Create or update `.env` in the project root:

```bash
# Supabase
SUPABASE_URL=https://[your-project-id].supabase.co
SUPABASE_ANON_KEY=[your-anon-public-key]
SUPABASE_SERVICE_KEY=[your-service-role-key]
MCP_API_KEY=[random-strong-key-for-supabase-mcp-stdio]

# PostgreSQL (typically Supabase connection string)
POSTGRES_CONNECTION_STRING=postgresql://postgres.[project-id]:[password]@aws-0-eu-north-1.pooler.supabase.com:6543/postgres

# GitHub (used by Python Docs MCP + GitHub MCP)
GITHUB_PERSONAL_ACCESS_TOKEN=[your-github-token]

# n8n
N8N_API_URL=http://localhost:5678
N8N_API_KEY=[your-n8n-api-key]
```

Load variables:

```bash
source ./load-env.sh
```

---

## Step 3: Create/Verify GitHub Token

1. Go to https://github.com/settings/tokens
2. Create token (classic or fine-grained)
3. Minimum scopes:
   - Read-only usage: repo metadata/content read
   - If creating issues/PR comments: issue/PR write scopes as needed
4. Set token in `.env` as `GITHUB_PERSONAL_ACCESS_TOKEN`

Use least privilege.

---

## Step 4: VS Code MCP Configuration

Open user settings JSON and add/update:

```json
{
  "github.copilot.chat.experimental.mcpServers": {
    "supabase": {
      "command": "npx",
      "args": ["-y", "supabase-mcp", "supabase-mcp-claude"],
      "env": {
        "SUPABASE_URL": "${env:SUPABASE_URL}",
        "SUPABASE_ANON_KEY": "${env:SUPABASE_ANON_KEY}",
        "SUPABASE_SERVICE_KEY": "${env:SUPABASE_SERVICE_KEY}",
        "SUPABASE_SERVICE_ROLE_KEY": "${env:SUPABASE_SERVICE_KEY}",
        "MCP_API_KEY": "${env:MCP_API_KEY}"
      }
    },
    "postgresql": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres", "${env:POSTGRES_CONNECTION_STRING}"]
    },
    "python-docs": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${env:GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    },
    "microsoft-learn": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-microsoft-learn"]
    },
    "n8n": {
      "command": "npx",
      "args": ["-y", "n8n-mcp"],
      "env": {
        "N8N_API_URL": "${env:N8N_API_URL}",
        "N8N_API_KEY": "${env:N8N_API_KEY}"
      }
    },
    "openapi": {
      "command": "npx",
      "args": ["-y", "openapi-mcp-server"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${env:GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp"]
    }
  }
}
```

Then restart VS Code.

---

## Step 5: Playwright Browser Dependencies

Playwright MCP may require browser binaries on first run:

```bash
npx playwright install
```

If prompted for system dependencies, follow output instructions.

---

## Step 6: Quick Connectivity Tests

```bash
# Core
MCP_API_KEY="local-smoke" node .workflow/mcp-smoke.js supabase supabase-mcp-claude
npx @modelcontextprotocol/server-postgres --help
npx @modelcontextprotocol/server-github --help
npx @modelcontextprotocol/server-microsoft-learn --help
npx n8n-mcp --help

# New
npx openapi-mcp-server --help
npx @playwright/mcp --help
```

If all commands respond, binaries are available.

---

## What You Need To Do (Checklist)

- [ ] Ensure Node.js 18+ is installed
- [ ] Install MCP server packages (or rely on `npx`)
- [ ] Add/update `.env` variables
- [ ] Create/verify GitHub token and scopes
- [ ] Add MCP server block in VS Code settings JSON
- [ ] Restart VS Code
- [ ] Run `npx playwright install`
- [ ] Run `--help` checks for new MCP servers
- [ ] Run one test query per new MCP in Copilot Chat

---

## Agent Usage Mapping

- **UX/UI Agent:** Supabase, Python Docs, n8n, Playwright, OpenAPI
- **Task Manager Agent:** Supabase, PostgreSQL, Python Docs, n8n, OpenAPI, GitHub

---

## Troubleshooting

### MCP not showing in Copilot
- Confirm settings are in **User** settings JSON
- Restart VS Code after edits
- Check Copilot output logs in VS Code Output panel

### GitHub MCP auth failures
- Re-check `GITHUB_PERSONAL_ACCESS_TOKEN`
- Verify token scopes and expiration

### Playwright MCP errors
- Run `npx playwright install`
- Re-run with internet access enabled

### n8n MCP cannot connect
- Verify `N8N_API_URL` and `N8N_API_KEY`
- Ensure n8n instance is reachable

---

## Security Notes

- Never commit `.env`
- Keep service-role keys and PAT tokens out of tracked files
- Prefer least-privilege tokens
- Rotate compromised keys immediately

---

**Last Updated:** February 13, 2026  
**Version:** 2.1
