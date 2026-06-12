# Agentic AI Framework

A comprehensive, production-ready framework for orchestrating specialized AI agents in software development workflows. Built with security-first principles, this framework enables teams to leverage AI agents for requirements analysis, development, code review, security scanning, and quality assurance.

## 🌟 Features

### 13 Specialized Agents
- **Orchestrator Agent (Project Manager)**: Single entry point for all work — routes requests, runs the pipeline autonomously between user decision gates, shields the user from agent coordination
- **Business Analyst Agent**: Requirements gathering, user story creation, stakeholder analysis
- **Behavioral Reframe Agent**: Perceptual reframes, low-cost behavioral interventions, experiment design — surfaces alternative ideas before build commitment
- **Research Manager**: Research coordination, task delegation, synthesis
- **Research Agent**: Technical research, comparative analysis, feasibility studies
- **UX/UI Agent**: Always presents 5 distinct design proposals for user selection before detailed design; accessibility compliance, design systems
- **Task Manager**: Epic decomposition, sprint planning, dependency mapping
- **Tech Lead**: Architecture design, technical coordination, sprint planning
- **DevOps/Platform Agent**: Infrastructure/platform readiness gate, CI/CD, and integration setup before coding
- **Coding Agent**: Secure implementation in the project-selected stack, with self-review
- **Code Inspector**: Code quality review, functionality validation, test coverage
- **Security Agent**: Security scanning (Semgrep), CVE detection, GDPR compliance — blocking end-to-end gate before every release
- **QA Lead**: Test strategy, automated testing (Playwright), story-level and sprint-level quality gates

### Reusable Skills
Skills are modular markdown documents that agents load to enhance their capabilities:
- **Security**: secure-coding, secrets-detection, dependency-security
- **Code Quality**: code-review-checklist, test-case-design
- **Planning**: sprint-planning, story-readiness-verification, backlog-planning-estimation
- **Research**: market-research, comparative-analysis, technical-synthesis, source-evaluation
- **Design**: ui-ux-research, accessibility-inclusive-design
- **Brand/Client Compliance**: atea-design-compliance
- **Architecture**: api-design, database-design, authentication-authorization, realtime-communication
- **Workflow**: workflow-automation, file-storage-security
- **Mindset**: curiosity

### 9 Output Templates
Standardized templates ensure consistency across agent outputs:
- **user-story-template.md**: User stories with acceptance criteria, DoR/DoD
- **research-report-template.md**: Research findings with evidence and recommendations
- **sprint-plan-template.md**: Sprint coordination with dependencies and risk assessment
- **security-review-report-template.md**: Security scan results with Semgrep integration
- **code-review-report-template.md**: Code quality review with coverage analysis
- **test-plan-template.md**: QA strategy with manual and automated test plans
- **ux-review-report-template.md**: UX evaluation with Nielsen heuristics and WCAG compliance
- **task-breakdown-template.md**: Epic decomposition with effort estimation
- **proposal-template.md**: Project proposals with business case

### MCP Server Configurations
Model Context Protocol (MCP) servers provide agents with real-time access to tools and data:
- Source control and planning integrations
- Workflow automation integrations
- Data/backend integrations
- Documentation/reference integrations
- API specification/contract integrations
- Browser and UI validation integrations
- Security scanning integrations

See `mcp-servers/README.md` for the full optional inventory. Server activation is project-specific.

## 🚀 Quick Start

### Goal: Project-Local Mirror (Recommended)

Use this mode if you want to:
- keep a clean source-of-truth framework repo,
- work with editable `agents/`, `skills/`, `templates/`, `mcp-servers/`, and `shared/` inside your project,
- ensure project edits do not impact the framework repo unless you explicitly push them.

This is implemented by:
- a local mirror clone at `.agentic-framework/` (git-ignored in your project),
- a sync script at `scripts/sync-framework.sh`.

