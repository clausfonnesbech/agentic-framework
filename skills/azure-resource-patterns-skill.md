# Azure Resource Patterns Skill

**Purpose:** Understand and implement Azure-specific resource patterns, best practices, and configurations for production-ready applications.

**When to use:** Designing Azure architecture, configuring Azure services, optimizing Azure resources.

**Agents who use this:** DevOps/Platform Engineering Agent, Tech Lead Agent

---

## Azure App Service Patterns

### Production Configuration

```python
# Python startup script (startup.sh)
#!/bin/bash

# Activate virtual environment (if using)
source antenv/bin/activate

# Run Django migrations
python manage.py migrate --noinput

# Collect static files
python manage.py collectstatic --noinput

# Start Gunicorn
gunicorn config.wsgi:application \
  --bind=0.0.0.0:8000 \
  --workers=4 \
  --worker-class=sync \
  --timeout=120 \
  --access-logfile=- \
  --error-logfile=- \
  --log-level=info
```

### Auto-Scaling Configuration

```bicep
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'plan-${appName}-${environment}'
  properties: {
    // Enable auto-scaling for production
    targetWorkerCount: environment == 'prod' ? 2 : 1
    maximumElasticWorkerCount: environment == 'prod' ? 10 : 1
  }
}

resource autoScaleSettings 'Microsoft.Insights/autoscalesettings@2022-10-01' = if (environment == 'prod') {
  name: 'autoscale-${appName}-${environment}'
  location: location
  properties: {
    enabled: true
    targetResourceUri: appServicePlan.id
    profiles: [
      {
        name: 'Auto scale based on CPU'
        capacity: {
          default: '2'
          minimum: '2'
          maximum: '10'
        }
        rules: [
          {
            metricTrigger: {
              metricName: 'CpuPercentage'
              metricResourceUri: appServicePlan.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT10M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: 70
            }
            scaleAction: {
              direction: 'Increase'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT5M'
            }
          }
          {
            metricTrigger: {
              metricName: 'CpuPercentage'
              metricResourceUri: appServicePlan.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT10M'
              timeAggregation: 'Average'
              operator: 'LessThan'
              threshold: 30
            }
            scaleAction: {
              direction: 'Decrease'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT10M'
            }
          }
        ]
      }
    ]
  }
}
```

---

## Azure Key Vault Patterns

### Managed Identity Integration (Recommended)

```python
# Django settings.py - Key Vault integration
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
import os

# Use managed identity in Azure (no credentials needed)
# Uses DefaultAzureCredential which tries:
# 1. Managed Identity (Azure)
# 2. Azure CLI (local development)
# 3. Environment variables

KEY_VAULT_NAME = os.getenv("KEY_VAULT_NAME")
credential = DefaultAzureCredential()
secret_client = SecretClient(vault_url=f"https://{KEY_VAULT_NAME}.vault.azure.net/", credential=credential)

# Retrieve secrets
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': secret_client.get_secret("DatabaseName").value,
        'USER': secret_client.get_secret("DatabaseUser").value,
        'PASSWORD': secret_client.get_secret("DatabasePassword").value,
        'HOST': secret_client.get_secret("DatabaseHost").value,
        'PORT': '5432',
    }
}

SECRET_KEY = secret_client.get_secret("DjangoSecretKey").value
```

### Key Vault References in App Service (Simpler Alternative)

```bicep
// App Service automatically resolves Key Vault references
appSettings: [
  {
    name: 'DATABASE_URL'
    value: '@Microsoft.KeyVault(SecretUri=https://${keyVaultName}.vault.azure.net/secrets/DatabaseUrl/)'
  }
  {
    name: 'DJANGO_SECRET_KEY'
    value: '@Microsoft.KeyVault(SecretUri=https://${keyVaultName}.vault.azure.net/secrets/DjangoSecretKey/)'
  }
]
```

