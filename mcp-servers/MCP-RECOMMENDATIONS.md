# MCP Server Recommendations for IIHF Portal Project

**Date:** February 12, 2026  
**Project:** IIHF World Championships Portal  
**Tech Stack:** Python (FastAPI/Django), Supabase (PostgreSQL + Auth + Storage), React, Azure Sweden

---

## Executive Summary

Based on research of available MCP servers and the IIHF portal tech stack requirements, I recommend adding **5 key MCP servers** to enhance the research and development workflow. These servers will provide agents with direct access to:
- Supabase capabilities and best practices
- PostgreSQL/database design patterns
- Python web framework documentation
- React component libraries and patterns
- API design standards

For the newly added UX/UI and Task Manager agents, add these enabling MCP servers:
- OpenAPI MCP for contract-level API validation in planning
- GitHub MCP for story-to-issue execution traceability
- Playwright MCP for browser-level UX flow validation

---

## Recommended MCP Servers

### 1. 🗄️ **Supabase MCP Server** ⭐ HIGHEST PRIORITY

**Official GitHub:** `github.com/supabase-community/supabase-mcp`

**Why Critical:**
- Project uses Supabase as primary database and auth provider
- Provides direct interaction with Supabase services
- Access to schema inspection, query execution, and documentation

**Capabilities:**
- Create and manage database tables
- Execute SQL queries
- Deploy and manage Edge Functions
- Access Supabase Auth configurations
- Manage Storage buckets
- Query database schema and relationships

**When to Use:**
- ✅ Database schema design research
- ✅ Row Level Security (RLS) policy creation
- ✅ Supabase Auth integration patterns
- ✅ Storage bucket configuration
- ✅ Real-time subscription setup
- ✅ Edge Function deployment strategies

**Setup:**
```bash
# Install via npm
npm install -g supabase-mcp

# Or run with npx
npx supabase-mcp
```

**Configuration Requirements:**
- `SUPABASE_URL`: Your Supabase project URL
- `SUPABASE_ANON_KEY`: Public anonymous key
- `SUPABASE_SERVICE_KEY`: Service role key (for admin operations)

**Agent Usage:**
- Research Agents: Schema design, RLS policies, auth patterns
- Research Manager: Planning database-related research tasks
- Business Analyst: Understanding Supabase capabilities for proposals

---

### 2. 🐘 **PostgreSQL MCP Server** ⭐ HIGH PRIORITY

**Official Options:**
1. `@modelcontextprotocol/server-postgres` (TypeScript)
2. `mcp-server-postgresql` (Python, multiple community versions)

**Why Important:**
- Supabase IS PostgreSQL (hosted)
- Need PostgreSQL-specific patterns and constraints
- Advanced query optimization and indexing strategies

**Capabilities:**
- Execute SQL queries
- Inspect database schema
- Analyze query performance (EXPLAIN)
- Create and manage indexes
- Define constraints and relationships
- Full-text search capabilities

**When to Use:**
- ✅ Complex SQL query research
- ✅ Database performance optimization
- ✅ Advanced PostgreSQL features (JSONB, arrays, full-text search)
- ✅ Migration script planning
- ✅ Index strategy research

**Setup:**
```bash
# TypeScript version (official)
npx @modelcontextprotocol/server-postgres <connection-string>

# Python version (community)
pip install mcp-server-postgresql
```

**Configuration Requirements:**
- Database connection string (can use Supabase connection details)
- Read-only access recommended for safety

**Agent Usage:**
- Research Agents: Query optimization, schema best practices
- Backend developers: Migration planning, schema validation

---

### 3. 🐍 **Python FastAPI/Django Documentation MCP**

**Options:**
1. **FastAPI GitHub MCP** - `github.com/tiangolo/fastapi` (via GitHub MCP)
2. **Python Documentation MCP** - Official Python docs access

**Why Valuable:**
- Project may use FastAPI or Django
- Need framework-specific patterns and best practices
- Integration patterns with Supabase

**Capabilities:**
- FastAPI routing and middleware patterns
- Django ORM and authentication
- Python web framework best practices
- Integration code examples
- Performance optimization guides

**When to Use:**
- ✅ Framework selection research (FastAPI vs Django)
- ✅ Authentication middleware implementation
- ✅ API endpoint design patterns
- ✅ WebSocket implementation (real-time chat)
- ✅ File upload handling
- ✅ Background task processing

**Setup:**
```bash
# Use GitHub MCP to access FastAPI/Django repos
npx @modelcontextprotocol/server-github

# Or dedicated Python docs MCP
npx @modelcontextprotocol/server-python-docs
```

