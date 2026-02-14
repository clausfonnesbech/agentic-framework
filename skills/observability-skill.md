# Observability Skill

**Purpose:** Implement comprehensive monitoring, logging, and alerting for production systems using Azure Application Insights and structured logging.

**When to use:** Setting up monitoring, debugging production issues, analyzing performance, tracking application health.

**Agents who use this:** DevOps/Platform Engineering Agent, Tech Lead Agent (architecture)

---

## Core Concepts

### The Three Pillars of Observability

1. **Metrics** - Numerical measurements over time (CPU, memory, request rate, error rate)
2. **Logs** - Discrete events with context (errors, warnings, info)
3. **Traces** - Request flows across distributed systems (performance, dependencies)

---

## Application Insights Integration (Python/Django)

### Installation

```bash
pip install opencensus-ext-azure opencensus-ext-django
```

### Django Configuration

**settings/base.py:**
```python
import os
from opencensus.ext.azure.log_exporter import AzureLogHandler
from opencensus.ext.azure.trace_exporter import AzureExporter
from opencensus.trace.samplers import ProbabilitySampler

# Application Insights connection string
APPLICATIONINSIGHTS_CONNECTION_STRING = os.getenv("APPLICATIONINSIGHTS_CONNECTION_STRING")

# Middleware for request tracking
MIDDLEWARE = [
    'opencensus.ext.django.middleware.OpencensusMiddleware',
    'django.middleware.security.SecurityMiddleware',
    # ... other middleware
]

# OpenCensus configuration for distributed tracing
OPENCENSUS = {
    'TRACE': {
        'SAMPLER': f'opencensus.trace.samplers.ProbabilitySampler(rate={1.0 if DEBUG else 0.5})',
        'EXPORTER': f'''opencensus.ext.azure.trace_exporter.AzureExporter(
            connection_string="{APPLICATIONINSIGHTS_CONNECTION_STRING}"
        )''',
    }
}

# Logging configuration
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'verbose': {
            'format': '{levelname} {asctime} {module} {process:d} {thread:d} {message}',
            'style': '{',
        },
        'json': {
            '()': 'pythonjsonlogger.jsonlogger.JsonFormatter',
            'format': '%(asctime)s %(name)s %(levelname)s %(message)s',
        },
    },
    'handlers': {
        'console': {
            'class': 'logging.StreamHandler',
            'formatter': 'verbose',
        },
        'azure': {
            'level': 'INFO',
            'class': 'opencensus.ext.azure.log_exporter.AzureLogHandler',
            'connection_string': APPLICATIONINSIGHTS_CONNECTION_STRING,
        },
        'file': {
            'level': 'INFO',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': '/var/log/django/app.log',
            'maxBytes': 10485760,  # 10MB
            'backupCount': 5,
            'formatter': 'json',
        },
    },
    'root': {
        'handlers': ['console', 'azure'],
        'level': 'INFO',
    },
    'loggers': {
        'django': {
            'handlers': ['console', 'azure'],
            'level': 'INFO',
            'propagate': False,
        },
        'django.request': {
            'handlers': ['console', 'azure'],
            'level': 'WARNING',
            'propagate': False,
        },
        'django.security': {
            'handlers': ['console', 'azure'],
            'level': 'WARNING',
            'propagate': False,
        },
        'myapp': {
            'handlers': ['console', 'azure', 'file'],
            'level': 'INFO',
            'propagate': False,
        },
    },
}
```

---

## Structured Logging Patterns

### Basic Logging

```python
import logging

logger = logging.getLogger(__name__)

# Info level
logger.info("User logged in", extra={
    'custom_dimensions': {
        'user_id': user.id,
        'username': user.username,
        'ip_address': request.META.get('REMOTE_ADDR'),
    }
})

# Warning level
logger.warning("Failed login attempt", extra={
    'custom_dimensions': {
        'username': username,
        'ip_address': request.META.get('REMOTE_ADDR'),
        'reason': 'invalid_password',
    }
})

# Error level
logger.error("Payment processing failed", extra={
    'custom_dimensions': {
        'user_id': user.id,
        'order_id': order.id,
        'amount': order.total,
        'error_code': error.code,
    }
}, exc_info=True)
```

