# Workflow Automation Design Skill

**Skill Type:** Technical Architecture  
**Purpose:** Design automated workflows, scheduled tasks, and event-driven processes using n8n and similar automation platforms

## Overview

This skill covers patterns for designing automated workflows, integrating services, handling notifications, scheduling tasks, and building event-driven architecture. It focuses on n8n workflow automation but principles apply to similar platforms (Zapier, Make, Temporal, Apache Airflow).

## When to Use This Skill

- ✅ Automating repetitive manual tasks
- ✅ Integrating multiple services/APIs
- ✅ Scheduling background jobs
- ✅ Sending notifications and reminders
- ✅ Data synchronization between systems
- ✅ Building event-driven processes

## Core Principles

### 1. Automate the Repetitive
If you do it more than twice, automate it.

### 2. Fail Gracefully
Workflows will fail. Design for retries, error handling, and alerting.

### 3. Idempotency
Running a workflow twice should have the same result as running it once.

### 4. Observable
Log workflow executions, measure performance, alert on failures.

### 5. Start Simple
Begin with basic workflows, add complexity incrementally.

---

## n8n Fundamentals

### Workflow Terminology

**Node:** Single step in workflow (trigger, action, logic)

**Trigger Node:** Starts workflow execution
- Webhook (HTTP request)
- Schedule (cron)
- Manual (button click)
- Database change

**Action Node:** Performs operation
- HTTP Request
- Send Email
- Database operation
- Transform data

**Logic Node:** Controls flow
- IF condition
- Switch (multiple conditions)
- Loop
- Merge

**Credentials:** Stored authentication (API keys, OAuth tokens)

---

### Workflow Execution Models

**1. On-Demand (Webhook Trigger)**
```
User action → HTTP request → n8n workflow → Process → Response
```

**Use Cases:**
- Task created in portal → Send notification email
- Document uploaded → Alert admins
- Form submitted → Process data

---

**2. Scheduled (Cron Trigger)**
```
Schedule → Execute periodically → Process batch
```

**Use Cases:**
- Daily digest emails (8 AM)
- Deadline reminders (check tasks due in 3 days)
- Data cleanup (delete old notifications)

---

**3. Event-Driven (Database Trigger)**
```
Database change → Detect change → n8n workflow → Process
```

**Use Cases:**
- Task status changes → Notify stakeholders
- New user registered → Send welcome email
- Document uploaded → Virus scan

---

## Workflow Design Patterns

### Pattern 1: Simple Notification

**Use Case:** Send email when task is created

```
Webhook Trigger (from portal)
  ↓
Get task details from webhook payload
  ↓
Format email template
  ↓
Send Email (SMTP)
```

**n8n Workflow:**
```json
{
  "nodes": [
    {
      "name": "Webhook",
      "type": "n8n-nodes-base.webhook",
      "parameters": {
        "path": "task-created"
      }
    },
    {
      "name": "Format Email",
      "type": "n8n-nodes-base.set",
      "parameters": {
        "values": {
          "string": [
            {
              "name": "subject",
              "value": "New Task: {{ $json.title }}"
            },
            {
              "name": "body",
              "value": "You have been assigned:\n\nTitle: {{ $json.title }}\nDeadline: {{ $json.deadline }}\n"
            }
          ]
        }
      }
    },
    {
      "name": "Send Email",
      "type": "n8n-nodes-base.emailSend",
      "parameters": {
        "fromEmail": "noreply@iihf-portal.com",
        "toEmail": "={{ $json.assignee_email }}",
        "subject": "={{ $('Format Email').item.json.subject }}",
        "text": "={{ $('Format Email').item.json.body }}"
      }
    }
  ]
}
```

---

### Pattern 2: Scheduled Reminder

**Use Case:** Send reminder 3 days before task deadline

```
Schedule Trigger (daily at 8 AM)
  ↓
Query database for tasks due in 3 days
  ↓
Filter incomplete tasks
  ↓
FOR EACH task:
    Get team member emails
    ↓
    Send reminder email
```

