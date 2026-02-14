# Authentication & Authorization Skill

**Skill Type:** Security & Access Control  
**Purpose:** Implement secure authentication and role-based authorization systems

## Overview

This skill covers authentication (verifying identity), authorization (controlling access), session management, OAuth 2.0 social login, JWT tokens, and Supabase Auth integration. It provides patterns for implementing secure, scalable access control in web applications.

## When to Use This Skill

- ✅ Implementing user login and registration
- ✅ Integrating social login (Google, Microsoft, GitHub)
- ✅ Designing role-based access control (RBAC)
- ✅ Securing API endpoints
- ✅ Managing user sessions
- ✅ Implementing password policies
- ✅ Planning multi-factor authentication

## Core Principles

### 1. Authentication ≠ Authorization
**Authentication:** Who are you? (Identity verification)  
**Authorization:** What can you do? (Permission checking)

### 2. Never Trust, Always Verify
Validate every request. Don't rely on client-side checks alone.

### 3. Defense in Depth
Multiple layers of security. If one fails, others protect.

### 4. Principle of Least Privilege
Users should have minimum permissions needed to do their job.

### 5. Secure by Default
Require authentication by default. Explicitly mark public endpoints.

---

## Authentication Methods

### 1. Email + Password (Basic)

**Registration Flow:**
```
User submits email + password
  ↓
Validate email format & password strength
  ↓
Hash password (bcrypt, argon2)
  ↓
Store user record with hashed password
  ↓
Send verification email (optional)
```

**Login Flow:**
```
User submits email + password
  ↓
Look up user by email
  ↓
Compare submitted password with hashed password
  ↓
If match: Generate session/token
  ↓
Return session identifier to client
```

**With Supabase:**
```javascript
// Register
const { data, error } = await supabase.auth.signUp({
  email: 'user@example.com',
  password: 'SecurePassword123!',
  options: {
    data: {
      full_name: 'John Doe',
      role: 'contributor'
    }
  }
})

// Login
const { data, error } = await supabase.auth.signInWithPassword({
  email: 'user@example.com',
  password: 'SecurePassword123!'
})

// Get session
const { data: { session } } = await supabase.auth.getSession()
const token = session.access_token
```

---

### 2. OAuth 2.0 (Social Login)

**Supported Providers:**
- Google
- Microsoft/Azure AD
- GitHub
- Apple
- Facebook
- Others (configurable)

**OAuth Flow (Authorization Code):**
```
1. User clicks "Login with Google"
   ↓
2. Redirect to Google with client_id & redirect_uri
   ↓
3. User authenticates with Google
   ↓
4. Google redirects back with authorization code
   ↓
5. Exchange code for access token
   ↓
6. Use token to fetch user info from Google
   ↓
7. Create/update user record in database
   ↓
8. Issue session token to user
```

**With Supabase (Simplified):**
```javascript
// Google login
const { data, error } = await supabase.auth.signInWithOAuth({
  provider: 'google',
  options: {
    redirectTo: 'https://yourapp.com/auth/callback'
  }
})

// Microsoft login
const { data, error } = await supabase.auth.signInWithOAuth({
  provider: 'azure',
  options: {
    scopes: 'email profile'
  }
})
```

**Configuration Required:**
- Register OAuth app with provider (Google Cloud Console, Azure Portal)
- Get client_id and client_secret
- Configure redirect URIs (whitelist)
- Add credentials to Supabase dashboard

---

### 3. Magic Links (Passwordless)

**How It Works:**
```
1. User enters email
   ↓
2. System generates unique token
   ↓
3. Send email with login link containing token
   ↓
4. User clicks link
   ↓
5. Verify token is valid and not expired
   ↓
6. Authenticate user, create session
```

**With Supabase:**
```javascript
// Send magic link
const { data, error } = await supabase.auth.signInWithOtp({
  email: 'user@example.com',
  options: {
    emailRedirectTo: 'https://yourapp.com/auth/callback'
  }
})

// User clicks link and is redirected with token
// Supabase automatically exchanges token for session
```

