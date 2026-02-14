# API Design & RESTful Architecture Skill

**Skill Type:** Technical Architecture  
**Purpose:** Design clean, maintainable, and scalable REST APIs following industry best practices

## Overview

This skill provides frameworks and patterns for designing RESTful APIs that are intuitive, consistent, and maintainable. It covers resource modeling, endpoint design, HTTP method usage, status codes, versioning strategies, and error handling patterns essential for building robust web applications.

## When to Use This Skill

- ✅ Designing new API endpoints
- ✅ Reviewing existing API architecture
- ✅ Planning backend services for web applications
- ✅ Evaluating third-party API quality
- ✅ Creating API documentation
- ✅ Refactoring legacy APIs

## Core Principles

### 1. Resources, Not Actions
URLs should represent **things** (nouns), not **actions** (verbs). Actions are expressed through HTTP methods.

**Good:**
```
GET    /tasks          # Get all tasks
POST   /tasks          # Create a task
GET    /tasks/123      # Get specific task
PUT    /tasks/123      # Update specific task
DELETE /tasks/123      # Delete specific task
```

**Bad:**
```
POST /createTask
POST /updateTask
POST /deleteTask
GET  /getTasks
```

### 2. Consistency Over Cleverness
Predictable patterns are better than clever shortcuts. Users should be able to guess your API structure.

### 3. Client-Focused Design
Design from the client's perspective. What data do they need? What operations make sense?

### 4. Idempotency Matters
Same request = same result. Critical for reliability in distributed systems.

### 5. Version from Day One
APIs evolve. Build versioning in from the start, even if you're on v1.

---

## RESTful Resource Modeling

### Resource Identification

**Single Resource:**
```
/teams/sweden
/tasks/42
/users/claus
```

**Collection Resource:**
```
/teams
/tasks
/users
```

**Nested/Related Resources:**
```
/teams/sweden/roster         # Sweden's roster
/teams/sweden/documents      # Sweden's documents
/tasks/42/comments           # Comments on task 42
```

**When to Nest:**
- ✅ Resource truly "belongs to" parent (team documents belong to team)
- ✅ Always accessed in parent context
- ⚠️ Don't nest more than 2 levels deep

**When NOT to Nest:**
- ❌ Resource has independent existence
- ❌ Many-to-many relationships
- ❌ Would create deep nesting (>2 levels)

**Alternative: Query Parameters**
```
# Instead of /teams/sweden/documents
GET /documents?team=sweden

# Instead of /teams/sweden/tasks?status=completed
GET /tasks?team=sweden&status=completed
```

---

## HTTP Methods (Verbs)

### Standard CRUD Operations

| Method | Purpose | Idempotent | Safe | Example |
|--------|---------|------------|------|---------|
| **GET** | Retrieve resource(s) | Yes | Yes | `GET /tasks` |
| **POST** | Create new resource | No | No | `POST /tasks` |
| **PUT** | Replace entire resource | Yes | No | `PUT /tasks/42` |
| **PATCH** | Partial update | No* | No | `PATCH /tasks/42` |
| **DELETE** | Remove resource | Yes | No | `DELETE /tasks/42` |

*PATCH can be designed to be idempotent but isn't required to be.

### GET - Retrieve

**Use Cases:**
- Fetch single resource
- List collection with filtering/pagination
- Never causes side effects (no data changes)

**Examples:**
```http
GET /tasks                    # List all tasks
GET /tasks?status=open        # Filter by status
GET /tasks?assignee=sweden    # Filter by assignee
GET /tasks/42                 # Get specific task
GET /teams/sweden/documents   # Get team's documents
```

**Response:**
```json
// Single resource
{
  "id": 42,
  "title": "Submit roster",
  "deadline": "2026-04-04",
  "status": "open",
  "assignee": "sweden"
}

// Collection
{
  "data": [
    { "id": 42, "title": "Submit roster" },
    { "id": 43, "title": "Submit rooming list" }
  ],
  "pagination": {
    "total": 15,
    "page": 1,
    "per_page": 10
  }
}
```

---

### POST - Create

**Use Cases:**
- Create new resource
- Trigger action that doesn't fit REST model
- Server assigns ID

**Examples:**
```http
POST /tasks
Content-Type: application/json

{
  "title": "Submit roster",
  "deadline": "2026-04-04",
  "assignee": "sweden"
}
```