**n8n Workflow:**
```json
{
  "nodes": [
    {
      "name": "Daily at 8 AM",
      "type": "n8n-nodes-base.cron",
      "parameters": {
        "rule": {
          "cronExpression": "0 8 * * *"
        }
      }
    },
    {
      "name": "Get Tasks Due in 3 Days",
      "type": "n8n-nodes-base.postgres",
      "parameters": {
        "operation": "executeQuery",
        "query": "SELECT t.*, u.email FROM tasks t JOIN users u ON t.team_id = u.team_id WHERE t.deadline = CURRENT_DATE + INTERVAL '3 days' AND t.status = 'open' AND u.role = 'contributor'"
      }
    },
    {
      "name": "Send Reminders",
      "type": "n8n-nodes-base.emailSend",
      "parameters": {
        "fromEmail": "reminders@iihf-portal.com",
        "toEmail": "={{ $json.email }}",
        "subject": "Reminder: {{ $json.title }} due in 3 days",
        "text": "Your task '{{ $json.title }}' is due on {{ $json.deadline }}.\n\nPlease complete it before the deadline."
      }
    }
  ]
}
```

**Cron Expression Guide:**
```
* * * * *
│ │ │ │ │
│ │ │ │ └─ Day of week (0-7, Sun-Sat)
│ │ │ └─── Month (1-12)
│ │ └───── Day of month (1-31)
│ └─────── Hour (0-23)
└───────── Minute (0-59)

Examples:
0 8 * * *       # Daily at 8 AM
0 */4 * * *     # Every 4 hours
0 9 * * 1       # Every Monday at 9 AM
0 0 1 * *       # First day of month at midnight
*/15 * * * *    # Every 15 minutes
```

---

### Pattern 3: Conditional Logic

**Use Case:** Send different emails based on task priority

```
Webhook Trigger
  ↓
IF task priority = 'high'
  ↓ YES: Send urgent email with escalation
  ↓ NO: Send standard email
```

**n8n Workflow:**
```json
{
  "nodes": [
    {
      "name": "IF Priority High",
      "type": "n8n-nodes-base.if",
      "parameters": {
        "conditions": {
          "string": [
            {
              "value1": "={{ $json.priority }}",
              "value2": "high"
            }
          ]
        }
      }
    },
    {
      "name": "Send Urgent Email",
      "type": "n8n-nodes-base.emailSend",
      "parameters": {
        "subject": "URGENT: {{ $json.title }}",
        "text": "High priority task assigned..."
      }
    },
    {
      "name": "Send Standard Email",
      "type": "n8n-nodes-base.emailSend",
      "parameters": {
        "subject": "New Task: {{ $json.title }}",
        "text": "Standard task assigned..."
      }
    }
  ],
  "connections": {
    "IF Priority High": {
      "main": [
        [{"node": "Send Urgent Email"}],  // True branch
        [{"node": "Send Standard Email"}]  // False branch
      ]
    }
  }
}
```

---

### Pattern 4: Data Aggregation & Digest

**Use Case:** Daily admin digest email

```
Schedule Trigger (daily at 8 AM)
  ↓
Get incomplete tasks (count)
  ↓
Get new documents uploaded today (count)
  ↓
Get tasks completed yesterday (count)
  ↓
Aggregate data
  ↓
Format digest email
  ↓
Send to admins
```

