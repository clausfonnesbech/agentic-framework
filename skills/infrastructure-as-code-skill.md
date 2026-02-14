# Infrastructure as Code Skill

**Purpose:** Generate and manage infrastructure using Azure Bicep, ensuring reproducible, version-controlled, and secure infrastructure provisioning.

**When to use:** Creating Azure infrastructure, updating resource configurations, managing infrastructure lifecycle.

**Agents who use this:** DevOps/Platform Engineering Agent, Tech Lead Agent (awareness)

---

## Core Principles

### 1. Everything as Code
- **All infrastructure** must be defined in Bicep/Terraform
- **No manual creation** of resources in Azure Portal (except initial setup)
- **Version control** all IaC files in Git
- **Review process** for infrastructure changes (like code review)

### 2. Modularity
- **Reusable modules** for common patterns (App Service, Key Vault, etc.)
- **Parameterization** for environment-specific values
- **Composition** of modules into complete environments

### 3. Immutability
- **Recreate instead of modify** when possible
- **Blue-green deployments** for zero-downtime updates
- **Infrastructure versioning** with Git tags

### 4. Security First
- **Secrets in Key Vault** never in code or parameters
- **Least privilege RBAC** assignments
- **Network isolation** with VNets and Private Endpoints
- **Audit logging** enabled on all resources

---

## Azure Bicep Patterns

### Resource Naming Convention

```bicep
// Pattern: {resourceType}-{appName}-{environment}-{region}-{instance}
// Example: app-myapp-prod-swe-001

var resourcePrefix = '${appName}-${environment}-${regionCode}'
var appServiceName = 'app-${resourcePrefix}-${instance}'
var keyVaultName = 'kv-${resourcePrefix}-${instance}'
var appInsightsName = 'appi-${resourcePrefix}-${instance}'
var storageAccountName = 'st${appName}${environment}${instance}' // no hyphens, max 24 chars
```

**Naming Standards:**
- **app** = App Service
- **plan** = App Service Plan
- **kv** = Key Vault
- **sql** = SQL Server
- **db** = Database
- **st** = Storage Account
- **appi** = Application Insights
- **vnet** = Virtual Network
- **nsg** = Network Security Group
- **pip** = Public IP Address

**Region Codes:**
- `swe` = Sweden Central
- `eun` = North Europe
- `eus` = East US

### Tagging Strategy

```bicep
var commonTags = {
  Environment: environment      // dev, staging, prod
  Project: projectName          // Project identifier
  CostCenter: costCenter        // For cost allocation
  ManagedBy: 'IaC-Bicep'       // How resource is managed
  Owner: owner                  // Team or person responsible
  Compliance: 'GDPR'           // Compliance requirements
  DataClassification: 'confidential' // Data sensitivity
  BackupRequired: 'true'       // Whether backups needed
  CreatedDate: utcNow()        // Creation timestamp
}
```

### Parameter Files

**main.bicep** - Template
```bicep
@description('Application name')
param appName string

@description('Environment (dev, staging, prod)')
@allowed(['dev', 'staging', 'prod'])
param environment string

@description('Azure region')
param location string = resourceGroup().location

@description('App Service Plan SKU')
param appServicePlanSku string = 'B2'

@secure()
@description('Database connection string')
param databaseConnectionString string
```

**parameters.dev.json** - Dev environment
```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "appName": {
      "value": "myapp"
    },
    "environment": {
      "value": "dev"
    },
    "location": {
      "value": "swedencentral"
    },
    "appServicePlanSku": {
      "value": "B1"
    }
  }
}
```

**parameters.prod.json** - Production environment
```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "appName": {
      "value": "myapp"
    },
    "environment": {
      "value": "prod"
    },
    "location": {
      "value": "swedencentral"
    },
    "appServicePlanSku": {
      "value": "P1v3"
    }
  }
}
```

### Module Structure

```
infrastructure/
├── bicep/
│   ├── main.bicep                    # Main orchestration
│   ├── modules/
│   │   ├── app-service.bicep         # App Service + Plan
│   │   ├── key-vault.bicep           # Key Vault
│   │   ├── postgresql.bicep          # Azure PostgreSQL
│   │   ├── monitoring.bicep          # Application Insights
│   │   ├── network.bicep             # VNet, NSG, Private Endpoints
│   │   └── storage.bicep             # Storage Account
│   └── parameters/
│       ├── parameters.dev.json       # Dev environment
│       ├── parameters.staging.json   # Staging environment
│       └── parameters.prod.json      # Production environment
└── README.md                          # Deployment instructions
```

---

## Complete Bicep Examples

### 1. App Service Module

