# Sprint Planning Skill

## Overview

This skill provides guidance on effective sprint planning, including story selection, capacity planning, sprint goal setting, and dependency management

.

## When to Use This Skill

- Planning sprint iterations
- Selecting stories for development
- Estimating team capacity
- Setting sprint goals
- Managing dependencies

## Sprint Planning Principles

### 1. Clear Sprint Goal
Every sprint should have a clear, achievable goal that provides focus and direction.

**Example Sprint Goals:**
- ✅ "Implement user authentication and basic profile management"
- ✅ "Complete task management MVP with create, edit, delete"
- ❌ "Do some work on various features" (too vague)

### 2. Team Capacity First
Never commit to more than the team can deliver.

**Capacity Calculation:**
```
Team capacity = (Available hours per person) × (Team size) × (Focus factor)

Example:
- Sprint duration: 2 weeks
- Team size: 1 coding agent (can work in parallel)
- Work hours per week: 40 hours
- Focus factor: 0.7 (accounting for overheads)

Capacity = 40 × 2 × 1 × 0.7 = 56 hours
```

### 3. Story Independence
Select stories that can be completed independently within the sprint.

**Good Story Selection:**
- Stories can be developed in parallel (if multiple agents)
- Minimal dependencies between stories
- Each story delivers value independently

**Poor Story Selection:**
- Story B depends on Story A (creates bottleneck)
- Stories form a chain (no parallelization possible)
- Half-implemented features that don't provide value

### 4. Definition of Done
Clear criteria for when work is complete.

**Sprint DoD Example:**
- [ ] Code written and self-reviewed
- [ ] Code reviewed by Code Inspector
- [ ] Unit tests written and passing
- [ ] Integration tests passing
- [ ] Security review passed
- [ ] Documentation updated
- [ ] Acceptance criteria met

## Sprint Planning Process

### Phase 1: Preparation (Before Sprint Planning)

**Tech Lead Responsibilities:**

1. **Review Backlog**
   ```markdown
   - Review all user stories in backlog
   - Ensure stories have acceptance criteria
   - Verify stories are ready for development
   - Prioritize by business value
   ```

2. **Check Story Readiness**
   ```markdown
   For each story, verify:
   - [ ] Clear description
   - [ ] Acceptance criteria defined
   - [ ] Dependencies identified
   - [ ] Technical approach understood
   - [ ] No blockers
   - [ ] Estimated (if using story points)
   ```

3. **Identify Dependencies**
   ```markdown
   - External dependencies (APIs, third parties)
   - Internal dependencies (other stories)
   - Technical dependencies (infrastructure, configs)
   - Resource dependencies (access, credentials)
   ```

4. **Prepare Sprint Candidates**
   ```markdown
   Create list of stories that COULD be included:
   - Prioritized by business value
   - Marked with dependencies
   - Estimated effort
   - Risk level noted
   ```

### Phase 2: Sprint Planning Meeting

1. **Set Sprint Goal**
   ```markdown
   Based on business priorities and team capacity:
   
   Sprint Goal: "Implement secure user authentication system with 
   email/password login, session management, and password reset"
   
   Why this goal?
   - High business priority
   - Foundation for other features
   - Clear scope
   - Achievable in sprint
   ```

2. **Select Stories**
   ```markdown
   Criteria for selection:
   - Aligns with sprint goal
   - Within team capacity
   - All dependencies resolved
   - Stories definition-of-ready
   
   Selected Stories:
   - US-001: User can register with email/password (8h)
   - US-002: User can login with credentials (5h)
   - US-003: User can logout (2h)
   - US-004: User can reset forgotten password (8h)
   - US-005: Session expires after 30 minutes (3h)
   - US-006: Password requirements enforced (4h)
   
   Total: 30 hours (within 56h capacity, leaves buffer)
   ```

3. **Order Stories**
   ```markdown
   Development sequence:
   1. US-001 (Registration) - Foundation
   2. US-002 (Login) - Depends on US-001
   3. US-006 (Password requirements) - Supports US-001, US-004
   4. US-003 (Logout) - Simple, independent
   5. US-005 (Session timeout) - Depends on US-002
   6. US-004 (Password reset) - Depends on US-001, US-002
   
   This order:
   - Builds foundation first
   - Unblocks dependent stories early
   - Allows parallel development where possible
   ```

