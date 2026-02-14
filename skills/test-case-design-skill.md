# Test Case Design Skill

## Overview

This skill provides guidance on designing effective test cases, creating test plans, and ensuring comprehensive test coverage for software quality assurance.

## When to Use This Skill

- Creating test cases for user stories
- Designing test strategies
- Planning QA activities
- Reviewing test coverage
- Functional testing

## Test Case Design Principles

### 1. Test Requirements, Not Implementation
- Focus on what the system should do
- Not how it does it
- Implementation can change, requirements shouldn't

### 2. Cover Happy Paths and Edge Cases
- Normal operation (happy path)
- Boundary conditions
- Error conditions
- Edge cases

### 3. Make Tests Independent
- Each test runs standalone
- No dependencies between tests
- Can run in any order
- Clean state for each test

### 4. Make Tests Repeatable
- Same input = same output
- No random data (use seeds)
- No dependencies on external state
- Can run multiple times reliably

### 5. Make Tests Maintainable
- Clear test names
- Well-organized
- Easy to update when requirements change
- Good documentation

## Test Case Structure

### Standard Format

```markdown
## Test Case ID: TC-001

**Title:** User can successfully log in with valid credentials

**Preconditions:**
- User account exists in database
- User has valid credentials (email: test@example.com, password: Test123!)
- Application is running and accessible

**Test Steps:**
1. Navigate to login page
2. Enter email: test@example.com
3. Enter password: Test123!
4. Click "Login" button

**Expected Results:**
- User is redirected to dashboard
- User name displayed in header
-"Logged in successfully" message shown
- Session token created

**Actual Results:**
[To be filled during execution]

**Status:** Not Executed / Pass / Fail

**Priority:** High / Medium / Low

**Type:** Functional / Integration / UI / API

**Execution Time:** ~30 seconds
```

## Test Types & When to Use

### Unit Tests
**What:** Test individual functions/methods in isolation

**When to use:**
- Testing business logic
- Testing utility functions
- Testing data transformations
- Testing calculations

**Example:**
```python
def test_calculate_discount():
    """Test discount calculation for different amounts"""
    assert calculate_discount(100, 10) == 90  # 10% discount
    assert calculate_discount(100, 0) == 100   # No discount
    assert calculate_discount(100, 100) == 0   # 100% discount
```

### Integration Tests
**What:** Test interaction between components

**When to use:**
- Testing API endpoints
- Testing database operations
- Testing external service integration
- Testing workflow across layers

**Example:**
```python
def test_create_user_endpoint():
    """Test user creation via API endpoint"""
    response = client.post('/api/users', json={
        'email': 'test@example.com',
        'name': 'Test User'
    })
    assert response.status_code == 201
    assert 'id' in response.json()
    
    # Verify user in database
    user = User.objects.get(email='test@example.com')
    assert user.name == 'Test User'
```

### Functional Tests
**What:** Test complete features from user perspective

**When to use:**
- Testing user stories
- Testing acceptance criteria
- End-to-end workflows
- User journeys

**Example:**
```python
def test_complete_order_flow():
    """Test complete order placement workflow"""
    # Login
    client.login(username='test@example.com', password='Test123!')
    
    # Add item to cart
    client.post('/cart/add', {'product_id': 1, 'quantity': 2})
    
    # Checkout
    response = client.post('/checkout', {'payment_method': 'card'})
    assert response.status_code == 200
    
    # Verify order created
    order = Order.objects.latest('created_at')
    assert order.status == 'pending'
    assert order.items.count() == 2
```

### Acceptance Tests
**What:** Verify system meets business requirements

**When to use:**
- Validating acceptance criteria
- Sprint completion verification
- Release readiness checks
- Stakeholder demos

**Example:**
```gherkin
Feature: User Login

Scenario: Successful login with valid credentials
  Given a user exists with email "test@example.com"
  When the user enters valid credentials
  And clicks the login button
  Then the user should be redirected to the dashboard
  And see their name in the header
```