**modules/app-service.bicep:**
```bicep
@description('Application name')
param appName string

@description('Environment')
param environment string

@description('Azure region')
param location string

@description('App Service Plan SKU')
param appServicePlanSku string

@description('Common resource tags')
param tags object

@description('Key Vault name for secret references')
param keyVaultName string

@description('Application Insights connection string')
param appInsightsConnectionString string

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'plan-${appName}-${environment}'
  location: location
  tags: tags
  sku: {
    name: appServicePlanSku
    tier: startsWith(appServicePlanSku, 'B') ? 'Basic' : startsWith(appServicePlanSku, 'S') ? 'Standard' : 'PremiumV3'
  }
  kind: 'linux'
  properties: {
    reserved: true  // Required for Linux
  }
}

// App Service
resource appService 'Microsoft.Web/sites@2023-01-01' = {
  name: 'app-${appName}-${environment}'
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'  // Managed identity for Key Vault access
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true  // Force HTTPS
    siteConfig: {
      linuxFxVersion: 'PYTHON|3.11'
      alwaysOn: environment == 'prod' ? true : false
      minTlsVersion: '1.2'
      ftpsState: 'Disabled'  // Disable FTP
      http20Enabled: true
      appSettings: [
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsightsConnectionString
        }
        {
          name: 'SCM_DO_BUILD_DURING_DEPLOYMENT'
          value: 'true'
        }
        {
          name: 'ENABLE_ORYX_BUILD'
          value: 'true'
        }
        {
          name: 'DJANGO_SETTINGS_MODULE'
          value: 'config.settings.${environment}'
        }
        {
          name: 'DATABASE_URL'
          value: '@Microsoft.KeyVault(SecretUri=https://${keyVaultName}.vault.azure.net/secrets/DatabaseUrl/)'
        }
        {
          name: 'DJANGO_SECRET_KEY'
          value: '@Microsoft.KeyVault(SecretUri=https://${keyVaultName}.vault.azure.net/secrets/DjangoSecretKey/)'
        }
      ]
    }
  }
}

// Deployment slot (staging) for production
resource stagingSlot 'Microsoft.Web/sites/slots@2023-01-01' = if (environment == 'prod') {
  parent: appService
  name: 'staging'
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'PYTHON|3.11'
      alwaysOn: true
    }
  }
}

output appServiceId string = appService.id
output appServiceName string = appService.name
output appServicePrincipalId string = appService.identity.principalId
output appServiceDefaultHostname string = appService.properties.defaultHostName
```

### 2. Key Vault Module

**modules/key-vault.bicep:**
```bicep
@description('Application name')
param appName string

@description('Environment')
param environment string

@description('Azure region')
param location string

@description('Common resource tags')
param tags object

@description('Object ID of App Service managed identity')
param appServicePrincipalId string

@description('Enable soft delete')
param enableSoftDelete bool = true

@description('Enable purge protection')
param enablePurgeProtection bool = true

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: 'kv-${appName}-${environment}'
  location: location
  tags: tags
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    enableSoftDelete: enableSoftDelete
    softDeleteRetentionInDays: 90
    enablePurgeProtection: enablePurgeProtection ? true : null
    enableRbacAuthorization: false  // Using access policies
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: appServicePrincipalId
        permissions: {
          secrets: [
            'get'
            'list'
          ]
        }
      }
    ]
    networkAcls: {
      defaultAction: 'Allow'  // Change to 'Deny' for private endpoint
      bypass: 'AzureServices'
    }
  }
}

// Grant Key Vault Secrets User role to App Service (RBAC alternative)
// Uncomment if using RBAC instead of access policies
// resource keyVaultRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
//   scope: keyVault
//   name: guid(keyVault.id, appServicePrincipalId, 'Key Vault Secrets User')
//   properties: {
//     roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4633458b-17de-408a-b874-0445c86b69e6')
//     principalId: appServicePrincipalId
//     principalType: 'ServicePrincipal'
//   }
// }

output keyVaultId string = keyVault.id
output keyVaultName string = keyVault.name
output keyVaultUri string = keyVault.properties.vaultUri
```

### 3. Application Insights Module

**modules/monitoring.bicep:**
```bicep
@description('Application name')
param appName string

@description('Environment')
param environment string

@description('Azure region')
param location string

@description('Common resource tags')
param tags object

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: 'log-${appName}-${environment}'
  location: location
  tags: tags
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: environment == 'prod' ? 90 : 30
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
  }
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appi-${appName}-${environment}'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
    RetentionInDays: environment == 'prod' ? 90 : 30
  }
}

// Alert rules
resource highErrorRateAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'High Error Rate - ${appName}-${environment}'
  location: 'global'
  tags: tags
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
          name: 'HighErrorRate'
          metricName: 'exceptions/count'
          operator: 'GreaterThan'
          threshold: 10
          timeAggregation: 'Total'
        }
      ]
    }
  }
}

output applicationInsightsId string = applicationInsights.id
output applicationInsightsName string = applicationInsights.name
output instrumentationKey string = applicationInsights.properties.InstrumentationKey
output connectionString string = applicationInsights.properties.ConnectionString
output workspaceId string = logAnalyticsWorkspace.id
```