**Pros:**
- ✅ No password to remember
- ✅ No password storage/hashing
- ✅ Phishing-resistant

**Cons:**
- ⚠️ Requires email access
- ⚠️ Slower than password login
- ⚠️ Email deliverability issues

---

## Password Security

### Password Strength Requirements

**Minimum Requirements:**
- 8+ characters
- At least 1 uppercase letter
- At least 1 lowercase letter
- At least 1 number
- At least 1 special character

**Regex Example:**
```python
import re

def validate_password(password):
    if len(password) < 8:
        return False, "Password must be at least 8 characters"
    
    if not re.search(r'[A-Z]', password):
        return False, "Password must contain uppercase letter"
    
    if not re.search(r'[a-z]', password):
        return False, "Password must contain lowercase letter"
    
    if not re.search(r'\d', password):
        return False, "Password must contain number"
    
    if not re.search(r'[!@#$%^&*(),.?":{}|<>]', password):
        return False, "Password must contain special character"
    
    return True, "Password is valid"
```

**Better: Use `zxcvbn` Library**
```python
from zxcvbn import zxcvbn

result = zxcvbn('password123')
if result['score'] < 3:  # Score 0-4
    return False, "Password is too weak"
```

---

### Password Hashing

**❌ NEVER:**
- Store passwords in plain text
- Use MD5 or SHA1 (too fast, vulnerable to rainbow tables)
- Use weak hashing algorithms

**✅ USE:**
- bcrypt (industry standard)
- argon2 (newer, more secure)
- scrypt (memory-hard)

**Python Example (bcrypt):**
```python
import bcrypt

# Hash password
password = "SecurePassword123!"
salt = bcrypt.gensalt(rounds=12)  # 12 rounds = good balance
hashed = bcrypt.hashpw(password.encode('utf-8'), salt)

# Store hashed in database
user.password_hash = hashed.decode('utf-8')

# Verify password on login
submitted_password = "user_input"
is_valid = bcrypt.checkpw(
    submitted_password.encode('utf-8'),
    user.password_hash.encode('utf-8')
)
```

**Key Points:**
- **Salt:** Random data added to password before hashing (prevents rainbow table attacks)
- **Rounds/Cost Factor:** Number of iterations (higher = slower = more secure)
- **12 rounds for bcrypt:** Good balance (~250ms per hash)

---

### Password Reset Flow

```
1. User clicks "Forgot Password"
   ↓
2. User enters email
   ↓
3. Generate secure random token (UUID or crypto.randomBytes)
   ↓
4. Store token with expiration (e.g., 1 hour) in database
   ↓
5. Send email with reset link: /reset-password?token=...
   ↓
6. User clicks link
   ↓
7. Verify token exists and not expired
   ↓
8. Show password reset form
   ↓
9. User submits new password
   ↓
10. Hash new password, update user, invalidate token
   ↓
11. Optionally: Invalidate all existing sessions
```

**Security Considerations:**
- ✅ Token must be cryptographically secure (not predictable)
- ✅ Short expiration (1-2 hours max)
- ✅ One-time use (invalidate after password change)
- ✅ Don't reveal if email exists (same message for valid/invalid emails)
- ✅ Rate limit reset requests (prevent abuse)

---

## Session Management

### Session-Based Authentication (Traditional)

**How It Works:**
```
1. User logs in successfully
   ↓
2. Server creates session record in database/cache
   ↓
3. Server sends session ID to client in cookie
   ↓
4. Client includes cookie in subsequent requests
   ↓
5. Server looks up session by ID, validates
   ↓
6. If valid, attach user info to request context
```

