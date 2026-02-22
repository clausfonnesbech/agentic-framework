# GitHub Operations Skill

Purpose
- Provide consistent, automated repository stewardship: branching strategy, commit conventions, PR hygiene, and CI/CD integration.
- Owned primarily by DevOps/Platform Agent (07). Tech Lead (06) can request/approve changes.

When to use
- Initial repository setup for a new project
- Enabling CI/CD and quality gates
- Enforcing branch protection and PR checks
- Release automation (tags, changelogs) when desired

Core responsibilities
1) Repository Standards
- Initialize main branch and default labels
- Add CODEOWNERS, pull request templates, and issue templates (optional)
- Configure .gitignore and standard directories (.github/workflows)

2) Branch & Commit Conventions
- Default branches: main (protected), feature/*, chore/*, fix/*, hotfix/*
- Conventional Commits recommended (feat, fix, chore, docs, refactor, test, ci)
- Small PRs, linked to issues when applicable

3) CI/CD Pipelines
- Python: lint (flake8), format check (black), types (mypy), tests (pytest)
- Infrastructure: Bicep build validation
- Optional deployment stages based on environment (dev/stage/prod)

4) Protection & Quality Gates
- Require PR reviews (min 1), dismiss stale approvals on new commits
- Require status checks (CI must pass)
- Restrict who can push to main

5) Automation (Optional)
- Semantic versioning and release notes
- Labeler for PRs and issues

Agent operating procedure
- Read the project context: /projects/<name>/.project-context.md
- Detect tech stack; choose templates accordingly
- Scaffold .github/workflows from templates
- Open a PR titled "chore: repo standards and CI/CD setup" with summary of applied standards

Outputs
- .github/workflows/*
- docs/ci-cd.md (optional)
- CODEOWNERS (optional)
- PULL_REQUEST_TEMPLATE.md / issue templates (optional)

Rollbacks & safety
- Use PRs to introduce standards; avoid force changes on main
- Document deviations in project docs

Success metrics
- CI is green on main
- Protected branches enforced
- Average PR cycle time reduces
- Releases are automated and consistent