**Response:**
```http
HTTP/1.1 201 Created
Location: /tasks/42
Content-Type: application/json

{
  "id": 42,
  "title": "Submit roster",
  "deadline": "2026-04-04",
  "assignee": "sweden",
  "status": "open",
  "created_at": "2026-02-12T10:30:00Z"
}
```

**Best Practices:**
- Return `201 Created` status
- Include `Location` header with new resource URL
- Return complete resource in response body
- Generate server-side values (id, created_at, etc.)

---

### PUT - Replace

**Use Cases:**
- Replace entire resource
- Client provides complete representation
- Idempotent (repeating request has same effect)

**Examples:**
```http
PUT /tasks/42
Content-Type: application/json

{
  "title": "Submit updated roster",
  "deadline": "2026-04-05",
  "assignee": "sweden",
  "status": "open"
}
```

**Response:**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 42,
  "title": "Submit updated roster",
  "deadline": "2026-04-05",
  "assignee": "sweden",
  "status": "open",
  "updated_at": "2026-02-12T14:20:00Z"
}
```

**Important:**
- Client must send **ALL** fields (except server-managed ones like id, created_at)
- Missing fields should be set to null/default
- If resource doesn't exist, can create it (if allowed)

---

### PATCH - Partial Update

**Use Cases:**
- Update specific fields only
- Client sends only changed fields
- More efficient than PUT

**Examples:**
```http
PATCH /tasks/42
Content-Type: application/json

{
  "status": "completed"
}
```

**Response:**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 42,
  "title": "Submit roster",  
  "deadline": "2026-04-04",
  "assignee": "sweden",
  "status": "completed",      // Updated field
  "updated_at": "2026-02-12T14:25:00Z"
}
```

**Best Practices:**
- Only update fields present in request
- Return complete updated resource
- Validate partial data (e.g., can't set invalid status)

---

### DELETE

**Use Cases:**
- Remove resource permanently
- Idempotent (deleting twice = same result)

**Examples:**
```http
DELETE /tasks/42
```

**Response Options:**

**Option 1: No Content**
```http
HTTP/1.1 204 No Content
```

**Option 2: Return Deleted Resource**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 42,
  "title": "Submit roster",
  "deleted_at": "2026-02-12T15:00:00Z"
}
```

**Soft Delete Pattern:**
```http
# Instead of DELETE, use PATCH to mark as deleted
PATCH /tasks/42
{
  "status": "archived"
}
```

---

## HTTP Status Codes

### Success Codes (2xx)

| Code | Meaning | Use Case |
|------|---------|----------|
| **200 OK** | Success | GET, PUT, PATCH, DELETE (with body) |
| **201 Created** | Resource created | POST |
| **204 No Content** | Success, no body | DELETE, PUT/PATCH when not returning body |

### Client Error Codes (4xx)

| Code | Meaning | Use Case |
|------|---------|----------|
| **400 Bad Request** | Invalid data | Validation errors, malformed JSON |
| **401 Unauthorized** | No/invalid auth | Missing or invalid token |
| **403 Forbidden** | Authenticated but not allowed | Insufficient permissions |
| **404 Not Found** | Resource doesn't exist | GET/PUT/DELETE non-existent resource |
| **409 Conflict** | State conflict | Duplicate creation, version mismatch |
| **422 Unprocessable Entity** | Semantic errors | Valid JSON but business logic fails |
| **429 Too Many Requests** | Rate limited | Exceeded API rate limit |

### Server Error Codes (5xx)

| Code | Meaning | Use Case |
|------|---------|----------|
| **500 Internal Server Error** | Unexpected error | Uncaught exception |
| **502 Bad Gateway** | Upstream failure | External service failed |
| **503 Service Unavailable** | Temporary outage | Maintenance, overload |

---

## Error Response Format

### Standardized Error Structure

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid request data",
    "details": [
      {
        "field": "deadline",
        "message": "Deadline must be in the future"
      },
      {
        "field": "assignee",
        "message": "Team 'invalid' does not exist"
      }
    ],
    "timestamp": "2026-02-12T10:30:00Z",
    "path": "/tasks",
    "request_id": "req_abc123"
  }
}
```