### Custom Metrics

```python
from opencensus.stats import aggregation as aggregation_module
from opencensus.stats import measure as measure_module
from opencensus.stats import stats as stats_module
from opencensus.stats import view as view_module
from opencensus.tags import tag_map as tag_map_module
from opencensus.ext.azure import metrics_exporter

# Initialize stats recorder
stats = stats_module.stats
view_manager = stats.view_manager
stats_recorder = stats.stats_recorder

# Define measures
order_count_measure = measure_module.MeasureInt("orders/count", "Number of orders", "orders")
order_value_measure = measure_module.MeasureFloat("orders/value", "Order value", "USD")

# Create views
order_count_view = view_module.View(
    "order_count_view",
    "Total orders created",
    [],
    order_count_measure,
    aggregation_module.CountAggregation()
)

order_value_view = view_module.View(
    "order_value_view",
    "Total order value",
    [],
    order_value_measure,
    aggregation_module.SumAggregation()
)

# Register views and exporter
view_manager.register_view(order_count_view)
view_manager.register_view(order_value_view)
exporter = metrics_exporter.new_metrics_exporter(
    connection_string=APPLICATIONINSIGHTS_CONNECTION_STRING
)
view_manager.register_exporter(exporter)

# Record metrics
def create_order(user, items, total):
    # ... order creation logic
    
    # Record metrics
    mmap = stats_recorder.new_measurement_map()
    tmap = tag_map_module.TagMap()
    tmap.insert("user_tier", user.tier)
    tmap.insert("order_type", order.type)
    
    mmap.measure_int_put(order_count_measure, 1)
    mmap.measure_float_put(order_value_measure, float(total))
    mmap.record(tmap)
    
    logger.info("Order created", extra={
        'custom_dimensions': {
            'order_id': order.id,
            'user_id': user.id,
            'total': total,
            'items_count': len(items),
        }
    })
```

### Custom Events

```python
from opencensus.ext.azure.common import utils

# Track custom events
logger.info("Feature flag toggled", extra={
    'custom_dimensions': {
        'feature': 'new_checkout',
        'enabled': True,
        'user_id': user.id,
    }
})

logger.info("A/B test variant assigned", extra={
    'custom_dimensions': {
        'experiment': 'pricing_test',
        'variant': 'variant_b',
        'user_id': user.id,
    }
})
```

---

## Performance Monitoring

### Database Query Tracking

```python
from django.db import connection
import logging

logger = logging.getLogger(__name__)

def log_slow_queries():
    """Middleware to log slow database queries"""
    for query in connection.queries:
        if float(query['time']) > 0.5:  # Slower than 500ms
            logger.warning("Slow query detected", extra={
                'custom_dimensions': {
                    'query': query['sql'],
                    'time': query['time'],
                }
            })
```

### Request Duration Tracking

```python
# Automatically tracked by OpenCensus middleware
# Query in Application Insights:
# requests
# | where duration > 3000  // 3 seconds
# | project timestamp, name, url, duration, resultCode
```

---

## Alert Rules (Bicep Configuration)

### High Error Rate Alert

```bicep
resource highErrorRateAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'High Error Rate - ${appName}'
  location: 'global'
  properties: {
    description: 'Alert when error rate exceeds 5%'
    severity: 2
    enabled: true
    scopes: [
      applicationInsights.id
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'ErrorRate'
          metricName: 'requests/failed'
          metricNamespace: 'microsoft.insights/components'
          operator: 'GreaterThan'
          threshold: 5
          timeAggregation: 'Average'
        }
      ]
    }
    actions: [
      {
        actionGroupId: actionGroup.id
      }
    ]
  }
}
```

### Slow Response Time Alert

