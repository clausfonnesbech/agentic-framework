# New MCP Servers Setup (Project-Agnostic)

Purpose: add optional MCP capabilities without introducing stack assumptions.

## Prerequisites

- AI assistant with MCP support
- Access to MCP settings in your assistant or editor
- Credentials/tokens only for servers you choose to enable

## Setup Workflow

1. Determine capability need from current project context.
2. Select matching server configuration file(s) in mcp-servers/.
3. Add selected servers to MCP settings.
4. Configure only required environment variables.
5. Validate each server starts successfully.
6. Record activation decision in PROJECT-MEMORY.md.

## Capability-Based Activation Matrix

- Source control and planning: enable when collaboration/traceability is needed.
- Security scanning: enable for secure coding and release gates.
- API contract validation: enable for API-first or integration-heavy projects.
- Browser validation: enable for UI and end-to-end flow testing.
- Data/backend operations: enable when project architecture includes these services.
- Documentation/reference: enable for selected runtime/framework/provider guidance.
- Automation and integrations: enable for workflow orchestration needs.
- Analytics and feedback: enable for experiment/measurement phases.

## Validation Checklist

- Server command resolves in local environment.
- Required env vars are present and scoped.
- Agent can execute one sample query successfully.
- Server use is justified by an explicit project decision.

## Troubleshooting

- Command not found: install required runtime/tooling for the selected server.
- Authentication failures: verify token scopes and expiration.
- Empty/irrelevant results: refine query and confirm server/category fit.
- Startup errors: run the server command manually to inspect logs.

## Change Control

When adding or removing servers:
- Update mcp-servers/README.md if inventory semantics change.
- Update project context and PROJECT-MEMORY.md with rationale.
- Keep unrelated server configs disabled by default.
