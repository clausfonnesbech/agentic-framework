# {{PROJECT_NAME}}

{{PROJECT_DESCRIPTION}}

## Getting Started

### Prerequisites
- {{RUNTIME_PREREQUISITES}} (determined during project setup)
- Any optional local tooling selected by the project

### Local Development Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd projects/{{PROJECT_FOLDER_NAME}}
   ```

2. **Install dependencies**
   ```bash
   # Follow the setup instructions in docs/deployment.md
   ```

3. **Configure environment**
   ```bash
   cp .env.example .env
   # Edit .env with your local settings
   ```

4. **Run locally**
   ```bash
   # See docs/deployment.md for project-specific run commands
   ```

## Project Structure

```
{{PROJECT_FOLDER_NAME}}/
├── .project-context.md      # Project context for agents
├── README.md                 # This file
├── .env.example             # Environment template
├── src/                     # Application source code
├── infrastructure/          # IaC templates chosen for this project
├── docs/                    # Project documentation
│   ├── architecture.md
│   ├── api-spec.md
│   └── deployment.md
├── backlog/                 # User stories & tasks
│   ├── sprint-01/
│   └── backlog.md
└── tests/                   # Test suite
    ├── unit/
    ├── integration/
    └── e2e/
```

## Deployment

See [docs/deployment.md](docs/deployment.md) for detailed deployment instructions.

## Documentation

- [Architecture](docs/architecture.md)
- [API Specification](docs/api-spec.md)
- [Deployment Guide](docs/deployment.md)

## Contributing

This project is managed using the Agentic Framework. See the main repository documentation for contribution guidelines.

## License

{{LICENSE}}