### Prerequisites
- Git
- Bash shell (macOS/Linux or Git Bash on Windows)
- AI assistant with MCP support

### Get Started (Mirror + Sync)

1. **Go to your project root (existing or new):**
   ```bash
   cd /path/to/your-project
   ```

2. **Bootstrap the framework mirror into your project:**

   Option A (recommended one-liner):
   ```bash
   curl -fsSL https://raw.githubusercontent.com/clausfonnesbech/agentic-framework/main/scripts/bootstrap-sync.sh \
     | bash -s -- "$PWD"
   ```

   Option B (from a local framework clone):
   ```bash
   /path/to/agentic-framework/scripts/bootstrap-sync.sh "$PWD"
   ```

3. **Confirm mirror setup:**
   ```bash
   ./scripts/sync-framework.sh status
   ```

4. **Pull framework updates when needed:**
   ```bash
   ./scripts/sync-framework.sh pull
   ```

### How Isolation Works

- Edit framework files directly in your project paths (`agents/`, `skills/`, etc.).
- Your edits are committed to your project repository, not to the framework repository.
- The framework clone lives in `.agentic-framework/` and is ignored by your project `.gitignore`.
- Nothing is sent upstream unless you explicitly run:
  ```bash
  ./scripts/sync-framework.sh push "your message"
  ```

If you never run `push`, your project-specific agent customizations stay project-local.

### MCP Setup

- Review `mcp-servers/SETUP-GUIDE.md`.
- Enable only the MCP servers required by your selected project stack.
- Add credentials/tokens in your local runtime environment.

### Basic Usage

**Example: Starting a Development Sprint**

1. **Tech Lead Agent** creates sprint plan:
   - Loads: `sprint-planning-skill.md`, `story-readiness-verification-skill.md`
   - Uses MCP: GitHub (issue tracking) + any stack-relevant docs MCP for the selected project stack
   - Outputs: `sprint-plan-template.md`

2. **Coding Agent** implements features:
   - Loads: `secure-coding-skill.md` (ALWAYS FIRST)
   - Uses MCP: stack-appropriate documentation/tooling MCPs, plus Semgrep (self-review)
   - Performs security self-check before completion

3. **Code Inspector** reviews implementation:
   - Loads: `code-review-checklist-skill.md`
   - Uses MCP: stack-appropriate docs and validation MCPs
   - Outputs: `code-review-report-template.md`
   - Max 5 iterations with Coding Agent

4. **Security Agent** scans code:
   - Loads: `secure-coding-skill.md`, `secrets-detection-skill.md`
   - Uses MCP: Semgrep (automated scanning - PRIMARY)
   - Outputs: `security-review-report-template.md`
   - BLOCKS commit on critical issues

5. **QA Lead** validates quality:
   - Loads: `test-case-design-skill.md`
   - Uses MCP: Playwright (UI testing)
   - Outputs: `test-plan-template.md`
   - Confirms all quality gates passed

## 🏗️ Architecture

### Orchestrated Pipeline (Recommended)

The **Orchestrator Agent** (`agents/00-orchestrator-agent.md`) is the single entry point. You give it any ask — from an initial idea to a small change request — and it runs the full pipeline, involving you only at decision gates:

```
USER ASK → Orchestrator (Project Manager)
   │
   ├── PRE-PHASE
   │     Business Analyst ──────────── GATE 1: approve proposal
   │     Research Manager → Research Agents (parallel)
   │     Behavioral Reframe Agent ──── GATE 2: review research + alternatives
   │     UX/UI Agent (5 proposals) ─── GATE 3: select a design
   │     UX/UI Agent (detailed design for chosen direction)
   │
   └── DELIVERY MODE
         Task Manager (phases/sprints) ─ GATE 4: approve plan
         Tech Lead (detailed stories)
         DevOps Agent (infra/MCP readiness gate)
         ┌──────────────────────────────────────┐
         │ Per story: Coding Agent ⇄ Code        │
         │ Inspector (max 3 rounds) → QA Lead    │
         │ (combined cap 5 → escalate to user)   │
         └──────────────────────────────────────┘
         QA Lead (full sprint regression) ─ GATE 5: sprint review
         Security Agent (end-to-end, blocking) ─ GATE 6: release approval
```