**Agent Usage:**
- Research Agents: Framework comparison, implementation patterns
- Research Manager: Planning framework-specific research tasks

---

### 4. ⚛️ **React Component Library MCP**

**Options:**
1. **Storybook MCP** - `github.com/storybookjs/addon-mcp`
2. **React Documentation MCP** - Access React docs and patterns

**Why Useful:**
- Frontend will use React
- Component design and state management patterns
- Integration with backend APIs

**Capabilities:**
- React component patterns
- State management approaches (Context, Redux, Zustand)
- UI component libraries (Material-UI, Chakra, Tailwind)
- React hooks and lifecycle patterns
- Performance optimization

**When to Use:**
- ✅ Component architecture research
- ✅ State management strategy selection
- ✅ UI library comparison
- ✅ Responsive design patterns
- ✅ Accessibility (a11y) best practices

**Setup:**
```bash
# Storybook MCP (if applicable)
npm install @storybook/addon-mcp

# React docs access (via web search or dedicated MCP)
# May use existing web search capabilities
```

**Agent Usage:**
- Research Agents: Frontend architecture, component design
- UI/UX research tasks

---

### 5. 🔌 **OpenAPI/API Design MCP**

**Official Options:**
1. **OpenAPI MCP** - `openapi-mcp-server` (npm)
2. **Postman MCP** - `github.com/postmanlabs/postman-api-mcp`

**Why Relevant:**
- REST API design is critical for the project
- API documentation generation
- Integration testing support

**Capabilities:**
- OpenAPI specification validation
- API design best practices
- Endpoint documentation generation
- Request/response schema validation
- API testing and mocking

**When to Use:**
- ✅ REST API endpoint design
- ✅ OpenAPI specification creation
- ✅ API versioning strategies
- ✅ Authentication flow documentation
- ✅ Error response standardization

**Setup:**
```bash
# OpenAPI MCP
npm install -g openapi-mcp-server

# Postman MCP
npm install -g @postman/mcp-server
```

**Agent Usage:**
- Research Agents: API design patterns, documentation standards
- Backend architecture research

---

## Priority Matrix

| MCP Server | Priority | Complexity | Setup Time | Impact on IIHF Portal |
|-----------|----------|------------|------------|----------------------|
| Supabase | ⭐⭐⭐⭐⭐ | Medium | 10 min | Critical - Core database/auth |
| PostgreSQL | ⭐⭐⭐⭐ | Low | 5 min | High - Database optimization |
| Python Docs | ⭐⭐⭐ | Low | 5 min | Medium - Framework guidance |
| React | ⭐⭐ | Low | 5 min | Medium - Frontend patterns |
| OpenAPI | ⭐⭐ | Low | 5 min | Medium - API documentation |

---

## Implementation Roadmap

### Phase 1: Essential (Week 1)
1. ✅ **Supabase MCP** - Set up immediately
2. ✅ **PostgreSQL MCP** - Set up for database research

**Rationale:** These directly support the core technology stack (Supabase/PostgreSQL).

### Phase 2: Framework Support (Week 2)
3. ✅ **Python FastAPI/Django MCP** - Once framework is selected
4. ✅ **React MCP** (if available) - For frontend architecture

**Rationale:** Framework-specific guidance becomes critical during implementation planning.

### Phase 3: Documentation (Week 3)
5. ✅ **OpenAPI MCP** - For API documentation standards

**Rationale:** API design solidifies after framework and database schemas are finalized.

---

## Configuration Template

Each MCP server will need a configuration file in `mcp-servers/`:

```
mcp-servers/
├── supabase-config.json         ← NEW
├── postgresql-config.json        ← NEW
├── python-docs-config.json       ← NEW
├── react-docs-config.json        ← NEW (optional)
├── openapi-config.json           ← NEW (optional)
├── github-config.json            ← NEW (recommended)
├── playwright-config.json        ← NEW (recommended)
├── microsoft-learn-config.json   ← EXISTING
└── n8n-config.json               ← EXISTING
```

### Agent-Specific MCP Mapping

| Agent | Primary MCPs | Recommended Additional MCPs |
|------|---------------|------------------------------|
| UX/UI Agent | Supabase, Python Docs, n8n | Playwright, OpenAPI |
| Task Manager Agent | Supabase, PostgreSQL, Python Docs, n8n | OpenAPI, GitHub |

---

## Security Considerations

### Environment Variables Required

