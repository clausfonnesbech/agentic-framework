# {{PROJECT_NAME}}

{{PROJECT_DESCRIPTION}}

## Getting Started

### Prerequisites
- Python 3.11+
- Azure CLI
- Docker (optional)

### Local Development Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd projects/{{PROJECT_FOLDER_NAME}}
   ```

2. **Install dependencies**
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   pip install -r requirements.txt
   ```

3. **Configure environment**
   ```bash
   cp .env.example .env
   # Edit .env with your local settings
   ```

4. **Run locally**
   ```bash
   python src/manage.py runserver
   ```

## Project Structure

```
{{PROJECT_FOLDER_NAME}}/
├── .project-context.md      # Project context for agents
├── README.md                 # This file
├── requirements.txt          # Python dependencies
├── .env.example             # Environment template
├── src/                     # Application source code
│   ├── main.py
│   └── ...
├── infrastructure/          # IaC (Bicep templates)
│   ├── main.bicep
│   ├── parameters.json
│   └── modules/
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