**Implementation:**
```python
# FastAPI with sessions
from fastapi import FastAPI, Depends, Cookie
from typing import Optional

users_sessions = {}  # In production: Use Redis or database

@app.post("/login")
async def login(email: str, password: str):
    user = authenticate_user(email, password)
    if not user:
        raise HTTPException(401, "Invalid credentials")
    
    # Create session
    session_id = generate_secure_token()
    users_sessions[session_id] = {"user_id": user.id, "expires": ...}
    
    # Return session cookie
    response = JSONResponse({"message": "Logged in"})
    response.set_cookie(
        key="session_id",
        value=session_id,
        httponly=True,  # Prevents JavaScript access (XSS protection)
        secure=True,    # HTTPS only
        samesite="lax", # CSRF protection
        max_age=86400   # 24 hours
    )
    return response

@app.get("/profile")
async def get_profile(session_id: Optional[str] = Cookie(None)):
    if not session_id or session_id not in users_sessions:
        raise HTTPException(401, "Not authenticated")
    
    session = users_sessions[session_id]
    user = get_user(session["user_id"])
    return user
```

**Pros:**
- ✅ Server controls session lifecycle
- ✅ Easy to revoke sessions
- ✅ Less data in cookie

**Cons:**
- ⚠️ Requires server-side storage (Redis, database)
- ⚠️ Harder to scale horizontally
- ⚠️ Sticky sessions or shared session store needed

---

### Token-Based Authentication (JWT)

**How It Works:**
```
1. User logs in successfully
   ↓
2. Server creates JWT token with user info
   ↓
3. Server signs token with secret key
   ↓
4. Return token to client
   ↓
5. Client stores token (localStorage or memory)
   ↓
6. Client includes token in Authorization header
   ↓
7. Server verifies signature, extracts user info
```

**JWT Structure:**
```
header.payload.signature

Example:
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.
eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwicm9sZSI6ImFkbWluIn0.
SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
```

**Payload Example (Decoded):**
```json
{
  "sub": "user-uuid-123",           // Subject (user ID)
  "email": "user@example.com",
  "role": "contributor",
  "team_id": "sweden",
  "iat": 1707739200,                // Issued at
  "exp": 1707825600                 // Expires
}
```

**Python Example (PyJWT):**
```python
import jwt
from datetime import datetime, timedelta

SECRET_KEY = "your-secret-key-keep-it-safe"

# Create token
def create_token(user):
    payload = {
        "sub": str(user.id),
        "email": user.email,
        "role": user.role,
        "team_id": str(user.team_id) if user.team_id else None,
        "iat": datetime.utcnow(),
        "exp": datetime.utcnow() + timedelta(hours=24)
    }
    token = jwt.encode(payload, SECRET_KEY, algorithm="HS256")
    return token

# Verify token
def verify_token(token):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        return payload
    except jwt.ExpiredSignatureError:
        raise HTTPException(401, "Token expired")
    except jwt.InvalidTokenError:
        raise HTTPException(401, "Invalid token")

# FastAPI dependency
from fastapi import Depends, HTTPException
from fastapi.security import HTTPBearer

security = HTTPBearer()

async def get_current_user(credentials = Depends(security)):
    token = credentials.credentials
    payload = verify_token(token)
    user_id = payload["sub"]
    user = get_user(user_id)
    return user

# Protected route
@app.get("/profile")
async def profile(user = Depends(get_current_user)):
    return user
```

**Pros:**
- ✅ Stateless (no server-side storage)
- ✅ Easy to scale horizontally
- ✅ Works across multiple services

**Cons:**
- ⚠️ Can't revoke before expiration (use short expiration + refresh tokens)
- ⚠️ Larger than session ID (sent with every request)
- ⚠️ If stolen, valid until expiration

---

### Refresh Tokens Pattern

**Problem:** Short-lived JWTs (15 minutes) require frequent re-authentication

**Solution:** Refresh token + access token

```
Access Token (JWT):
- Short-lived (15 minutes)
- Sent with every API request
- If stolen, limited damage

Refresh Token:
- Long-lived (7 days, 30 days)
- Used only to get new access token
- Stored securely (httpOnly cookie)
- Can be revoked server-side
```

**Flow:**
```
1. Login → Receive access token + refresh token
   ↓
2. Use access token for API requests
   ↓
3. Access token expires after 15 minutes
   ↓
4. Send refresh token to /auth/refresh endpoint
   ↓
5. Server validates refresh token (check database)
   ↓
6. Issue new access token
   ↓
7. Continue using new access token
```

