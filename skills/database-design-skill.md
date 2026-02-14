# Database Design & Data Modeling Skill

**Skill Type:** Technical Architecture  
**Purpose:** Design efficient, maintainable database schemas with proper relationships, constraints, and indexing

## Overview

This skill provides frameworks for designing relational database schemas (PostgreSQL/Supabase), modeling entity relationships, implementing data integrity constraints, and optimizing for performance. It covers normalization, denormalization strategies, indexing patterns, and Supabase-specific features like Row Level Security.

## When to Use This Skill

- ✅ Designing database schema for new applications
- ✅ Planning data models and relationships
- ✅ Implementing security policies (Row Level Security)
- ✅ Optimizing query performance
- ✅ Migrating or refactoring existing schemas
- ✅ Evaluating database architecture decisions

## Core Principles

### 1. Data Integrity First
Use constraints, foreign keys, and validation to prevent invalid data at the database level.

### 2. Normalize, Then Denormalize
Start with normalized design (reduce redundancy), then strategically denormalize for performance.

### 3. Security by Design
Build access control into the schema (Row Level Security) rather than relying solely on application code.

### 4. Query for Your Use Case
Design tables for how data will be queried, not just how it's structured conceptually.

### 5. Plan for Scale
Even with <100 users, design for future growth (indexes, partitioning considerations).

---

## Entity-Relationship Modeling

### Step 1: Identify Entities

**Entities are "things" in your system:**

For IIHF Portal:
- **User** - People who access the system
- **Team** - National teams participating
- **Task** - Work items assigned to teams
- **Document** - Files uploaded by teams
- **Page** - Information content created by admins
- **Comment** - Messages on tasks
- **ChatMessage** - Communication between admin and teams

---

### Step 2: Identify Relationships

**Relationship Types:**

**One-to-Many (1:N):**
- One team → many users (team members)
- One team → many documents
- One task → many comments

**Many-to-Many (M:N):**
- Users ↔ Teams (user can be on multiple teams)
- Pages ↔ Teams (page can be visible to multiple teams)

**One-to-One (1:1):**
- User → UserProfile (extended info)

---

### Step 3: Define Attributes

**For Each Entity:**

**User:**
- id (primary key)
- email
- full_name
- role (admin, contributor, reader)
- team_id (foreign key)
- created_at
- updated_at

**Team:**
- id (primary key)
- name
- code (e.g., "sweden")
- created_at

**Task:**
- id (primary key)
- title
- description
- deadline
- status (open, completed, closed)
- team_id (foreign key)
- created_by (foreign key to user)
- completed_at
- closed_at
- created_at
- updated_at

---

## Schema Design Patterns

### Pattern 1: User & Roles

#### Option A: Role as Enum (Simple)

```sql
CREATE TYPE user_role AS ENUM ('admin', 'contributor', 'reader');

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    role user_role NOT NULL DEFAULT 'reader',
    team_id UUID REFERENCES teams(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

**Pros:**
- ✅ Simple
- ✅ Fast (no joins)
- ✅ Type-safe with enums

**Cons:**
- ⚠️ Hard to add role-specific attributes
- ⚠️ Can't assign multiple roles to one user

**Use When:** Fixed set of roles, simple permission model (IIHF Portal case)

---

#### Option B: Separate Roles Table (Complex)

```sql
CREATE TABLE roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) UNIQUE NOT NULL,
    permissions JSONB
);

CREATE TABLE user_roles (
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    role_id UUID REFERENCES roles(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, role_id)
);
```

**Pros:**
- ✅ Flexible (multiple roles per user)
- ✅ Dynamic role definition
- ✅ Can store role-specific permissions

**Cons:**
- ⚠️ More complex queries
- ⚠️ Overkill for simple apps

**Use When:** Complex permission systems, dynamic roles

---

### Pattern 2: Soft Delete vs Hard Delete

#### Hard Delete (Permanent)

```sql
DELETE FROM tasks WHERE id = '123';
```

**Pros:**
- ✅ Simple
- ✅ Frees up storage
- ✅ GDPR right to be forgotten

**Cons:**
- ⚠️ Data loss
- ⚠️ Can't recover or audit

---

#### Soft Delete (Archived)

```sql
CREATE TABLE tasks (
    id UUID PRIMARY KEY,
    title TEXT NOT NULL,
    deleted_at TIMESTAMPTZ,  -- NULL = active, value = deleted
    ...
);

