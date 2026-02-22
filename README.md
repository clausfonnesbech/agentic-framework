# Agentic AI Framework

A comprehensive, production-ready framework for orchestrating specialized AI agents in software development workflows. Built with security-first principles, this framework enables teams to leverage AI agents for requirements analysis, development, code review, security scanning, and quality assurance.

## 🌟 Features

### 11 Specialized Agents
- **Business Analyst Agent**: Requirements gathering, user story creation, stakeholder analysis
 - **Behavioral Reframe Agent**: Perceptual reframes, low-cost behavioral interventions, experiment design
- **Research Manager**: Research coordination, task delegation, synthesis
- **Research Agent**: Technical research, comparative analysis, feasibility studies
- **UX/UI Agent**: User experience evaluation, accessibility compliance, design systems
- **Task Manager**: Epic decomposition, sprint planning, dependency mapping
- **Tech Lead**: Architecture design, technical coordination, sprint planning
- **Coding Agent**: Secure implementation, Django/Azure development, self-review
- **Code Inspector**: Code quality review, functionality validation, test coverage
- **Security Agent**: Security scanning (Semgrep), CVE detection, GDPR compliance
- **QA Lead**: Test strategy, automated testing (Playwright), quality gates

### 21 Reusable Skills
Skills are modular markdown documents that agents load to enhance their capabilities:
- **Security**: secure-coding, secrets-detection, dependency-security
- **Code Quality**: code-review-checklist, test-case-design
- **Planning**: sprint-planning, story-readiness-verification, backlog-planning-estimation
- **Research**: market-research, comparative-analysis, technical-synthesis, source-evaluation
- **Design**: ui-ux-research, accessibility-inclusive-design
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

### 12 MCP Server Configurations
Model Context Protocol (MCP) servers provide agents with real-time access to tools and data:
- **github-config.json**: Issue tracking, PR management, security alerts
- **n8n-config.json**: Workflow automation patterns
- **supabase-config.json**: Database, authentication, storage patterns
- **postgresql-config.json**: Database design and query optimization
- **playwright-config.json**: Browser automation, UI testing
- **django-config.json**: Django framework, security patterns, DRF
- **azure-config.json**: Azure App Service, Key Vault, Application Insights
- **semgrep-config.json**: Automated security scanning, OWASP Top 10
- **python-docs-config.json**: Python/FastAPI/Django documentation
- **openapi-config.json**: API specification and design
- **microsoft-learn-config.json**: Microsoft Azure documentation

## 🚀 Quick Start

### Prerequisites
- AI assistant with MCP support (e.g., Claude with MCP enabled)
- Access to required MCP servers (see `mcp-servers/SETUP-GUIDE.md`)
- For security scanning: Semgrep installed (`brew install semgrep` or `pip install semgrep`)

### Installation

1. **Clone this repository:**
   ```bash
   git clone https://github.com/yourusername/agentic-framework.git
   cd agentic-framework
   ```

2. **Configure MCP servers:**
   - Review `mcp-servers/SETUP-GUIDE.md` for detailed setup instructions
   - Configure MCP servers in your AI assistant (e.g., Claude Desktop app)
   - Update config files with your credentials/tokens as needed

3. **Choose your agents:**
   - Review agent definitions in `agents/` directory
   - Select agents based on your workflow needs
   - Each agent file contains initialization instructions and required resources

4. **Load skills and templates:**
   - Agents reference skills and templates from this framework
   - Ensure your AI assistant has access to these directories
   - Skills are loaded at agent session start

### Basic Usage

**Example: Starting a Development Sprint**

1. **Tech Lead Agent** creates sprint plan:
   - Loads: `sprint-planning-skill.md`, `story-readiness-verification-skill.md`
   - Uses MCP: GitHub (issue tracking), Django (architecture)
   - Outputs: `sprint-plan-template.md`

2. **Coding Agent** implements features:
   - Loads: `secure-coding-skill.md` (ALWAYS FIRST)
   - Uses MCP: Django (primary), Azure SDK, Semgrep (self-review)
   - Performs security self-check before completion

3. **Code Inspector** reviews implementation:
   - Loads: `code-review-checklist-skill.md`
   - Uses MCP: Django (framework best practices)
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

### Agent Coordination Pattern

```
Tech Lead (Coordinator)
    ↓
Coding Agent (Implementation)
    ↓
Code Inspector (Quality Review) ←┐ Max 5 iterations total
    ↓                              │
    ↓──────────────────────────────┘
Security Agent (Security Gate)
    ↓
QA Lead (Quality Validation)
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

**Development Workflow:**
- Tech Lead coordinates → Coding Agent implements → Code Inspector reviews (iterations) → Security Agent scans → QA Lead validates

**Research Workflow:**
- Research Manager coordinates → Research Agents investigate → Research Manager synthesizes

**Planning Workflow:**
- Business Analyst gathers requirements → Task Manager decomposes epics → Tech Lead plans sprints

**UX Workflow:**
- UX/UI Agent evaluates → Security Agent validates accessibility → QA Lead tests user flows

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
- **pytest**: For Python test execution

**Security Scanning Examples:**
```bash
# Full security scan
semgrep scan --config=auto

# Django-specific scan
semgrep scan --config=python.django

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
Input: "Implement user profile password reset with Azure Key Vault"

Tech Lead:
- Creates sprint plan with security requirements
- Assigns to Coding Agent
- Configures Security Agent gate

Coding Agent:
- Loads secure-coding-skill.md FIRST
- References Azure MCP for Key Vault patterns
- Implements password reset with:
  - Secrets stored in Key Vault (never code/env vars)
  - CSRF protection
  - Rate limiting
  - Audit logging
- Performs security self-check before completion

Code Inspector:
- Reviews code quality and functionality
- Confirms test coverage >80%
- Validates Django best practices
- PASS → sends to Security Agent

Security Agent:
- Runs Semgrep scan
- Checks for secrets exposure
- Validates Azure Key Vault configuration
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
Input: "Should we use Django or FastAPI for our API backend?"

Research Manager:
- Creates research task breakdown
- Assigns comparative analysis to Research Agents

Research Agents:
- Load comparative-analysis-skill.md
- Use Python Docs MCP for documentation
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