4. **Identify Risks**
   ```markdown
   Potential Risks:
   - US-004 (Password reset) requires SMTP configuration
     * Mitigation: Configure SMTP in sprint setup
     * Fallback: Use console email backend for testing
   
   - US-005 (Session timeout) may need load testing
     * Mitigation: Basic testing sufficient for MVP
     * Note: Performance testing in future sprint
   ```

### Phase 3: Sprint Kickoff

**Checklist:**

```markdown
## Sprint SPRINT-001 Kickoff

**Sprint Goal:** Implement secure user authentication system

**Duration:** Feb 14 - Feb 28, 2026 (2 weeks)

**Team Capacity:** 56 hours

**Stories Committed:** 6 stories, 30 hours estimated

### Prerequisites Complete
- [ ] Development environment ready
- [ ] Database migrations up to date
- [ ] SMTP configured (or console backend set)
- [ ] Test data fixtures available
- [ ] Access to required systems granted
- [ ] Documentation templates ready

### Tools & Resources
- [ ] GitHub repo accessible
- [ ] CI/CD pipeline configured
- [ ] Testing frameworks set up
- [ ] n8n instance running (if workflows needed)
- [ ] MCP servers configured

### Communication Plan
- [ ] Daily check-ins (async via docs)
- [ ] Mid-sprint review (after 1 week)
- [ ] Sprint demo scheduled (end of sprint)
- [ ] Retrospective scheduled (after demo)

### Ready to Start: ✅
```

## Story Estimation

### Estimation Techniques

**1. Time-Based Estimation**
```markdown
US-001: User Registration
- Design data model: 1h
- Implement API endpoint: 2h
- Write validation logic: 1h
- Create tests: 2h
- Integration: 1h
- Documentation: 1h
Total: 8 hours
```

**2. T-Shirt Sizing**
```markdown
- XS: < 2 hours (very simple)
- S: 2-4 hours (simple)
- M: 4-8 hours (moderate)
- L: 8-16 hours (complex)
- XL: 16+ hours (very complex - should be split!)

US-001: M (8h)
US-002: S (4h)
US-003: XS (2h)
```

**3. Story Points (Fibonacci)**
```markdown
1 point = ~2 hours
2 points = ~4 hours
3 points = ~6 hours
5 points = ~10 hours
8 points = ~16 hours (should split)

US-001: 5 points
US-002: 3 points
US-003: 1 point
```

### Estimation Guidelines

**Include in Estimate:**
- Design/planning time
- Implementation time
- Testing time (unit + integration)
- Code review iterations (1-2)
- Documentation time
- Buffer for unknowns (~20%)

**Don't Estimate Separately:**
- Code review time (part of story)
- Security review (part of DoD)
- QA testing (end of sprint, not per story)

## Dependency Management

### Types of Dependencies

**1. Sequential Dependencies**
```markdown
US-001 (User registration) → US-002 (User login)

Login requires registration to exist first.

Strategy:
- Complete US-001 first
- Then start US-002
- No parallelization possible
```

**2. Shared Resource Dependencies**
```markdown
US-010 (Task creation) ← User model → US-011 (Team creation)

Both need User model changes.

Strategy:
- Complete User model changes first
- Then both can proceed in parallel
```

**3. External Dependencies**
```markdown
US-020 (Email notifications) → External SMTP service

Depends on external system configuration.

Strategy:
- Configure early in sprint
- Have fallback (console emails for testing)
- Test with real SMTP before completion
```

**4. Technical Dependencies**
```markdown
US-030 (File uploads) → Azure Storage configuration

Depends on infrastructure setup.

Strategy:
- Setup infrastructure before sprint
- Or use local storage for development
- Switch to Azure in later sprint if needed
```

### Dependency Tracking

