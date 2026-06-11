# MCP Setup Guide (Project-Agnostic)

This guide defines how to enable MCP servers without preselecting infrastructure, language, framework, or provider.

## Principle

Enable MCP servers based on current project decisions, not template defaults.

## Before You Start

- Confirm project context exists:
  - docs/[project-slug]/PROJECT-MEMORY.md
  - docs/[project-slug]/01-proposals/
  - docs/[project-slug]/02-research/
  - .project-context.md (if present)
- Determine required capability categories for the current phase.

## Capability Categories

- Source control and planning
- Security scanning
- API specification and contract validation
- Browser and UI validation
- Data/backend operations
- Documentation/reference
- Workflow automation
- Analytics and feedback

## Setup Steps

1. Select only the server config files needed for current project capabilities.
2. Add selected servers to your MCP client settings.
3. Configure only required environment variables for selected servers.
4. Validate each server command starts successfully.
5. Run one sample query per server.
6. Record active MCPs and rationale in PROJECT-MEMORY.md.

## Environment Variables

Use scoped variables per enabled server. Example naming pattern:

```bash
MCP_<SERVER_ID>_TOKEN=
MCP_<SERVER_ID>_BASE_URL=
MCP_<SERVER_ID>_PROJECT_ID=
```

Do not define credentials for disabled servers.

## Validation Checklist

- Startup command resolves.
- Authentication succeeds.
- Query returns relevant results.
- Enabled servers map to explicit project decisions.
- Credentials are least-privilege and rotated.

## Troubleshooting

- Command failure: verify required runtime dependencies and package source.
- Auth failure: check token scope, expiration, and environment loading.
- Empty results: refine query and verify server/category fit.
- Slow/unavailable server: continue with fallback local analysis and note limitation.

## Security Requirements

- Never commit secrets to source control.
- Prefer runtime secret stores over local files.
- Keep server access scoped to least privilege.
- Disable servers not required by the current project phase.

## Agent Usage Guidance

- Orchestrator and BA: discovery-oriented documentation/research servers only.
- Tech Lead and DevOps: architecture, infrastructure, and delivery servers as required.
- Coding and Inspector: implementation, quality, and security servers as required.
- QA and Security: validation and risk-control servers as required.