### UI/UX Tests
**What:** Test user interface and experience

**When to use:**
- Testing responsive design
- Testing accessibility
- Testing browser compatibility
- Testing user interactions

**Example:**
```python
def test_mobile_navigation():
    """Test navigation menu on mobile viewport"""
    driver.set_window_size(375, 667)  # iPhone size
    driver.get('http://localhost:8000')
    
    # Verify hamburger menu visible
    menu_button = driver.find_element_by_id('mobile-menu')
    assert menu_button.is_displayed()
    
    # Click and verify menu opens
    menu_button.click()
    nav_menu = driver.find_element_by_id('nav-menu')
    assert nav_menu.is_displayed()
```

### Performance Tests
**What:** Test system performance and scalability

**When to use:**
- Testing response times
- Testing load capacity
- Testing resource usage
- Before production release

**Example:**
```python
def test_api_response_time():
    """Test API responds within acceptable time"""
    import time
    
    start = time.time()
    response = client.get('/api/products')
    end = time.time()
    
    assert response.status_code == 200
    assert (end - start) < 0.5  # Less than 500ms
```

### Security Tests
**What:** Test security controls and vulnerabilities

**When to use:**
- Testing authentication
- Testing authorization
- Testing input validation
- Before each release

**Example:**
```python
def test_unauthorized_access_blocked():
    """Test unauthorized users cannot access protected resources"""
    # Attempt access without authentication
    response = client.get('/api/admin/users')
    assert response.status_code == 401
    
    # Attempt access with non-admin user
    client.login(username='user@example.com', password='Test123!')
    response = client.get('/api/admin/users')
    assert response.status_code == 403
```

## Test Case Design Techniques

### 1. Equivalence Partitioning

Divide input domain into classes where test behaves similarly.

**Example: Age validation (must be 18-65)**

Partitions:
- Below minimum: age < 18 (invalid)
- Valid range: 18 ≤ age ≤ 65 (valid)
- Above maximum: age > 65 (invalid)

Test cases:
```python
def test_age_validation():
    assert validate_age(17) == False  # Below minimum
    assert validate_age(18) == True   # Minimum boundary
    assert validate_age(40) == True   # Middle of range
    assert validate_age(65) == True   # Maximum boundary
    assert validate_age(66) == False  # Above maximum
```

### 2. Boundary Value Analysis

Test values at boundaries between partitions.

**Example: Discount tiers**
- 0-99: No discount
- 100-499: 10% discount
- 500+: 20% discount

Test cases:
```python
def test_discount_boundaries():
    assert get_discount(0) == 0      # Lowest value
    assert get_discount(99) == 0     # Just below first boundary
    assert get_discount(100) == 10   # First boundary
    assert get_discount(101) == 10   # Just above first boundary
    assert get_discount(499) == 10   # Just below second boundary
    assert get_discount(500) == 20   # Second boundary
    assert get_discount(501) == 20   # Just above second boundary
```

### 3. Decision Table Testing

Map combinations of inputs to expected outputs.

**Example: Loan approval**

| Age >= 18 | Income > 30k | Credit > 650 | Result |
|-----------|-------------|--------------|---------|
| No        | Yes         | Yes          | Reject  |
| Yes       | No          | Yes          | Reject  |
| Yes       | Yes         | No           | Reject  |
| Yes       | Yes         | Yes          | Approve |

Test cases cover all combinations.

### 4. State Transition Testing

Test transitions between different states.

**Example: Order states**
```
Pending → Processing → Shipped → Delivered
               ↓
           Cancelled
```

Test cases:
```python
def test_order_state_transitions():
    order = create_order()
    assert order.status == 'pending'
    
    # Valid transition
    order.process()
    assert order.status == 'processing'
    
    # Valid transition
    order.ship()
    assert order.status == 'shipped'
    
    # Invalid transition (can't cancel shipped order)
    with pytest.raises(InvalidTransition):
        order.cancel()
```

