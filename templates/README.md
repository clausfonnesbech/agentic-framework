# Templates Directory

This directory contains output templates for all agents in the framework. Each template provides a structured format for agent deliverables, ensuring consistency and completeness.

---

## Project Template

### **project-template/** 🎯 NEW
**Used by:** All agents when starting new projects  
**Purpose:** Complete project scaffolding for multi-project workspaces  
**When:** Creating a new solution/project

**Usage:**
```powershell
# Interactive mode
./scripts/new-project.ps1

# With parameters
./scripts/new-project.ps1 -ProjectName "Customer Portal" -ProjectFolder "customer-portal"
```

**Includes:**
- `.project-context.md` - Project metadata and agent coordination
- `README.md` - Project documentation
- `.env.example` - Environment configuration template
- `infrastructure/` - Azure Bicep IaC templates
- `docs/` - Architecture, API specs, deployment guides
- `backlog/` - Backlog and sprint planning structure
- Standard directory layout for src/, tests/, etc.

See [project-template/README.md](project-template/README.md) for full structure details.

---

## Document Templates

### 1. **proposal-template.md**
**Used by:** Business Analyst Agent  
**Purpose:** Solution proposals and project recommendations  
**When:** Initial project scoping and business case development

---

### 2. **user-story-template.md** ⭐ NEW
**Used by:** Business Analyst Agent, Task Manager Agent  
**Purpose:** Detailed user story documentation with acceptance criteria  
**When:** Breaking down features into actionable stories

**Includes:**
- User story format (As a/I want/So that)
- Acceptance criteria (Given/When/Then)
- Technical notes & dependencies
- Definition of Ready/Done
- Story points & estimates

---

### 3. **research-report-template.md** ⭐ NEW
**Used by:** Research Agent, Research Manager Agent  
**Purpose:** Comprehensive research findings and recommendations  
**When:** Technical research, comparative analysis, feasibility studies

**Includes:**
- Executive summary
- Detailed findings
- Comparative analysis matrix
- Technical specifications
- Cost analysis
- Recommendations

---

### 4. **sprint-plan-template.md** ⭐ NEW
**Used by:** Tech Lead Agent  
**Purpose:** Sprint planning and coordination  
**When:** Beginning of each sprint

**Includes:**
- Sprint goal & objectives
- Team capacity planning
- Sprint backlog with stories
- Dependencies & risks
- Quality gates
- Daily schedule
- Success metrics

---

###5. **security-review-report-template.md** ⭐ NEW
**Used by:** Security Agent  
**Purpose:** Comprehensive security assessment before commit  
**When:** After Code Inspector approval, before story completion

**Includes:**
- Automated scan results (Semgrep)
- Secrets detection findings
- GDPR compliance check
- Dependency vulnerabilities
- Secure coding review
- Pass/Fail verdict with remediation

---

### 6. **code-review-report-template.md** ⭐ NEW
**Used by:** Code Inspector Agent  
**Purpose:** Code quality and functional review  
**When:** After coding complete, before Security Agent

**Includes:**
- Functional validation
- Code quality assessment
- Test coverage review
- Performance considerations
- Documentation review
- Pass/Fail/Needs Revision verdict

---

### 7. **test-plan-template.md** ⭐ NEW
**Used by:** QA Lead Agent  
**Purpose:** Comprehensive testing strategy and execution  
**When:** Sprint end validation, release testing

**Includes:**
- Test scope & objectives
- Test cases (manual & automated)
- Test environment setup
- Defect management
- Test metrics & coverage
- Entry/exit criteria

---

### 8. **ux-review-report-template.md** ⭐ NEW
**Used by:** UX/UI Agent  
**Purpose:** User experience and interface quality assessment  
**When:** Design review, implementation validation

**Includes:**
- Usability heuristic evaluation
- User flow analysis
- Accessibility review (WCAG 2.1)
- Visual design assessment
- Responsive design review
- UX improvement recommendations

---

### 9. **task-breakdown-template.md** ⭐ NEW
**Used by:** Task Manager Agent  
**Purpose:** Epic/feature decomposition into user stories and tasks  
**When:** Feature planning, backlog grooming

**Includes:**
- Epic overview & scope
- User story breakdown
- Dependency mapping
- Sprint allocation
- Effort estimation
- Resource allocation
- Risk assessment

