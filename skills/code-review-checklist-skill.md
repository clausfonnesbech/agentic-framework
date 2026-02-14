# Code Review Checklist Skill

## Overview

This skill provides comprehensive checklists and guidance for conducting effective code reviews. Use it to ensure code quality, maintainability, security, and adherence to best practices.

## When to Use This Skill

- Reviewing pull requests
- Conducting code inspections
- Quality gate verification
- Pre-merge checks
- Pair programming reviews

## Code Review Principles

### 1. Be Constructive
- Focus on the code, not the person
- Suggest improvements, don't just criticize
- Explain why something should change

### 2. Be Thorough but Timely
- Don't rubber-stamp approvals
- Don't let perfect be enemy of good
- Balance thoroughness with velocity

### 3. Focus on Impact
- Prioritize critical issues
- Security > Bugs > Style
- Fix blockers, document nice-to-haves

## Core Review Checklist

### Functionality
- [ ] **Code does what it's supposed to do**
  - Implements user story requirements
  - Meets acceptance criteria
  - Handles edge cases

- [ ] **Business logic is correct**
  - Calculations accurate
  - State transitions valid
  - Data flows correctly

- [ ] **No obvious bugs**
  - Null pointer checks
  - Off-by-one errors
  - Logic errors

### Code Quality

- [ ] **Readable and understandable**
  - Clear variable/function names
  - Logical structure
  - Not overly complex

- [ ] **Well-organized**
  - Proper file/folder structure
  - Related code grouped together
  - Separation of concerns