### 5. Error Guessing

Use experience to guess likely errors.

Common error scenarios:
- Null/None values
- Empty strings/lists
- Special characters in input
- Very large numbers
- Negative numbers where positive expected
- Concurrent access
- Network failures
- Database unavailable

```python
def test_common_error_scenarios():
    # Null input
    with pytest.raises(ValueError):
        process_user(None)
    
    # Empty string
    with pytest.raises(ValueError):
        process_user("")
    
    # Special characters
    result = process_user("O'Brien")  # Should handle apostrophe
    assert result is not None
    
    # SQL injection attempt
    result = process_user("'; DROP TABLE users; --")
    assert "DROP TABLE" not in result
```

## Test Coverage Goals

### Code Coverage
- **80%+ overall coverage** (industry standard)
- **100% critical path coverage** (must have)
- **90%+ branch coverage** (good practice)

### Requirement Coverage
- **100% of acceptance criteria** (must have)
- **100% of defined test scenarios** (must have)
- **Key user workflows** (must have)

### Risk-Based Coverage
- **High risk areas**: 100% coverage
- **Medium risk areas**: 80% coverage
- **Low risk areas**: Basic smoke tests

## Test Case Examples by Feature

### Authentication Feature

```markdown
## TC-AUTH-001: Successful Login
**Steps:**
1. Navigate to /login
2. Enter valid email and password
3. Click Login
**Expected:** Redirect to dashboard, session created

## TC-AUTH-002: Invalid Credentials
**Steps:**
1. Navigate to /login
2. Enter invalid password
3. Click Login
**Expected:** Error message "Invalid credentials", stay on login page

## TC-AUTH-003: Locked Account
**Steps:**
1. Fail login 5 times
2. Attempt 6th login with valid credentials
**Expected:** Error message "Account locked", email sent to user

## TC-AUTH-004: Password Reset Flow
**Steps:**
1. Click "Forgot Password"
2. Enter email
3. Check email for reset link
4. Click link and set new password
5. Login with new password
**Expected:** Password updated, successful login

## TC-AUTH-005: Session Timeout
**Steps:**
1. Login successfully
2. Wait for 30 minutes (session timeout)
3. Attempt to access protected page
**Expected:** Redirect to login page, message "Session expired"
```

### Task Management Feature

```markdown
## TC-TASK-001: Create New Task
**Preconditions:** User logged in with appropriate permissions
**Steps:**
1. Navigate to Tasks page
2. Click "New Task" button
3. Fill in title, description, due date
4. Assign to team member
5. Set priority to High
6. Click Save
**Expected:** 
- Task created in database
- Task appears in task list
- Assignee receives notification
- Task ID returned

## TC-TASK-002: Edit Existing Task
**Preconditions:** Task TC-TASK-001 exists
**Steps:**
1. Open task from list
2. Change title to "Updated Title"
3. Click Save
**Expected:**
- Task updated in database
- Changes reflected in task list
- "Last modified" timestamp updated

## TC-TASK-003: Delete Task
**Preconditions:** Task exists
**Steps:**
1. Open task
2. Click Delete button
3. Confirm deletion
**Expected:**
- Task soft-deleted (status = deleted)
- Task removed from active task list
- Audit log entry created

## TC-TASK-004: Cannot Delete Others' Tasks
**Preconditions:** Task assigned to User A, logged in as User B
**Steps:**
1. Attempt to open task detail
2. Attempt to access delete endpoint directly
**Expected:**
- 403 Forbidden error
- Task remains unchanged
- Security event logged
```

## Test Data Management

### Test Data Principles
- **Realistic but safe:** No real user data
- **Consistent:** Same data for repeatable tests
- **Comprehensive:** Cover all scenarios
- **Isolated:** Each test has its own data

