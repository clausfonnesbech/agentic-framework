# Project Coordination Skill

## Purpose
Enable agents (especially Task Manager and Tech Lead) to effectively manage and coordinate work across multiple concurrent projects in a monorepo workspace. This skill ensures proper project context awareness, efficient resource allocation, and cross-project knowledge sharing.

## When to Use This Skill
- Managing multiple active projects in the workspace
- Routing tasks and agents to the correct project
- Identifying cross-project dependencies and opportunities for reuse
- Coordinating shared resources (infrastructure modules, utilities)
- Tracking project health and status across the portfolio

## Core Competencies

### 1. Project Discovery & Context Loading

**Identify Active Projects**
```markdown
Action: List all projects in the workspace
Location: /projects/
Look for: Directories containing .project-context.md

For each project, extract:
- Project name and status
- Current phase
- Active agents
- Tech stack
- Key constraints
```

**Load Project Context**
```markdown
When assigned work, ALWAYS:
1. Identify which project(s) are involved
2. Read the project's .project-context.md file
3. Note project-specific constraints (budget, timeline, compliance)
4. Check project health checklist
5. Review active agents and their assignments
```

**Example Context Check:**
```markdown
Input: "I need to add authentication to the Customer Portal"

Step 1: Identify project
  → Search for "customer-portal" in /projects/
  → Found: /projects/customer-portal/.project-context.md

Step 2: Load context
  Project: Customer Portal
  Status: Active Development
  Phase: Feature implementation
  Tech Stack: Django, PostgreSQL, Azure
  Active Agents: DevOps (infrastructure), Coding (features)
  Constraints: GDPR compliance (Sweden Central), Q2 deadline

Step 3: Route work
  → Authentication is a feature → Assign to Tech Lead
  → Tech Lead checks if DevOps has Azure AD B2C ready
  → Then assigns to Coding Agent with compliance requirements
```

### 2. Multi-Project Task Routing

**Task Classification**
Determine which project(s) a task belongs to:

```markdown
Task Types:

1. SINGLE PROJECT TASK
   - Clearly scoped to one project
   - Action: Load that project's context, proceed normally
   - Example: "Add user profile page to Customer Portal"

2. MULTI-PROJECT TASK
   - Affects multiple projects
   - Action: Load all affected project contexts, coordinate changes
   - Example: "Update authentication library across all projects"

3. SHARED RESOURCE TASK
   - Creates/modifies shared infrastructure or utilities
   - Action: Document in /shared/, notify affected projects
   - Example: "Create reusable Bicep module for App Service"

4. NEW PROJECT TASK
   - Initiates a new project
   - Action: Run /scripts/new-project.ps1
   - Example: "Start a new inventory management system"

5. CROSS-PROJECT DEPENDENCY
   - One project depends on another
   - Action: Coordinate both projects, update dependency docs
   - Example: "Project B needs API from Project A"
```

**Routing Decision Tree**
```
Is this a new project?
├─ YES → Use new-project.ps1 script
└─ NO → Continue

Can you identify the project(s)?
├─ YES → Load context for each project
└─ NO → Ask user to clarify which project

Is this a shared resource (infrastructure/utility)?
├─ YES → Place in /shared/, document usage
└─ NO → Place in project directory

Does this affect multiple projects?
├─ YES → Coordinate across project contexts
└─ NO → Proceed with single project

Are there dependencies on other projects?
├─ YES → Check dependent project readiness
└─ NO → Proceed normally
```

### 3. Resource Allocation & Conflict Resolution

**Agent Assignment Across Projects**
Track agent availability and prevent overload:

```markdown
Check Agent Load:
1. Review .project-context.md files for all active projects
2. Note which agents are marked as active on each project
3. Avoid assigning one agent to critical paths in multiple projects simultaneously

Example Check:
  Project A: Coding Agent actively implementing auth
  Project B: Coding Agent requested for payment feature
  
  Decision: 
  - If both are high priority, complete Project A first OR
  - If Project B is urgent, assign a different coding session OR
  - Document as backlog item in Project B until capacity available
```

