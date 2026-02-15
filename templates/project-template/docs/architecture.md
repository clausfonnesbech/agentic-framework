# {{PROJECT_NAME}} - Architecture

## System Overview

{{HIGH_LEVEL_DESCRIPTION}}

## Architecture Diagram

```
[Add architecture diagram here using Mermaid or embedded image]
```

## Components

### Frontend
- **Technology:** {{FRONTEND_TECH}}
- **Hosting:** {{FRONTEND_HOSTING}}
- **Key Features:**

### Backend
- **Technology:** {{BACKEND_TECH}}
- **Hosting:** Azure App Service (Sweden Central)
- **Key Features:**

### Database
- **Technology:** {{DATABASE_TYPE}}
- **Hosting:** {{DATABASE_HOSTING}}
- **Schema Design:** [Link to schema documentation]

### Infrastructure
- **IaC Tool:** Azure Bicep
- **CI/CD:** GitHub Actions
- **Monitoring:** Application Insights

## Security Architecture

### Authentication & Authorization
- Method: {{AUTH_METHOD}}
- Provider: {{AUTH_PROVIDER}}

### Data Protection
- Encryption at rest: Azure Storage Encryption
- Encryption in transit: TLS 1.3
- Secrets management: Azure Key Vault

### Network Security
- VNet configuration
- NSG rules
- Private endpoints (if applicable)

## Data Flow

```
[Describe data flow through the system]
```

## Scalability & Performance

### Scaling Strategy
- Horizontal scaling: {{SCALING_APPROACH}}
- Caching: {{CACHING_STRATEGY}}
- CDN: {{CDN_USAGE}}

### Performance Targets
- Response time: < {{TARGET_MS}}ms (p95)
- Throughput: {{TARGET_RPS}} requests/second
- Availability: {{SLA_TARGET}}

## Disaster Recovery

- **RTO:** {{RECOVERY_TIME_OBJECTIVE}}
- **RPO:** {{RECOVERY_POINT_OBJECTIVE}}
- **Backup strategy:** {{BACKUP_STRATEGY}}

## Observability

### Monitoring
- Application Insights dashboards
- Custom metrics
- Log aggregation

### Alerting
- Critical alerts
- Warning alerts
- SLO monitoring

## Architecture Decision Records (ADRs)

### ADR-001: [Decision Title]
- **Status:** Accepted
- **Context:** Why this decision was needed
- **Decision:** What was decided
- **Consequences:** Impact of the decision

## Dependencies

### External Services
- Service 1: Purpose
- Service 2: Purpose

### Shared Infrastructure
- Common modules from `/shared/common-infrastructure/`
- Shared utilities from `/shared/utilities/`

## Future Considerations

- Planned improvements
- Known limitations
- Technology evaluation