### Test Data Examples

```python
# Good test data
TEST_USERS = {
    'admin': {
        'email': 'admin@test.example.com',
        'password': 'Test123!Admin',
        'role': 'admin'
    },
    'user': {
        'email': 'user@test.example.com',
        'password': 'Test123!User',
        'role': 'user'
    },
    'no_team': {
        'email': 'noteam@test.example.com',
        'password': 'Test123!NoTeam',
        'role': 'user',
        'team': None  # Edge case: user without team
    }
}

# Good test products
TEST_PRODUCTS = [
    {'id': 1, 'name': 'Test Product A', 'price': 10.00},
    {'id': 2, 'name': 'Test Product B', 'price': 0.01},  # Boundary: very low price
    {'id': 3, 'name': 'Test Product C', 'price': 9999.99}  # Boundary: high price
]
```

### Fixtures (Pytest)

```python
import pytest

@pytest.fixture
def test_user(db):
    """Create test user for tests"""
    user = User.objects.create(
        email='test@example.com',
        name='Test User'
    )
    user.set_password('Test123!')
    user.save()
    return user

@pytest.fixture
def authenticated_client(client, test_user):
    """Create authenticated client"""
    client.login(email='test@example.com', password='Test123!')
    return client

def test_dashboard_access(authenticated_client):
    """Test dashboard requires authentication"""
    response = authenticated_client.get('/dashboard')
    assert response.status_code == 200
```

## Test Execution & Reporting

### Test Execution Order
1. **Smoke tests:** Basic functionality works
2. **Critical path tests:** Core features work
3. **Extended tests:** Full coverage
4. **Regression tests:** Previous bugs don't reappear
5. **Performance tests:** System performs adequately

### Test Report Template

```markdown
# Test Execution Report

**Sprint:** SPRINT-001
**Date:** February 14, 2026
**Tester:** QA Lead Agent

## Summary
- **Total Test Cases:** 45
- **Executed:** 45
- **Passed:** 42
- **Failed:** 3
- **Blocked:** 0
- **Not Executed:** 0

**Pass Rate:** 93.3%

## Test Results by Feature

### Authentication (8 tests)
- ✅ 8 Passed
- ❌ 0 Failed
- Status: READY

### Task Management (15 tests)
- ✅ 13 Passed
- ❌ 2 Failed
- Status: NEEDS FIX

#### Failed Tests:
- TC-TASK-012: Task notification not sent
  - Severity: HIGH
  - Issue: SMTP configuration error
  - Action: Fix SMTP settings

- TC-TASK-015: Task deletion authorization
  - Severity: CRITICAL
  - Issue: Non-owner can delete tasks
  - Action: Add authorization check

### Document Management (12 tests)
- ✅ 11 Passed
- ❌ 1 Failed
- Status: NEEDS FIX

#### Failed Tests:
- TC-DOC-008: File upload size limit
  - Severity: MEDIUM
  - Issue: Allows files > 20MB
  - Action: Enforce size limit

### Dashboard & Reports (10 tests)
- ✅ 10 Passed
- ❌ 0 Failed
- Status: READY

## Critical Issues
1. **TC-TASK-015:** Authorization bypass (CRITICAL)
   - Must fix before release
   - Security vulnerability

## Recommendations
- Fix critical authorization issue immediately
- Configure SMTP for notifications
- Enforce file size limits
- Re-test after fixes

## Next Steps
1. Dev team fixes critical issues
2. Re-run failed tests
3. Conduct final regression test
4. Release readiness review
```

## Exploratory Testing

Beyond scripted tests, perform exploratory testing:

### Areas to Explore
- **Edge cases not in test cases**
- **Unusual user behaviors**
- **Combination of features**
- **Performance under stress**
- **Browser/device variations**

### Exploratory Testing Session

