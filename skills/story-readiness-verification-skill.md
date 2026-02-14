# Story Readiness Verification Skill

## Overview

This skill provides criteria and checklists for verifying that user stories are ready for development. Use it to ensure stories have all necessary information before committing to a sprint.

## When to Use This Skill

- Before sprint planning
- During backlog refinement
- When evaluating story completeness
- Before assigning work to developers
- During story creation/review

## Definition of Ready (DoR)

A user story is "ready" when it contains all information needed for development to begin without blockers.

## Story Readiness Checklist

### Essential Elements ALL STORIES

- [ ] **User Story Format**
  - Written in "As a... I want... So that..." format
  - OR clear description of what needs to be built
  - User role identified
  - Desired capability stated
  - Business value explained

- [ ] **Acceptance Criteria**
  - Clear, testable criteria
  - Describes "done" behavior
  - Covers happy path
  - Covers key error cases
  - Specific and measurable

- [ ] **Story Size**
  - Completable within one sprint
  - Estimated effort reasonable (< 16 hours)
  - If too large, broken into smaller stories
  - If too small, potentially combined

- [ ] **Dependencies Identified**
  - Technical dependencies listed
  - External dependencies noted
  - Blocking stories identified
  - Dependency resolution plan exists

- [ ] **Priority Assigned**
  - Business value understood
  - Priority level set (High/Medium/Low)
  - Prioritization rationale documented

- [ ] **No Obvious Blockers**
  - Required access/credentials available
  - External systems accessible
  - Technical approach understood
  - Design decisions made

### Backend/API Stories

- [ ] **API Endpoints Defined**
  - HTTP method specified (GET, POST, PUT, DELETE)
  - URL pattern defined
  - Request payload format described
  - Response format described
  - Status codes specified

- [ ] **Data Model Understood**
  - Database tables/collections identified
  - Required fields specified
  - Relationships defined
  - Constraints noted

- [ ] **Authentication/Authorization**
  - Auth requirements specified
  - User roles/permissions defined
  - Authorization rules clear

- [ ] **Error Handling**
  - Expected error scenarios listed
  - Error response formats defined
  - Validation rules specified

### Frontend/UI Stories

- [ ] **UI Design Available**
  - Wireframes or mockups provided
  - Or detailed description of UI
  - User interaction flow clear
  - Responsive behavior defined

- [ ] **User Flows Documented**
  - Step-by-step user journey
  - Navigation paths clear
  - Form fields specified
  - Validation rules defined

- [ ] **UI States Defined**
  - Loading states
  - Empty states
  - Error states
  - Success states

- [ ] **Accessibility Requirements**
  - WCAG compliance level
  - Keyboard navigation
  - Screen reader support
  - Color contrast requirements

### Integration Stories

- [ ] **External Systems Identified**
  - Third-party APIs specified
  - Integration points defined
  - Authentication method known
  - Rate limits understood

- [ ] **API Documentation Available**
  - API docs URL provided
  - API keys/credentials available (or process to obtain)
  - Example requests/responses
  - Error handling documented

- [ ] **Integration Testing Plan**
  - Test environment access
  - Test data available
  - Sandbox/staging endpoints known

### Database Stories

- [ ] **Schema Changes Specified**
  - Tables to create/modify
  - Columns to add/change/remove
  - Indexes needed
  - Constraints required

- [ ] **Migration Strategy**
  - Backward compatibility plan
  - Data migration needs identified
  - Rollback strategy defined

- [ ] **Performance Considerations**
  - Expected data volume
  - Query performance requirements
  - Indexing strategy

## Story Quality Assessment

### Story Title

**Good Titles:**
- ✅ "User can reset forgotten password via email"
- ✅ "Admin can export user list to CSV"
- ✅ "System sends reminder email 24h before task due"

**Poor Titles:**
- ❌ "Password stuff"
- ❌ "Export feature"
- ❌ "Emails"

### User Story Format