**Shared Resource Coordination**
```markdown
When using shared resources:

1. Check existing shared modules
   Location: /shared/common-infrastructure/
   Action: Reuse if available, extend if needed

2. Creating new shared modules
   Decision criteria:
   - Used by 2+ projects → Create in /shared/
   - Used by 1 project → Keep in project, move to /shared/ if reused later
   
3. Document usage
   In each project's .project-context.md, list:
   - Shared infrastructure modules used
   - Dependencies on other projects
   - Shared utilities consumed
```

### 4. Cross-Project Knowledge Sharing

**Pattern Recognition**
Identify opportunities to reuse solutions:

```markdown
When solving a problem in Project A:
1. Document the solution approach
2. Check if other projects have similar needs
3. If yes:
   - Extract reusable components to /shared/
   - Create documentation
   - Notify relevant project teams

Example:
  Problem: Project A implements Azure AD B2C authentication
  Pattern: Other projects also need authentication
  Action: 
  - Extract Bicep template to /shared/common-infrastructure/adb2c.bicep
  - Create auth utility in /shared/utilities/auth_helpers.py
  - Document in project context files
```

**Technical Debt Tracking**
Monitor technical debt across projects:

```markdown
Track in each project's backlog/backlog.md:
- Shared dependencies that need updates
- Common infrastructure improvements
- Security patches needed across multiple projects

Prioritize:
- Security issues → Address immediately across all projects
- Breaking changes → Coordinate rollout
- Improvements → Batch updates when possible
```

### 5. Project Health Monitoring

**Health Check Template**
Regularly assess project health:

```markdown
For each active project, verify:

Infrastructure:
- [ ] Resources provisioned
- [ ] CI/CD pipeline operational
- [ ] Monitoring configured
- [ ] Backup strategy active

Code Quality:
- [ ] Tests passing
- [ ] Code reviews current
- [ ] Security scans clean
- [ ] Documentation updated

Process:
- [ ] Backlog groomed
- [ ] Sprints on track
- [ ] Blockers resolved
- [ ] Stakeholders aligned

Update .project-context.md health section accordingly.
```

**Portfolio Status Summary**
```markdown
Generate portfolio overview:

Active Projects: [count]
  - In Planning: [list]
  - In Development: [list]
  - In Testing: [list]
  - Blocked: [list]

Resource Utilization:
  - DevOps Agent: [projects assigned]
  - Coding Agent: [projects assigned]
  - etc.

Shared Resources:
  - Infrastructure modules: [count]
  - Shared utilities: [count]
  - Common dependencies: [list]

Upcoming Milestones:
  - [Project A]: [milestone] - [date]
  - [Project B]: [milestone] - [date]
```

## Workflow Examples

### Example 1: Starting Work on a Request

**User Request:** "Add user notification feature to the Mobile App"

**Project Coordinator Workflow:**
```markdown
1. Identify Project
   Search: /projects/ for "mobile-app"
   Found: /projects/mobile-app/.project-context.md

2. Load Context
   Project: Mobile App
   Status: Active Development
   Phase: Feature implementation
   Tech Stack: React Native, Node.js, Azure Functions
   Active Agents: Coding Agent (frontend)
   
3. Check Dependencies
   - Will need backend API → Check if available
   - Notifications → Check if Azure Notification Hub provisioned
   
4. Verify Prerequisites
   Read: /projects/mobile-app/.project-context.md
   Infrastructure: ✓ Provisioned
   CI/CD: ✓ Active
   Notification Hub: ✗ Not provisioned
   
5. Route Work
   a) Assign DevOps Agent: Provision Azure Notification Hub
   b) After completion, assign Coding Agent: Implement feature
   c) After coding, assign QA Lead: Test notification delivery
   
6. Update Project Context
   Mark DevOps Agent as active for notification infrastructure task
```

### Example 2: Creating a Shared Module

**User Request:** "All projects need better error logging"