```bash
# Supabase MCP
export SUPABASE_URL="https://your-project.supabase.co"
export SUPABASE_ANON_KEY="your-anon-key"
export SUPABASE_SERVICE_KEY="your-service-key"  # SENSITIVE

# PostgreSQL MCP
export POSTGRES_CONNECTION_STRING="postgresql://user:pass@host:5432/db"

# Other MCPs (minimal auth if needed)
```

### Security Best Practices

1. **Never commit secrets** - Use `.env` files (add to `.gitignore`)
2. **Use read-only keys** where possible - Especially for PostgreSQL MCP
3. **Rotate keys regularly** - Service keys should be rotated every 90 days
4. **Least privilege access** - Grant minimal permissions needed
5. **Audit MCP usage** - Log when agents access sensitive information

---

## Alternative/Future MCP Servers

### Consider Later (Not Immediate Priority)

**Medium-Term (Months 2-3):**
- **Azure MCP** - For Azure-specific hosting queries (already have Microsoft Learn)
- **GitHub MCP** - If using GitHub for code repository
- **Docker MCP** - For container deployment strategies

**Low Priority (Post-MVP):**
- **Testing MCPs** (Pytest, Jest) - After core features complete
- **Monitoring MCPs** (Grafana, Sentry) - For observability research
- **Security Scanning MCPs** - For vulnerability assessment

**Not Recommended:**
- Proprietary/paid MCPs - Stick with open-source when possible
- Overly specific MCPs - Use general web search for edge cases
- Unmaintained community MCPs - Risk of outdated info

---

## Expected Benefits

### For Research Agents
- **Faster research** - Direct access to official documentation
- **More accurate** - Information from authoritative sources
- **Better context** - Access to related topics and patterns
- **Code examples** - Real implementation guidance

### For Research Manager
- **Better task distribution** - Assign MCP-specific research
- **Quality assurance** - Verify research against official sources
- **Parallel execution** - Multiple agents accessing different MCPs simultaneously

### For Business Analyst
- **Proposal accuracy** - Verify technical feasibility during proposal creation
- **Up-to-date capabilities** - Access latest Supabase/framework features
- **Risk identification** - Discover constraints and limitations early

### For UX/UI Agent
- **Flow confidence** - Validate key journeys in a real browser
- **State quality** - Verify loading/error/empty/permission states
- **Accessibility support** - Add keyboard/focus checks to handoff

### For Task Manager Agent
- **Execution traceability** - Link stories to GitHub issues and PRs
- **Contract precision** - Validate API stories against OpenAPI definitions
- **Delivery predictability** - Expose integration blockers earlier

---

## Measurement Criteria

Track MCP effectiveness by:
1. **Research quality** - Are findings more accurate/complete?
2. **Time savings** - How much faster is research with MCPs?
3. **Agent usage patterns** - Which MCPs are used most frequently?
4. **Error reduction** - Fewer incorrect assumptions about capabilities?

---

## Next Steps

1. ✅ Create configuration files for each recommended MCP server
2. ✅ Set up environment variables for Supabase and PostgreSQL MCPs
3. ✅ Update Research Agent and Research Manager definitions with new MCPs
4. ✅ Test MCP connectivity and query capabilities
5. ✅ Document usage examples for agents
6. ✅ Add MCP descriptions to agent "Available Skills & Tools" sections
7. ✅ Add UX/UI + Task Manager MCP configs: OpenAPI, GitHub, Playwright

---

## Questions for Consideration

**Before Implementation:**
1. Do we have Supabase project credentials ready?
2. Which Python framework (FastAPI or Django) will be selected?
3. Should we set up read-only vs. read-write PostgreSQL access?
4. Are there any security policies around MCP server usage in the organization?
5. Do we need approval for external MCP server connections?

**During Implementation:**
1. How do we handle MCP server downtime or failures gracefully?
2. Should we cache MCP responses to reduce API calls?
3. Do we need rate limiting for MCP usage?

---

## Resources

### Official MCP Server Registry
- **GitHub MCP Servers List**: https://github.com/modelcontextprotocol/servers
- **MCP Protocol Specification**: https://modelcontextprotocol.io/
- **Community MCPs**: https://mcphub.com/

### Specific Server Documentation
- **Supabase MCP**: https://github.com/supabase-community/supabase-mcp
- **PostgreSQL MCP**: Search "mcp-server-postgres" on npm/GitHub
- **OpenAPI MCP**: https://www.npmjs.com/package/openapi-mcp-server

---

**Document Owner:** AI Workflow Architect  
**Last Updated:** February 12, 2026  
**Status:** Recommendation (Pending Implementation)  
**Next Review:** After Phase 1 implementation (1 week)
