# Technical Synthesis Skill

**Skill Type:** Technical Analysis  
**Purpose:** Extract, interpret, and synthesize information from technical documentation, API specs, and framework documentation

## Overview

The Technical Synthesis Skill enables agents to efficiently navigate technical documentation, understand API specifications, interpret changelogs, and extract key capabilities from framework docs. This skill transforms dense technical material into actionable insights for architecture and implementation decisions.

## When to Use This Skill

- ✅ Reading framework or library documentation
- ✅ Understanding API specifications
- ✅ Analyzing technical capabilities of platforms
- ✅ Interpreting changelogs and release notes
- ✅ Evaluating technical constraints and limitations
- ✅ Assessing integration possibilities

## Core Principles

### 1. Focus on Capabilities, Not Features
Look for what the technology enables, not just what it includes.

### 2. Identify Constraints Early
Limitations are often more important than capabilities for architectural decisions.

### 3. Version Matters
Documentation version must match target implementation version.

### 4. Examples Over Theory
Code examples reveal more than conceptual descriptions.

### 5. Community Signals
GitHub activity, Stack Overflow presence, and ecosystem indicate health.

## Documentation Navigation Strategy

### Quick Assessment (5 Minutes)

**Step 1: Overview Scan**
- Read homepage/introduction
- Check "Features" or "Capabilities" section
- Note stated use cases
- Identify what problem it solves

**Step 2: Architecture Check**
- Look for architecture diagrams
- Understand component relationships
- Identify dependencies
- Note supported platforms

**Step 3: Quick Start Evaluation**
- How complex is "Hello World"?
- What's the setup process?
- Are examples clear and working?
- Are prerequisites reasonable?

**Outputs:**
- Core purpose and capabilities
- Target use cases
- Setup complexity
- First impression of documentation quality

---

### Deep Dive (20-30 Minutes)

**Step 4: Capability Catalog**
- List major features/modules
- Understand data flow
- Identify integration points
- Note extension mechanisms

**Step 5: Constraints Discovery**
- Check limits (scale, concurrency, data size)
- Identify platform requirements
- Note breaking changes or known issues
- Review migration guides

**Step 6: Community Assessment**
- Check GitHub: stars, issues, recent commits
- Stack Overflow: question volume, answer quality
- Active/abandoned signals
- Corporate backing or community-driven?

**Outputs:**
- Comprehensive capability list
- Known limitations and constraints
- Community health assessment
- Integration possibilities

---

## Reading API Documentation

### REST API Documentation Structure

**Essential Sections:**

1. **Authentication**
   - Method (API key, OAuth, JWT)
   - Where to include (header, query param)
   - How to obtain credentials
   - Token refresh mechanism

2. **Base URL & Versioning**
   - Production vs. sandbox endpoints
   - API version strategy (path vs. header)
   - Backwards compatibility policy

3. **Endpoint Catalog**
   - HTTP methods (GET, POST, PUT, DELETE)
   - Resource paths
   - Required vs. optional parameters
   - Request/response formats

4. **Rate Limits**
   - Requests per time period
   - Throttling behavior
   - How limits are communicated (headers)

5. **Error Handling**
   - Error code structure
   - Common error scenarios
   - Retry strategies

**Reading Pattern:**

```markdown
## Endpoint: Create Task

### What to Extract:

**Request:**
- Method: POST
- Path: /api/v1/tasks
- Headers: Authorization, Content-Type
- Body schema: { title, description, deadline, assignee }
- Required fields: title, assignee

**Response:**
- Success: 201 Created
- Body: { id, title, description, deadline, assignee, created_at, status }
- Error codes: 400 (validation), 401 (auth), 429 (rate limit)

**Rate Limit:** 100 requests/minute

**Key Insight:** 
Tasks require assignee (can't be unassigned) - important for workflow

**Example cURL:**
```bash
curl -X POST https://api.example.com/v1/tasks \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"title":"Test task", "assignee":"user123"}'
```

**Integration Consideration:**
- Need user ID before creating task
- Consider batch creation if creating many tasks
```

---

### API Documentation Red Flags

⚠️ **Warning Signs:**
- No version information visible
- Examples that don't work (outdated)
- Missing error documentation
- No rate limit information
- Authentication section unclear
- Last updated > 1 year ago (for active service)
- Broken links or missing content