```python
# Django settings.py - simpler with Key Vault references
import os
import dj_database_url

# App Service resolves Key Vault references automatically
DATABASE_URL = os.getenv("DATABASE_URL")
DATABASES = {'default': dj_database_url.parse(DATABASE_URL)}

SECRET_KEY = os.getenv("DJANGO_SECRET_KEY")
```

---

## Application Insights Patterns

### Python/Django Integration

```python
# Install packages
# pip install opencensus-ext-azure opencensus-ext-django

# settings.py
from opencensus.ext.azure.log_exporter import AzureLogHandler
from opencensus.ext.azure.trace_exporter import AzureExporter
from opencensus.trace.samplers import ProbabilitySampler
import logging

# Application Insights connection string
APPLICATIONINSIGHTS_CONNECTION_STRING = os.getenv("APPLICATIONINSIGHTS_CONNECTION_STRING")

# Configure logging
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'verbose': {
            'format': '{levelname} {asctime} {module} {message}',
            'style': '{',
        },
    },
    'handlers': {
        'azure': {
            'class': 'opencensus.ext.azure.log_exporter.AzureLogHandler',
            'connection_string': APPLICATIONINSIGHTS_CONNECTION_STRING,
        },
        'console': {
            'class': 'logging.StreamHandler',
            'formatter': 'verbose',
        },
    },
    'root': {
        'handlers': ['console', 'azure'],
        'level': 'INFO',
    },
}

# Middleware for request tracking
MIDDLEWARE = [
    'opencensus.ext.django.middleware.OpencensusMiddleware',
    # ... other middleware
]

# OpenCensus configuration
OPENCENSUS = {
    'TRACE': {
        'SAMPLER': 'opencensus.trace.samplers.ProbabilitySampler(rate=1.0)',
        'EXPORTER': f'opencensus.ext.azure.trace_exporter.AzureExporter(connection_string="{APPLICATIONINSIGHTS_CONNECTION_STRING}")',
    }
}
```

### Custom Metrics and Events

```python
from opencensus.ext.azure import metrics_exporter
from opencensus.stats import aggregation as aggregation_module
from opencensus.stats import measure as measure_module
from opencensus.stats import stats as stats_module
from opencensus.stats import view as view_module
from opencensus.tags import tag_map as tag_map_module
import logging

logger = logging.getLogger(__name__)

# Track custom events
logger.info("User login", extra={
    'custom_dimensions': {
        'user_id': user.id,
        'username': user.username,
        'login_method': 'password'
    }
})

# Track custom metrics
stats = stats_module.stats
view_manager = stats.view_manager
stats_recorder = stats.stats_recorder

# Define a measure
response_time_measure = measure_module.MeasureFloat("response_time", "Response time", "ms")

# Create a view
response_time_view = view_module.View("response_time_view",
    "Response time distribution",
    [],
    response_time_measure,
    aggregation_module.LastValueAggregation())

view_manager.register_view(response_time_view)
exporter = metrics_exporter.new_metrics_exporter(connection_string=APPLICATIONINSIGHTS_CONNECTION_STRING)
view_manager.register_exporter(exporter)

# Record measurement
mmap = stats_recorder.new_measurement_map()
tmap = tag_map_module.TagMap()
mmap.measure_float_put(response_time_measure, 125.5)
mmap.record(tmap)
```

---

## PostgreSQL (Azure or Supabase) Patterns

### Azure PostgreSQL Flexible Server

```bicep
resource postgresServer 'Microsoft.DBforPostgreSQL/flexibleServers@2023-03-01-preview' = {
  name: 'psql-${appName}-${environment}'
  location: location
  tags: tags
  sku: {
    name: 'Standard_B2s'
    tier: 'Burstable'
  }
  properties: {
    version: '15'
    administratorLogin: 'pgadmin'
    administratorLoginPassword: adminPassword
    storage: {
      storageSizeGB: 32
    }
    backup: {
      backupRetentionDays: environment == 'prod' ? 35 : 7
      geoRedundantBackup: environment == 'prod' ? 'Enabled' : 'Disabled'
    }
    highAvailability: {
      mode: environment == 'prod' ? 'ZoneRedundant' : 'Disabled'
    }
  }
}

resource postgresDatabase 'Microsoft.DBforPostgreSQL/flexibleServers/databases@2023-03-01-preview' = {
  parent: postgresServer
  name: databaseName
}

// Firewall rule to allow Azure services
resource firewallRule 'Microsoft.DBforPostgreSQL/flexibleServers/firewallRules@2023-03-01-preview' = {
  parent: postgresServer
  name: 'AllowAzureServices'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}
```

