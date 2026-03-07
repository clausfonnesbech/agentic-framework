# MCP Credentials Template

Placeholders and example variables for MCP servers added to this repo. Do NOT commit real secrets to the repository. Store real credentials in your runtime secret store or CI/CD secret vault and reference them in agent runtime configuration.

Example environment variables (copy into your secure runtime or `.env` file):

```
# Analytics (GA4 / Amplitude / Mixpanel)
ANALYTICS_API_KEY=YOUR_ANALYTICS_API_KEY
ANALYTICS_API_BASE=https://analytics.example.com

# Experimentation / Feature flagging (Optimizely / LaunchDarkly)
OPTIMIZELY_API_KEY=YOUR_OPTIMIZELY_API_KEY
OPTIMIZELY_API_BASE=https://flags.example.com

# Surveys (Qualtrics / Typeform)
QUALTRICS_API_TOKEN=YOUR_QUALTRICS_API_TOKEN
QUALTRICS_API_BASE=https://survey.example.com

# YouTube Data API (for transcripts)
YOUTUBE_API_KEY=YOUR_YOUTUBE_DATA_API_KEY

# Example: Git remote
GIT_REMOTE=https://github.com/clausfonnesbech/agentic-framework.git
GIT_BRANCH=chore/azure-python-enhancements
```

Security guidance

- NEVER commit API keys to source control. Use your CI/CD secrets manager (GitHub Secrets, Azure Key Vault, etc.).
- Use least-privilege tokens (read-only for analytics where possible, scoped management tokens for feature flags).
- Rotate keys periodically and restrict IP ranges if supported.