### 4. Main Orchestration

**main.bicep:**
```bicep
@description('Application name')
param appName string

@description('Environment (dev, staging, prod)')
@allowed(['dev', 'staging', 'prod'])
param environment string

@description('Azure region')
param location string = resourceGroup().location

@description('App Service Plan SKU')
param appServicePlanSku string

@description('Owner email or team')
param owner string

@description('Cost center for billing')
param costCenter string

@description('Project name')
param projectName string

// Common tags
var tags = {
  Environment: environment
  Project: projectName
  CostCenter: costCenter
  ManagedBy: 'IaC-Bicep'
  Owner: owner
  Compliance: 'GDPR'
  DataClassification: 'confidential'
  BackupRequired: 'true'
  CreatedDate: utcNow()
}

// Deploy Application Insights first
module monitoring 'modules/monitoring.bicep' = {
  name: 'monitoring-deployment'
  params: {
    appName: appName
    environment: environment
    location: location
    tags: tags
  }
}

// Deploy App Service (with temp managed identity)
module appService 'modules/app-service.bicep' = {
  name: 'app-service-deployment'
  params: {
    appName: appName
    environment: environment
    location: location
    appServicePlanSku: appServicePlanSku
    tags: tags
    keyVaultName: 'kv-${appName}-${environment}'  // Reference before created
    appInsightsConnectionString: monitoring.outputs.connectionString
  }
}

// Deploy Key Vault with access for App Service
module keyVault 'modules/key-vault.bicep' = {
  name: 'key-vault-deployment'
  params: {
    appName: appName
    environment: environment
    location: location
    tags: tags
    appServicePrincipalId: appService.outputs.appServicePrincipalId
    enableSoftDelete: true
    enablePurgeProtection: environment == 'prod' ? true : false
  }
}

// Outputs
output resourceGroupName string = resourceGroup().name
output appServiceName string = appService.outputs.appServiceName
output appServiceUrl string = 'https://${appService.outputs.appServiceDefaultHostname}'
output keyVaultName string = keyVault.outputs.keyVaultName
output applicationInsightsName string = monitoring.outputs.applicationInsightsName
```

---

## Deployment Commands

### Deploy to Azure

```bash
# 1. Login to Azure
az login

# 2. Set subscription
az account set --subscription "<subscription-id>"

# 3. Create resource group
az group create \
  --name "rg-myapp-dev-swedencentral" \
  --location "swedencentral" \
  --tags "Environment=dev" "ManagedBy=IaC-Bicep"

# 4. Validate template
az deployment group validate \
  --resource-group "rg-myapp-dev-swedencentral" \
  --template-file infrastructure/bicep/main.bicep \
  --parameters infrastructure/bicep/parameters/parameters.dev.json

# 5. Deploy (with what-if preview)
az deployment group what-if \
  --resource-group "rg-myapp-dev-swedencentral" \
  --template-file infrastructure/bicep/main.bicep \
  --parameters infrastructure/bicep/parameters/parameters.dev.json

# 6. Deploy for real
az deployment group create \
  --resource-group "rg-myapp-dev-swedencentral" \
  --template-file infrastructure/bicep/main.bicep \
  --parameters infrastructure/bicep/parameters/parameters.dev.json \
  --mode Incremental

# 7. Get outputs
az deployment group show \
  --resource-group "rg-myapp-dev-swedencentral" \
  --name "main" \
  --query properties.outputs
```

### Add Secrets to Key Vault

```bash
# After infrastructure deployment, add secrets

KEY_VAULT_NAME="kv-myapp-dev"

# Database URL
az keyvault secret set \
  --vault-name "$KEY_VAULT_NAME" \
  --name "DatabaseUrl" \
  --value "postgresql://user:pass@server.postgres.database.azure.com:5432/db?sslmode=require"

# Django Secret Key
DJANGO_SECRET=$(python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
az keyvault secret set \
  --vault-name "$KEY_VAULT_NAME" \
  --name "DjangoSecretKey" \
  --value "$DJANGO_SECRET"
```

---

## Testing Infrastructure

### Validation Checklist