### Connection Pooling (pgbouncer)

```python
# For high-traffic applications, use connection pooling

# Option 1: Supabase (built-in pooling)
DATABASE_URL = "postgresql://user:pass@pooler.supabase.com:6543/db"

# Option 2: Django connection pooling
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'mydb',
        'USER': 'user',
        'PASSWORD': 'pass',
        'HOST': 'server.postgres.database.azure.com',
        'PORT': '5432',
        'CONN_MAX_AGE': 600,  # Connection pooling (10 minutes)
        'OPTIONS': {
            'connect_timeout': 10,
            'options': '-c statement_timeout=30000'  # 30 seconds
        }
    }
}
```

---

## Storage Account Patterns

### Static Files (Django)

```bicep
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'st${appName}${environment}'
  location: location
  tags: tags
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    minimumTlsVersion: 'TLS1_2'
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccount
  name: 'default'
}

resource staticContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: 'static'
  properties: {
    publicAccess: 'Blob'
  }
}

resource mediaContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: 'media'
  properties: {
    publicAccess: 'None'  // Private
  }
}
```

```python
# Django settings.py - Azure Blob Storage
# pip install django-storages[azure]

INSTALLED_APPS = [
    # ...
    'storages',
]

# Static files (CSS, JS, images)
STATICFILES_STORAGE = 'storages.backends.azure_storage.AzureStorage'
AZURE_ACCOUNT_NAME = os.getenv("AZURE_STORAGE_ACCOUNT_NAME")
AZURE_ACCOUNT_KEY = os.getenv("AZURE_STORAGE_ACCOUNT_KEY")
AZURE_CONTAINER = 'static'
AZURE_CUSTOM_DOMAIN = f'{AZURE_ACCOUNT_NAME}.blob.core.windows.net'
STATIC_URL = f'https://{AZURE_CUSTOM_DOMAIN}/{AZURE_CONTAINER}/'

# Media files (user uploads)
DEFAULT_FILE_STORAGE = 'storages.backends.azure_storage.AzureStorage'
AZURE_MEDIA_CONTAINER = 'media'
MEDIA_URL = f'https://{AZURE_CUSTOM_DOMAIN}/{AZURE_MEDIA_CONTAINER}/'
```

---

## Network Security Patterns

### Virtual Network Integration

```bicep
resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: 'vnet-${appName}-${environment}'
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'app-subnet'
        properties: {
          addressPrefix: '10.0.1.0/24'
          delegations: [
            {
              name: 'delegation'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
            }
          ]
        }
      }
      {
        name: 'data-subnet'
        properties: {
          addressPrefix: '10.0.2.0/24'
          serviceEndpoints: [
            {
              service: 'Microsoft.KeyVault'
            }
            {
              service: 'Microsoft.Sql'
            }
          ]
        }
      }
    ]
  }
}
```

### Private Endpoints (for Key Vault)

```bicep
resource keyVaultPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = if (enablePrivateEndpoint) {
  name: 'pe-kv-${appName}-${environment}'
  location: location
  tags: tags
  properties: {
    subnet: {
      id: dataSubnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'kv-connection'
        properties: {
          privateLinkServiceId: keyVault.id
          groupIds: [
            'vault'
          ]
        }
      }
    ]
  }
}
```

---

## Cost Optimization Patterns

### Right-Sizing App Service Plans

