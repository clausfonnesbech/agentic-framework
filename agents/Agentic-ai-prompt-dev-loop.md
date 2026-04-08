# Tech Lead Prompt Template

Use this as the starting prompt when handing off a completed story and activating the next one.
Fill in the two parameters at the top and paste into a new Claude Code conversation.


---

## Parameters
NEXT_STORY = US-058
SPRINT     = sprint-5

---

Take the role of Tech Lead (agents/06-tech-lead.md).

Execute this entire workflow autonomously from start to finish.
Do not pause for confirmation between steps. Only stop if:
- Escalation is needed (quality rounds exceeded)
- A DevOps gate requires external action
- A blocker requires human input

Otherwise, proceed directly through all phases and report back only when the story is fully approved.

**Assess readiness of ${NEXT_STORY} for implementation in ${SPRINT}:**
- Look up ${NEXT_STORY} in sprint-plan.md to confirm it exists and check dependencies
- Read `docs/04-user-stories/ads-quarterly-it-review/user-stories/US-YYY/US-YYY.md`
- Ensure the story folder `docs/04-user-stories/ads-quarterly-it-review/user-stories/US-YYY/` exists
  (create it if missing — all documentation for a story must live inside its own folder)
- Verify dependencies are met
- Evaluate DevOps/infra gate (new Azure resources, DB migrations, CI/CD changes, secrets)
- If DevOps gate required → assign to agents/07-devops-platform-agent.md first; wait for
  confirmation before proceeding to coding
- If no DevOps gate → assign directly to agents/08-coding-agent.md with full implementation brief

**Quality loop (repeat until all gates pass):**
1. Assign implementation to agents/08-coding-agent.md
2. On completion, assign delivery to agents/09-code-inspector.md
   - Inspector writes findings to:
     `docs/04-user-stories/ads-quarterly-it-review/user-stories/US-YYY/US-YYY-inspection.md`
     using `templates/inspection-report-template.md` as the format
   - If FAIL → return findings to agents/08-coding-agent.md for fixes; re-inspect into
     `docs/04-user-stories/ads-quarterly-it-review/user-stories/US-YYY/US-YYY-reinspection.md` (max 3 rounds)
3. When Code Inspector returns PASS, assign to agents/10-qa-lead.md
   - QA Lead validates acceptance criteria, functional behaviour, and edge cases
   - QA Lead writes findings to:
     `docs/04-user-stories/ads-quarterly-it-review/user-stories/US-YYY/US-YYY-qa-review.md`
     using `templates/qa-review-template.md` as the format
   - If FAIL → return findings to agents/08-coding-agent.md for fixes; restart from step 2
   - Combined Code Inspector + QA rounds capped at 5; escalate to me if exceeded
4. When QA Lead returns PASS, assign to agents/11-security-agent.md
   - Security Agent reviews for OWASP Top 10, auth/authz flaws, secrets exposure, input
     validation, and any Azure/infrastructure security concerns
   - Security Agent writes findings to:
     `docs/04-user-stories/ads-quarterly-it-review/user-stories/US-YYY/US-YYY-security-review.md`
     using `templates/security-review-template.md` as the format
   - If findings require code changes → return to agents/08-coding-agent.md for fixes;
     re-run Code Inspector (step 2) and QA Lead (step 3) before returning to Security Agent
   - If findings require infrastructure/config changes → return to
     agents/07-devops-platform-agent.md for fixes; Security Agent re-reviews after confirmation
   - Security Agent re-review rounds count toward the combined cap of 5; escalate to me if exceeded
5. When Security Agent returns PASS → record ${NEXT_STORY} approval:
   - `.workflow/current-story.md` — convert active → completed, add summary table
   - `docs/04-user-stories/ads-quarterly-it-review/sprint-plan.md` — status → ✅ Approved — [today's date]
   - `docs/04-user-stories/ads-quarterly-it-review/user-stories/US-YYY/US-YYY.md` — add approved status banner
   - Completion report saved to:
     `docs/04-user-stories/ads-quarterly-it-review/user-stories/US-YYY/US-YYY-completion.md`
     using `templates/completion-report-template.md` as the format
   - DevOps completion report (if applicable) saved to:
     `docs/04-user-stories/ads-quarterly-it-review/user-stories/US-YYY/US-YYY-devops-completion.md`

Report back when ${NEXT_STORY} is approved or if escalation is needed.