---

## Template Usage Guidelines

### When to Use Templates

**✅ DO use templates when:**
- Creating formal deliverables
- Documenting decisions
- Providing status updates
- Creating artifacts for stakeholders
- Ensuring completeness

**❌ DON'T use templates for:**
- Quick informal updates
- Internal agent communication
- Brainstorming sessions
- Draft explorations

---

## Template Customization

### How to Adapt Templates

1. **Remove sections not needed** - Templates are comprehensive; not all sections apply to every situation
2. **Add project-specific sections** - Extend templates for unique needs
3. **Adjust depth** - Simple stories need less detail than complex ones
4. **Maintain structure** - Keep core sections for consistency

### Example: Lightweight vs. Detailed

**Lightweight user story (simple change):**
- Use story template but skip detailed technical notes
- Focus on acceptance criteria
- Minimal documentation

**Detailed user story (complex feature):**
- Full template with all sections
- Extensive technical specifications
- Multiple design considerations

---

## Template Relationships

### How Templates Connect

```
proposal-template.md
        ↓ (approved proposal)
task-breakdown-template.md
        ↓ (creates stories)
user-story-template.md
        ↓ (planned in sprint)
sprint-plan-template.md
        ↓ (implementation)
code-review-report-template.md
        ↓ (passed review)
security-review-report-template.md
        ↓ (passed security)
test-plan-template.md
        ↓ (validated)
ux-review-report-template.md
```

---

## Best Practices

### For Business Analyst Agent

- Use **proposal-template.md** for initial project scoping
- Use **user-story-template.md** when detailing specific features
- Always include acceptance criteria in Given/When/Then format
- Link stories to original proposal

### For Research Agents

- Use **research-report-template.md** for all formal research
- Include source credibility assessment
- Provide clear recommendations, not just findings
- Compare multiple options in analysis matrix

### For Tech Lead Agent

- Use **sprint-plan-template.md** at start of each sprint
- Update capacity based on actual availability
- Track iteration count (max 5 before escalation)
- Document all dependencies and risks

### For Security Agent

- Use **security-review-report-template.md** for every review
- Run Semgrep first, then manual review
- Block on ERROR severity findings (non-negotiable)
- Provide specific remediation guidance

### For Code Inspector Agent

- Use **code-review-report-template.md** for all reviews
- Reference **code-review-checklist-skill.md** as primary guide
- Focus on quality and functionality, not deep security
- Track iteration count

### For QA Lead Agent

- Use **test-plan-template.md** for sprint validation
- Include both manual and automated tests
- Document test coverage metrics
- Track defects with severity levels

### For UX/UI Agent

- Use **ux-review-report-template.md** for design/implementation reviews
- Evaluate against Nielsen's heuristics
- Check WCAG 2.1 AA compliance minimum
- Provide actionable improvement suggestions

### For Task Manager Agent

- Use **task-breakdown-template.md** for epic decomposition
- Create user stories with **user-story-template.md**
- Map all dependencies explicitly
- Estimate effort realistically

---

## Template Maintenance

### Versioning

Templates use semantic versioning:
- **Major version** (1.0 → 2.0): Structural changes
- **Minor version** (1.0 → 1.1): New sections added
- **Patch** (1.0.0 → 1.0.1): Clarifications, typos

### Feedback & Improvements

If a template is:
- Missing critical sections
- Too verbose for common use cases
- Unclear or confusing

Create an issue or discuss with Tech Lead for template improvements.

---

## Quick Reference

| Agent | Primary Template | Secondary Templates |
|-------|------------------|---------------------|
| Business Analyst | proposal-template.md | user-story-template.md |
| Research Agent | research-report-template.md | - |
| Research Manager | research-report-template.md | - |
| UX/UI Agent | ux-review-report-template.md | - |
| Task Manager | task-breakdown-template.md | user-story-template.md |
| Tech Lead | sprint-plan-template.md | - |
| Coding Agent | - | [Uses templates from other agents] |
| Code Inspector | code-review-report-template.md | - |
| Security Agent | security-review-report-template.md | - |
| QA Lead | test-plan-template.md | - |

---

## Examples

See `examples/` directory for filled-out template examples from real projects.

---

**Last Updated:** February 14, 2026  
**Template Count:** 9  
**Status:** All templates complete ✅