```
Environment | Workload | Recommended SKU | Monthly Cost (Sweden Central)
------------|----------|-----------------|------------------------------
Dev         | Low      | B1 (1 core, 1.75GB) | ~$13
Staging     | Medium   | B2 (2 cores, 3.5GB) | ~$56
Production  | High     | P1v3 (2 cores, 8GB) | ~$110
Production  | Very High| P2v3 (4 cores, 16GB)| ~$220
```

### Reserved Instances

```
Savings with 1-year commitment:
- App Service: ~30% savings
- Database: ~35% savings

Savings with 3-year commitment:
- App Service: ~50% savings
- Database: ~55% savings

Recommendation: Use for production environments with stable workloads
```

### Auto-Shutdown for Non-Production

```bicep
// Tag non-production resources for auto-shutdown
resource appService 'Microsoft.Web/sites@2023-01-01' = {
  tags: union(tags, {
    'AutoShutdown': environment != 'prod' ? 'true' : 'false'
    'ShutdownTime': environment != 'prod' ? '19:00' : 'none'
    'StartupTime': environment != 'prod' ? '07:00' : 'none'
  })
}
```

---

## Disaster Recovery Patterns

### Backup Configuration

```bicep
// PostgreSQL automated backups
backup: {
  backupRetentionDays: environment == 'prod' ? 35 : 7
  geoRedundantBackup: environment == 'prod' ? 'Enabled' : 'Disabled'
}

// Key Vault with soft-delete and purge protection
properties: {
  enableSoftDelete: true
  softDeleteRetentionInDays: 90
  enablePurgeProtection: environment == 'prod' ? true : false
}

// Storage Account geo-redundancy
sku: {
  name: environment == 'prod' ? 'Standard_GRS' : 'Standard_LRS'
}
```

### Recovery Testing

```bash
# Test database restore
az postgres flexible-server restore \
  --resource-group <rg> \
  --name <server-name> \
  --source-server <source-server-id> \
  --restore-time "2026-02-14T12:00:00Z"

# Test Key Vault recovery
az keyvault recover --name <kv-name>

# Test infrastructure recreation from Bicep
az deployment group create \
  --resource-group <dr-rg> \
  --template-file main.bicep \
  --parameters parameters.dr.json
```

---

## Compliance Patterns (GDPR)

### Data Residency

```bicep
// Always deploy to Sweden Central for GDPR compliance
location: 'swedencentral'

// Enable geo-redundancy within Europe only
geoRedundantBackup: 'Enabled'  // Replicates within Europe
```

### Audit Logging

```bicep
resource diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'audit-logs'
  scope: keyVault
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [
      {
        category: 'AuditEvent'
        enabled: true
        retentionPolicy: {
          enabled: true
          days: 365
        }
      }
    ]
  }
}
```

### Data Encryption

```bicep
// Encryption at rest (enabled by default)
// Encryption in transit (TLS 1.2/1.3)
properties: {
  minimumTlsVersion: 'TLS1_2'
  httpsOnly: true
}
```

---

## Best Practices Summary

1. **Always use managed identities** instead of connection strings/passwords
2. **Store secrets in Key Vault** never in code or environment variables
3. **Enable HTTPS-only** with TLS 1.2+ minimum
4. **Tag all resources** for cost allocation and management
5. **Enable monitoring** on all production resources
6. **Configure auto-scaling** for production workloads
7. **Use deployment slots** for zero-downtime deployments
8. **Enable soft-delete** on Key Vault (90-day retention)
9. **Configure backups** with appropriate retention
10. **Deploy to Sweden Central** for GDPR compliance
11. **Use VNet integration** for sensitive workloads
12. **Right-size resources** based on actual usage
13. **Use Reserved Instances** for cost savings (production)
14. **Test disaster recovery** procedures quarterly
15. **Enable audit logging** for compliance

---

**Remember:** Azure services evolve rapidly. Always check the latest Azure documentation for the most current patterns and best practices.
