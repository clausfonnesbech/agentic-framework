# Canned Reframes & Experiment Examples

Short library of 12 ready-to-run reframes inspired by Rory Sutherland: each item includes a one-line contrarian opener, the change, mechanism, a concrete experiment (control vs treatment, sample/timeframe, primary metric), risk/effort, and a short copy/UI snippet where relevant.

1) "Have you tried making them feel they've already won?" — Endowment
- Change: Present starter content or a 'welcome pack' as already saved in the account
- Mechanism: Endowment / ownership bias
- Experiment: Randomize new signups (N=10k) for 14 days; metric: onboarding completion rate
- Risk & Effort: Low (UI + small backend flag)
- Copy: "Welcome — your starter kit is waiting (see it in My Stuff)"

2) "What if price anchored upward made everything feel cheaper?" — Anchor Pricing
- Change: Show a clearly labeled premium tier at high price as an anchor on pricing page
- Mechanism: Anchoring effect
- Experiment: 50/50 split visitors; metric: average revenue per user (ARPU), conversion
- Risk & Effort: Low (pricing page copy + layout)
- Copy: [Anchor label] "Premium Pro — $199/mo" then main tier: "Starter — $29/mo"

3) "Can a small, immediate gift change long-term habits?" — Immediate Reward
- Change: Give a tangible small reward (e.g., coffee voucher) after first action
- Mechanism: Reciprocity / immediate reinforcement
- Experiment: Control vs voucher cohort (N=5k) for 30 days; metric: 30-day retention
- Risk & Effort: Medium (cost of reward, redemption flow)
- Copy: "Get a $5 coffee on us after your first completed project"

4) "Is friction the enemy or the signal?" — Reduce Decision Friction
- Change: Pre-select the most common option as default and simplify choices to 2
- Mechanism: Satisficing / effort minimization
- Experiment: AB test default vs no-default (N=20k sessions) for 2 weeks; metric: completion rate
- Risk & Effort: Low (UX change)
- Copy: "Most users pick: [Recommended option] — selected for you"

5) "Could changing the story change the sale?" — Narrative Micro-Headline
- Change: Replace feature list with a one-sentence story describing transformation
- Mechanism: Storytelling heuristic / mental simulation
- Experiment: AB headline test on landing page (N=50k) for 2 weeks; metric: signup rate
- Risk & Effort: Very Low (copy+headline)
- Copy: "From zero to confident reporting in under 10 minutes"

6) "What if scarcity was about time, not inventory?" — Time-Bound Exclusivity
- Change: Offer short, clearly-explained limited-time onboarding slots or cohort access
- Mechanism: Scarcity / urgency
- Experiment: Show time-limited CTA vs evergreen CTA (N=20k) for 7 days; metric: conversion uplift
- Risk & Effort: Low (copy + scheduler)
- Copy: "Join our next onboarding cohort — limited seats this week"

7) "Why not make the social norm visible?" — Local Social Proof
- Change: Display local or peer-group stats (e.g., "X companies in your sector use this")
- Mechanism: Social proof / identity signaling
- Experiment: Regionalized proof vs generic proof (N=10k) for 2 weeks; metric: activation rate
- Risk & Effort: Low-Medium (data sourcing)
- Copy: "Trusted by 24 marketing teams in your city"

8) "Could a small default calendar slot beat a scheduling email?" — Default Scheduling
- Change: Offer a pre-booked onboarding slot users can opt out of (opt-out default)
- Mechanism: Default effect / inertia
- Experiment: Offer pre-booked vs self-schedule (N=4k invites) for 30 days; metric: attendance rate
- Risk & Effort: Medium (calendar integration)
- Copy: "We've tentatively booked you: Tue 10am — click to reschedule"

9) "What if perceived quality trumped feature counts?" — Perception Cues
- Change: Add subtle premium cues (packaging, photography, micro-animations) to the paid flow
- Mechanism: Placebo / perceived quality
- Experiment: Premium-cues variant vs baseline (N=15k) for 3 weeks; metric: paid conversion rate
- Risk & Effort: Medium (design work)
- Example: polished hero image + testimonial carousel

10) "Can we turn cancellations into a conversation?" — Exit Reframe
- Change: On cancel flow, offer a one-click 'pause' and a tiny immediate benefit if they stay (e.g., credit)
- Mechanism: Loss aversion + friction to cancel reduced to pause option
- Experiment: Cancel vs pause offer (N=3k cancels) for 30 days; metric: net churn reduction
- Risk & Effort: Low-Medium (billing logic)
- Copy: "Pause your plan for 30 days and keep your settings — or cancel now"

11) "Why not frame trial as 'temporary ownership'?" — Trial Endowment
- Change: During trial, create an 'owned' dashboard item (saved preferences, curated content) and email reminders emphasizing ownership
- Mechanism: Endowment + foot-in-the-door
- Experiment: Trial-with-endowment vs plain trial (N=8k trials) for trial length; metric: trial-to-paid conversion
- Risk & Effort: Low (copy + dashboard widget)
- Copy: "Your curated workspace is waiting — keep it after trial"

12) "Can re-engagement be made ceremonious?" — Ritualized Re-Entry
- Change: When dormant users return, present a brief celebratory micro-experience (progress recap + small celebratory badge)
- Mechanism: Reinforcement + identity signaling
- Experiment: Re-entry ritual vs standard welcome (N=10k reactivations) for 4 weeks; metric: 30-day active retention
- Risk & Effort: Low-Medium (UI small component)
- Copy: "Welcome back! Here's what you missed — claim your comeback badge"

---

Experiment Template (copy to reuse):

- Control: current flow
- Treatment: [describe variant]
- Sample: [N or % of traffic]
- Duration: [days/weeks]
- Primary metric: [single KPI]
- Success threshold: [meaningful uplift]

If you want, I can generate AB test code snippets, copy variations in CSV, or tailor these reframes to a specific product or user segment.
