# Behavioral Alchemy — Few-shot Examples

Example 1 — Using analytics + feature flag

User: "Onboarding completion is 18% at step 3. How would you improve it?"

Agent (steps):
1. Query `analytics-config` for current funnel counts (new users entering step 1 → step 3 → completion).
2. Propose 3 reframes. For the chosen pilot, create an Optimizely flag `prefill-claim-v1` and roll out 30% to new users.
3. Configure Qualtrics micro-survey for treated users: two questions (Why did you confirm pre-filled data? What stopped you from completing?).

Example output snippet (short):
- Contrarian opener: "Have you tried making them believe they've already finished?"

1) Pre-fill Claim (chosen pilot)
- Mechanism: Default / Endowment
- Experiment Plan: Analytics baseline: onboarding completion = 18%. Create flag `prefill-claim-v1` (Optimizely) → rollout 30% of new users; Duration 4 weeks; Primary metric: step 3 → completion rate. Attach Qualtrics micro-survey to treatment cohort.
- Ethics note: Pre-fill using prior-quarter snapshots; require explicit confirmation before saving.

Example 2 — When MCPs are unavailable

User: "We don't have analytics access yet — what low-cost test can we run?"

Agent:
- Propose lightweight manual pilot: implement pre-filled CSV confirmation for two manager areas; ask managers to confirm by email; measure time-to-submit manually for 6 weeks. Recommend instrumenting analytics when possible.

Example 3 — Sourcing rhetoric

User: "Add a memorable quote to the challenge report."

Agent:
- If `youtube-config` available: fetch transcript for 'Rory Sutherland TED' and extract a one-line quote about perception vs reality. If not available, use a concise paraphrase and cite _Alchemy_.