Request triage: **Track A** (new project — full pipeline), **Track B** (enhancement — abbreviated pre-phase), **Track C** (small fix — straight to delivery loop). Quality gates are never skipped.

Before triage, the Orchestrator discloses whether the work is an Atea project. If Atea Design applies, the agent team loads `skills/atea-design-compliance-skill.md` and enforces Atea brand, design-system, accessibility, component, and tone-of-voice requirements throughout proposal, UX/UI, implementation, inspection, and QA.

### Agent Coordination Pattern (Story-Level Loop)

```
Tech Lead (Coordinator)
    ↓
Coding Agent (Implementation)
    ↓
Code Inspector (Quality Review) ←┐ Max 5 iterations total
    ↓                              │
    ↓──────────────────────────────┘
QA Lead (Story Validation)
    ↓
Security Agent (Release Gate)
    ↓
✅ Ready for Commit
```

### Design Principles

1. **Security-First**: Every developer agent loads secure-coding-skill.md FIRST
2. **Iteration Control**: Max 5 combined iterations before user escalation
3. **Blocking Gates**: Security Agent blocks commits on critical issues
4. **Separation of Concerns**: Each agent has specific, non-overlapping responsibilities
5. **Skill Modularity**: Skills are reusable across multiple agents
6. **Template Standardization**: Consistent outputs across all agent sessions
7. **MCP Integration**: Real-time access to tools and documentation

### Key Workflows

**Orchestrated Workflow (recommended):**
- Orchestrator triages → runs pre-phase (BA → Research → Reframes → UX 5 proposals) → delivery mode (Task Manager → Tech Lead → DevOps gate → dev quality loop → sprint QA → security release gate) — user involved only at 6 decision gates

**Development Workflow:**
- Tech Lead coordinates → Coding Agent implements → Code Inspector reviews (iterations) → QA Lead validates story → Security Agent gates release

**Research Workflow:**
- Research Manager coordinates → Research Agents investigate → Research Manager synthesizes → Behavioral Reframe Agent challenges with alternatives

**Planning Workflow:**
- Business Analyst gathers requirements → Task Manager decomposes epics → Tech Lead plans sprints

**UX Workflow:**
- UX/UI Agent presents 5 distinct proposals → user selects → detailed design → QA Lead tests user flows

## 📚 Documentation

- **[agents/README.md](agents/README.md)**: Complete agent catalog with capabilities
- **[skills/README.md](skills/README.md)**: Skill library reference
- **[templates/README.md](templates/README.md)**: Template usage guide
- **[mcp-servers/README.md](mcp-servers/README.md)**: MCP server inventory
- **[mcp-servers/SETUP-GUIDE.md](mcp-servers/SETUP-GUIDE.md)**: Detailed MCP setup
- **[docs/DEVELOPMENT-AGENTS-ENHANCEMENT-SUMMARY.md](docs/DEVELOPMENT-AGENTS-ENHANCEMENT-SUMMARY.md)**: Framework design document

## 🔧 Customization

### Adding New Agents

1. Create new agent definition in `agents/` directory
2. Define purpose, capabilities, skills, and MCP servers
3. Specify initialization instructions and session management
4. Document agent's role in workflow coordination

### Creating Custom Skills

1. Create markdown file in `skills/` directory
2. Include clear purpose, capabilities, and usage examples
3. Provide code samples, checklists, or procedures
4. Reference from agent definitions

### Extending Templates

1. Create template in `templates/` directory
2. Use structured format with clear sections
3. Include agent-specific guidance
4. Add to `templates/README.md` catalog