**Key Elements:**
- **code:** Machine-readable error code
- **message:** Human-readable summary
- **details:** Field-specific errors (validation)
- **timestamp:** When error occurred
- **path:** Which endpoint failed
- **request_id:** For debugging/support

### Error Code Examples

```python
# Common error codes
ERROR_CODES = {
    "VALIDATION_ERROR": 400,
    "AUTHENTICATION_REQUIRED": 401,
    "PERMISSION_DENIED": 403,
    "RESOURCE_NOT_FOUND": 404,
    "DUPLICATE_RESOURCE": 409,
    "RATE_LIMIT_EXCEEDED": 429,
    "INTERNAL_ERROR": 500
}
```

---

## Query Parameters

### Common Patterns

**Filtering:**
```
GET /tasks?status=open
GET /tasks?assignee=sweden&status=open
GET /tasks?deadline_before=2026-04-01
```

**Pagination:**
```
GET /tasks?page=2&per_page=20
GET /tasks?offset=40&limit=20
```

**Sorting:**
```
GET /tasks?sort=deadline:asc
GET /tasks?sort=-deadline          # Descending (- prefix)
GET /tasks?sort=deadline,title     # Multiple fields
```

**Field Selection (Sparse Fieldsets):**
```
GET /tasks?fields=id,title,deadline
GET /tasks/42?fields=title,status
```

**Searching:**
```
GET /tasks?search=roster
GET /documents?q=medical+forms
```

**Inclusion (Related Resources):**
```
GET /tasks?include=comments,assignee
GET /teams/sweden?include=roster,documents
```

### Query Parameter Best Practices

✅ **Use meaningful names:**
- `status`, `assignee`, `deadline_before` (clear)
- Not: `s`, `a`, `db` (unclear)

✅ **Use consistent conventions:**
- All lowercase
- Underscores or camelCase (be consistent)
- Plural for collections: `fields`, not `field`

✅ **Support common operations:**
- Filtering, pagination, sorting, searching
- Document which parameters are supported

✅ **Validate parameters:**
- Return 400 for invalid parameter names
- Return 400 for invalid parameter values

---

## Request/Response Bodies

### JSON Format (Standard)

**Request:**
```json
{
  "title": "Submit roster",
  "deadline": "2026-04-04",
  "assignee": "sweden",
  "description": "Please upload final roster by deadline"
}
```

**Best Practices:**

✅ **Use camelCase or snake_case consistently:**
```json
// snake_case (Python backend style)
{
  "task_id": 42,
  "created_at": "2026-02-12T10:00:00Z"
}

// camelCase (JavaScript style)
{
  "taskId": 42,
  "createdAt": "2026-02-12T10:00:00Z"
}
```

✅ **Use ISO 8601 for dates/times:**
```json
{
  "deadline": "2026-04-04",                    // Date
  "created_at": "2026-02-12T10:30:00Z",       // DateTime (UTC)
  "updated_at": "2026-02-12T10:30:00+01:00"   // DateTime (timezone)
}
```

✅ **Use null for missing optional values:**
```json
{
  "title": "Submit roster",
  "description": null,  // Explicitly null, not omitted
  "assignee": "sweden"
}
```

✅ **Nest related data thoughtfully:**
```json
{
  "id": 42,
  "title": "Submit roster",
  "assignee": {
    "id": "sweden",
    "name": "Team Sweden"
  },
  "created_by": {
    "id": 5,
    "name": "Admin User"
  }
}
```

---

## API Versioning Strategies

### 1. URL Path Versioning (Recommended)

```
https://api.example.com/v1/tasks
https://api.example.com/v2/tasks
```

**Pros:**
- ✅ Explicit and visible
- ✅ Easy to route different versions
- ✅ Works with all clients/browsers

**Cons:**
- ⚠️ URL changes between versions

**Example:**
```python
# FastAPI routing
@app.get("/v1/tasks")
def get_tasks_v1():
    return {"version": 1, "tasks": [...]}

@app.get("/v2/tasks")
def get_tasks_v2():
    return {"version": 2, "data": [...], "meta": {...}}
```

---

### 2. Header Versioning

```http
GET /tasks
Accept: application/vnd.myapi.v1+json
```

**Pros:**
- ✅ URLs stay consistent
- ✅ More RESTful

