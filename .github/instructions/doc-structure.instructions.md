---
applyTo: "**"
description: "Documentation conventions for all agentic framework projects — folder structure, PROJECT-MEMORY format, user story layout, and agent output paths."
---

# Project Documentation Structure

Every project managed by this framework uses the following structure. All non-code agent outputs live under `docs/[project-slug]/`. The `[project-slug]` is the project name in kebab-case (e.g., `employee-time-tracker`).

## Canonical Folder Layout

```
docs/
  [project-slug]/
    PROJECT-MEMORY.md              ← ALWAYS exists; every agent updates this
    01-proposals/
      [project-slug]-proposal.md   ← BA Agent — GATE 1
    02-research/
      research-synthesis.md        ← Research Manager
      [topic]-research.md          ← Research Agents (one per topic)
    03-reframes/
      behavioral-reframes.md       ← Behavioral Reframe Agent — GATE 2 (with research)
    04-design/
      design-proposals.md          ← UX/UI Agent concept mode — GATE 3
      [direction]-detailed/
        workflow-diagram.md
        screen-mockups.md
        design-system.md
        style-guide.md
        components.md
        handoff-checklist.md
    05-delivery-plan/
      sprint-plan.md               ← Task Manager — GATE 4
    06-user-stories/
      US-NNN-[short-title]/        ← one folder per story, created by Tech Lead
        US-NNN.md                  ← full user story (Tech Lead)
        US-NNN-devops-gate.md      ← DevOps Agent (if applicable)
        US-NNN-inspection.md       ← Code Inspector (round 1)
        US-NNN-reinspection-2.md   ← Code Inspector (round 2, if needed)
        US-NNN-reinspection-3.md   ← Code Inspector (round 3, if needed)
        US-NNN-qa-review.md        ← QA Lead
        US-NNN-security-review.md  ← Security Agent (if story-level finding)
        US-NNN-completion.md       ← completion report (Tech Lead/Orchestrator)
    07-sprint-reviews/
      sprint-[N]-review.md         ← QA Lead sprint regression — GATE 5
    08-releases/
      release-[version]-security.md ← Security Agent end-to-end — GATE 6
```

## User Story Folder Naming

Format: `US-NNN-[short-title]`
- `NNN` = zero-padded story number (001, 002, …)
- `[short-title]` = 3–5 words, kebab-case, no articles
- Examples: `US-001-user-login-entra`, `US-012-export-csv-report`

## PROJECT-MEMORY.md — Required Sections

Every `PROJECT-MEMORY.md` must contain these sections in order. See `templates/PROJECT-MEMORY-template.md` for the full template.

| Section | Purpose | Who updates |
|---|---|---|
| Current Status | Phase, active stage, sprint, next gate | Every agent |
| ⏳ Awaiting User Review | Items blocked on user decision, with gate number and file link | Agent that created the output |
| User Story Status | ID, title, sprint, status, last-agent | Tech Lead, all dev-loop agents |
| Key Decisions | Timestamped decisions with rationale | BA, Tech Lead, Orchestrator |
| Open Assumptions | From BA interview; consumed by all agents | BA Agent, cleared when resolved |
| Open Blockers | Anything stopping progress | Any agent |
| Agent Activity Log | Last 20 entries: date, agent, action, output file | Every agent on every action |

## Agent Output Rules

1. **Every agent updates PROJECT-MEMORY.md** as the last step of every action — add a row to Agent Activity Log, update Current Status, and (if applicable) add/clear Awaiting User Review rows.
2. **Gate outputs always appear in Awaiting User Review** until the user approves them.
3. **User story documents always go into the correct `US-NNN-[short-title]/` folder** — never at the root of `06-user-stories/`.
4. **File names use the story ID as a prefix** so sorting by name shows all story documents together.
5. **No agent output goes in the project root, `.workflow/`, or undocumented locations** — only `docs/[project-slug]/` (for project docs) and `.workflow/` (for internal Orchestrator pipeline state).

## Gates Requiring User Review

| Gate | Owner | Output file | Awaiting Review text |
|---|---|---|---|
| Gate 1 | BA Agent | `01-proposals/[project-slug]-proposal.md` | "Proposal ready for approval" |
| Gate 2 | Orchestrator | `02-research/research-synthesis.md` + `03-reframes/behavioral-reframes.md` | "Research + reframes ready for review" |
| Gate 3 | UX/UI Agent | `04-design/design-proposals.md` | "5 design proposals — please select one" |
| Gate 4 | Task Manager | `05-delivery-plan/sprint-plan.md` | "Delivery plan ready for approval" |
| Gate 5 | QA Lead | `07-sprint-reviews/sprint-[N]-review.md` | "Sprint [N] regression complete — review required" |
| Gate 6 | Security Agent | `08-releases/release-[version]-security.md` | "Release security review complete — approval required before deploy" |