```bicep
resource slowResponseAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'Slow Response Time - ${appName}'
  location: 'global'
  properties: {
    description: 'Alert when p95 response time exceeds 3 seconds'
    severity: 3
    enabled: true
    scopes: [
      applicationInsights.id
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'ResponseTime'
          metricName: 'requests/duration'
          metricNamespace: 'microsoft.insights/components'
          operator: 'GreaterThan'
          threshold: 3000
          timeAggregation: 'Average'
        }
      ]
    }
  }
}
```

### High CPU Usage Alert

```bicep
resource highCpuAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'High CPU Usage - ${appName}'
  location: 'global'
  properties: {
    description: 'Alert when CPU usage exceeds 80%'
    severity: 2
    enabled: true
    scopes: [
      appServicePlan.id
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'CpuPercentage'
          metricName: 'CpuPercentage'
          operator: 'GreaterThan'
          threshold: 80
          timeAggregation: 'Average'
        }
      ]
    }
  }
}
```

---

## KQL Queries (Kusto Query Language)

### Error Analysis

```kql
// Top 10 exceptions in last 24 hours
exceptions
| where timestamp > ago(24h)
| summarize count() by type, outerMessage
| top 10 by count_
| order by count_ desc

// Error trends over time
exceptions
| where timestamp > ago(7d)
| summarize count() by bin(timestamp, 1h), type
| render timechart

// Errors by operation
exceptions
| where timestamp > ago(24h)
| summarize count() by operation_Name
| order by count_ desc
```

### Performance Analysis

```kql
// Slow requests (p95 > 3 seconds)
requests
| where timestamp > ago(24h)
| summarize p95=percentile(duration, 95) by name
| where p95 > 3000
| order by p95 desc

// Request duration trends
requests
| where timestamp > ago(7d)
| summarize avg(duration), p50=percentile(duration, 50), p95=percentile(duration, 95) by bin(timestamp, 1h)
| render timechart

// Slowest dependencies (database, API calls)
dependencies
| where timestamp > ago(24h)
| summarize avg(duration), p95=percentile(duration, 95) by name, type
| where p95 > 1000
| order by p95 desc
```

### User Behavior

```kql
// Active users in last hour
customEvents
| where timestamp > ago(1h)
| where name == "UserLogin"
| summarize dcount(tostring(customDimensions.user_id))

// Most used features
customEvents
| where timestamp > ago(7d)
| where name startswith "Feature"
| summarize count() by name
| order by count_ desc
| take 10
```

---

## Dashboards

### Application Health Dashboard

```kql
// Request rate
requests
| where timestamp > ago(1h)
| summarize count() by bin(timestamp, 1m)
| render timechart

// Success vs. failure rate
requests
| where timestamp > ago(1h)
| summarize Success=countif(success == true), Failed=countif(success == false) by bin(timestamp, 5m)
| render timechart

// Response time percentiles
requests
| where timestamp > ago(1h)
| summarize p50=percentile(duration, 50), p95=percentile(duration, 95), p99=percentile(duration, 99) by bin(timestamp, 5m)
| render timechart

// Active users
customEvents
| where timestamp > ago(1h)
| where name == "UserLogin"
| summarize ActiveUsers=dcount(tostring(customDimensions.user_id)) by bin(timestamp, 5m)
| render timechart
```

---

## SLO/SLI Definitions

### Service Level Indicators (SLIs)

```
1. Availability: Percentage of successful requests
   Target: 99.9% (43 minutes downtime per month)
   
2. Latency: p95 response time
   Target: < 500ms for API endpoints, < 2s for page loads
   
3. Error Rate: Percentage of failed requests
   Target: < 0.1%
   
4. Throughput: Requests per second
   Target: > 100 RPS sustained
```

### KQL Query for SLO Tracking