**Supabase automatically handles this:**
```javascript
// Supabase refreshes tokens automatically
const { data: { session } } = await supabase.auth.getSession()

// Access token
const accessToken = session.access_token  // Short-lived

// Refresh token (stored in httpOnly cookie by Supabase)
const refreshToken = session.refresh_token
```

---

## Authorization (Access Control)

### Role-Based Access Control (RBAC)

**Roles:**
- **Admin:** Full access to all features
- **Contributor:** Can upload documents, complete tasks, view team area
- **Reader:** Can view public information only

**Implementation Patterns:**

#### 1. Role Check in Code

```python
from fastapi import Depends, HTTPException

async def require_role(required_role: str):
    def role_checker(user = Depends(get_current_user)):
        if user.role != required_role and user.role != 'admin':
            raise HTTPException(403, "Insufficient permissions")
        return user
    return role_checker

# Admin-only endpoint
@app.delete("/users/{user_id}")
async def delete_user(user_id: str, user = Depends(require_role('admin'))):
    delete_user_by_id(user_id)
    return {"message": "User deleted"}

# Contributor or Admin
@app.post("/documents")
async def upload_document(user = Depends(require_role('contributor'))):
    # Upload logic
    pass
```

---

#### 2. Permission-Based (More Flexible)

```python
permissions = {
    "admin": ["read", "write", "delete", "manage_users"],
    "contributor": ["read", "write"],
    "reader": ["read"]
}

def has_permission(user, required_permission):
    user_permissions = permissions.get(user.role, [])
    return required_permission in user_permissions or "admin" in user.role

@app.post("/documents")
async def upload_document(user = Depends(get_current_user)):
    if not has_permission(user, "write"):
        raise HTTPException(403, "No write permission")
    # Upload logic
```

---

#### 3. Resource-Based (Ownership)

```python
@app.get("/documents/{doc_id}")
async def get_document(doc_id: str, user = Depends(get_current_user)):
    document = get_document_by_id(doc_id)
    
    # Admin can access all
    if user.role == "admin":
        return document
    
    # User can only access their team's documents
    if document.team_id != user.team_id:
        raise HTTPException(403, "Access denied")
    
    return document
```

---

### Row Level Security (Database-Level)

**Supabase RLS Policies:**

```sql
-- Enable RLS
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;

-- Admin: Full access
CREATE POLICY admin_all_access ON documents
FOR ALL  -- SELECT, INSERT, UPDATE, DELETE
TO authenticated
USING (auth.jwt() ->> 'role' = 'admin');

-- Contributors: Access own team's documents
CREATE POLICY contributor_team_access ON documents
FOR SELECT
TO authenticated
USING (
    team_id::text = auth.jwt() ->> 'team_id'
    AND auth.jwt() ->> 'role' IN ('contributor', 'admin')
);

-- Contributors: Upload to own team only
CREATE POLICY contributor_upload ON documents
FOR INSERT
TO authenticated
WITH CHECK (
    team_id::text = auth.jwt() ->> 'team_id'
    AND auth.jwt() ->> 'role' IN ('contributor', 'admin')
);

-- Readers: No document access
-- (No policy = no access when RLS enabled)
```

