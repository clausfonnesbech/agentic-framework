# Quick Start Guide

Get started with the Agentic AI Framework in 5 minutes.

## Prerequisites

- AI assistant with MCP support (Claude Desktop app recommended)
- Git installed
- (Optional) Semgrep for security scanning: `brew install semgrep`

## Step 1: Clone the Framework

```bash
git clone https://github.com/yourusername/agentic-framework.git
cd agentic-framework
```

## Step 2: Configure MCP Servers

### Required for Basic Usage:
- **GitHub MCP**: Issue tracking, PR management
- **Django MCP** (if using Django): Framework documentation
- **Semgrep MCP** (for security): Automated scanning

### Setup:
1. Review `mcp-servers/SETUP-GUIDE.md`
2. Configure MCP servers in Claude Desktop app settings
3. Update config files with your credentials

**Example Claude Desktop Configuration:**
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your-token-here"
      }
    }
  }
}
```

## Step 3: Choose Your Workflow

### Development Workflow (Most Common)

**Agents needed:**
- Tech Lead (coordinator)
- Coding Agent (implementation)
- Code Inspector (code review)
- Security Agent (security gate)
- QA Lead (quality validation)

**Start a sprint:**

1. **Chat with Tech Lead:**
   ```
   You are the Tech Lead Agent from the Agentic Framework.
   Load skills: sprint-planning-skill.md, story-readiness-verification-skill.md
   MCP servers: GitHub (issue tracking), Django (architecture)
   
   Create a sprint plan for: [describe your project/feature]
   Use sprint-plan-template.md for output.
   ```

2. **Implement with Coding Agent:**
   ```
   You are the Coding Agent from the Agentic Framework.
   Load skills: secure-coding-skill.md (FIRST), secrets-detection-skill.md
   MCP servers: Django (primary), Azure SDK, Semgrep (self-review)
   
   Implement: [user story from sprint plan]
   Perform security self-check before completion.
   ```

3. **Review with Code Inspector:**
   ```
   You are the Code Inspector Agent from the Agentic Framework.
   Load skills: code-review-checklist-skill.md
   MCP servers: Django (framework best practices)
   
   Review the implementation by Coding Agent.
   Use code-review-report-template.md for output.
   Max 5 iterations with Coding Agent.
   ```

4. **Scan with Security Agent:**
   ```
   You are the Security Agent from the Agentic Framework.
   Load skills: secure-coding-skill.md, secrets-detection-skill.md, dependency-security-skill.md
   MCP servers: Semgrep (primary), Django (security patterns)
   
   Perform security scan on the code.
   Use security-review-report-template.md for output.
   BLOCK commit if critical issues found.
   ```

5. **Validate with QA Lead:**
   ```
   You are the QA Lead Agent from the Agentic Framework.
   Load skills: test-case-design-skill.md
   MCP servers: Playwright (UI testing)
   
   Create test plan and validate quality.
   Use test-plan-template.md for output.
   ```

### Research Workflow

**Agents needed:**
- Research Manager (coordinator)
- Research Agent(s) (investigators)

**Start research:**

1. **Chat with Research Manager:**
   ```
   You are the Research Manager Agent from the Agentic Framework.
   Load skills: comparative-analysis-skill.md, technical-synthesis-skill.md
   
   Research topic: [your question]
   Coordinate research and synthesize findings.
   Use research-report-template.md for output.
   ```

### Planning Workflow

**Agents needed:**
- Business Analyst (requirements)
- Task Manager (decomposition)
- Tech Lead (sprint planning)

**Start planning:**

1. **Chat with Business Analyst:**
   ```
   You are the Business Analyst Agent from the Agentic Framework.
   Load skills: market-research-skill.md
   
   Gather requirements for: [project description]
   Use user-story-template.md for output.
   ```

2. **Chat with Task Manager:**
   ```
   You are the Task Manager Agent from the Agentic Framework.
   Load skills: backlog-planning-estimation-skill.md
   
   Break down epic: [epic description]
   Use task-breakdown-template.md for output.
   ```

## Step 4: Agent Initialization Template

Use this template to start any agent:

```
You are the [Agent Name] from the Agentic Framework.

