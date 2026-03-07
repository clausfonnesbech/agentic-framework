# Experiment Design Skill

Purpose
- Provide practical templates and rules-of-thumb for A/B tests, pilots, and rapid behavioral experiments the agent recommends.

When to use
- Whenever a reframe or intervention is proposed; include a clear experiment plan (control, treatment, sample, duration, primary metric, success threshold).

Quick A/B Template
- Control: [current flow]
- Treatment: [description of reframe]
- Sample: [N users | % traffic | specific cohorts]
- Duration: [days/weeks]
- Primary metric: [single KPI — e.g., onboarding completion rate]
- Success threshold: [absolute or relative uplift]

Sample-size heuristics (rules of thumb)
- Small pilots / qualitative: 50–200 users (to validate feasibility and detect large effects)
- Medium A/B: 1k–10k users (detect moderate effects in common funnels)
- Large A/B: 10k+ users (needed for small % lifts or low-frequency events)
- When in doubt, prioritize strong directional signal + rapid iteration over under-powered precision.

Analysis checklist
- Pre-register primary metric and success threshold
- Monitor for novelty effects early in experiment
- Segment by key cohorts (new vs returning, role, geography)
- Check for implementation bias (logging completeness, sampling imbalance)
- Stop rule: pre-defined time or sample reached; avoid peeking-driven decisions

Instrumentation checklist
- Ensure events for control & treatment are distinct and firing
- Log user identifiers, cohort assignment, timestamp
- Track secondary metrics for safety signals (errors, drop-off)

Ethics & Consent
- For interventions that publish personal narratives or signal status, require explicit opt-in

Example experiment snippets
- "Pre-fill confirm": Control = manual upload; Treatment = pre-filled values + one-click confirm; Sample = 50% of managers for 6 weeks; Primary metric = median time-to-submit
