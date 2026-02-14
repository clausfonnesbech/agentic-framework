# Test Plan Template

**Test Plan ID:** TP-XXX  
**Created by:** QA Lead Agent  
**Date:** [Date]  
**Project:** [Project Name]  
**Sprint:** [Sprint ID]  
**Test Phase:** [Unit / Integration / System / UAT / Regression]

---

## Executive Summary

**Test Objective:** [What is being tested and why]

**Scope:** [Brief description of what's in/out of scope]

**Test Approach:** [Manual / Automated / Mixed]

**Timeline:** [Start Date] - [End Date]

---

## Test Scope

### In Scope

**Features to Test:**
1. **[Feature 1]** - [User Stories: US-XXX, US-XXX]
   - [Sub-feature A]
   - [Sub-feature B]

2. **[Feature 2]** - [User Stories: US-XXX]
   - [Sub-feature A]

**Test Types:**
- [✅] Functional Testing
- [✅] Integration Testing
- [✅] UI/UX Testing
- [✅] Security Testing (basic validation)
- [✅] Performance Testing (if applicable)
- [✅] Compatibility Testing
- [✅] Accessibility Testing

### Out of Scope

- [Item 1 not being tested]
- [Item 2 not being tested]
- [Rationale for exclusions]

---

## Test Objectives

### Primary Objectives

1. **Validate Functionality**
   - All acceptance criteria met
   - Business rules correctly implemented
   - User workflows function as expected

2. **Ensure Quality**
   - No critical or high-severity bugs
   - Acceptable performance
   - Good user experience

3. **Verify Integration**
   - Components work together correctly
   - APIs function as documented
   - Data flows correctly

### Success Criteria

- ✅ All critical test cases pass
- ✅ 95%+ of high-priority cases pass
- ✅ No critical or high-severity bugs remain
- ✅ Performance meets requirements
- ✅ User acceptance obtained

---

## Test Strategy

### Testing Approach

**Test Levels:**
1. **Unit Testing** - Developer responsibility (>80% coverage)
2. **Integration Testing** - QA validates component interaction
3. **System Testing** - End-to-end workflow validation
4. **User Acceptance Testing** - Stakeholder validation

**Test Types Selected:**

#### Functional Testing
- **Approach:** Manual + Automated
- **Tools:** Playwright (UI), pytest (API)
- **Coverage:** All acceptance criteria

#### UI Testing
- **Approach:** Automated with Playwright
- **Focus:** User interactions, visual validation, responsiveness
- **Browsers:** Chrome, Firefox, Safari

#### API Testing
- **Approach:** Automated
- **Tools:** pytest, requests library
- **Coverage:** All endpoints

#### Integration Testing
- **Approach:** Automated
- **Focus:** Component interactions, data flow

#### Performance Testing (if applicable)
- **Approach:** Automated load testing
- **Tools:** [Locust / k6 / JMeter]
- **Metrics:** Response time, throughput, resource usage

---

## Test Environment

### Environment Details

**Test Environment:** [Staging / QA Environment]

**URL:** [https://staging.example.com]

**Infrastructure:**
- **Backend:** [Django on Azure App Service]
- **Database:** [PostgreSQL via Supabase]
- **Frontend:** [If applicable]

**Test Data:**
- **Approach:** [Seed data / Test data generation]
- **Reset Strategy:** [Between test runs]

### Environment Setup Checklist

- [ ] Test environment deployed and accessible
- [ ] Test data loaded
- [ ] User accounts created
- [ ] API keys configured
- [ ] Email/notification testing configured
- [ ] Monitoring enabled
- [ ] Backups verified

---

## Test Cases

### Test Case Structure

Each test case includes:
- Test Case ID
- Feature/Story Reference
- Priority (Critical / High / Medium / Low)
- Preconditions
- Test Steps
- Expected Results
- Actual Results
- Pass/Fail Status

---

### Test Case #1: [Description]

**Test Case ID:** TC-001  
**Feature:** [Feature name]  
**User Story:** [US-XXX]  
**Priority:** CRITICAL / HIGH / MEDIUM / LOW  
**Type:** Functional / UI / Integration / Performance

**Objective:**
[What this test validates]

**Preconditions:**
1. [Condition 1]
2. [Condition 2]

**Test  Data:**
- User: [test@example.com]
- Password: [TestPassword123]
- Test record: [ID or description]

**Test Steps:**

| Step # | Action | Expected Result |
|--------|--------|-----------------|
| 1 | Navigate to [URL] | Page loads successfully |
| 2 | Enter credentials and login | User logged in, redirected to dashboard |
| 3 | Click [Button/Link] | [Expected behavior] |
| 4 | Verify [Element] | [Element] displays [expected data] |

**Expected Result:**
[Overall expected outcome]

**Actual Result:**
[To be filled during testing]

**Status:** ⬜ Not Run / ✅ Pass / ❌ Fail / ⚠️ Blocked

**Notes:**
[Any additional observations]

**Defects Found:**
[Bug IDs if failures]

---

### Test Case #2: [Description]

[Repeat structure for each test case]

---

## Test Case Summary

### Test Cases by Priority

| Priority | Total | Executed | Passed | Failed | Blocked |
|----------|-------|----------|--------|--------|---------|
| Critical | [#] | [#] | [#] | [#] | [#] |
| High | [#] | [#] | [#] | [#] | [#] |
| Medium | [#] | [#] | [#] | [#] | [#] |
| Low | [#] | [#] | [#] | [#] | [#] |
| **Total** | **[#]** | **[#]** | **[#]** | **[#]** | **[#]** |

### Test Cases by Feature

| Feature | Total Cases | Pass | Fail | Pass Rate |
|---------|-------------|------|------|-----------|
| [Feature 1] | [#] | [#] | [#] | [%] |
| [Feature 2] | [#] | [#] | [#] | [%] |
| **Total** | **[#]** | **[#]** | **[#]** | **[%]** |

---

## Automated Test Scripts

### Playwright UI Tests

**Location:** `tests/ui/`

**Test Suites:**

#### Suite: Authentication Tests
```javascript
// tests/ui/auth.spec.js
describe('Authentication', () => {
  test('User can login with valid credentials', async ({ page }) => {
    await page.goto('/login');
    await page.fill('[name="email"]', 'test@example.com');
    await page.fill('[name="password"]', 'TestPassword123');
    await page.click('button[type="submit"]');
    await expect(page).toHaveURL('/dashboard');
  });
  
  test('Login fails with invalid credentials', async ({ page }) => {
    // Test implementation
  });
});
```

**Execution:**
```bash
npx playwright test tests/ui/auth.spec.js
```

---

#### Suite: Team Management Tests
[Test code]

---

### API Tests

**Location:** `tests/api/`

**Test Suites:**

#### Suite: User API Tests
```python
# tests/api/test_user_api.py
import pytest
from tests.helpers import api_client

def test_create_user():
    """Test user creation via API"""
    response = api_client.post('/api/users/', {
        'email': 'newuser@example.com',
        'name': 'New User',
        'role': 'contributor'
    })
    assert response.status_code == 201
    assert response.json()['email'] == 'newuser@example.com'

def test_get_user():
    """Test user retrieval via API"""
    # Test implementation
```

**Execution:**
```bash
pytest tests/api/test_user_api.py -v
```

---

## Test Execution Schedule

### Week 1: [Dates]

**Days 1-2: Setup & Smoke Testing**
- Environment setup
- Smoke tests
- Test data preparation

**Days 3-5: Functional Testing**
- Execute critical test cases
- Execute high-priority test cases
- Log defects

---

### Week 2: [Dates]

**Days 1-3: Integration & System Testing**
- Execute integration test cases
- End-to-end workflow testing
- Performance testing (if applicable)

**Days 4-5: Regression & Retesting**
- Regression testing
- Retest fixed defects
- Final validation

---

## Defect Management

### Defect Lifecycle

```
New → Assigned → In Progress → Fixed → Ready for Retest → Closed
                                      → Reopened (if retest fails)
```

### Defect Priority & Severity

**Priority Levels:**
- **P1 - Critical:** System unusable, data loss, security breach
- **P2 - High:** Major feature broken, significant impact
- **P3 - Medium:** Feature partially works, workaround exists
- **P4 - Low:** Minor issue, cosmetic problem

**Severity Levels:**
- **S1 - Blocker:** Cannot proceed with testing
- **S2 - Critical:** Major functionality broken
- **S3 - Major:** Important feature affected
- **S4 - Minor:** Small issue, minimal impact

---

### Defect Template

**Defect ID:** BUG-XXX  
**Title:** [Short description]  
**Priority:** P1 / P2 / P3 / P4  
**Severity:** S1 / S2 / S3 / S4  
**Status:** New / Assigned / Fixed / Closed

**Environment:** [Staging / Production]  
**Detected in:** [Sprint/Release]  
**Feature/Story:** [US-XXX]

**Description:**
[Detailed description of the issue]

**Steps to Reproduce:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Expected Result:**
[What should happen]

**Actual Result:**
[What actually happens]

**Screenshots/Logs:**
[Attachments]

**Assigned To:** [Developer/Agent]

---

### Defect Summary

| Priority | Total | Open | In Progress | Fixed | Closed |
|----------|-------|------|-------------|-------|--------|
| P1 | [#] | [#] | [#] | [#] | [#] |
| P2 | [#] | [#] | [#] | [#] | [#] |
| P3 | [#] | [#] | [#] | [#] | [#] |
| P4 | [#] | [#] | [#] | [#] | [#] |
| **Total** | **[#]** | **[#]** | **[#]** | **[#]** | **[#]** |

---

## Test Metrics

### Test Progress

**Overall Progress:** [%]

| Metric | Target | Actual | Status |
|--------|--------|--------|--------|
| Test Case Execution | 100% | [%] | ✅/⚠️/❌ |
| Critical Tests Passed | 100% | [%] | ✅/⚠️/❌ |
| High Priority Tests Passed | 95% | [%] | ✅/⚠️/❌ |
| Defect Fix Rate | 90% | [%] | ✅/⚠️/❌ |

### Quality Metrics

| Metric | Value |
|--------|-------|
| Total Test Cases | [#] |
| Executed | [#] |
| Passed | [#] |
| Failed | [#] |
| Pass Rate | [%] |
| Defects Found | [#] |
| Defects Fixed | [#] |
| Defect Density | [defects/KLOC] |

---

## Test Coverage

### Functional Coverage

| Feature Area | Test Cases | Coverage | Status |
|--------------|------------|----------|--------|
| Authentication | [#] | [%] | ✅ Complete |
| User Management | [#] | [%] | ✅ Complete |
| Team Management | [#] | [%] | ⚠️ In Progress |
| Content Pages | [#] | [%] | ⬜ Not Started |
| Task Management | [#] | [%] | ⬜ Not Started |

**Overall Functional Coverage:** [%]

### Code Coverage (from Unit Tests)

| Module | Coverage | Target | Status |
|--------|----------|--------|--------|
| models/ | [%] | 80% | ✅/❌ |
| views/ | [%] | 80% | ✅/❌ |
| serializers/ | [%] | 80% | ✅/❌ |
| utils/ | [%] | 80% | ✅/❌ |
| **Overall** | **[%]** | **80%** | **✅/❌** |

---

## Risk Assessment

### Testing Risks

#### Risk #1: [Risk Title]

**Probability:** High / Medium / Low  
**Impact:** High / Medium / Low  
**Risk Level:** HIGH / MEDIUM / LOW

**Description:**
[What could go wrong]

**Mitigation:**
[How we reduce the risk]

**Contingency:**
[What we do if it happens]

---

## Entry & Exit Criteria

### Entry Criteria (Start Testing)

- [ ] Code development complete
- [ ] Unit tests passing (>80% coverage)
- [ ] Code review passed
- [ ] Security review passed
- [ ] Test environment ready
- [ ] Test data prepared
- [ ] Test cases reviewed and approved

### Exit Criteria (Testing Complete)

- [ ] All critical test cases executed and passed
- [ ] 95%+ high-priority test cases passed
- [ ] All P1/P2 defects fixed and verified
- [ ] Regression testing complete
- [ ] Test summary report prepared
- [ ] Stakeholder sign-off obtained

---

## Tools & Resources

### Testing Tools

- **UI Testing:** Playwright
- **API Testing:** pytest, requests
- **Performance:** [Tool name]
- **Test Management:** [Tool/Spreadsheet]
- **Defect Tracking:** GitHub Issues

### Skills Used

- `skills/test-case-design-skill.md` (test design)
- `skills/code-review-checklist-skill.md` (quality checks)

### MCP Tools

- Playwright MCP (UI automation)

---

## Test Deliverables

1. **Test Plan** (this document)
2. **Test Cases** (detailed test scenarios)
3. **Test Scripts** (automated tests)
4. **Test Execution Report** (daily/final)
5. **Defect Reports** (bug tracking)
6. **Test Summary Report** (final report)
7. **Test Coverage Report** (coverage analysis)

---

## Sign-off

### Test Plan Approval

- [ ] Test approach approved
- [ ] Test cases reviewed
- [ ] Resources allocated
- [ ] Schedule agreed

**QA Lead:** [Name]  
**Tech Lead:** [Name]  
**Stakeholder:** [Name]  
**Date:** [Date]

---

### Test Completion Sign-off

- [ ] All exit criteria met
- [ ] Critical defects resolved
- [ ] Test summary reviewed
- [ ] Ready for release

**QA Lead:** [Name]  
**Date:** [Date]  
**Status:** [IN PROGRESS / COMPLETED]