✅ **Good Signs:**
- Interactive API explorer (Swagger, Postman collections)
- Code samples in multiple languages
- Detailed error documentation
- Changelog showing active development
- Clear versioning strategy
- Webhook documentation (for event-driven integration)

---

## Framework Documentation Patterns

### What to Extract from Framework Docs

#### 1. **Core Architecture**

**Questions:**
- Is it MVC, MVVM, component-based, other?
- How does data flow through the system?
- What's the folder structure convention?
- How are dependencies managed?

**Example: FastAPI**
```markdown
**Architecture:**
- ASGI-based (async by default)
- Route decorators define endpoints
- Pydantic models for validation
- Dependency injection via function parameters

**Data Flow:**
Request → Route → Dependencies → Handler → Pydantic Model → Response

**Project Structure:**
```
app/
  main.py          # Application entry
  routers/         # Route handlers
  models/          # Pydantic models
  dependencies.py  # Shared dependencies
```

**Key Insight:** Async-first means easier concurrency but requires async database drivers
```

---

#### 2. **Integration Patterns**

**Questions:**
- How does it connect to databases?
- What ORMs or query builders are recommended?
- How are external APIs called?
- What authentication mechanisms are supported?

**Example: Django + Supabase**
```markdown
**Database Integration:**
- Django ORM native support for PostgreSQL
- Supabase IS PostgreSQL, so full compatibility
- Connection via DATABASE_URL in settings

**Authentication Options:**
1. Django built-in (User model, sessions)
2. Custom backend for Supabase Auth
3. Hybrid: Supabase for client, Django for API

**Key Insight:** 
Can use Django ORM with Supabase database, but Supabase Auth requires custom integration

**Code Pattern:**
```python
# settings.py
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'postgres',
        'USER': 'postgres',
        'PASSWORD': SUPABASE_PASSWORD,
        'HOST': SUPABASE_HOST,
        'PORT': '5432',
    }
}
```
```

---

#### 3. **Extension Mechanisms**

**Questions:**
- How do I add custom functionality?
- What's the plugin/middleware architecture?
- Can I override default behavior?
- What hooks or events are available?

**Example: Django Middleware**
```markdown
**Extension Points:**
- Middleware: Process requests/responses globally
- Signals: React to model events (pre_save, post_save)
- Custom management commands: CLI tooling
- Admin customization: ModelAdmin classes

**Use Case: Add request logging**
```python
class RequestLoggingMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response
    
    def __call__(self, request):
        # Log before request
        logger.info(f"{request.method} {request.path}")
        response = self.get_response(request)
        # Log after request
        logger.info(f"Status: {response.status_code}")
        return response
```

**Key Insight:** 
Middleware enables cross-cutting concerns (auth, logging, caching) without modifying views
```

---

#### 4. **Performance Characteristics**

**Questions:**
- What's the typical throughput?
- Where are the bottlenecks?
- What caching strategies are available?
- How does it scale?

**What to Look For:**
- Benchmark results (if provided)
- Async/concurrency model
- Connection pooling
- Caching integrations
- Static file serving recommendations

**Example Synthesis:**
```markdown
**Performance Profile:**
- Single-threaded throughput: 2,000 req/sec
- Async throughput: 10,000 req/sec
- Bottleneck typically: Database queries

**Optimization Strategies Documented:**
1. Query optimization (select_related, prefetch_related)
2. Caching (Redis integration)
3. Connection pooling (pgBouncer recommended)
4. Static files via CDN

**Scaling Approach:**
- Horizontal: Load balancer + multiple app servers
- Database: Read replicas for queries
- Caching: Redis cluster

**Key Insight:**
Framework designed for vertical scaling first, horizontal scaling requires additional orchestration
```

---

## Changelog Interpretation

### Reading Release Notes

**Priority Information:**

1. **Breaking Changes** 🔴
   - Requires code changes to upgrade
   - API changes
   - Deprecated features removed
   - Configuration changes

2. **Security Fixes** 🔒
   - Upgrade urgency
   - Vulnerability details
   - Affected versions

3. **New Features** ✨
   - Capabilities added
   - New APIs or modules
   - Performance improvements