**Implementation:**
```json
{
  "nodes": [
    {
      "name": "Daily at 8 AM",
      "type": "n8n-nodes-base.cron",
      "parameters": {
        "rule": {
          "cronExpression": "0 8 * * *"
        }
      }
    },
    {
      "name": "Get Incomplete Tasks",
      "type": "n8n-nodes-base.postgres",
      "parameters": {
        "operation": "executeQuery",
        "query": "SELECT COUNT(*) as incomplete FROM tasks WHERE status = 'open'"
      }
    },
    {
      "name": "Get Documents Uploaded",
      "type": "n8n-nodes-base.postgres",
      "parameters": {
        "operation": "executeQuery",
        "query": "SELECT COUNT(*) as uploaded FROM documents WHERE DATE(uploaded_at) = CURRENT_DATE"
      }
    },
    {
      "name": "Get Completed Tasks",
      "type": "n8n-nodes-base.postgres",
      "parameters": {
        "operation": "executeQuery",
        "query": "SELECT COUNT(*) as completed FROM tasks WHERE DATE(completed_at) = CURRENT_DATE - 1"
      }
    },
    {
      "name": "Merge Data",
      "type": "n8n-nodes-base.merge",
      "parameters": {
        "mode": "mergeByPosition"
      }
    },
    {
      "name": "Format Digest",
      "type": "n8n-nodes-base.set",
      "parameters": {
        "values": {
          "string": [
            {
              "name": "digest",
              "value": "Daily Portal Update\n\n📋 Incomplete tasks: {{ $json.incomplete }}\n📄 Documents uploaded today: {{ $json.uploaded }}\n✅ Tasks completed yesterday: {{ $json.completed }}"
            }
          ]
        }
      }
    },
    {
      "name": "Send to Admins",
      "type": "n8n-nodes-base.emailSend",
      "parameters": {
        "toEmail": "admin@iihf-portal.com",
        "subject": "Daily Portal Digest",
        "text": "={{ $json.digest }}"
      }
    }
  ]
}
```

---

### Pattern 5: Error Handling & Retry

**Use Case:** Send email with retry on failure

```
Webhook Trigger
  ↓
TRY:
    Send Email
    ↓
    Log success
CATCH error:
    Wait 5 minutes
    ↓
    Retry send (max 3 attempts)
    ↓
    IF still fails: Alert admin
```

**n8n Implementation:**
```json
{
  "nodes": [
    {
      "name": "Send Email",
      "type": "n8n-nodes-base.emailSend",
      "parameters": {
        "toEmail": "={{ $json.email }}",
        "subject": "Test",
        "text": "Message"
      },
      "continueOnFail": true,  // Don't stop workflow on error
      "retryOnFail": true,
      "maxTries": 3,
      "waitBetweenTries": 300000  // 5 minutes in ms
    },
    {
      "name": "Check If Failed",
      "type": "n8n-nodes-base.if",
      "parameters": {
        "conditions": {
          "boolean": [
            {
              "value1": "={{ $json.error !== undefined }}",
              "value2": true
            }
          ]
        }
      }
    },
    {
      "name": "Alert Admin",
      "type": "n8n-nodes-base.emailSend",
      "parameters": {
        "toEmail": "admin@iihf-portal.com",
        "subject": "Email Send Failed",
        "text": "Failed to send email after 3 attempts.\n\nError: {{ $json.error }}"
      }
    }
  ]
}
```

---

## Integration Patterns

### Webhook Integration (Portal → n8n)

**Portal sends event to n8n:**

```python
# FastAPI endpoint
import httpx

N8N_WEBHOOK_URL = "https://n8n.yourcompany.com/webhook/task-created"

@app.post("/tasks")
async def create_task(task: TaskCreate, user = Depends(get_current_user)):
    # 1. Create task in database
    new_task = create_task_in_db(task)
    
    # 2. Trigger n8n workflow
    async with httpx.AsyncClient() as client:
        try:
            await client.post(
                N8N_WEBHOOK_URL,
                json={
                    "task_id": str(new_task.id),
                    "title": new_task.title,
                    "deadline": new_task.deadline.isoformat(),
                    "team_id": str(new_task.team_id),
                    "assignee_emails": get_team_emails(new_task.team_id)
                },
                timeout=5.0
            )
        except httpx.TimeoutException:
            # Log error but don't fail task creation
            logger.error("n8n webhook timeout")
    
    return new_task
```