**Project Coordinator Workflow:**
```markdown
1. Identify Scope
   Affects: All Python projects
   Type: Shared utility
   
2. Assess Impact
   Projects affected:
   - customer-portal (Django)
   - inventory-system (Django)
   - mobile-app (Node.js - skip)
   
3. Create Shared Component
   Location: /shared/utilities/logging/
   Files:
   - error_logger.py
   - README.md
   - requirements.txt (if dependencies)
   
4. Assign Agent
   Tech Lead → Design logging interface
   Coding Agent → Implement utility
   DevOps Agent → Add to common infrastructure (Application Insights)
   
5. Roll Out to Projects
   For each affected project:
   a) Update requirements.txt
   b) Update logging configuration
   c) Document in .project-context.md → Dependencies section
   d) Test integration
   
6. Document
   Create: /shared/utilities/logging/README.md
   Update: Each project's docs/architecture.md
```

### Example 3: Handling Cross-Project Dependencies

**User Request:** "Project B needs authentication API from Project A"

**Project Coordinator Workflow:**
```markdown
1. Identify Projects
   Provider: /projects/project-a/ (has auth API)
   Consumer: /projects/project-b/ (needs auth API)
   
2. Check Provider Readiness
   Read: /projects/project-a/.project-context.md
   
   Check:
   - [ ] Auth API implemented?
   - [ ] API documented?
   - [ ] API deployed and accessible?
   - [ ] Security reviewed?
   
3. Document Dependency
   In /projects/project-b/.project-context.md:
   ```markdown
   ## Dependencies
   - Project A Authentication API
     - Endpoint: https://project-a.azurewebsites.net/api/auth
     - Documentation: /projects/project-a/docs/api-spec.md
     - Contact: [Project A team]
   ```
   
4. Coordinate Integration
   If API ready:
   - Provide API spec to Project B
   - Assign Coding Agent to integrate
   
   If API not ready:
   - Add to Project A backlog with priority
   - Block Project B feature until API available
   - Coordinate timelines with stakeholders
   
5. Monitor
   Track API stability and changes
   Alert Project B if breaking changes coming
```

## Best Practices

### 1. Always Load Context First
Before starting any work:
- Read relevant .project-context.md files
- Check project phase and status
- Note constraints and deadlines
- Review active agents and assignments

### 2. Document Cross-Project Impacts
When making changes that could affect multiple projects:
- List all affected projects
- Document the change in each project
- Coordinate rollout if needed
- Update shared resource documentation

### 3. Maintain Project Health
Regularly verify:
- Infrastructure is operational
- CI/CD pipelines are green
- Security scans are passing
- Documentation is current
- Backlog is prioritized

### 4. Optimize for Reuse
When solving a problem:
- Check if similar problems exist in other projects
- Extract reusable components to /shared/
- Document patterns and solutions
- Share learnings across projects

### 5. Clear Communication
Update project context files:
- Mark agents as active/inactive
- Document blockers immediately
- Update project phase as work progresses
- Keep stakeholder information current

## Integration with Other Skills

This skill works closely with:
- **Backlog Planning & Estimation** - Prioritizing across projects
- **Sprint Planning** - Allocating capacity across projects
- **Task Breakdown** - Decomposing cross-project work
- **Technical Synthesis** - Sharing technical patterns
- **Infrastructure as Code** - Managing shared infrastructure
- **Observability** - Monitoring across projects

## Success Metrics

Effective project coordination achieves:
- ✓ Agents always work with correct project context
- ✓ Shared resources are reused, not duplicated
- ✓ Cross-project dependencies are identified early
- ✓ No agent overload (agents assigned to too many projects)
- ✓ Project health is actively monitored
- ✓ Knowledge and patterns are shared across projects
- ✓ Efficient resource allocation across portfolio

## Quick Reference Commands

```bash
# Initialize new project
./scripts/new-project.ps1

# Check project structure
ls projects/

# View project context
cat projects/{project-name}/.project-context.md

# List shared resources
ls shared/common-infrastructure/
ls shared/utilities/

# Check agent assignments across projects
grep -r "Active Agents" projects/*/. project-context.md
```

## Remember
> "Context is king. Load it first, every time."

> "If it's used twice, it belongs in /shared/."

> "One agent, one critical path at a time."

> "Document dependencies before they become problems."