### Adding MCP Servers

1. Create config file in `mcp-servers/` directory
2. Define capabilities and use cases
3. Document installation and setup
4. Update `mcp-servers/README.md` and `SETUP-GUIDE.md`
5. Reference from relevant agents

## 🛡️ Security

This framework implements security at multiple levels:

- **Secure Coding Skill**: Loaded by all development agents as first priority
- **Secrets Detection**: Pattern-based scanning for exposed credentials
- **Dependency Security**: CVE scanning with safety/pip-audit
- **Automated Scanning**: Semgrep integration for OWASP Top 10
- **GDPR Compliance**: Data protection checks in Security Agent
- **No Tolerance Policy**: Critical security issues BLOCK commits
- **Iteration Limits**: Max 5 iterations prevents infinite security fix loops

## 🧪 Testing

**Required Tools:**
- **Semgrep**: `brew install semgrep` or `pip install semgrep` (v1.151.0+)
- **Playwright**: Configured via MCP server for UI testing
- **Project test runner**: Use the runner selected by the project

**Security Scanning Examples:**
```bash
# Full security scan
semgrep scan --config=auto

# Optional stack-specific scan (only if relevant)
semgrep scan --config=<stack-specific-policy>

# Secrets only
semgrep scan --config=secrets

# OWASP Top 10
semgrep scan --config=owasp-top-ten
```

**Test Coverage Requirements:**
- Overall: 80%+ coverage
- Critical paths: 100% coverage
- Security functions: 100% coverage

## 📊 Usage Examples

### Example 1: Security-First Feature Development

```
Input: "Implement secure user profile password reset"

Tech Lead:
- Creates sprint plan with security requirements
- Assigns to Coding Agent
- Configures Security Agent gate

Coding Agent:
- Loads secure-coding-skill.md FIRST
- Implements password reset with:
   - Secrets stored in the project's secrets manager (never code)
  - CSRF protection
  - Rate limiting
  - Audit logging
- Performs security self-check before completion

Code Inspector:
- Reviews code quality and functionality
- Confirms test coverage >80%
- Validates selected-stack best practices
- PASS → sends to Security Agent

Security Agent:
- Runs Semgrep scan
- Checks for secrets exposure
- Validates secrets manager configuration
- GDPR compliance check
- PASS → ready for QA

QA Lead:
- Creates test plan
- Executes automated tests (Playwright)
- Validates all acceptance criteria
- PASS → ready for commit ✅
```

### Example 2: Research-Driven Architecture Decision

```
Input: "Which backend stack should we use for our API?"

Research Manager:
- Creates research task breakdown
- Assigns comparative analysis to Research Agents

Research Agents:
- Load comparative-analysis-skill.md
- Use the most relevant docs MCPs for the candidate stacks
- Research performance, scalability, ecosystem
- Output: research-report-template.md

Research Manager:
- Synthesizes findings
- Provides recommendation with evidence
- Documents trade-offs

Tech Lead:
- Reviews research
- Makes architecture decision
- Documents in sprint plan
```

## 🤝 Contributing

Contributions welcome! This framework is designed to be extended and customized for various workflows.

**Areas for Contribution:**
- New agent definitions for different domains
- Additional skills for emerging technologies
- MCP server configurations for popular tools
- Template improvements and new formats
- Documentation and usage examples

**Guidelines:**
- Follow existing agent/skill/template structure
- Include clear documentation
- Provide usage examples
- Test with real workflows
- Update relevant README files

## 📝 License

[Choose your license: MIT, Apache 2.0, etc.]

## 🙏 Acknowledgments

Built on the Model Context Protocol (MCP) standard for AI agent integration with tools and data sources.

---

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/agentic-framework/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/agentic-framework/discussions)
- **Documentation**: See `docs/` directory for detailed guides

---

**Version**: 1.0.0  
**Last Updated**: 2026-02-15  
**Status**: Production Ready
