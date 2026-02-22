# IT Quarterly Review — Sutherland Challenge Report

## Rational Review
- The BA proposal sensibly replaces manual PowerPoint consolidation with a centralized, secure dashboard and weekly snapshot pipeline. It addresses obvious operational pain (data gathering, inconsistent KPI calculations, lack of trends, and security risks) with a practical, engineering-forward MVP (CSV uploads, validated ingestion, RBAC via Azure AD).
- The plan is technically coherent, low-risk, and scoped for the short timeline. However, it treats the problem primarily as an engineering/data-flow challenge (build the canonical source of truth) rather than as a behavioral problem about how managers and leadership *perceive* reporting, effort, and ownership.

## Behavioral Blind Spots
- Assumes managers will reliably upload CSVs and care enough about the system to change behaviour; ignores effort aversion and task prioritisation — reporting is low-status work.
- Treats consistency as a purely technical problem; ignores signalling and social incentives that lead managers to cut corners or adopt ad-hoc definitions.
- Misses an opportunity to reframe the output as a visible signal for managers (status, recognition) and for leadership (actionable, curated insights) instead of a tedious compliance task.
- Overlooks uncertainty and anxiety drivers: managers may delay submission because they fear being judged on 'imperfect' numbers.

## Counterintuitive Proposals
| Original Idea | Sutherland Twist | Expected Impact |
|---|---:|---|
| CSV upload + validation | "Quarterly Showcase": convert manager inputs into a curated 'public' showcase page for each area, spotlighting one success story per manager | Signals status; increases care & timely submissions; higher-quality narratives |
| Manual CSV upload by manager | "Pre-filled Claim" default: pre-populate KPI values from historical snapshots and ask managers to confirm/adjust (opt-out) | Reduces friction; leverages default effect; quicker completion rates |
| Separate Manager narrative + Leadership dashboard | "Ceremony & Slotting": allocate short, scheduled leadership review slots tied to managers' submissions and publicise the review agenda | Creates scarcity and social accountability; timely submissions; better preparedness |
| Security-first engineering focus | "Perceived Safety Cues": prominently show audit/permission badges + 'trusted export' indicators when managers submit (visual signals of compliance) | Reduces anxiety about data sharing; increases willingness to centralise sensitive data |

## Experiment Plans (one per proposal)

1) Quarterly Showcase
- Control: Standard manager dashboard + CSV upload
- Treatment: Manager page includes a curated showcase tile (public to leadership) with a highlighted 'success story' and optional image
- Sample: Roll out to 4 manager areas (2 control, 2 treatment) for one quarter
- Duration: 1 quarter (12 weeks)
- Primary metric: % of on-time submissions; secondary: narrative quality score (leadership rating 1–5)
- Success threshold: +25% on-time submissions or +0.5 leadership rating
- Risk & Effort: Low-Medium (UI + small editorial flow)

2) Pre-filled Claim Default
- Control: Manual CSV upload only
- Treatment: System pre-fills KPI values from previous snapshot and flags differences for manager confirmation (one-click confirm)
- Sample: A/B across managers (toggle by area) for org-wide pilot
- Duration: 6 weeks
- Primary metric: median time-to-submit per manager; Secondary: number of manual edits
- Success threshold: 40% reduction in time-to-submit
- Risk & Effort: Low (UX + backend prefill logic)

3) Ceremony & Slotting
- Control: Leadership uses dashboards ad-hoc
- Treatment: Scheduled 10–15 minute review slots per manager; leadership sees 'submission readiness' and an agenda before meeting
- Sample: Test with Leadership + 2 studio managers for 6 weeks
- Duration: 6–8 weeks
- Primary metric: % of managers submitting before slot; Secondary: leadership satisfaction with discussion quality
- Success threshold: 60% pre-slot submissions; +20% leadership satisfaction
- Risk & Effort: Low (process + calendar invites)

4) Perceived Safety Cues
- Control: Standard security notices buried in docs
- Treatment: Immediate visual badges on forms: "Audit-logged • Sweden-resident • Encrypted" and a short line: "Your data is handled per policy X — shown to leadership only as aggregate unless you opt-in"
- Sample: A/B across managers or toggle in staging
- Duration: 4 weeks
- Primary metric: willingness to consolidate sensitive data (measured by number of OneTrust-related KPIs uploaded centrally)
- Success threshold: +30% uptake in OneTrust KPI centralisation
- Risk & Effort: Very Low (copy + UI badges)

## Risks of Rationality
- Building a technically flawless system does not guarantee adoption — behaviour, status, and incentives often determine whether digital tools replace legacy practices.
- Over-reliance on process automation (CSV ingestion) risks creating a black-box that reduces managers' narrative ownership and accountability.
- Treating leadership as passive consumers ignores their signalling role: they must visibly value and act on the new outputs for managers to care.

## Approval Gates
- Does the proposal change perception of reporting (status, ownership, safety)? ✅/❌
- Has at least one counterintuitive pilot been run and met its success threshold? ✅/❌
- Are ethical boundaries documented (consent for making narratives public)? ✅/❌
- Ready for UX/UI handoff? (Only if above checks pass.) ✅/❌

## Quick Recommendations (practical)
- Ship "Pre-filled Claim" as the fastest, lowest-effort pilot — likely to produce the biggest immediate drop in time-to-submit.
- Add one visible 'Showcase' tile to the Leadership dashboard to test signalling effects; keep content easy to publish (one-line + image).
- Use calendar 'slotting' for one quarter's reviews to create social accountability — low-cost, high-return.
- Add security badges and one-line privacy copy on submission forms to reduce anxiety and increase centralisation.

## One-line Takeaway
Logic built the platform; perception will decide if anyone uses it. Make reporting feel worth doing.

Generated by the Behavioral Alchemy Agent — use as the `docs/02-challenges/it-quarterly-review-sutherland-challenge.md` handoff for BA → UX/UI.