**Good User Story:**
```markdown
## US-001: Password Reset

**As a** registered user
**I want to** reset my password if I forget it
**So that** I can regain access to my account without contacting support

### Acceptance Criteria
- [ ] User can request password reset from login page
- [ ] Reset email sent to registered email address
- [ ] Reset link expires after 24 hours
- [ ] User can set new password via reset link
- [ ] Old password no longer works after reset
- [ ] User receives confirmation email after successful reset

### Technical Notes
- Use Django password reset tokens
- Email template: templates/email/password_reset.html
- Token stored in database with expiration
- Minimum password requirements enforced (8 chars, 1 number, 1 symbol)

### Dependencies
- SMTP configuration required
- Email templates created

### Definition of Done
- [ ] API endpoints implemented
- [ ] Email templates created
- [ ] Tests written and passing
- [ ] Security review passed
- [ ] Documentation updated
```

**Poor User Story:**
```markdown
## Story: Password

Users need to be able to reset passwords.

Make it work like other sites.
```

**Problems:**
- No acceptance criteria
- No technical details
- Vague requirements
- No definition of done

### Acceptance Criteria Quality

**Good Acceptance Criteria:**
```markdown
### AC1: User Registration
- [ ] User can submit registration form with email and password
- [ ] Email must be valid format (contains @ and domain)
- [ ] Password must be at least 8 characters with 1 number
- [ ] System validates email is not already registered
- [ ] Success: User account created, confirmation email sent
- [ ] Error: Clear message shown for validation failures

### AC2: Email Confirmation
- [ ] Confirmation email sent immediately after registration
- [ ] Email contains confirmation link valid for 24 hours
- [ ] Clicking link activates account
- [ ] Expired links show friendly error message
- [ ] User can request new confirmation email
```

**Poor Acceptance Criteria:**
```markdown
- Should work properly
- Email validation
- Passwords secure
- Error handling
```

**Problems:**
- Not specific/testable
- No clear pass/fail criteria
- Missing edge cases
- Too vague

## Verification Process

### Step 1: Initial Review

```markdown
## Story Readiness Review: US-XXX

**Reviewer:** [Tech Lead]
**Date:** [Date]

### Quick Check
- [ ] Has user story format OR clear description
- [ ] Has acceptance criteria
- [ ] Size seems reasonable
- [ ] No obvious blockers mentioned

**Initial Assessment:** READY / NEEDS WORK / NOT READY
```

### Step 2: Detailed Review

```markdown
### Detailed Verification

**Story Format:** ✅ PASS
- Clear user role (registered user)
- Desired capability stated
- Business value explained

**Acceptance Criteria:** ✅ PASS
- 6 criteria, all testable
- Covers happy path and errors
- Specific and measurable

**Technical Clarity:** ⚠️ NEEDS CLARIFICATION
- Question: Which SMTP provider?
- Question: Password complexity rules?
- Question: Rate limiting on reset requests?

**Dependencies:** ✅ CLEAR
- SMTP configuration (to be done in sprint setup)
- Email templates (part of this story)

**Size Estimate:** 8 hours
- API implementation: 3h
- Email templates: 2h
- Testing: 2h
- Documentation: 1h

**Recommendation:** READY AFTER CLARIFICATIONS
```

### Step 3: Clarification

```markdown
## Story Clarifications Needed

**To:** Story Author / Product Owner
**Story:** US-001 Password Reset

**Questions:**

1. **SMTP Provider:**
   - Which email service? (SendGrid, AWS SES, Mailgun?)
   - Are credentials already available?
   - **Decision Needed Before Sprint**

2. **Password Complexity:**
   - Confirm requirements: 8+ chars, 1 number, 1 symbol?
   - Any other rules (uppercase, special chars)?
   - **Decision: Use standard rules (as stated)**

3. **Rate Limiting:**
   - How many reset requests per hour/day?
   - What happens if limit exceeded?
   - **Decision: 3 requests per hour per email**

**Updated Story:** [After clarifications, story is READY]
```

### Step 4: Final Approval

