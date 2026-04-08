# US-XXX Completion Report — [Short Story Title]

**Date:** YYYY-MM-DD
**Sprint:** Sprint N
**Status:** ✅ Approved / 🔄 In Review

---

## Summary

[2–3 sentences: what was implemented, key design decisions, and any noteworthy constraints.]

---

## Files Created / Modified

| Action | File |
|--------|------|
| Created | `src/AdsQuarterlyItReview/…/NewFile.cs` — [what it does] |
| Modified | `src/AdsQuarterlyItReview/…/ExistingFile.cs` — [what changed] |

---

## Quality Gates

| Gate | Result | Notes |
|------|--------|-------|
| `dotnet build` | ✅ 0 errors, 0 warnings | Clean build |
| Code Inspector | ✅ PASS / ❌ FAIL | [key findings if any] |
| QA Lead | ✅ PASS / ❌ FAIL | [key findings if any] |
| Security Agent | ✅ PASS / ❌ FAIL | [key findings if any] |

---

## Acceptance Criteria

- [x] AC1: [description]
- [x] AC2: [description]

---

## How to Test This Delivery

### Local Environment

**Pre-requisites:**
- App running locally with Azure SQL connection (`appsettings.Development.json` configured)
- [Any additional setup — migrations, seed data, user roles, etc.]

**Test steps:**

1. **[Feature name]** — [navigation or action]
   - **Expected:** [what the tester sees or the HTTP status returned]

2. **[Feature name]** — [navigation or action]
   - **Expected:** [what the tester sees]

### Azure Environment

**Pre-requisites:** [Any Azure-specific setup — deployment, migration run, secrets, etc.]

**Test steps:** Identical to local steps above, using the Azure App Service URL.

**Known current limitations:**
- [Any deferred work or pre-requisites not yet in place. State what the tester will see *today*
  vs. what they will see once all pre-requisites are met. If none: "None."]