```markdown
## Exploratory Testing Session

**Feature:** Task Management
**Duration:** 60 minutes
**Tester:** QA Lead
**Charter:** Explore task creation and assignment workflows

### Findings

**Bug 1:** Long task titles overflow UI
- **Severity:** LOW
- **Steps:** Create task with 500-character title
- **Expected:** Title truncated or wrapped
- **Actual:** Title overflows container

**Bug 2:** Cannot assign task to user in different team
- **Severity:** MEDIUM
- **Steps:** Try to assign task to user from Team B while in Team A
- **Expected:** Error message or filtered user list
- **Actual:** Allows assignment but task disappears

**Observation:** UX could be improved
- **Area:** Task priority selection
- **Issue:** Priority dropdown not obvious
- **Suggestion:** Use color-coded buttons instead
```

## Test Automation Strategy

### What to Automate
- ✅ Repetitive tests
- ✅ Regression tests
- ✅ API tests
- ✅ Data-driven tests
- ✅ Critical path tests

### What to Keep Manual
- ⚠️ UI/UX evaluation
- ⚠️ Exploratory testing
- ⚠️ Accessibility testing
- ⚠️ New feature exploration

## Testing Best Practices

1. **Write tests first (TDD)** - Or at least alongside code
2. **Keep tests simple** - One assertion per test (ideally)
3. **Use descriptive names** - Test name explains what's being tested
4. **Arrange-Act-Assert** - Clear structure
5. **Don't test framework** - Test your code, not Django/FastAPI
6. **Mock external dependencies** - Tests should be fast and isolated
7. **Clean up after tests** - Don't leave test data
8. **Run tests often** - Catch bugs early
9. **Maintain test code** - Tests are code too
10. **Review test coverage** - Ensure adequate coverage

## Common Testing Mistakes

### ❌ Testing Too Much
```python
# Don't test framework/library code
def test_django_user_model():
    user = User.objects.create(email='test@example.com')
    assert user.email == 'test@example.com'  # Testing Django, not your code
```

### ❌ Vague Test Names
```python
# Bad
def test1():
    ...

# Good
def test_user_cannot_delete_other_users_tasks():
    ...
```

### ❌ Multiple Assertions Testing Different Things
```python
# Bad - hard to tell what failed
def test_user_creation():
    user = create_user('test@example.com')
    assert user.email == 'test@example.com'
    assert user.is_active == True
    assert user.role == 'user'
    assert len(User.objects.all()) == 1

# Good - separate concerns
def test_user_created_with_correct_email():
    user = create_user('test@example.com')
    assert user.email == 'test@example.com'

def test_new_user_is_active_by_default():
    user = create_user('test@example.com')
    assert user.is_active == True
```

### ❌ Tests That Depend on Each Other
```python
# Bad - test2 depends on test1
def test1_create_user():
    user = User.objects.create(email='test@example.com')
    global test_user_id
    test_user_id = user.id

def test2_update_user():
    user = User.objects.get(id=test_user_id)  # Depends on test1!
    user.name = 'Updated'
    user.save()

# Good - each test independent
@pytest.fixture
def test_user():
    return User.objects.create(email='test@example.com')

def test_user_creation(test_user):
    assert test_user.id is not None

def test_user_update(test_user):
    test_user.name = 'Updated'
    test_user.save()
    assert test_user.name == 'Updated'
```

## Resources

- **Pytest Documentation**: https://docs.pytest.org/
- **Django Testing**: https://docs.djangoproject.com/en/stable/topics/testing/
- **Test Design Patterns**: https://martinfowler.com/articles/practical-test-pyramid.html
- **BDD with Gherkin**: https://cucumber.io/docs/gherkin/

## Skill Metadata

**Skill Name:** Test Case Design
**Version:** 1.0
**Last Updated:** February 14, 2026
**Applicable To:** QA Lead, Code Inspector, Coding Agent
**Dependencies:** None
**Related Skills:** code-review-checklist-skill.md