4. **Bug Fixes** 🐛
   - What was broken
   - What's now fixed
   - Workarounds no longer needed

5. **Deprecations** ⚠️
   - What will be removed in future
   - Migration path
   - Timeline for removal

**Example Changelog Synthesis:**

```markdown
## Django 5.0 Release Notes Summary

**Breaking Changes:**
- Dropped Python 3.8 and 3.9 support (now requires 3.10+)
- Removed deprecated `django.utils.http.urlquote()` (use `urllib.parse.quote()`)
- Changed default database backend behavior for JSON fields

**Key New Features:**
- ✨ Async ORM queries now support more operations
- ✨ Improved database connection management
- ✨ New form validation helpers

**Security:**
- Fixed CVE-2023-XXXX (SQL injection via JSONField)
- Severity: Medium
- Upgrade recommended for all production deployments

**Migration Path:**
1. Upgrade Python to 3.10+ first
2. Replace deprecated `urlquote` usages
3. Test JSON field queries (behavior changed)
4. Update Django: `pip install Django==5.0`

**Impact Assessment for Our Project:**
- ✅ Already using Python 3.11 (no blocker)
- ⚠️ Need to check for `urlquote` usage (search codebase)
- ⚠️ Test JSON field queries if we use them
- ✅ Security fix is low urgency for us (don't use affected feature)
- 🎯 Recommendation: Upgrade during next maintenance window

**Relevant for Research:**
- New async ORM features may benefit real-time requirements
- Improved connection management helps with Supabase pooling
```

---

## Technical Constraint Discovery

### Limits to Always Check

**Scale Limits:**
- Maximum concurrent connections
- Maximum request size
- Maximum response size
- Maximum database size
- Rate limits (requests per second/minute/hour)
- Quota limits (free tier vs. paid)

**Platform Constraints:**
- Supported operating systems
- Minimum/recommended hardware
- Required dependencies
- Network requirements
- Browser support (for web frameworks)

**Operational Constraints:**
- Backup/restore capabilities
- Monitoring/observability options
- Deployment requirements
- Update/migration process complexity

**Example: Supabase Constraints (from Documentation)**

```markdown
## Supabase Limits

**Free Tier:**
- Database: 500 MB
- Bandwidth: 2 GB/month
- API requests: Unlimited
- Auth users: 50,000
- Storage: 1 GB
- Edge functions: 500K invocations/month

**Pro Tier ($25/month):**
- Database: 8 GB included ($0.125/GB additional)
- Bandwidth: 250 GB/month
- All other limits significantly higher

**Hard Limits (All Tiers):**
- Max row size: 1 GB (PostgreSQL limit)
- Max file upload: 5 GB (Storage)
- Connection pooling: IPv4 only

**Operational:**
- Automatic backups: Daily (retained 7 days free, 30 days pro)
- Point-in-time recovery: Pro tier only
- Pausing: Free tier projects pause after 1 week inactivity

**Impact on Project:**
- ✅ 500 MB database sufficient for MVP (<100 users, document storage via Storage)
- ✅ 50K auth users far exceeds need (<100 users)
- ⚠️ 1 GB storage may be tight if many documents (monitor usage)
- ⚠️ Free tier project will pause if no activity (document this)
- 🎯 Start with free tier, upgrade to Pro at launch if needed (~$25 cost)
```

---

## Code Example Analysis

### What Good Examples Reveal

**Structure Patterns:**
- File organization
- Import patterns
- Naming conventions
- Error handling approach

**Configuration Patterns:**
- Environment variables
- Settings management
- Secrets handling

**Best Practices:**
- Security measures
- Input validation
- Resource cleanup
- Logging approach

**Example: Analyzing Supabase Python Client Example**

```python
from supabase import create_client, Client

url: str = os.environ.get("SUPABASE_URL")
key: str = os.environ.get("SUPABASE_KEY")
supabase: Client = create_client(url, key)

# Insert
data = supabase.table("tasks").insert({"title": "New task"}).execute()

# Query
tasks = supabase.table("tasks").select("*").eq("status", "open").execute()
```

**Extracted Patterns:**

