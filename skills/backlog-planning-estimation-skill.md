# Backlog Planning & Estimation Skill

**Skill Type:** Delivery Planning  
**Purpose:** Convert requirements and design artifacts into executable, dependency-aware, right-sized delivery work.

## Overview

This skill provides a practical framework for story decomposition, sequencing, estimation, and risk-aware sprint planning.

## When to Use This Skill

- ✅ Breaking scope into user stories
- ✅ Building sprint/phase plans
- ✅ Estimating effort and complexity
- ✅ Mapping dependencies and critical path
- ✅ Preparing implementation-ready backlogs

## Core Principles

### 1. Slice by User Value
Prefer vertical slices delivering end-to-end behavior over horizontal technical chunks.

### 2. Keep Work Small
Target stories that fit 1-3 days; split large items early.

### 3. Make Stories Testable
Every story needs verifiable acceptance criteria.

### 4. Sequence Explicitly
Unclear dependencies become delivery risk; map them up front.

### 5. Plan for Risk
High uncertainty or integration risk should produce explicit spike/hardening tasks.

## Story Slicing Framework

For each requirement:
1. Identify user outcome
2. Identify minimum viable behavior
3. Identify data/API/UI dependencies
4. Create smallest independently testable slice
5. Add hardening or edge-case slices as separate stories

## Estimation Framework

### Size Bands
- **S:** 4-8 hours
- **M:** 1-2 days
- **L:** 3-4 days
- **XL:** 5+ days (split required)

### Effort Inputs
- Scope clarity
- Dependency count
- Integration complexity
- Testing effort
- Unknowns/assumptions

### Estimation Rule
If uncertainty > 30%, add a discovery/spike story before committing full implementation estimate.

## Dependency Mapping

For each story, classify:
- **Hard dependency:** must be completed first
- **Soft dependency:** preferable but not mandatory
- **External dependency:** outside team control

Track:
- Story blocked by
- Stories this item blocks
- Risk if delayed

## Prioritization Patterns

### MoSCoW
- Must / Should / Could / Won’t

### WSJF-lite (for tie-breaks)
Use a simple score:

$$
WSJF\text{-lite} = \frac{Business\ Value + Time\ Criticality + Risk\ Reduction}{Estimated\ Effort}
$$

Higher score = earlier priority.

## Sprint/Phase Construction

### Recommended Sequence
1. **Foundation:** environment, auth, core data models, CI/CD
2. **Core value:** highest-impact user journeys
3. **Integration:** external services, automation, cross-system flows
4. **Hardening:** quality, performance, security, observability

### Capacity Guardrail
Plan sprint load at ~80-85% of nominal capacity to absorb uncertainty.

## Acceptance Criteria Quality Checklist

- Specific, measurable outcomes
- Includes positive and negative paths
- Includes permissions and validation where relevant
- Includes non-functional checks when applicable

## Risk Register Template

For each top risk:
- Risk description
- Probability (Low/Med/High)
- Impact (Low/Med/High)
- Mitigation action
- Owner and trigger condition

## Common Anti-Patterns

- ❌ Epics disguised as stories
- ❌ Stories with no explicit user value
- ❌ Missing acceptance criteria
- ❌ Ignoring cross-story dependencies
- ❌ Overcommitting sprint capacity

## Output Artifacts to Create or Enrich

- `project-plan.md`: milestones, risks, assumptions
- `dependencies.md`: graph + critical path
- `sprint-plan.md`: capacity and sequencing
- `coverage-matrix.md`: requirement/design to story mapping
- `user-stories/US-XXX.md`: implementation-ready stories

## Definition of Done (Planning)

- ✅ Full requirement/design coverage is mapped
- ✅ Stories are decomposed to actionable size
- ✅ Dependencies and critical path are explicit
- ✅ Estimates are consistent and justified
- ✅ Risks have mitigation actions

---

Use this skill when execution speed and predictability matter and the team needs a backlog that is ready to build.