```markdown
## Sprint SPRINT-001 Dependencies

### Resolved Before Sprint
- ✅ Database schema v1.0 deployed
- ✅ Development environment configured
- ✅ SMTP credentials obtained

### Must Resolve in Sprint
- ⏳ US-001 must complete before US-002 (Day 1-2)
- ⏳ Azure Storage configuration for US-030 (Day 1)

### External Dependencies (Tracked)
- 🔴 API key for third-party service (waiting on vendor)
  - Blocks: US-040
  - ETA: Feb 20
  - Fallback: Mock service responses

### Unblocked for Parallel Development
- US-003, US-004, US-005 can start immediately
- US-006, US-007 after US-001 completes
```

## Sprint Capacity Planning

### Calculate Available Capacity

```markdown
## Sprint Capacity Calculation

**Team Composition:**
- 1 Coding Agent (can work on 1 story at a time)

**Sprint Duration:** 2 weeks (10 business days)

**Working Hours:**
- 8 hours/day × 10 days = 80 hours total

**Adjustments:**
- Sprint planning: -2h
- Daily syncs (10 × 15min): -2.5h
- Sprint review: -1h
- Sprint retrospective: -1h
- Buffer for unknowns (20%): -14.7h

**Available Capacity:** ~59 hours

**Commitment:** Target 80% of capacity = ~47 hours
(Leaves buffer for issues, blockers, learning)
```

### Velocity Tracking

```markdown
## Historical Velocity

**Sprint 001:** 30h committed, 28h completed (93% completion)
**Sprint 002:** 35h committed, 35h completed (100% completion)
**Sprint 003:** 40h committed, 32h completed (80% completion)

**Average Velocity:** ~32 hours per sprint

**Next Sprint Commitment:** 35 hours
(Slightly above average, accounting for learning curve improvement)
```

## Sprint Goal Examples

### Good Sprint Goals

```markdown
✅ "Implement MVP task management with create, edit, delete, and list views"
- Specific functionality
- Clear scope
- Deliverable value
- Achievable in sprint

✅ "Enable team collaboration with file sharing and commenting"
- Focused theme
- Related features
- Business value clear
- Technical scope reasonable

✅ "Improve system performance: reduce API response times to <200ms"
- Measurable goal
- Clear success criteria
- Focused effort
- Achievable scope
```

### Poor Sprint Goals

```markdown
❌ "Work on various improvements"
- Too vague
- No clear direction
- Can't measure success

❌ "Complete entire user management system"
- Too broad
- Likely not achievable in one sprint
- Should be broken down

❌ "Fix all bugs and add new features"
- Unfocused
- Too many competing priorities
- Recipe for incomplete work
```

## Sprint Board Structure

```markdown
## Sprint Board: SPRINT-001

### 📋 To Do
- US-001: User Registration
- US-002: User Login
- US-003: User Logout

### 🔄 In Progress
- US-004: Password Reset (Coding Agent working)

### 👀 Code Review
- US-005: Session Timeout (awaiting inspector)

### ✅ Done
- US-006: Password Requirements (approved, merged)

### 🚫 Blocked
- US-007: OAuth Login (waiting for OAuth credentials)
```

## Mid-Sprint Adjustments

### When to Adjust

**Add Work:**
- Sprint progressing faster than expected
- Critical bug discovered
- All committed stories completed early

**Remove Work:**
- Stories taking longer than estimated
- Unexpected blocker encountered
- Team capacity reduced (agent issues, etc.)

### Adjustment Process

```markdown
## Mid-Sprint Adjustment (Day 5 of 10)

**Current Status:**
- US-001, US-002, US-003: ✅ Complete (15h)
- US-004: 🔄 In Progress, 60% done (6h/8h spent)
- US-005, US-006: 📋 Not Started (7h planned)

**Issue:** US-004 taking longer (complex email template logic)

**Options:**
1. Continue as planned, may not finish US-005 and US-006
2. Descope US-004 (basic email, enhance later)
3. Remove US-005 or US-006 from sprint

**Decision:** Descope US-004 to basic text email
- Keeps sprint goal intact
- Allows US-005 and US-006 to proceed
- Document enhancement for next sprint

**Updated Sprint Scope:**
- US-004: Simplified to text email → 6h total (was 8h)
- US-005, US-006: Proceed as planned
- New estimated total: 28h (within capacity)
```