```markdown
**Connection:**
- Environment variables for credentials (secure) ✅
- Single client instance can be reused
- Type hints used (good practice)

**API Style:**
- Chainable query builder (.table().select().eq())
- Always ends with .execute()
- Returns object with .data property

**Error Handling:**
- Example doesn't show error handling (check docs for exceptions)
- Need to add try/except in production

**Integration Pattern:**
```python
# Derived best practice
class SupabaseService:
    def __init__(self):
        self.client = create_client(
            os.getenv("SUPABASE_URL"),
            os.getenv("SUPABASE_KEY")
        )
    
    def create_task(self, task_data):
        try:
            result = self.client.table("tasks").insert(task_data).execute()
            return result.data
        except Exception as e:
            logger.error(f"Task creation failed: {e}")
            raise
```

**Key Insights:**
- Simple, intuitive API
- Minimal boilerplate
- Credentials via environment (secure)
- Need to add error handling (not in example)
```

---

## Community Health Indicators

### GitHub Analysis

**Repository Metrics:**

**Stars:**
- 10K+: Very popular
- 1K-10K: Healthy community
- <1K: Niche or new

**Activity:**
- Daily commits: Very active
- Weekly commits: Active
- Monthly commits: Stable
- No commits >3 months: Potentially abandoned

**Issues:**
- Open issues: >100 (check if being addressed)
- Issue close rate: >70% good sign
- Issue response time: <48 hours good
- Stale issues: >6 months old is red flag

**Pull Requests:**
- Contributor count: >10 active is healthy
- PR review speed: <1 week good
- Merged PR rate: >50% indicates healthy contribution

**Releases:**
- Regular releases (quarterly or more)
- Semantic versioning used
- Clear changelog

**Example: FastAPI GitHub Assessment**

```markdown
## FastAPI Community Health

**Metrics (as of check date):**
- ⭐ Stars: 67K (very popular)
- 🍴 Forks: 5.8K
- 👀 Watchers: 650
- 🐛 Open issues: 1.7K
- ✅ Closed issues: 6.4K (79% close rate)
- 🔄 Open PRs: 150
- ✅ Merged PRs: High merge rate

**Activity:**
- Last commit: 2 days ago (very active)
- Release frequency: Monthly
- Contributors: 500+

**Signals:**
- ✅ Very active development
- ✅ High community engagement
- ✅ Good issue management
- ✅ Corporate backing (multiple companies use in production)
- ⚠️ High issue count (sign of popularity AND complexity)

**Conclusion:** 
Mature, actively maintained, production-ready. Large community increases likelihood of finding solutions to problems.
```

---

### Stack Overflow Presence

**Search Pattern:**
`[technology-name] site:stackoverflow.com`

**What to Check:**
- Total questions: Indicates adoption
- Question freshness: Recent questions = active use
- Answer quality: Are questions getting answered?
- View counts: Popular questions have 10K+ views

**Red Flags:**
- No questions in last 6 months (abandoned?)
- Questions without answers
- Low view counts (not widely adopted)

**Green Flags:**
- Active questions (last 30 days)
- High answer rates
- Detailed, upvoted answers
- Official support participation

---

## Quick Reference

### Technical Documentation Checklist

When researching a technology:

**Initial Assessment:**
- [ ] Read overview/introduction
- [ ] Check supported versions/platforms
- [ ] Review quick start guide
- [ ] Scan feature list

**Capabilities:**
- [ ] List core features
- [ ] Understand architecture/data flow
- [ ] Identify integration points
- [ ] Note extension mechanisms

**Constraints:**
- [ ] Document scale limits
- [ ] Identify platform requirements
- [ ] Note breaking changes in recent releases
- [ ] Check deprecation warnings

**Community:**
- [ ] Check GitHub activity (commits, issues, PRs)
- [ ] Assess Stack Overflow presence
- [ ] Note corporate backing or community-driven
- [ ] Review security/vulnerability history

**Documentation Quality:**
- [ ] Are examples clear and working?
- [ ] Is error handling documented?
- [ ] Are best practices covered?
- [ ] Is versioning clear?

**Integration Research:**
- [ ] API authentication method
- [ ] Rate limits and quotas
- [ ] Supported integration patterns
- [ ] Available client libraries/SDKs

---

**Skill Owner:** Research Agents, Architects  
**Skill Version:** 1.0  
**Last Updated:** February 12, 2026
