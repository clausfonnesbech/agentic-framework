# MCP Recommendations (Project-Agnostic)

This guide is intentionally stack-neutral.

## Core Rule

Do not preselect language, framework, cloud provider, database, or infrastructure tooling.
Select MCP servers only after project context confirms requirements.

## Selection Process

1. Read project context sources:
   - docs/[project-slug]/PROJECT-MEMORY.md
   - docs/[project-slug]/01-proposals/
   - docs/[project-slug]/02-research/
   - .project-context.md (if present)
2. Identify required capability categories:
   - Source control and issue tracking
   - Security scanning
   - API/spec validation
   - Browser/UX validation
   - Data/backend operations
   - Vendor/platform documentation
   - Workflow automation
   - Analytics/feedback
3. Enable only servers needed by the current phase.
4. Document enabled servers and rationale in PROJECT-MEMORY.md.

## Recommended Baseline

- Keep one source-control MCP configured.
- Keep one security scanning MCP configured.
- Add all other MCP servers on demand per project decisions.

## Agent Routing Guidance

- Business Analyst: load only discovery-relevant documentation/research servers.
- Tech Lead: load architecture and delivery-relevant servers.
- Coding Agent: load implementation and security-relevant servers.
- Code Inspector: load quality and reference servers.
- Security Agent: load security scanning and compliance servers.
- QA Lead: load browser/testing and observability servers.

## Governance Checks

Before each phase begins:
- Confirm no MCP is activated solely due to legacy defaults.
- Confirm activation maps to an explicit project decision.
- Confirm credentials are scoped to least privilege.

## Output Requirement

When recommending MCP setup, always include:
- Enabled server list
- Capability objective per server
- Why each server is needed now
- What remains intentionally disabled