```markdown
## Story Approved for Sprint

**Story:** US-001 Password Reset
**Status:** ✅ READY

All criteria met:
- Clear requirements
- Testable acceptance criteria
- Dependencies resolved
- Technical approach understood
- Estimated and sized appropriately

**Ready for Sprint Planning:** YES
```

## Common Readiness Issues

### Issue 1: Missing Acceptance Criteria

**Problem:**
```markdown
## Story: User Login

Users should be able to log in.
```

**Solution:**
```markdown
## Story: User Login

As a registered user
I want to log in with my credentials
So that I can access my account

### Acceptance Criteria
- [ ] User can enter email and password
- [ ] Valid credentials redirect to dashboard
- [ ] Invalid credentials show error message
- [ ] Account locked after 5 failed attempts
- [ ] "Remember me" option keeps user logged in
- [ ] Forgot password link available
```

### Issue 2: Too Large/Vague

**Problem:**
```markdown
## Story: Build Complete User Management System

Implement all user management features including registration, login,
profile editing, password management, account deletion, user search,
admin panel, etc.
```

**Solution: Break into smaller stories:**
```markdown
## Epic: User Management System

### Sprint 1:
- US-001: User Registration
- US-002: User Login
- US-003: User Logout
- US-004: Password Reset

### Sprint 2:
- US-005: User Profile View
- US-006: User Profile Edit
- US-007: Change Password
- US-008: Delete Account

### Sprint 3:
- US-009: Admin User List
- US-010: Admin User Search
- US-011: Admin User Suspend/Reactivate
```

### Issue 3: Unclear Technical Approach

**Problem:**
```markdown
## Story: Real-time Notifications

Users should get real-time notifications.

[No technical details provided]
```

**Solution:**
```markdown
## Story: Real-time Task Notifications

As a team member
I want to receive real-time notifications when tasks are assigned to me
So that I can respond quickly

### Technical Approach
- Use Supabase Realtime for WebSocket connection
- Subscribe to task_assignments channel
- Client listens for insert events where assigned_user_id matches
- Notification appears as toast in UI
- Badge count updates in header

### Acceptance Criteria
- [ ] User receives notification within 2 seconds of task assignment
- [ ] Notification shows task title and assigner name
- [ ] Clicking notification navigates to task detail
- [ ] Badge count shows unread notifications
- [ ] Works across multiple browser tabs

### Dependencies
- Supabase Realtime configured
- WebSocket connection established on login
```

### Issue 4: Unresolved Dependencies

**Problem:**
```markdown
## Story: OAuth Google Login

Implement Google OAuth login.

[No mention that OAuth credentials need to be obtained]
```

**Solution:**
```markdown
## Story: OAuth Google Login

As a user
I want to log in with my Google account
So that I don't need to create another password

### Acceptance Criteria
- [ ] "Sign in with Google" button on login page
- [ ] Clicking button redirects to Google OAuth consent
- [ ] After approval, user redirected back to app
- [ ] User account created or updated with Google profile data
- [ ] User logged in automatically

### Dependencies
⚠️ **BLOCKER - Must resolve before sprint:**
- [ ] Google Cloud project created
- [ ] OAuth credentials obtained (Client ID, Client Secret)
- [ ] Redirect URIs configured in Google Console
- [ ] Credentials added to environment variables

**Estimated time to resolve:** 1-2 days
**Responsible:** DevOps / Tech Lead

### Technical Approach
- Use supabase.auth.signInWithOAuth({provider: 'google'})
- Store Google ID in user profile
- Link Google account to existing email if match found
```

## Story Refinement Meeting

### Agenda

```markdown
## Backlog Refinement Session

**Duration:** 1 hour
**Participants:** Tech Lead, Product Owner, (optionally) Coding Agent

**Agenda:**
1. Review upcoming stories (15min)
2. Clarify ambiguous stories (20min)
3. Identify dependencies (10min)
4. Estimate story efforts (10min)
5. Mark stories ready/not ready (5min)

**Stories to Review:**
- US-015: Team member invitation
- US-016: Task templates
- US-017: File attachments
- US-018: Task comments
```

