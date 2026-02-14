# Code Review Report Template

**Review ID:** CR-XXX  
**Created by:** Code Inspector Agent  
**Date:** [Date]  
**Story/Sprint:** [Story ID or Sprint ID]  
**Review Iteration:** [#] of 5 maximum

---

## Review Summary

**Verdict:** ✅ PASS / ❌ FAIL / ⚠️ NEEDS REVISION

**Overall Code Quality:** Excellent / Good / Acceptable / Needs Improvement

[2-3 sentence summary of the code quality and review outcome]

### Key Metrics

- **Files Reviewed:** [Count]
- **Lines of Code:** [Count]
- **Issues Found:** [Count]
  - CRITICAL: [#] (must fix)
  - HIGH: [#] (should fix)
  - MEDIUM: [#] (nice to fix)
  - LOW: [#] (suggestions)
- **Test Coverage:** [%]

**Recommendation:** [APPROVE / REQUEST CHANGES / REJECT]

---

## Review Scope

**Story Details:**
- **Story ID:** [US-XXX]
- **Story Title:** [Title]
- **Implementation Type:** [Backend / Frontend / Full Stack / Workflow / Infrastructure]

**Files Reviewed:**
```
src/
  ├── models/
  │   ├── user.py [+150, -0]
  │   └── team.py [+120, -0]
  ├── views/
  │   ├── auth.py [+200, -5]
  │   └── team_api.py [+180, -0]
  ├── tests/
  │   ├── test_user.py [+100, -0]
  │   └── test_team.py [+90, -0]
  └── migrations/
      └── 0001_initial.py [+50, -0]

Total: [X] files, [Y] lines added, [Z] lines removed
```

**Review Focus Areas:**
- [✅] Functionality
- [✅] Code Quality
- [✅] Testing
- [✅] Documentation
- [✅] Performance
- [✅] Security (basic awareness)
- [✅] Error Handling

**Skills Referenced:**
- `skills/code-review-checklist-skill.md` (PRIMARY)
- `skills/secure-coding-skill.md` (basic awareness)

---

## Functional Review

### Acceptance Criteria Validation

**Story Acceptance Criteria:**

#### Criterion #1: [Description]

**Status:** ✅ MET / ❌ NOT MET / ⚠️ PARTIALLY MET

**Evidence:**
- [Location in code where this is implemented]
- [Test that validates this]

**Notes:**
[Any concerns or observations]

---

#### Criterion #2: [Description]

[Repeat for all acceptance criteria]

---

### Functional Summary

**Functional Correctness:** ✅ PASS / ❌ FAIL

**Does the code do what it's supposed to do?** YES / NO / PARTIALLY

**Findings:**
- [List any functional issues]

---

## Code Quality Review

### 1. Code Structure & Organization

**Rating:** ⭐⭐⭐⭐⭐ (1-5 stars)

**✅ Strengths:**
- [Good practice 1]
- [Good practice 2]

**⚠️ Issues Found:**

#### CQ-1: [Issue Title]

**Severity:** CRITICAL / HIGH / MEDIUM / LOW  
**Location:** [file:line]

**Issue:**
```python
# Current code
[problematic code snippet]
```

**Problem:**
[Explanation of what's wrong]

**Recommendation:**
```python
# Suggested improvement
[better code snippet]
```

**Impact:** [Maintainability / Readability / Performance / etc.]

---

### 2. Code Readability

**Rating:** ⭐⭐⭐⭐☆

**Checks:**
- [✅/❌] Clear and descriptive naming
- [✅/❌] Appropriate comments where needed
- [✅/❌] Consistent code style
- [✅/❌] Logical function/class organization
- [✅/❌] Reasonable function length (<50 lines)
- [✅/❌] Reasonable complexity (cyclomatic < 10)

**Issues:**
[List readability issues]

---

### 3. Code Maintainability

**Rating:** ⭐⭐⭐⭐⭐

**Checks:**
- [✅/❌] DRY principle followed (no duplication)
- [✅/❌] SOLID principles applied
- [✅/❌] Clear separation of concerns
- [✅/❌] Modular and reusable code
- [✅/❌] Easy to extend without modification

**Issues:**
[List maintainability concerns]

---

### 4. Code Style & Conventions

**Rating:** ⭐⭐⭐⭐⭐

**Language:** [Python / JavaScript / etc.]  
**Style Guide:** [PEP 8 / Airbnb / etc.]

**Checks:**
- [✅/❌] Consistent indentation
- [✅/❌] Proper naming conventions
- [✅/❌] Import organization
- [✅/❌] Line length (<120 chars)
- [✅/❌] Docstrings/JSDoc comments

**Linter Results:**
```
Linter: [flake8 / eslint / etc.]
Errors: [0]
Warnings: [2]
```

**Issues:**
[List style violations]

---

## Testing Review

### Test Coverage

**Overall Coverage:** [%]

**Coverage by Module:**

| Module | Coverage | Status |
|--------|----------|--------|
| models/user.py | [%] | ✅/⚠️/❌ |
| models/team.py | [%] | ✅/⚠️/❌ |
| views/auth.py | [%] | ✅/⚠️/❌ |
| views/team_api.py | [%] | ✅/⚠️/❌ |

**Target:** 80% minimum  
**Critical paths:** 100% required

---

### Test Quality

**Rating:** ⭐⭐⭐⭐☆

**Checks:**
- [✅/❌] Unit tests exist and pass
- [✅/❌] Integration tests cover happy paths
- [✅/❌] Edge cases tested
- [✅/❌] Error conditions tested
- [✅/❌] Tests are clear and maintainable
- [✅/❌] Tests follow AAA pattern (Arrange-Act-Assert)
- [✅/❌] Mock/stub usage appropriate

**Test Summary:**
- **Total Tests:** [Count]
- **Passing:** [Count]
- **Failing:** [Count]
- **Skipped:** [Count]

---

### Test Findings

#### Test Issue #1: [Title]

**Severity:** HIGH / MEDIUM / LOW  
**Category:** [Missing coverage / Poor test / Brittle test]

**Description:**
[What's wrong with the tests]

**Location:**
[Test file and function]

**Recommendation:**
[How to improve]

---

## Security Review (Basic Awareness)

**Note:** Detailed security review performed by Security Agent. This is basic awareness only.

### Basic Security Checks

**Status:** ✅ NO OBVIOUS ISSUES / ⚠️ POTENTIAL CONCERNS / ❌ ISSUES FOUND

**Checks:**
- [✅/❌] No obvious SQL injection risks
- [✅/❌] No obvious XSS vulnerabilities
- [✅/❌] Input validation appears present
- [✅/❌] No hardcoded secrets visible
- [✅/❌] Error messages don't leak sensitive info
- [✅/❌] Authentication/authorization checks present

**Findings:**
[List any basic security concerns to flag for Security Agent]

**⚠️ Flagged for Security Agent Review:**
- [Item 1]
- [Item 2]

---

## Performance Review

### Performance Considerations

**Rating:** ⭐⭐⭐⭐⭐

**Checks:**
- [✅/❌] Database queries optimized (no N+1)
- [✅/❌] Appropriate indexes used
- [✅/❌] Caching used where beneficial
- [✅/❌] No obvious memory leaks
- [✅/❌] Async operations used appropriately
- [✅/❌] Large data sets handled efficiently

**Issues:**

#### Performance Issue #1: [Title]

**Severity:** HIGH / MEDIUM / LOW  
**Location:** [file:line]

**Issue:**
[Description of performance concern]

**Impact:**
[Expected performance impact]

**Recommendation:**
[How to optimize]

---

## Error Handling Review

### Error Handling Quality

**Rating:** ⭐⭐⭐⭐☆

**Checks:**
- [✅/❌] Exceptions properly caught
- [✅/❌] Meaningful error messages
- [✅/❌] Proper error logging
- [✅/❌] Graceful degradation
- [✅/❌] User-friendly error responses
- [✅/❌] No silent failures

**Issues:**
[List error handling concerns]

---

## Documentation Review

### Code Documentation

**Rating:** ⭐⭐⭐⭐⭐

**Checks:**
- [✅/❌] Functions/classes have docstrings
- [✅/❌] Complex logic is commented
- [✅/❌] API endpoints documented
- [✅/❌] README updated (if needed)
- [✅/❌] Changelog updated
- [✅/❌] Configuration examples provided

**Issues:**
[List documentation gaps]

---

## Django/Framework-Specific Review

### Django Best Practices

**Checks:**
- [✅/❌] Models use appropriate field types
- [✅/❌] Model constraints properly defined
- [✅/❌] Migrations properly structured
- [✅/❌] QuerySet optimization used
- [✅/❌] Django ORM patterns followed
- [✅/❌] Serializers properly structured (if DRF)
- [✅/❌] URL patterns RESTful

**Issues:**
[List Django-specific concerns]

**Django MCP Consulted:** [YES/NO]  
**Queries:** [List any Django MCP queries made]

---

## Critical Issues Summary

### Issues That MUST Be Fixed

#### Issue #1: [Title]

**Severity:** CRITICAL  
**Category:** [Functionality / Quality / Security / Testing]  
**Location:** [file:line]

**Description:**
[Clear explanation]

**Why it's critical:**
[Impact if not fixed]

**How to fix:**
[Step-by-step remediation]

**Blocking:** YES / NO

---

## High Priority Issues

### Issues That SHOULD Be Fixed

[List high priority issues with less detail than critical]

---

## Medium/Low Priority Issues

### Improvements We Suggest

[List suggestions for improvement]

---

## Positive Observations

**✅ Things Done Well:**

1. **[Good practice 1]**
   - Location: [where]
   - Why it's good: [explanation]

2. **[Good practice 2]**
   - Location: [where]
   - Why it's good: [explanation]

---

## Code Review Checklist

### Functionality ✅

- [✅] All acceptance criteria met
- [✅] Edge cases handled
- [✅] Error conditions handled
- [✅] Business logic correct

### Code Quality ✅

- [✅] Code is readable and maintainable
- [✅] DRY principle followed
- [✅] Proper abstraction levels
- [✅] Consistent style

### Testing ✅

- [✅] Tests exist and pass
- [✅] Coverage > 80%
- [✅] Edge cases tested
- [✅] Integration tests present

### Documentation ✅

- [✅] Code commented appropriately
- [✅] API documentation updated
- [✅] README updated if needed

### Performance ✅

- [✅] No obvious performance issues
- [✅] Database queries optimized
- [✅] Caching used where appropriate

### Security (Basic) ✅

- [✅] No obvious security issues
- [✅] Input validation present
- [✅] No hardcoded secrets

---

## Recommendations

### Must Do (Before Approval)

1. **[Action 1]** - CRITICAL
   - File: [location]
   - Fix: [what to change]

2. **[Action 2]** - CRITICAL
   - File: [location]
   - Fix: [what to change]

### Should Do (High Priority)

1. **[Improvement 1]**
   - Recommended change

2. **[Improvement 2]**
   - Recommended change

### Nice to Have

1. **[Enhancement 1]**
   - Optional improvement

---

## Verdict & Next Steps

### Final Verdict

**⚠️ VERDICT: [PASS / FAIL / NEEDS REVISION]**

### Justification

**✅ PASS:**
- Code quality is high
- All acceptance criteria met
- Test coverage adequate (>80%)
- No critical or high issues
- Ready for Security Agent review

**❌ FAIL:**
- [Count] critical issues must be fixed
- Functional requirements not met
- Code quality below acceptable standards
- Must be reworked and resubmitted

**⚠️ NEEDS REVISION:**
- [Count] issues need to be addressed
- Code can be fixed with minor changes
- Resubmit after addressing listed issues

---

### Next Steps

**If PASS:**
- ✅ Forward to Security Agent for security review
- ✅ Update iteration count: [#] of 5
- ✅ Story proceeds in workflow

**If FAIL or NEEDS REVISION:**
- ❌ Return to Coding Agent with detailed feedback
- ❌ Increment iteration count: [#] of 5
- ❌ If iteration > 5: Escalate to Tech Lead for user decision

**Recommended Timeline:**
- Fix turnaround: [X hours/days]
- Re-review timing: [When]

---

## Iteration Tracking

**Current Iteration:** [#] of 5 maximum

**Review History:**

| Iteration | Date | Outcome | Key Issues | Time to Fix |
|-----------|------|---------|------------|-------------|
| 1 | [Date] | NEEDS REVISION | [Brief list] | [Duration] |
| 2 | [Date] | PASS | - | - |

**If approaching limit (> 3 iterations):**
- ⚠️ Consider if systemic issues require architectural discussion
- ⚠️ May need Tech Lead involvement
- ⚠️ Prepare for potential user escalation

---

## Skills & Tools Used

**Skills Referenced:**
- ✅ `skills/code-review-checklist-skill.md` (PRIMARY)
- ✅ `skills/secure-coding-skill.md` (security awareness)
- ✅ `skills/code-quality/SKILL.md`

**MCP Tools Used:**
- [✅/❌] Django MCP (for framework patterns)
- [✅/❌] n8n MCP (for workflow reviews)

---

## Review Metadata

**Inspector:** Code Inspector Agent  
**Review Duration:** [X minutes]  
**Review Date:** [Date]  
**Story Status After Review:** [In Progress / Ready for Security / Needs Revision]

---

## Sign-off

**Reviewed by:** Code Inspector Agent  
**Status:** [APPROVED / REJECTED / REVISION REQUESTED]  
**Date:** [Date]  
**Next Review:** [If needed]
