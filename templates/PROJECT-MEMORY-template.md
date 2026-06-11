# PROJECT MEMORY: [Project Name]

> **This file is the single source of truth for project progress.**  
> Every agent updates it as the last step of every action.  
> The Orchestrator reads it at session start to resume context.

**Project:** [Project Name]  
**Project Slug:** [project-slug]  
**Started:** [YYYY-MM-DD]  
**Last Updated:** [YYYY-MM-DD] by [Agent Name]

---

## Current Status

| Field | Value |
|---|---|
| **Phase** | Pre-Phase / Delivery / Complete |
| **Active Stage** | e.g. "Awaiting user approval of proposal" |
| **Current Sprint** | Sprint N / Not started |
| **Next Gate** | Gate N — [gate description] |
| **Overall Health** | 🟢 On track / 🟡 At risk / 🔴 Blocked |

---

## ⏳ Awaiting User Review

*Items in this table block pipeline progress until the user acts.*

| # | Item | File | Gate | Added | Status |
|---|------|------|------|-------|--------|
| 1 | [e.g. Proposal ready for approval] | [docs/project/01-proposals/...](.) | Gate 1 | YYYY-MM-DD | ⏳ Waiting |

*Clear rows (mark ✅ Approved or ❌ Rejected + note) when the user decides. Do not delete rows — the log is permanent.*

---

## User Story Status

| ID | Title | Sprint | Status | Last Agent | Updated |
|----|-------|--------|--------|------------|---------|
| US-001 | [short title] | Sprint 1 | 📝 Defined / 🔨 In Dev / 🔍 In Review / ✅ Done / ❌ Blocked | Tech Lead | YYYY-MM-DD |

**Status key:** 📝 Defined — 🔨 In Dev — 🔍 In Inspection — 🧪 In QA — 🔒 Security Review — ✅ Approved — ❌ Blocked

---

## Key Decisions

*Timestamped decisions that shape the project. All agents must read this before acting.*

| Date | Decision | Made by | Rationale |
|------|----------|---------|-----------|
| YYYY-MM-DD | [e.g. Use [DB option A] over [DB option B]] | BA Agent / User | [reason] |

---

## Open Assumptions

*From the BA interview. Mark resolved when confirmed by research, DevOps, or the user.*

| ID | Assumption | Owner | Risk | Status |
|----|------------|-------|------|--------|
| A-001 | [e.g. Self-reported time, no approval workflow] | BA Agent | Medium | ⏳ Open / ✅ Resolved |

---

## Open Blockers

*Anything stopping progress. Orchestrator surfaces these to the user immediately.*

| ID | Description | Raised by | Date | Status |
|----|-------------|-----------|------|--------|
| B-001 | [e.g. Cloud subscription access needed] | DevOps Agent | YYYY-MM-DD | ⏳ Open |

---

## Agent Activity Log

*Last 20 entries — oldest entries drop off the bottom when the table exceeds 20 rows.*

| Date | Agent | Action | Output |
|------|-------|--------|--------|
| YYYY-MM-DD | BA Agent | Completed two-phase interview; proposal created | [docs/.../proposal.md](.) |
