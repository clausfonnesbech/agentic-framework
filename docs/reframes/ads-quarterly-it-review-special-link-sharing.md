- Contrarian opener: What if the share link felt less like a leak and more like a guest badge into a carefully prepared review room?

1. Guest Review Link
- Change: Label the feature as a guest review link, not a special link; show clear scope and expiry metadata at the top of the shared storybook view.
- Mechanism: Uncertainty reduction and visible safety. People share more confidently when the bounds are obvious.
- Experiment: Pilot with one quarter review. Compare share-link usage and post-meeting confidence feedback against a plain-link variant.
- Risk & Effort: Low.

2. Curated Story, Not Raw Access
- Change: Default sharers to full-session mode, then offer an explicit "selected KPIs only" option for focused follow-up conversations.
- Mechanism: Choice architecture and effort minimisation. Most users want the obvious default; a smaller group wants deliberate curation.
- Experiment: Track how often users keep the default versus curate KPI subsets, and whether curated links lead to faster review preparation.
- Risk & Effort: Low to medium.

3. Trust Through Bounds
- Change: Always hide the presentation timer, show a small shared-view badge, and make the link revocable and time-bound.
- Mechanism: Loss-aversion reduction and signalling. The sharer feels safe because the link visibly cannot sprawl.
- Experiment: Short qualitative check after two leadership reviews: "Did you feel in control of what the recipient could see?"
- Risk & Effort: Medium because the security model matters.

Recommended pilot: Ship the feature with calm microcopy such as `Guest review link`, `Shared view only`, `Limited to selected KPIs`, and `Expires on ...`. Measure whether leadership uses the feature without asking for manual reassurance from admins.

Ethics note: Bounds and expiry should be real, not decorative. The UI should explain the restriction truthfully and let the sharer revoke access.

Takeaway: Make sharing feel safe, intentional, and curated rather than technically possible.