**Skills to load:**
- [skill-1.md]
- [skill-2.md]

**MCP servers to use:**
- [MCP Server 1]: [purpose]
- [MCP Server 2]: [purpose]

**Task:**
[Describe what you need the agent to do]

**Output format:**
Use [template-name.md] for structured output.

**Additional context:**
[Any specific requirements, constraints, or background]
```

## Step 5: Directory Structure Reference

```
agentic-framework/
├── agents/          # 10 agent definitions
├── skills/          # 21 reusable skills
├── templates/       # 9 output templates
├── mcp-servers/     # 12 MCP configurations
├── docs/            # Documentation
└── README.md        # Full documentation
```

## Common Patterns

### Security-First Development
```
1. Coding Agent loads secure-coding-skill.md FIRST
2. Self-check security before completion
3. Code Inspector reviews quality
4. Security Agent performs deep scan (Semgrep)
5. QA Lead validates functionality
```

### Iteration Control
```
- Max 5 combined iterations between Coding Agent and Code Inspector
- After 5 iterations → escalate to user
- Security Agent findings = new iteration cycle
- QA Lead findings = back to Coding Agent
```

### Blocking Gates
```
Security Agent: CRITICAL issues = BLOCK commit
Code Inspector: FAIL = back to Coding Agent
QA Lead: Test failures = back to Coding Agent
```

## Tips

1. **Always load skills first** - Skills enhance agent capabilities
2. **Use templates** - Ensures consistent, complete outputs
3. **One agent at a time** - Complete one agent's work before moving to next
4. **Reference framework paths** - Tell agents where files are located
5. **MCP servers are optional** - Agents work without but are enhanced with MCP
6. **Semgrep is key** - Install for security-first development
7. **Respect iteration limits** - Max 5 prevents infinite loops

## Troubleshooting

**Agent doesn't follow instructions:**
- Ensure agent definition is loaded
- Explicitly list skills to load
- Reference template structure

**MCP server not working:**
- Check Claude Desktop app settings
- Verify credentials/tokens
- Review `mcp-servers/SETUP-GUIDE.md`

**Security scan fails:**
- Install Semgrep: `brew install semgrep` or `pip install semgrep`
- Check Semgrep version: `semgrep --version` (need 1.X+)
- Test scan: `semgrep scan --config=auto`

**Templates not structured correctly:**
- Explicitly tell agent: "Use [template-name.md] for output"
- Provide template path: `templates/[template-name.md]`
- Request specific sections if needed

## Next Steps

- Read full [README.md](README.md) for detailed documentation
- Explore `agents/` directory for all agent definitions
- Review `skills/` directory for capability enhancements
- Check `templates/` directory for output formats
- Configure additional MCP servers from `mcp-servers/`

## Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/agentic-framework/issues)
- **Docs**: Full documentation in [README.md](README.md)
- **Setup**: Detailed MCP setup in `mcp-servers/SETUP-GUIDE.md`

---

**Quick Reference Card:**

| Agent | Primary Skill | Primary MCP | Output Template |
|-------|---------------|-------------|-----------------|
| Tech Lead | sprint-planning | GitHub, Django | sprint-plan |
| Coding Agent | secure-coding | Django, Semgrep | code files |
| Code Inspector | code-review-checklist | Django | code-review-report |
| Security Agent | secure-coding | Semgrep | security-review-report |
| QA Lead | test-case-design | Playwright | test-plan |
| Business Analyst | market-research | GitHub | user-story |
| Research Agent | comparative-analysis | [varies] | research-report |
| Task Manager | backlog-planning-estimation | GitHub | task-breakdown |
| UX/UI Agent | ui-ux-research | Playwright | ux-review-report |

---

Ready to build with AI agents! 🚀