## Sprint Review Preparation

```markdown
## Sprint Review Checklist

**Preparation (1 day before):**
- [ ] Demo environment ready
- [ ] Test data loaded
- [ ] All completed stories deployed to demo
- [ ] Demo script written
- [ ] Known issues documented
- [ ] Stakeholder invites sent

**Demo Content:**
- Sprint goal recap
- Stories completed vs. committed
- Live demonstration of features
- Metrics (velocity, test coverage, etc.)
- What didn't get done and why
- Next sprint preview

**Demo Script:**
```markdown
1. Introduction (2min)
   - Sprint goal
   - Stories committed

2. Feature Demo (15min)
   - Show US-001: Registration flow
   - Show US-002: Login flow
   - Show US-004: Password reset flow
   - Demonstrate security features

3. Technical Highlights (5min)
   - Test coverage: 87%
   - Security review: Passed
   - Performance: All endpoints <200ms

4. Sprint Metrics (3min)
   - 6 stories committed, 5 completed
   - 1 story (US-007) moved to next sprint
   - No critical bugs

5. Next Sprint (5min)
   - US-007: OAuth login
   - US-008-010: User profile management
   - Goal: Complete core user management
```

## Sprint Retrospective

```markdown
## Sprint Retrospective Template

### What Went Well ⭐
- Clear sprint goal helped focus
- Good test coverage maintained
- No major blockers
- Code reviews efficient

### What Could Be Improved 🔧
- Estimation off on US-004 (underestimated complexity)
- SMTP configuration delayed start of testing
- Could use better story description template

### Action Items 📋
- [ ] Create story template with required sections
- [ ] Configure SMTP early in next sprint
- [ ] Add 20% buffer to estimates for unfamiliar work
- [ ] Document email template approach for future reference

### Shoutouts 🎉
- Great security review process
- Efficient code inspector feedback
```

## Common Sprint Planning Mistakes

### ❌ Overcommitment
```markdown
Problem: Committing 70h of work with 50h capacity

Result: Incomplete work, technical debt, stress

Solution: Commit to 80% of capacity, leave buffer
```

### ❌ Vague Sprint Goal
```markdown
Problem: "Make progress on the project"

Result: Unfocused work, unclear success criteria

Solution: "Complete user authentication MVP with email login and password reset"
```

### ❌ Ignoring Dependencies
```markdown
Problem: Selecting stories that depend on incomplete infrastructure

Result: Blocked work, wasted effort

Solution: Verify all dependencies resolved before sprint starts
```

### ❌ No Buffer Time
```markdown
Problem: Planning every hour of the sprint

Result: No time for unexpected issues, code review iterations, bugfixes

Solution: Leave 20% buffer for unknowns
```

## Templates

### Sprint Plan Template

```markdown
# Sprint Plan: SPRINT-XXX

**Sprint Goal:** [Clear, focused goal]

**Duration:** [Start Date] - [End Date]

**Team Capacity:** [X hours]

## Stories Committed

| ID | Title | Estimate | Priority | Dependencies |
|----|-------|----------|----------|--------------|
| US-001 | [Title] | 8h | High | None |
| US-002 | [Title] | 5h | High | US-001 |

**Total Estimate:** [Xh]

## Sprint Backlog Order

1. US-001 (Foundation)
2. US-002 (Depends on US-001)
3. US-003 (Independent)

## Risks & Mitigations

**Risk 1:** [Description]
- Impact: [High/Medium/Low]
- Probability: [High/Medium/Low]
- Mitigation: [Strategy]

## Definition of Done

- [ ] Code written and reviewed
- [ ] Tests passing (>80% coverage)
- [ ] Security review passed
- [ ] Documentation updated
- [ ] Acceptance criteria met
```

## Skill Metadata

**Skill Name:** Sprint Planning
**Version:** 1.0
**Last Updated:** February 14, 2026
**Applicable To:** Tech Lead, Project Manager
**Dependencies:** story-readiness-verification-skill.md
**Related Skills:** backlog-planning-estimation-skill.md