-- Soft delete
UPDATE tasks SET deleted_at = NOW() WHERE id = '123';

-- Query active tasks
SELECT * FROM tasks WHERE deleted_at IS NULL;

-- Restore
UPDATE tasks SET deleted_at = NULL WHERE id = '123';
```

**Pros:**
- ✅ Recoverable
- ✅ Audit trail
- ✅ Maintain referential integrity

**Cons:**
- ⚠️ Storage overhead
- ⚠️ Must filter deleted records in queries
- ⚠️ Complicates unique constraints

**For IIHF Portal:**
- **Soft delete** for tasks and documents (retain history)
- **Hard delete** for users upon request (GDPR compliance)

---

### Pattern 3: Audit Trail

```sql
CREATE TABLE tasks (
    id UUID PRIMARY KEY,
    title TEXT NOT NULL,
    status VARCHAR(20),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID REFERENCES users(id),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by UUID REFERENCES users(id),
    ...
);

-- Trigger to auto-update updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_updated_at
BEFORE UPDATE ON tasks
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();
```

**Track:**
- created_at / created_by
- updated_at / updated_by
- deleted_at / deleted_by (if soft delete)

---

### Pattern 4: Timestamps (Best Practices)

```sql
CREATE TABLE tasks (
    id UUID PRIMARY KEY,
    ...
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

**Use TIMESTAMPTZ, not TIMESTAMP:**
- Stores timezone information
- Converts to UTC automatically
- Critical for international applications

**Always Include:**
- `created_at` on every table (when created)
- `updated_at` on tables that change (when last modified)

---

## Data Types & Constraints

### PostgreSQL Data Types

| Data Type | Use Case | Example |
|-----------|----------|---------|
| **UUID** | Primary keys, foreign keys | `gen_random_uuid()` |
| **VARCHAR(n)** | Text with max length | `VARCHAR(255)` for emails |
| **TEXT** | Unlimited text | Descriptions, content |
| **INTEGER** | Whole numbers | Count, age |
| **BIGINT** | Large whole numbers | IDs if high volume |
| **NUMERIC(p,s)** | Precise decimals | Money, percentages |
| **BOOLEAN** | True/false | `is_published`, `is_active` |
| **TIMESTAMPTZ** | Date + time + timezone | `created_at`, `deadline` |
| **DATE** | Date only | `birthdate`, `event_date` |
| **JSONB** | Flexible structured data | Settings, metadata |
| **ENUM** | Fixed set of values | Status, role |

---

### Constraints

#### Primary Key

```sql
CREATE TABLE teams (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ...
);
```

**Always define explicitly**

---

#### Foreign Key

```sql
CREATE TABLE documents (
    id UUID PRIMARY KEY,
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    ...
);
```

**ON DELETE Actions:**
- `CASCADE` - Delete related records (documents deleted when team deleted)
- `SET NULL` - Set to NULL (user.team_id = NULL when team deleted)
- `RESTRICT` - Prevent deletion if related records exist
- `NO ACTION` - Same as RESTRICT

**For IIHF Portal:**
- Documents → Team: `CASCADE` (team documents should be deleted with team)
- Tasks → Team: `CASCADE` (team tasks deleted with team)
- User → Team: `SET NULL` (user can exist without team)

---

#### Unique Constraint

```sql
CREATE TABLE users (
    id UUID PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    ...
);

-- Or composite unique
CREATE TABLE user_roles (
    user_id UUID,
    role_id UUID,
    PRIMARY KEY (user_id, role_id)  -- Composite primary = unique combination
);
```

---

#### Not Null Constraint

```sql
CREATE TABLE tasks (
    id UUID PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,  -- Optional, can be NULL
    deadline DATE NOT NULL,
    ...
);
```

**Use NOT NULL for required fields**

---

#### Check Constraint

```sql
CREATE TABLE tasks (
    id UUID PRIMARY KEY,
    title TEXT NOT NULL,
    status VARCHAR(20) CHECK (status IN ('open', 'completed', 'closed')),
    deadline DATE CHECK (deadline >= CURRENT_DATE),
    ...
);
```

**Validate data at database level**

---

## Indexing for Performance

### When to Index

✅ **Always index:**
- Primary keys (automatic)
- Foreign keys
- Columns used in WHERE clauses frequently
- Columns used in JOIN conditions
- Columns used in ORDER BY

⚠️ **Consider indexing:**
- Columns used in GROUP BY
- Columns with high selectivity (many unique values)

❌ **Don't index:**
- Small tables (<1000 rows)
- Columns with low selectivity (few unique values like boolean)
- Columns rarely queried
- Frequently updated columns (indexes slow writes)

---

### Index Types

#### B-Tree Index (Default)

```sql
CREATE INDEX idx_tasks_deadline ON tasks(deadline);
CREATE INDEX idx_documents_team_id ON documents(team_id);
```

**Use for:**
- Equality comparisons (`WHERE team_id = '...'`)
- Range queries (`WHERE deadline > '2026-04-01'`)
- Sorting (`ORDER BY deadline`)

---

#### Composite Index

```sql
-- Index on multiple columns
CREATE INDEX idx_tasks_team_status ON tasks(team_id, status);
```

**Useful for queries like:**
```sql
SELECT * FROM tasks WHERE team_id = 'sweden' AND status = 'open';
```

**Column order matters:**
- Most selective column first
- Columns used together in WHERE clauses

---

#### Partial Index

```sql
-- Index only active tasks
CREATE INDEX idx_active_tasks ON tasks(deadline) 
WHERE deleted_at IS NULL;
```

**Benefits:**
- Smaller index size
- Faster queries on subset
- Less maintenance

---

#### Full-Text Search Index

```sql
-- For searching page content
CREATE INDEX idx_pages_content_search ON pages 
USING gin(to_tsvector('english', content));

-- Query
SELECT * FROM pages 
WHERE to_tsvector('english', content) @@ to_tsquery('roster & deadline');
```

**Use for:** Search functionality across text fields

---

### For IIHF Portal

```sql
-- Foreign keys (most important)
CREATE INDEX idx_documents_team_id ON documents(team_id);
CREATE INDEX idx_tasks_team_id ON tasks(team_id);
CREATE INDEX idx_tasks_created_by ON tasks(created_by);
CREATE INDEX idx_comments_task_id ON comments(task_id);

-- Query optimization
CREATE INDEX idx_tasks_deadline ON tasks(deadline);
CREATE INDEX idx_tasks_status ON tasks(status);
CREATE INDEX idx_chat_messages_team ON chat_messages(team_id, created_at);

-- Composite for common queries
CREATE INDEX idx_tasks_team_status ON tasks(team_id, status);

-- Partial for active records
CREATE INDEX idx_active_tasks ON tasks(deadline) 
WHERE deleted_at IS NULL;
```

---

## Normalization

### Normal Forms

#### 1NF (First Normal Form)
**Rule:** Atomic values only (no arrays or lists in cells)

❌ **Violation:**
```
| user_id | email | teams |
|---------|-------|-------|
| 1 | user@example.com | sweden, denmark |
```

✅ **Fixed:**
```
| user_id | email | team |
|---------|-------|------|
| 1 | user@example.com | sweden |
| 1 | user@example.com | denmark |
```

Or use junction table (M:N relationship).

---

#### 2NF (Second Normal Form)
**Rule:** No partial dependencies (all non-key columns depend on entire primary key)

❌ **Violation:**
```
CREATE TABLE task_assignments (
    task_id UUID,
    user_id UUID,
    task_title TEXT,  -- Depends only on task_id, not (task_id, user_id)
    PRIMARY KEY (task_id, user_id)
);
```

✅ **Fixed:** Move `task_title` to `tasks` table

---

#### 3NF (Third Normal Form)
**Rule:** No transitive dependencies (non-key columns depend only on primary key, not on other non-key columns)

❌ **Violation:**
```
CREATE TABLE users (
    id UUID PRIMARY KEY,
    team_id UUID,
    team_name TEXT  -- Depends on team_id, not directly on user id
);
```

✅ **Fixed:** Remove `team_name`, join to `teams` table when needed

---

### When to Denormalize

Sometimes breaking normalization improves performance:

**Example: Storing computed values**
```sql
CREATE TABLE teams (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    task_count INTEGER DEFAULT 0,  -- Denormalized count
    completed_task_count INTEGER DEFAULT 0  -- Denormalized count
);

-- Update counts with trigger
CREATE TRIGGER update_team_task_counts
AFTER INSERT OR UPDATE OR DELETE ON tasks
FOR EACH ROW
EXECUTE FUNCTION recalculate_team_task_counts();
```

**When to denormalize:**
- Expensive joins are common
- Read-heavy workload
- Computed values used frequently
- Acceptable to have slightly stale data

**Maintain with triggers or scheduled jobs**

---

## Row Level Security (RLS) - Supabase

### Enable RLS

```sql
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;
```

**Once enabled, NO ONE can access data without policies**

---

### Policy Patterns

#### Pattern 1: Simple Role-Based Access

```sql
-- Admins can see all documents
CREATE POLICY admin_all_documents ON documents
FOR ALL
TO authenticated
USING (
    auth.jwt() ->> 'role' = 'admin'
);

-- Contributors can see their own team's documents
CREATE POLICY contributor_own_team_documents ON documents
FOR SELECT
TO authenticated
USING (
    team_id = (auth.jwt() ->> 'team_id')::uuid
    AND auth.jwt() ->> 'role' IN ('contributor', 'admin')
);
```

---

#### Pattern 2: Owner-Based Access

```sql
-- Users can view their own profile
CREATE POLICY users_view_own ON users
FOR SELECT
TO authenticated
USING (id = auth.uid());

-- Users can update their own profile
CREATE POLICY users_update_own ON users
FOR UPDATE
TO authenticated
USING (id = auth.uid())
WITH CHECK (id = auth.uid());
```

---

#### Pattern 3: Team Isolation

```sql
-- Team contributors can upload documents to their team only
CREATE POLICY team_upload_documents ON documents
FOR INSERT
TO authenticated
WITH CHECK (
    team_id = (auth.jwt() ->> 'team_id')::uuid
    AND auth.jwt() ->> 'role' = 'contributor'
);

-- Team contributors can view their team's tasks
CREATE POLICY team_view_tasks ON tasks
FOR SELECT
TO authenticated
USING (
    team_id = (auth.jwt() ->> 'team_id')::uuid
    OR auth.jwt() ->> 'role' = 'admin'
);
```

---

#### Pattern 4: Time-Based Access

```sql
-- Tasks visible only before deletion
CREATE POLICY view_active_tasks ON tasks
FOR SELECT
TO authenticated
USING (deleted_at IS NULL);
```

---

### RLS Best Practices

✅ **Enable on all tables with sensitive data**

✅ **Test policies thoroughly:**
```sql
-- Test as different users
SET LOCAL role TO authenticated;
SET LOCAL request.jwt.claims TO '{"role": "contributor", "team_id": "..."}';
SELECT * FROM documents;  -- Should only see team documents
```

✅ **Use policy names that describe purpose:**
- `admin_full_access`
- `contributor_team_only`
- `reader_public_pages`

✅ **Combine policies with OR logic:**
Multiple policies on same table = rows matching ANY policy are accessible

⚠️ **Performance consideration:**
RLS adds overhead to queries. Use indexes on policy columns.

---

## Schema for IIHF Portal

### Core Tables

```sql
-- Teams
CREATE TABLE teams (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    code VARCHAR(20) UNIQUE NOT NULL,  -- 'sweden', 'denmark'
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Users
CREATE TYPE user_role AS ENUM ('admin', 'contributor', 'reader');

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    role user_role NOT NULL DEFAULT 'reader',
    team_id UUID REFERENCES teams(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_team_id ON users(team_id);
CREATE INDEX idx_users_role ON users(role);

-- Pages (CMS content)
CREATE TYPE content_state AS ENUM ('draft', 'published', 'archived');

CREATE TABLE pages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    content TEXT,
    state content_state NOT NULL DEFAULT 'draft',
    menu_group VARCHAR(100),
    menu_order INTEGER DEFAULT 0,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_pages_slug ON pages(slug);
CREATE INDEX idx_pages_state ON pages(state);
CREATE INDEX idx_pages_menu_group ON pages(menu_group);

-- Documents
CREATE TABLE documents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    filename VARCHAR(255) NOT NULL,
    file_path TEXT NOT NULL,  -- Supabase Storage path
    file_size INTEGER NOT NULL,
    mime_type VARCHAR(100) NOT NULL,
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    uploaded_by UUID NOT NULL REFERENCES users(id),
    uploaded_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_documents_team_id ON documents(team_id);
CREATE INDEX idx_documents_uploaded_by ON documents(uploaded_by);

-- Tasks
CREATE TYPE task_status AS ENUM ('open', 'completed', 'closed');

CREATE TABLE tasks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    deadline DATE NOT NULL,
    status task_status NOT NULL DEFAULT 'open',
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    created_by UUID NOT NULL REFERENCES users(id),
    completed_at TIMESTAMPTZ,
    completed_by UUID REFERENCES users(id),
    closed_at TIMESTAMPTZ,
    closed_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_tasks_team_id ON tasks(team_id);
CREATE INDEX idx_tasks_status ON tasks(status);
CREATE INDEX idx_tasks_deadline ON tasks(deadline);
CREATE INDEX idx_tasks_team_status ON tasks(team_id, status);
CREATE INDEX idx_active_tasks ON tasks(deadline) WHERE deleted_at IS NULL;

-- Comments
CREATE TABLE comments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    task_id UUID NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_by UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_comments_task_id ON comments(task_id);

-- Chat Messages
CREATE TABLE chat_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    sender_id UUID NOT NULL REFERENCES users(id),
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_chat_messages_team_created ON chat_messages(team_id, created_at);
```

---

## Migrations Best Practices

### Version Control Schema Changes

```sql
-- migrations/001_create_users.sql
CREATE TABLE users (...);

-- migrations/002_add_user_role.sql
ALTER TABLE users ADD COLUMN role user_role DEFAULT 'reader';

-- migrations/003_create_tasks.sql
CREATE TABLE tasks (...);
```

**Tools:**
- Flyway
- Liquibase
- Django migrations
- Alembic (Python)
- Supabase migrations (built-in)

---

### Safe Migration Patterns

✅ **Adding columns (non-breaking):**
```sql
ALTER TABLE users ADD COLUMN phone VARCHAR(20);
```

✅ **Adding indexes (non-breaking):**
```sql
CREATE INDEX CONCURRENTLY idx_tasks_status ON tasks(status);
```
**Use CONCURRENTLY to avoid locking table**

⚠️ **Renaming columns (breaking):**
```sql
-- Step 1: Add new column
ALTER TABLE users ADD COLUMN full_name VARCHAR(255);

-- Step 2: Backfill data
UPDATE users SET full_name = name;

-- Step 3: Update application to use full_name

-- Step 4: Drop old column (later migration)
ALTER TABLE users DROP COLUMN name;
```

⚠️ **Changing column types (potentially breaking):**
```sql
-- Safe if no data loss
ALTER TABLE users ALTER COLUMN email TYPE VARCHAR(320);

-- Unsafe if data might not fit
ALTER TABLE users ALTER COLUMN age TYPE SMALLINT;  -- Could fail
```

---

**Skill Owner:** Research Agents, Backend Architects, Database Administrators  
**Skill Version:** 1.0  
**Last Updated:** February 12, 2026