### Refinement Checklist

```markdown
For each story reviewed:

- [ ] Read story aloud
- [ ] Discuss any unclear points
- [ ] Add missing acceptance criteria
- [ ] Identify technical dependencies
- [ ] Estimate effort (hours or points)
- [ ] Mark as READY or LIST BLOCKERS

Example Output:

**US-015:** READY ✅
- Estimate: 5 hours
- No blockers
- Send sprint

**US-016:** NOT READY ❌
- Missing: UI wireframes
- Unclear: What fields in template?
- Action: Product brings wireframes next week

**US-017:** BLOCKED 🚫
- Dependency: Azure Storage not configured
- Action: DevOps to configure before sprint begins
```

## Templates

### Story Review Template

```markdown
## Story Readiness Review

**Story ID:** US-XXX
**Title:** [Story Title]
**Reviewer:** [Name]
**Date:** [Date]

### Readiness Checklist

**Story Format:**
- [ ] Clear user role
- [ ] Desired capability
- [ ] Business value

**Acceptance Criteria:**
- [ ] Present and clear
- [ ] Testable
- [ ] Cover main scenarios
- [ ] Cover error cases

**Technical Clarity:**
- [ ] Approach understood
- [ ] No ambiguity
- [ ] Feasible solution known

**Dependencies:**
- [ ] Dependencies identified
- [ ] Dependencies resolvable
- [ ] No blockers

**Size:**
- [ ] Completable in sprint
- [ ] Estimate provided
- [ ] Not too large (< 16h)

### Questions/Clarifications Needed

1. [Question]
2. [Question]

### Recommendation

- [ ] READY - Can proceed to sprint
- [ ] READY AFTER CLARIFICATIONS - Minor questions to resolve
- [ ] NOT READY - Significant work needed
- [ ] BLOCKED - External dependency must be resolved

### Notes

[Additional context or recommendations]
```

### Quick Readiness Scorecard

```markdown
## Story Readiness Scorecard

Rate each dimension 1-5:

**Clarity (User Story):** [1-5]
- 5: Crystal clear
- 3: Mostly clear, minor questions
- 1: Very vague

**Acceptance Criteria:** [1-5]
- 5: Complete, testable, specific
- 3: Present but could be better
- 1: Missing or very vague

**Technical Feasibility:** [1-5]
- 5: Approach clear, no unknowns
- 3: Mostly clear, some questions
- 1: Many unknowns

**Dependencies:** [1-5]
- 5: No dependencies or all resolved
- 3: Dependencies identified, plan exists
- 1: Unidentified or unresolved blockers

**Overall Score:** [Total / 20]

**Interpretation:**
- 18-20: READY
- 14-17: READY AFTER MINOR WORK
- 10-13: NOT READY YET
- < 10: SIGNIFICANT WORK NEEDED
```

## Red Flags (Story NOT Ready)

- ❌ "Make it like that other app" (no specifics)
- ❌ "Users want better performance" (not measurable)
- ❌ "Fix all the bugs" (not a story, too vague)
- ❌ "Improve the system" (no clear scope)
- ❌ No acceptance criteria
- ❌ Multiple "TBDs" in critical fields
- ❌ Estimate is "we'll figure it out"
- ❌ Known blocker not addressed

## Benefits of Ready Stories

### For Development Team
- Can start work immediately
- No mid-sprint clarifications needed
- Clear definition of done
- Accurate estimates possible

### For Project
- Predictable velocity
- Reduced waste
- Better sprint planning
- Higher quality output

### For Stakeholders
- Clear expectations
- Better visibility
- Fewer surprises
- Faster delivery

## Skill Metadata

**Skill Name:** Story Readiness Verification
**Version:** 1.0
**Last Updated:** February 14, 2026
**Applicable To:** Tech Lead, Business Analyst, Product Owner
**Dependencies:** None
**Related Skills:** sprint-planning-skill.md, backlog-planning-estimation-skill.md