**Cons:**
- ⚠️ Less visible
- ⚠️ Harder to test (can't just click URL)

---

### 3. Query Parameter Versioning

```
GET /tasks?version=1
GET /tasks?v=2
```

**Pros:**
- ✅ Simple
- ✅ Easy to switch versions

**Cons:**
- ⚠️ Mixes versioning with filtering
- ⚠️ Less common pattern

---

### Version Strategy Recommendations

**For IIHF Portal Project:**
Use **URL path versioning** (`/v1/tasks`):
- Simple to implement in FastAPI/Django
- Easy for clients (mobile, web) to specify version
- Clear which version is being used
- Supports gradual migration

**Versioning Rules:**
- Major version (v1 → v2) for breaking changes
- Don't over-version: Only increment when breaking changes occur
- Support N-1 version for deprecation period
- Document migration guides

**Example Breaking Changes:**
- Change response format
- Remove endpoint or field
- Change authentication method
- Change validation rules (strict)

**Non-Breaking Changes (Don't Version):**
- Add new endpoint
- Add optional field to request
- Add new field to response (clients ignore unknown fields)
- Bug fixes

---

## Pagination

### Offset-Based Pagination

```http
GET /tasks?offset=0&limit=20    # First page
GET /tasks?offset=20&limit=20   # Second page
GET /tasks?offset=40&limit=20   # Third page
```

**Response:**
```json
{
  "data": [...],
  "pagination": {
    "total": 156,
    "offset": 20,
    "limit": 20,
    "has_next": true,
    "has_previous": true
  }
}
```

**Pros:**
- ✅ Easy to implement
- ✅ Can jump to arbitrary page
- ✅ Shows total count

**Cons:**
- ⚠️ Performance degrades with large offsets
- ⚠️ Inconsistent if data changes between requests

---

### Cursor-Based Pagination

```http
GET /tasks?limit=20                       # First page
GET /tasks?cursor=eyJpZCI6NDJ9&limit=20  # Next page
```

**Response:**
```json
{
  "data": [...],
  "pagination": {
    "next_cursor": "eyJpZCI6NjJ9",
    "has_more": true
  }
}
```

**Pros:**
- ✅ Consistent even if data changes
- ✅ Better performance for large datasets
- ✅ No "disappeared items" problem

**Cons:**
- ⚠️ Can't jump to arbitrary page
- ⚠️ More complex to implement

---

### Page Number Pagination (Common UI Pattern)

```http
GET /tasks?page=1&per_page=20
GET /tasks?page=2&per_page=20
```

**Response:**
```json
{
  "data": [...],
  "pagination": {
    "total": 156,
    "page": 2,
    "per_page": 20,
    "total_pages": 8,
    "has_next": true,
    "has_previous": true
  }
}
```

**For IIHF Portal:**
Use **page number pagination** for simplicity with small datasets (<100 users, <500 tasks).

---

## Authentication & Authorization

### Authentication Methods

**1. Bearer Token (Recommended for API)**

```http
GET /tasks
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**Use Case:** API clients, mobile apps, SPA

**Implementation with Supabase:**
```javascript
// Client gets token from Supabase Auth
const { data: { session } } = await supabase.auth.getSession()
const token = session.access_token

// Include in API calls
fetch('/api/v1/tasks', {
  headers: {
    'Authorization': `Bearer ${token}`
  }
})
```

**2. Session Cookies (Web Applications)**

```http
GET /tasks
Cookie: session_id=abc123...
```

**Use Case:** Traditional web apps with server-side rendering

---

### Authorization Headers

**Required for Protected Endpoints:**
```http
GET /teams/sweden/documents
Authorization: Bearer <token>
```

**Response if Missing:**
```http
HTTP/1.1 401 Unauthorized
{
  "error": {
    "code": "AUTHENTICATION_REQUIRED",
    "message": "Authentication token required"
  }
}
```

**Response if Invalid Permissions:**
```http
HTTP/1.1 403 Forbidden
{
  "error": {
    "code": "PERMISSION_DENIED",
    "message": "You don't have permission to access Team Sweden's documents"
  }
}
```

---

## Content Negotiation

### Request Headers

```http
POST /tasks
Content-Type: application/json
Accept: application/json

{...}
```

**Content-Type:** What format the request body is in
**Accept:** What format the client wants in response

### Response Headers

```http
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{...}
```

### Common Content Types

- `application/json` - JSON (standard for REST APIs)
- `application/xml` - XML (legacy)
- `multipart/form-data` - File uploads
- `text/html` - HTML (web pages)

---

## Rate Limiting

### Rate Limit Headers

```http
HTTP/1.1 200 OK
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 87
X-RateLimit-Reset: 1707739200
```

### Rate Limit Exceeded Response

```http
HTTP/1.1 429 Too Many Requests
Retry-After: 60

{
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Too many requests. Please try again in 60 seconds.",
    "retry_after": 60
  }
}
```

### Common Rate Limit Strategies

**Per User:**
- 100 requests per minute per user
- 1000 requests per hour per user

**Per IP (Unauthenticated):**
- 10 requests per minute per IP
- Prevents abuse while allowing anonymous usage

**For IIHF Portal:**
Low traffic expected (<100 users) - generous limits like 1000 req/hour per user sufficient.

---

## API Documentation Best Practices

### Endpoint Documentation Template

```markdown
## GET /tasks

Retrieve list of tasks assigned to authenticated user's team.

**Authentication:** Required (Bearer token)

**Query Parameters:**
- `status` (optional, string): Filter by status. Values: `open`, `completed`, `closed`
- `page` (optional, integer): Page number. Default: 1
- `per_page` (optional, integer): Items per page. Default: 20, Max: 100

**Response:** 200 OK
```json
{
  "data": [
    {
      "id": 42,
      "title": "Submit roster",
      "deadline": "2026-04-04",
      "status": "open",
      "assignee": "sweden"
    }
  ],
  "pagination": {...}
}
```

**Errors:**
- `401 Unauthorized`: Missing or invalid authentication
- `403 Forbidden`: User doesn't have permission to view these tasks
```

### Tools for API Documentation

- **OpenAPI/Swagger:** Industry standard, generates interactive docs
- **Postman Collections:** Shareable, executable documentation
- **FastAPI:** Automatic Swagger UI generation
- **Django REST Framework:** Built-in browsable API

---

## For the IIHF Portal Project

### Recommended API Structure

```
# Authentication
POST   /v1/auth/register
POST   /v1/auth/login
POST   /v1/auth/logout
GET    /v1/auth/me

# Users (Admin only)
GET    /v1/users
POST   /v1/users
GET    /v1/users/{id}
PATCH  /v1/users/{id}
DELETE /v1/users/{id}

# Content Management
GET    /v1/pages
POST   /v1/pages
GET    /v1/pages/{id}
PUT    /v1/pages/{id}
DELETE /v1/pages/{id}
PATCH  /v1/pages/{id}/publish

# Team Areas
GET    /v1/teams
GET    /v1/teams/{team_id}/documents
POST   /v1/teams/{team_id}/documents
GET    /v1/teams/{team_id}/documents/{id}
DELETE /v1/teams/{team_id}/documents/{id}

# Tasks
GET    /v1/tasks
POST   /v1/tasks
GET    /v1/tasks/{id}
PATCH  /v1/tasks/{id}
DELETE /v1/tasks/{id}
PATCH  /v1/tasks/{id}/complete
PATCH  /v1/tasks/{id}/close

# Comments
GET    /v1/tasks/{task_id}/comments
POST   /v1/tasks/{task_id}/comments
DELETE /v1/tasks/{task_id}/comments/{id}

# Chat
GET    /v1/chat/messages?team={team_id}
POST   /v1/chat/messages
GET    /v1/chat/messages/unread

# Analytics (Admin)
GET    /v1/analytics/overview
GET    /v1/analytics/completion-rates
GET    /v1/analytics/page-views
```

### Key Design Decisions

✅ **Version from start:** `/v1/` prefix allows future evolution

✅ **Resource-based:** `/tasks`, `/documents`, not `/getTask` or `/createDocument`

✅ **Nested for ownership:** `/teams/{team_id}/documents` makes ownership clear

✅ **Actions as PATCH:** `/tasks/{id}/complete` for state transitions

✅ **Consistent naming:** Plural resources (`/tasks`, not `/task`)

✅ **Pagination on all lists:** Even if small now, grows later

---

**Skill Owner:** Research Agents, Backend Architects, Full-Stack Developers  
**Skill Version:** 1.0  
**Last Updated:** February 12, 2026