```kql
// Availability SLI (last 30 days)
requests
| where timestamp > ago(30d)
| summarize 
    Total=count(),
    Success=countif(success == true),
    Failed=countif(success == false)
| extend AvailabilityPercent = (todouble(Success) / todouble(Total)) * 100
| project AvailabilityPercent, Success, Failed, Total

// Latency SLI (p95 < 500ms)
requests
| where timestamp > ago(30d)
| summarize p95=percentile(duration, 95)
| extend MeetsTarget = p95 < 500
| project p95, MeetsTarget

// Error budget remaining
let targetAvailability = 99.9;
let totalMinutes = 30 * 24 * 60;  // 30 days
let allowedDowntime = totalMinutes * (1 - targetAvailability / 100);
requests
| where timestamp > ago(30d)
| summarize 
    Total=count(),
    Failed=countif(success == false)
| extend 
    ErrorRate = (todouble(Failed) / todouble(Total)) * 100,
    ActualDowntime = (todouble(Failed) / todouble(Total)) * totalMinutes,
    ErrorBudgetRemaining = allowedDowntime - (todouble(Failed) / todouble(Total)) * totalMinutes
| project ErrorRate, ActualDowntime, ErrorBudgetRemaining, allowedDowntime
```

---

## Best Practices

### 1. Log Levels
- **DEBUG**: Detailed diagnostic information (not in production)
- **INFO**: General informational messages (user actions, system events)
- **WARNING**: Unexpected behavior that doesn't break functionality
- **ERROR**: Errors that should be investigated
- **CRITICAL**: System-breaking errors requiring immediate attention

### 2. Custom Dimensions
Always include context in logs:
```python
logger.info("Action performed", extra={
    'custom_dimensions': {
        'user_id': user.id,
        'action': 'update_profile',
        'duration_ms': duration,
        'success': True,
    }
})
```

### 3. Avoid Logging Sensitive Data
```python
# ❌ Bad - logs sensitive data
logger.info(f"User {user.email} logged in with password {password}")

# ✅ Good - no sensitive data
logger.info("User logged in", extra={
    'custom_dimensions': {
        'user_id': user.id,
        'method': 'password',
    }
})
```

### 4. Sampling for High-Volume Events
```python
# Sample 10% of high-volume events
if random.random() < 0.1:
    logger.info("High volume event", extra={...})
```

### 5. Correlation IDs
```python
# Track requests across services
import uuid

correlation_id = str(uuid.uuid4())
logger.info("Request started", extra={
    'custom_dimensions': {
        'correlation_id': correlation_id,
    }
})
```

---

## Troubleshooting

### Issue: Logs Not Appearing in Application Insights

```
1. Verify connection string is correct
2. Check firewall/network rules
3. Verify opencensus packages installed
4. Check sampling rate (not set to 0)
5. Wait 2-5 minutes for ingestion delay
```

### Issue: Too Many Logs

```
1. Reduce log level in production (INFO instead of DEBUG)
2. Implement sampling for high-volume events
3. Filter noisy dependencies
4. Set retention period appropriately
```

### Issue: High Application Insights Costs

```
1. Reduce sampling rate (e.g., 0.5 = 50%)
2. Filter out health check requests
3. Reduce custom metric cardinality
4. Use basic tier for non-production
5. Set data cap and alerts
```

---

## Observability Checklist

Before going to production:

- [ ] Application Insights configured
- [ ] Structured logging implemented
- [ ] Custom metrics for business KPIs
- [ ] Alert rules configured (error rate, latency, CPU, memory)
- [ ] Dashboard created for application health
- [ ] SLOs defined and tracked
- [ ] Log retention configured (90+ days for compliance)
- [ ] Sensitive data excluded from logs
- [ ] Correlation IDs implemented for request tracking
- [ ] Runbooks created for common issues
- [ ] On-call rotation configured
- [ ] Alert notifications configured (email, Slack, PagerDuty)

---

**Remember:** Observability is not just about collecting data—it's about **understanding your system's behavior** and **responding to issues quickly**. Instrument early, monitor continuously, and iterate based on real-world usage.