**Best Practices:**
- ✅ Use async requests (don't block)
- ✅ Set timeout (5-10 seconds)
- ✅ Don't fail primary operation if webhook fails
- ✅ Include webhook authentication (secret header)

---

### Database Trigger (PostgreSQL → n8n)

**Option 1: Polling (Simple)**

```json
{
  "name": "Poll for New Documents",
  "type": "n8n-nodes-base.cron",
  "parameters": {
    "rule": {
      "cronExpression": "*/5 * * * *"  // Every 5 minutes
    }
  },
  "next": {
    "name": "Query New Documents",
    "type": "n8n-nodes-base.postgres",
    "parameters": {
      "query": "SELECT * FROM documents WHERE created_at > NOW() - INTERVAL '5 minutes'"
    }
  }
}
```

**Option 2: Trigger Function (Real-time)**

```sql
-- Create function to call n8n webhook
CREATE OR REPLACE FUNCTION notify_n8n_document_upload()
RETURNS TRIGGER AS $$
BEGIN
    PERFORM net.http_post(
        url := 'https://n8n.yourcompany.com/webhook/document-uploaded',
        headers := '{"Content-Type": "application/json"}'::jsonb,
        body := json_build_object(
            'document_id', NEW.id,
            'filename', NEW.filename,
            'team_id', NEW.team_id,
            'uploaded_by', NEW.uploaded_by
        )::text
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger
CREATE TRIGGER document_upload_trigger
AFTER INSERT ON documents
FOR EACH ROW
EXECUTE FUNCTION notify_n8n_document_upload();
```

---

## Email Templates

### Template Design

**Use variables for dynamic content:**

```
Subject: {{ task_title }} - Deadline Reminder

Dear {{ team_name }},

This is a reminder that your task "{{ task_title }}" is due on {{ deadline_date }}.

Task Details:
- Assigned to: {{ team_name }}
- Deadline: {{ deadline_date }} ({{ days_remaining }} days remaining)
- Description: {{ task_description }}

Please complete this task before the deadline.

View task: {{ portal_url }}/tasks/{{ task_id }}

Best regards,
IIHF Organizing Committee
```

**HTML Email Template:**

```html
<!DOCTYPE html>
<html>
<head>
    <style>
        body { font-family: Arial, sans-serif; }
        .header { background-color: #003f7f; color: white; padding: 20px; }
        .content { padding: 20px; }
        .button { 
            background-color: #003f7f; 
            color: white; 
            padding: 10px 20px; 
            text-decoration: none;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h2>IIHF World Championships Portal</h2>
    </div>
    <div class="content">
        <h3>{{ task_title }}</h3>
        <p>Dear {{ team_name }},</p>
        <p>Your task is due on <strong>{{ deadline_date }}</strong>.</p>
        <p><a href="{{ portal_url }}/tasks/{{ task_id }}" class="button">View Task</a></p>
    </div>
</body>
</html>
```

---

### Multi-Language Support (Future)

```javascript
// Language detection based on team country
const templates = {
  en: {
    subject: "Task Reminder: {{ title }}",
    body: "This is a reminder..."
  },
  sv: {
    subject: "Påminnelse: {{ title }}",
    body: "Detta är en påminnelse..."
  },
  dk: {
    subject: "Påmindelse: {{ title }}",
    body: "Dette er en påmindelse..."
  }
}

const language = team.country === 'sweden' ? 'sv' : 'en'
const template = templates[language]
```

---

## Workflow Best Practices

### 1. Idempotency

**Problem:** Workflow runs twice, sends duplicate emails

**Solution:** Track execution state

```sql
CREATE TABLE workflow_executions (
    id UUID PRIMARY KEY,
    workflow_name VARCHAR(255),
    entity_id VARCHAR(255),  -- e.g., task_id
    execution_time TIMESTAMPTZ,
    status VARCHAR(50),
    UNIQUE(workflow_name, entity_id)
);

-- Before sending email, check if already sent
INSERT INTO workflow_executions (workflow_name, entity_id, status)
VALUES ('task_reminder', '{{task_id}}', 'sent')
ON CONFLICT (workflow_name, entity_id) DO NOTHING
RETURNING id;

-- If returns null, already executed
```

---

### 2. Rate Limiting

**Problem:** Workflow sends 100 emails instantly, triggers spam filter

**Solution:** Batch and delay

```json
{
  "name": "Loop Through Recipients",
  "type": "n8n-nodes-base.splitInBatches",
  "parameters": {
    "batchSize": 10,  // Process 10 at a time
    "options": {
      "reset": false
    }
  }
},
{
  "name": "Wait Between Batches",
  "type": "n8n-nodes-base.wait",
  "parameters": {
    "amount": 60,  // Wait 60 seconds between batches
    "unit": "seconds"
  }
}
```

---

### 3. Logging & Monitoring

**Log workflow executions:**

```sql
CREATE TABLE workflow_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    workflow_name VARCHAR(255),
    execution_id VARCHAR(255),
    status VARCHAR(50),  -- success, failure, running
    input_data JSONB,
    output_data JSONB,
    error_message TEXT,
    duration_ms INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW()
);
```

**n8n logging node:**

```json
{
  "name": "Log Execution",
  "type": "n8n-nodes-base.postgres",
  "parameters": {
    "operation": "insert",
    "table": "workflow_logs",
    "columns": "workflow_name, execution_id, status, input_data",
    "values": "'task_reminder', '{{ $execution.id }}', 'success', '{{ $json }}'"
  }
}
```

---

### 4. Error Alerting

**Alert admin if workflow fails:**

```json
{
  "name": "Error Trigger",
  "type": "n8n-nodes-base.errorTrigger",
  "parameters": {}
},
{
  "name": "Send Alert",
  "type": "n8n-nodes-base.emailSend",
  "parameters": {
    "toEmail": "admin@iihf-portal.com",
    "subject": "Workflow Failed: {{ $json.workflow.name }}",
    "text": "Workflow failed with error:\n\n{{ $json.error.message }}\n\nExecution ID: {{ $json.execution.id }}"
  }
}
```

---

## For IIHF Portal Project

### Required Workflows (Phase 6)

**1. New Task Notification**
- Trigger: Webhook from portal (task created)
- Action: Send email to team contributors
- Frequency: On-demand

**2. Deadline Reminder**
- Trigger: Schedule (daily at 8 AM)
- Query: Tasks due in 3 days and still incomplete
- Action: Send reminder email to team
- Frequency: Daily

**3. Task Completion Notification**
- Trigger: Webhook (task marked complete)
- Action: Send email to admins
- Frequency: On-demand

**4. Document Upload Alert**
- Trigger: Webhook (document uploaded)
- Action: Send email to admins
- Frequency: On-demand

**5. Daily Admin Digest (Optional)**
- Trigger: Schedule (daily at 8 AM)
- Aggregate: Incomplete tasks, new documents, completed tasks
- Action: Send digest email to admins
- Frequency: Daily

---

### n8n Setup Checklist

- [x] Deploy n8n instance (Docker on Azure or n8n Cloud)
- [x] Configure SMTP credentials for email sending
- [x] Create webhook endpoints for portal integration
- [x] Set up database connection (PostgreSQL/Supabase)
- [x] Configure authentication (webhook secret headers)
- [x] Create workflows for each use case above
- [x] Test workflows with sample data
- [x] Enable error alerting to admin email
- [x] Set up execution logging
- [x] Document workflow URLs for portal integration

**Estimated Effort:** 60 hours (Phase 6)

---

**Skill Owner:** Research Agents, Backend Developers, DevOps Engineers  
**Skill Version:** 1.0  
**Last Updated:** February 12, 2026
