# Infrastructure Templates

This folder is intentionally stack-neutral.

Add infrastructure definitions only after project architecture decisions are finalized in:
- docs/architecture.md
- .project-context.md

Recommended structure:
- infrastructure/modules/ (reusable components)
- infrastructure/environments/ (dev, staging, prod definitions)
- scripts/validate-infra.sh (called by CI)

Validation guidance:
- Use project-selected IaC tooling and policy checks.
- Keep infrastructure fully version-controlled.
- Avoid committing credentials or secrets.