- [ ] **DRY (Don't Repeat Yourself)**
  - No unnecessary duplication
  - Common logic extracted
  - Reusable functions/classes

- [ ] **SOLID principles followed**
  - Single Responsibility
  - Open/Closed
  - Liskov Substitution
  - Interface Segregation
  - Dependency Inversion

### Security

- [ ] **Input validation present**
  - All user inputs validated
  - Type checking
  - Range/length limits

- [ ] **No SQL injection vulnerabilities**
  - Parameterized queries used
  - ORM used properly
  - No string concatenation in queries

- [ ] **No XSS vulnerabilities**
  - Output properly escaped
  - Templates auto-escape
  - No innerHTML with user data

- [ ] **Authentication & authorization enforced**
  - Auth checks on all endpoints
  - Authorization verified
  - No bypass vulnerabilities

- [ ] **Sensitive data protected**
  - No secrets in code
  - PII encrypted
  - Secure data handling

- [ ] **Error handling secure**
  - No sensitive info in errors
  - Stack traces not exposed
  - Generic error messages to users

### Performance

- [ ] **No obvious performance issues**
  - No N+1 queries
  - Appropriate data structures
  - Efficient algorithms

- [ ] **Database queries optimized**
  - Proper indexes used
  - Select only needed fields
  - Pagination for large datasets

- [ ] **Resource usage reasonable**
  - No memory leaks
  - File handles closed
  - Connections cleaned up

### Testing

- [ ] **Tests present and passing**
  - Unit tests for new functions
  - Integration tests for APIs
  - Edge cases covered

- [ ] **Test coverage adequate**
  - Critical paths tested
  - Coverage >= 80% (or project standard)
  - Tests are meaningful (not just coverage)

- [ ] **Tests are good quality**
  - Tests are readable
  - Tests are independent
  - Tests use appropriate assertions

### Documentation

- [ ] **Code is self-documenting**
  - Clear naming
  - Obvious logic flow
  - Minimal comments needed

- [ ] **Comments where needed**
  - Why, not what
  - Complex logic explained
  - Public APIs documented

- [ ] **API documentation updated**
  - Endpoint descriptions
  - Request/response examples
  - Error codes documented

- [ ] **README updated if needed**
  - Setup instructions current
  - New features documented
  - Breaking changes noted

### Error Handling

- [ ] **Errors handled appropriately**
  - Try/catch where needed
  - Specific exception types
  - Proper error propagation

- [ ] **Logging appropriate**
  - Errors logged with context
  - No PII in logs
  - Appropriate log levels

- [ ] **Graceful degradation**
  - Fails safely
  - User-friendly error messages
  - Recovery mechanisms

### Database & Data

- [ ] **Schema changes correct**
  - Migrations present
  - Backward compatible
  - Indexes added for queries

- [ ] **Data integrity maintained**
  - Foreign keys used
  - Constraints enforced
  - Validation rules in place

- [ ] **Transactions used appropriately**
  - ACID properties maintained
  - Rollback on errors
  - No partial updates

### API Design (if applicable)

- [ ] **RESTful conventions followed**
  - Proper HTTP methods
  - Appropriate status codes
  - Resource-based URLs

- [ ] **Versioning strategy followed**
  - API version in URL/header
  - Backward compatibility maintained
  - Deprecation notices

- [ ] **Request/response format consistent**
  - Standard JSON structure
  - Error format consistent
  - Pagination standardized

### Configuration

- [ ] **Configuration externalized**
  - No hardcoded values
  - Environment variables used
  - Config files for settings

- [ ] **Secrets managed properly**
  - No secrets in code
  - Environment variables
  - Secret management service

### Dependencies

- [ ] **Dependencies justified**
  - New dependencies necessary
  - No better alternatives
  - Well-maintained packages

- [ ] **Dependency versions pinned**
  - Specific versions in requirements
  - Lock files updated
  - No known vulnerabilities

## Language-Specific Checklists

### Python/Django

- [ ] **Python style (PEP 8)**
  - 4-space indentation
  - Snake_case naming
  - Line length <= 88 chars (Black formatter)

- [ ] **Django best practices**
  - QuerySets used efficiently
  - Migrations generated
  - Templates use {% csrf_token %}
  - Forms use Django forms

- [ ] **Type hints used** (Python 3.6+)
  ```python
  def process_user(user_id: int) -> User:
      ...
  ```

### JavaScript/TypeScript

- [ ] **Modern JS features used**
  - const/let instead of var
  - Arrow functions
  - Template literals

- [ ] **TypeScript types defined** (if TS)
  - No 'any' types
  - Interfaces for objects
  - Return types specified

- [ ] **Async/await used properly**
  - Error handling present
  - No unhandled rejections
  - Concurrent operations optimized

### SQL

- [ ] **Queries optimized**
  - Proper indexes used
  - Joins efficient
  - No SELECT *

- [ ] **Parameterized queries**
  - No string concatenation
  - Prepared statements
  - ORM or query builder

## Review Process

### Step 1: Understand Context

1. Read the user story
2. Review acceptance criteria
3. Check linked issues
4. Understand the change scope

### Step 2: High-Level Review

1. Review file changes overview
2. Check if architecture makes sense
3. Verify separation of concerns
4. Assess overall approach

### Step 3: Detailed Review

1. Go through each file
2. Check against checklists above
3. Note issues by severity:
   - **CRITICAL**: Must fix before merge
   - **HIGH**: Should fix before merge
   - **MEDIUM**: Fix soon
   - **LOW**: Nice to have

### Step 4: Test Verification

1. Verify tests exist
2. Check test coverage
3. Review test quality
4. Ensure tests pass

### Step 5: Provide Feedback

1. Start with positives
2. Group similar issues
3. Provide specific suggestions
4. Link to documentation/examples
5. Mark severity of each issue

## Feedback Templates

### Approval Comment

```markdown
## Code Review - APPROVED ✅

### Strengths
- Clean, readable code
- Good test coverage (85%)
- Proper error handling
- Security best practices followed

### Minor Suggestions (non-blocking)
- Consider extracting [specific code] into separate function for reusability
- Could add docstring to [specific function]

Great work! Approved for merge.
```

### Request Changes Comment

```markdown
## Code Review - CHANGES REQUESTED ⚠️

### Critical Issues (Must Fix)
1. **SQL Injection Vulnerability** (Line 45)
   - Current: String concatenation in query
   - Fix: Use parameterized query
   - Example:
     ```python
     # Instead of:
     query = f"SELECT * FROM users WHERE id = {user_id}"
     # Use:
     user = User.objects.get(id=user_id)
     ```

2. **Missing Authorization Check** (Line 78)
   - Endpoint allows any authenticated user to delete
   - Need to verify user owns the resource

### High Priority Issues (Should Fix)
1. **N+1 Query** (Line 120)
   - Fetching related objects in loop
   - Use select_related() or prefetch_related()

2. **Missing Tests** (feature_x.py)
   - No tests for new delete functionality
   - Need at least basic happy path test

### Medium Priority Issues (Fix When Possible)
1. **Long Function** (process_data, Line 150-230)
   - Consider breaking into smaller functions
   - Would improve readability

Please address critical and high priority issues before re-review.
```

### Questions Comment

```markdown
## Code Review - QUESTIONS ❓

Before I approve, I have some questions:

1. **Line 34:** Why use threading here instead of async/await?
   - Is there a specific reason?
   - Performance comparison?

2. **Line 67:** Will this handle the case when user has no team?
   - Should we add a null check?

3. **Migration 0005:** Will this run on large tables?
   - Any performance considerations?
   - Should we schedule for maintenance window?

Please clarify these points.
```

## Common Issues & Solutions

### Issue: Long Functions

**Problem:**
```python
def process_order(order_id):
    # 200 lines of code...
    pass
```

**Solution:**
```python
def process_order(order_id):
    order = fetch_order(order_id)
    validate_order(order)
    calculate_totals(order)
    process_payment(order)
    send_confirmation(order)
    return order
```

**Review Comment:**
> This function is quite long (200+ lines). Consider breaking it down into smaller, focused functions like `fetch_order()`, `validate_order()`, etc. This would improve readability and testability.

### Issue: Magic Numbers

**Problem:**
```python
if user.age >= 18 and user.score > 750:
    approve_application()
```

**Solution:**
```python
MINIMUM_AGE = 18
MINIMUM_CREDIT_SCORE = 750

if user.age >= MINIMUM_AGE and user.score > MINIMUM_CREDIT_SCORE:
    approve_application()
```

**Review Comment:**
> Consider extracting magic numbers (18, 750) into named constants. This makes the code more maintainable and self-documenting.

### Issue: No Error Handling

**Problem:**
```python
def get_user(user_id):
    return User.objects.get(id=user_id)
```

**Solution:**
```python
def get_user(user_id):
    try:
        return User.objects.get(id=user_id)
    except User.DoesNotExist:
        logger.warning(f"User {user_id} not found")
        return None
```

**Review Comment:**
> This will raise an exception if user doesn't exist. Should we handle the DoesNotExist case? Or is the exception intentional?

### Issue: Inconsistent Naming

**Problem:**
```python
def getUserData(id):
    user_info = fetchUser(id)
    ProcessUserInfo(user_info)
```

**Solution:**
```python
def get_user_data(user_id):
    user_info = fetch_user(user_id)
    process_user_info(user_info)
```

**Review Comment:**
> Let's keep naming consistent with Python conventions (snake_case for functions, descriptive parameter names).

## Automation Opportunities

### Pre-Commit Checks
```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/psf/black
    rev: 23.3.0
    hooks:
      - id: black
  
  - repo: https://github.com/PyCQA/flake8
    rev: 6.0.0
    hooks:
      - id: flake8
  
  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.3.0
    hooks:
      - id: mypy
```

### CI Checks
- Linting (flake8, eslint)
- Type checking (mypy, TypeScript)
- Tests with coverage
- Security scanning
- Dependency vulnerabilities

### Code Review Tools
- **SonarQube**: Code quality analysis
- **CodeClimate**: Automated review
- **Codecov**: Coverage visualization
- **Snyk**: Security scanning

## Review Anti-Patterns

### Don't: Rubber Stamp
- Approving without actually reviewing
- Trusting author implicitly
- Skipping security checks

### Don't: Nitpick Excessively
- Focusing only on style
- Debating subjective preferences
- Blocking on minor issues

### Don't: Review in Pieces
- Missing the big picture
- Not understanding context
- Redundant comments

### Don't: Be Vague
- "This looks wrong"
- "Can you improve this?"
- "I don't like this approach"

### Do: Be Specific
- Point to exact lines
- Explain the issue
- Suggest concrete solutions
- Link to documentation

## Edge Cases to Check

- [ ] **Null/None handling**
  - What if input is null?
  - Empty strings/lists?

- [ ] **Boundary conditions**
  - Zero, one, many
  - Min/max values
  - Edge of ranges

- [ ] **Error conditions**
  - Network failures
  - Database errors
  - External API failures

- [ ] **Concurrent access**
  - Race conditions
  - Simultaneous updates
  - Lock conflicts

- [ ] **Large datasets**
  - Pagination working?
  - Memory usage reasonable?
  - Query performance?

## When to Approve

**Approve when:**
- All critical issues resolved
- High priority issues addressed or documented
- Tests pass and coverage adequate
- Security concerns addressed
- Code meets quality standards

**Don't approve when:**
- Security vulnerabilities present
- Tests failing
- Critical bugs evident
- Code unclear/unmaintainable

**Conditional approve:**
- Minor issues that can be fixed post-merge
- Style issues only
- Documentation improvements

## Skill Metadata

**Skill Name:** Code Review Checklist
**Version:** 1.0
**Last Updated:** February 14, 2026
**Applicable To:** Code Inspector, Tech Lead, Coding Agent (self-review)
**Dependencies:** secure-coding-skill.md
**Related Skills:** test-case-design-skill.md, secure-coding-skill.md