**Benefits:**
- ✅ Security at database level (can't bypass with buggy code)
- ✅ Policies apply to all queries automatically
- ✅ Centralized access control logic

---

## Common Security Patterns

### 1. Rate Limiting

**Prevent brute force attacks:**

```python
from slowapi import Limiter, _rate_limit_exceeded_handler
from slowapi.util import get_remote_address

limiter = Limiter(key_func=get_remote_address)
app.state.limiter = limiter
app.add_exception_handler(RateLimitExceeded, _rate_limit_exceeded_handler)

# Login endpoint: 5 attempts per minute
@app.post("/login")
@limiter.limit("5/minute")
async def login(request: Request, email: str, password: str):
    # Login logic
    pass

# Registration: 3 per hour per IP
@app.post("/register")
@limiter.limit("3/hour")
async def register(request: Request, user_data: dict):
    # Registration logic
    pass
```

---

### 2. CSRF Protection

**For session-based auth:**

```python
from fastapi_csrf_protect import CsrfProtect

@app.post("/tasks")
async def create_task(csrf_token: str = Depends(CsrfProtect)):
    # CSRF token validated automatically
    pass
```

**For token-based (JWT): CSRF not needed** (tokens in Authorization header, not cookies)

---

### 3. XSS Protection

**Prevent script injection:**

✅ **Escape user input in templates:**
```html
<!-- Jinja2 automatically escapes -->
<p>{{ user.name }}</p>

<!-- If you must render HTML, use safe filter carefully -->
<div>{{ content | safe }}</div>  <!-- Dangerous if content is user input -->
```

✅ **Sanitize on input:**
```python
from bleach import clean

def sanitize_html(content):
    allowed_tags = ['p', 'br', 'strong', 'em', 'ul', 'li', 'ol']
    return clean(content, tags=allowed_tags, strip=True)

@app.post("/pages")
async def create_page(content: str):
    sanitized_content = sanitize_html(content)
    # Save to database
```

✅ **Content Security Policy (CSP) headers:**
```python
@app.middleware("http")
async def add_security_headers(request, call_next):
    response = await call_next(request)
    response.headers["Content-Security-Policy"] = (
        "default-src 'self'; "
        "script-src 'self' 'unsafe-inline'; "
        "style-src 'self' 'unsafe-inline';"
    )
    return response
```

---

### 4. HTTPS Only

**Enforce HTTPS in production:**

```python
@app.middleware("http")
async def enforce_https(request, call_next):
    if request.url.scheme != "https" and not settings.DEBUG:
        https_url = request.url.replace(scheme="https")
        return RedirectResponse(https_url, status_code=301)
    return await call_next(request)
```

**Secure cookies:**
```python
response.set_cookie(
    key="session_id",
    value=session_id,
    httponly=True,   # JavaScript can't access
    secure=True,     # HTTPS only
    samesite="lax"   # CSRF protection
)
```

---

## For IIHF Portal Project

### Authentication Strategy

**Phase 1:**
- Email + password ✅
- Google OAuth ✅
- Microsoft OAuth ✅

**Use Supabase Auth for all:**
- Handles hashing, sessions, OAuth
- Reduces custom code
- Built-in security best practices

---

### Authorization Model

**Roles:**
- `admin` → Organizing committee (5 users)
- `contributor` → Team representatives (~30 users)
- `reader` → Officials, IIHF staff (~40 users)

**Access Control:**

| Resource | Admin | Contributor | Reader |
|----------|-------|-------------|--------|
| Public pages | Read/Write | Read | Read |
| Team documents | All teams | Own team | No access |
| Tasks | Create/Assign | Complete own | No access |
| User management | Full | No | No |
| Analytics | Full | No | No |
| Chat | All threads | Own team | No |

**Implementation:**
- JWT tokens with role claim
- Supabase RLS policies for database security
- FastAPI dependencies for endpoint protection
- Team ID in JWT for team isolation

---

### Security Checklist

- [x] Use HTTPS in production
- [x] Hash passwords with bcrypt (handled by Supabase)
- [x] Implement rate limiting on auth endpoints
- [x] Use httpOnly, secure cookies for sessions
- [x] Enable Row Level Security on all tables
- [x] Validate all user input
- [x] Sanitize HTML content (CMS pages)
- [x] Set short JWT expiration (15-30 minutes)
- [x] Use refresh tokens for persistent login
- [x] Log authentication events (login, logout, failed attempts)
- [x] Implement password reset with secure tokens
- [ ] Consider 2FA for admin accounts (future phase)

---

**Skill Owner:** Research Agents, Backend Developers, Security Engineers  
**Skill Version:** 1.0  
**Last Updated:** February 12, 2026