```bash
# 1. Bicep syntax validation
az bicep build --file main.bicep

# 2. Template validation against Azure
az deployment group validate \
  --resource-group <rg-name> \
  --template-file main.bicep \
  --parameters parameters.json

# 3. What-if analysis (preview changes)
az deployment group what-if \
  --resource-group <rg-name> \
  --template-file main.bicep \
  --parameters parameters.json

# 4. Deploy to test environment
# Always test in dev before staging/prod

# 5. Verify resource creation
az resource list --resource-group <rg-name> --output table

# 6. Test App Service deployment
curl https://app-myapp-dev.azurewebsites.net/health

# 7. Test Key Vault access from App Service
# Check App Service logs for successful secret retrieval

# 8. Test Application Insights
# Generate traffic and verify telemetry in Azure Portal
```

---

## Best Practices

### 1. Idempotency
- Ensure deployments can be run multiple times safely
- Use `mode: Incremental` for updates
- Use `mode: Complete` carefully (deletes resources not in template)

### 2. Secrets Management
- ❌ **Never** hardcode secrets in Bicep files
- ✅ Use `@secure()` decorator for sensitive parameters
- ✅ Store secrets in Key Vault
- ✅ Reference secrets with Key Vault references in App Service

### 3. Environment Separation
- Separate resource groups per environment (dev, staging, prod)
- Separate parameter files per environment
- Consider separate subscriptions for production isolation

### 4. Resource Naming
- Follow consistent naming convention
- Include environment in names
- Use short names for storage accounts (24 char limit)

### 5. Cost Management
- Tag all resources for cost allocation
- Use appropriate SKUs per environment (cheaper for dev)
- Enable auto-shutdown for non-production resources

### 6. Documentation
- Document all parameters in Bicep files
- Include deployment instructions in README.md
- Document any manual steps (rare, but necessary for initial setup)

---

## Common Patterns

### Pattern: Multi-Environment Deployment

```bash
# Deploy same template to multiple environments
for ENV in dev staging prod; do
  az deployment group create \
    --resource-group "rg-myapp-$ENV-swedencentral" \
    --template-file main.bicep \
    --parameters parameters.$ENV.json
done
```

### Pattern: Blue-Green Deployment

```bicep
// Use deployment slots for zero-downtime deployment
resource stagingSlot 'Microsoft.Web/sites/slots@2023-01-01' = {
  parent: appService
  name: 'staging'
  // ... configuration
}

// After validation, swap slots
// az webapp deployment slot swap \
//   --resource-group <rg> \
//   --name <app-name> \
//   --slot staging \
//   --target-slot production
```

### Pattern: Conditional Resources

```bicep
// Only create staging slot for production
resource stagingSlot 'Microsoft.Web/sites/slots@2023-01-01' = if (environment == 'prod') {
  parent: appService
  name: 'staging'
  // ... configuration
}

// Only enable purge protection for production
enablePurgeProtection: environment == 'prod' ? true : false
```

---

## Troubleshooting

### Issue: Deployment Fails with RBAC Error

```
Solution: Ensure your Azure account has Contributor role on the subscription/resource group.

az role assignment create \
  --assignee <your-email> \
  --role Contributor \
  --scope /subscriptions/<subscription-id>/resourceGroups/<rg-name>
```

### Issue: Key Vault Access Denied from App Service

```
Solution: Verify managed identity has access policy or RBAC role.

# Check App Service identity
az webapp identity show --resource-group <rg> --name <app-name>

# Grant access
az keyvault set-policy \
  --name <kv-name> \
  --object-id <app-service-principal-id> \
  --secret-permissions get list
```

### Issue: App Service Can't Retrieve Secrets

```
Solution: Check Key Vault reference format in App Service settings.

Correct format:
@Microsoft.KeyVault(SecretUri=https://kv-name.vault.azure.net/secrets/secret-name/)

# Verify in Azure Portal or CLI
az webapp config appsettings list --resource-group <rg> --name <app-name>
```

---

## Security Checklist

Before deploying infrastructure:

- [ ] No secrets in Bicep files (use `@secure()` parameters)
- [ ] All secrets stored in Key Vault
- [ ] Managed identity configured for App Service
- [ ] HTTPS enforced on App Service
- [ ] TLS 1.2/1.3 minimum version
- [ ] FTP disabled on App Service
- [ ] Soft-delete enabled on Key Vault
- [ ] Purge protection enabled on production Key Vault
- [ ] Proper RBAC assignments (least privilege)
- [ ] All resources tagged appropriately
- [ ] Application Insights configured
- [ ] Alert rules configured
- [ ] Diagnostic logs enabled
- [ ] Resources deployed to correct region (Sweden Central for GDPR)

---

**Remember:** Infrastructure as Code is not just about automation—it's about **reliability, security, and reproducibility**. Treat your Bicep files with the same care as application code: version control, code review, testing, and documentation.
