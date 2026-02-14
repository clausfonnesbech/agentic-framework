# UX Review Report Template

**Review ID:** UXR-XXX  
**Created by:** UX/UI Agent  
**Date:** [Date]  
**Project:** [Project Name]  
**Feature/Sprint:** [Feature or Sprint ID]

---

## Executive Summary

**Review Focus:** [What was reviewed - feature, flow, full app, prototype]

**Overall UX Rating:** ⭐⭐⭐⭐⭐ (1-5 stars)

**Key Finding:** [1-2 sentence summary of main UX insight]

**Recommendation:** ✅ APPROVE / ⚠️ APPROVE WITH CHANGES / ❌ NEEDS REDESIGN

---

## Review Scope

**What Was Reviewed:**
- [Feature/Screen 1]
- [Feature/Screen 2]
- [User Flow 1]
- [User Flow 2]

**Review Type:**
- [ ] Wireframes/Mockups
- [ ] Prototype
- [ ] Implemented Feature
- [ ] Full Application

**Review Focus Areas:**
- [✅] Usability
- [✅] Accessibility
- [✅] Visual Design
- [✅] User Flow
- [✅] Information Architecture
- [✅] Interaction Design
- [✅] Responsiveness

**User Personas Considered:**
- [Persona 1: Role/Type]
- [Persona 2: Role/Type]

---

## Usability Review

### Overall Usability Score: [X]/10

### Heuristic Evaluation (Nielsen's 10 Usability Heuristics)

#### 1. Visibility of System Status ⭐⭐⭐⭐⭐

**Score:** [X]/5  
**Status:** ✅ Excellent / ⚠️ Needs Improvement / ❌ Poor

**Findings:**
- ✅ [Good example: Loading states clearly shown]
- ⚠️ [Issue: No feedback after form submission]

**Recommendations:**
- [Specific improvement]

---

#### 2. Match Between System and Real World ⭐⭐⭐⭐☆

**Score:** [X]/5

**Findings:**
- [Language and terminology assessment]

**Recommendations:**
- [Improvements needed]

---

#### 3. User Control and Freedom ⭐⭐⭐⭐⭐

**Score:** [X]/5

**Findings:**
- ✅ [Good: Clear back buttons and navigation]
- ❌ [Issue: No way to undo delete action]

**Recommendations:**
- Add confirmation dialogs for destructive actions
- Implement undo functionality for critical operations

---

#### 4. Consistency and Standards ⭐⭐⭐☆☆

**Score:** [X]/5

**Findings:**
- [Consistency across interface assessment]

**Recommendations:**
- [Standardization needed]

---

#### 5. Error Prevention ⭐⭐⭐⭐☆

**Score:** [X]/5

**Findings:**
- [Error prevention mechanisms]

**Recommendations:**
- [Improvements]

---

#### 6. Recognition Rather Than Recall ⭐⭐⭐⭐⭐

**Score:** [X]/5

**Findings:**
- [Memory load assessment]

---

#### 7. Flexibility and Efficiency of Use ⭐⭐⭐⭐☆

**Score:** [X]/5

**Findings:**
- [Shortcuts, power user features]

---

#### 8. Aesthetic and Minimalist Design ⭐⭐⭐⭐⭐

**Score:** [X]/5

**Findings:**
- [Visual clutter, information density]

---

#### 9. Help Users Recognize, Diagnose, and Recover from Errors ⭐⭐⭐⭐☆

**Score:** [X]/5

**Findings:**
- [Error message quality]

---

#### 10. Help and Documentation ⭐⭐⭐☆☆

**Score:** [X]/5

**Findings:**
- [Help availability and quality]

---

## User Flow Analysis

### Flow #1: [Flow Name - e.g., User Registration]

**User Goal:** [What the user wants to accomplish]

**Flow Diagram:**
```
[Login Page] → [Register] → [Fill Form] → [Email Verification] → [Dashboard]
     ↓                                            ↓
[Forgot Password]                          [Resend Email]
```

**Step-by-Step Analysis:**

#### Step 1: [Navigate to Registration]

**User Action:** [What user does]  
**System Response:** [What happens]  
**UX Rating:** ✅ Good / ⚠️ Acceptable / ❌ Poor

**Findings:**
- [Observations]

**Issues:**
- [Problems identified]

**Recommendations:**
- [Improvements]

---

#### Step 2: [Fill Registration Form]

[Repeat for each step]

---

**Flow Summary:**
- **Total Steps:** [#]
- **Cognitive Load:** Low / Medium / High
- **Friction Points:** [#]
- **Success Probability:** [%] (estimated)

**Overall Flow Rating:** ⭐⭐⭐⭐☆

---

### Flow #2: [Another Flow]

[Repeat structure]

---

## Accessibility Review

### WCAG 2.1 Compliance

**Target Level:** AA / AAA  
**Current Compliance:** [%]

### Accessibility Checks

#### Perceivable ⭐⭐⭐⭐☆

- [✅/❌] **Text alternatives:** Images have alt text
- [✅/❌] **Time-based media:** Captions for video/audio (if applicable)
- [✅/❌] **Adaptable:** Content can be presented in different ways
- [✅/❌] **Distinguishable:** Easy to see and hear content
  - Color contrast ratio: [X:1] (min 4.5:1 for AA)
  - Text is resizable
  - Images of text avoided

**Issues:**
- [List accessibility issues]

---

#### Operable ⭐⭐⭐⭐⭐

- [✅/❌] **Keyboard accessible:** All functionality via keyboard
- [✅/❌] **Enough time:** Users have enough time to read/use content
- [✅/❌] **Seizures:** Nothing flashes more than 3 times per second
- [✅/❌] **Navigable:** Clear navigation, focus indicators
  - Skip to main content link
  - Logical tab order
  - Clear focus indicators

**Issues:**
- [List keyboard/navigation issues]

---

#### Understandable ⭐⭐⭐⭐☆

- [✅/❌] **Readable:** Text is readable and understandable
- [✅/❌] **Predictable:** Pages operate in predictable ways
- [✅/❌] **Input assistance:** Help users avoid and correct mistakes
  - Clear labels
  - Error identification
  - Error suggestions

**Issues:**
- [List comprehension issues]

---

#### Robust ⭐⭐⭐⭐⭐

- [✅/❌] **Compatible:** Works with assistive technologies
  - Valid HTML
  - ARIA labels where needed
  - Semantic HTML used

**Issues:**
- [List compatibility issues]

---

### Accessibility Testing Results

**Tools Used:**
- [axe DevTools / WAVE / Lighthouse]

**Automated Scan Results:**
- Errors: [#]
- Warnings: [#]
- Manual review items: [#]

**Screen Reader Testing:**
- **Tool:** [NVDA / JAWS / VoiceOver]
- **Issues Found:** [List]

---

## Visual Design Review

### Design System Consistency ⭐⭐⭐⭐⭐

**Checks:**
- [✅] Color palette consistent
- [✅] Typography hierarchy clear
- [✅] Spacing/padding consistent
- [✅] Component styling unified
- [✅] Icons consistent style

**Issues:**
- [List inconsistencies]

---

### Visual Hierarchy ⭐⭐⭐⭐☆

**Assessment:**
- [How well does the design guide user attention]

**Issues:**
- [Elements that compete for attention]
- [Missing emphasis on important elements]

---

### Branding & Aesthetics ⭐⭐⭐⭐⭐

**Brand Alignment:**
- [How well does design match brand guidelines]

**Visual Appeal:**
- [Professional / Modern / Outdated / Cluttered]

---

## Responsive Design Review

### Breakpoints Tested

- [✅] Mobile (< 768px)
- [✅] Tablet (768px - 1024px)
- [✅] Desktop (> 1024px)
- [✅] Large screens (> 1920px)

### Responsive Behavior

#### Mobile View (< 768px)

**Rating:** ⭐⭐⭐⭐☆

**Findings:**
- ✅ [Good: Navigation collapses to hamburger menu]
- ⚠️ [Issue: Tables not scrollable, overflow hidden]
- ❌ [Problem: Text too small to read]

**Issues:**
- [List mobile-specific issues]

**Recommendations:**
- [Improvements]

---

#### Tablet View

[Similar structure]

---

#### Desktop View

[Similar structure]

---

## Interaction Design Review

### Microinteractions ⭐⭐⭐⭐⭐

**Assessment:**
- Button hover states
- Loading animations
- Transition smoothness
- Feedback mechanisms

**Good Examples:**
- [Positive interactions]

**Issues:**
- [Missing or poor interactions]

---

### Form Design ⭐⭐⭐⭐☆

**Forms Reviewed:**
- [Login form]
- [Registration form]
- [Task creation form]

**Assessment:**

#### Form #1: [Form Name]

- [✅/❌] Clear labels
- [✅/❌] Appropriate input types
- [✅/❌] Inline validation
- [✅/❌] Clear error messages
- [✅/❌] Help text where needed
- [✅/❌] Logical field order
- [✅/❌] Autocomplete enabled

**Issues:**
- [Form-specific issues]

---

### Navigation & Information Architecture ⭐⭐⭐⭐⭐

**Primary Navigation:**
- Clear and findable: ✅
- Consistent across pages: ✅
- Current location indicated: ✅

**Information Architecture:**
- Logical grouping: ✅/❌
- Appropriate hierarchy: ✅/❌
- Search functionality: ✅/❌ (if needed)

**Issues:**
- [Navigation problems]

---

## Critical UX Issues

### Issue #1: [Issue Title]

**Severity:** CRITICAL / HIGH / MEDIUM / LOW  
**Category:** [Usability / Accessibility / Visual / Flow]  
**Affected Users:** [All / Specific persona]

**Description:**
[What the problem is]

**Impact:**
[How this affects users]

**Location:**
[Where in the app]

**Current Behavior:**
[What happens now]

**Expected Behavior:**
[What should happen]

**Recommendation:**
[How to fix]

**Priority:** Must Fix / Should Fix / Nice to Fix

---

### Issue #2: [Issue Title]

[Repeat structure]

---

## UX Improvements Suggested

### Quick Wins (Low Effort, High Impact)

1. **[Improvement 1]**
   - Effort: Low
   - Impact: High
   - Implementation: [How to do it]

2. **[Improvement 2]**
   - Effort: Low
   - Impact: High
   - Implementation: [How to do it]

---

### High-Priority Improvements

1. **[Improvement 1]**
   - Effort: Medium/High
   - Impact: High
   - Implementation: [How to do it]

---

### Nice-to-Have Enhancements

1. **[Enhancement 1]**
   - Effort: [Level]
   - Impact: Medium
   - Implementation: [How to do it]

---

## Positive Observations

**✅ Things Done Well:**

1. **[Good practice 1]**
   - Why it's good: [Explanation]
   - Keep doing this!

2. **[Good practice 2]**
   - Why it's good: [Explanation]

---

## Comparison with Best Practices

### Industry Standards

**[ Feature Area]:**
- **Best Practice:** [Industry standard]
- **Current Implementation:** [How it compares]
- **Recommendation:** [Align/Innovate]

---

## User Feedback (if available)

**User Testing Results:**
- [Summary of user testing findings]

**Common User Complaints:**
- [Issues users reported]

**User Requests:**
- [Features users want]

---

## Skills & Tools Used

**Skills Referenced:**
- `skills/ui-ux-research-skill.md`
- `skills/accessibility-inclusive-design-skill.md`
- `skills/curiosity-skill.md` (understanding user needs)

**MCP Tools:**
- Playwright MCP (for UI testing)

**Design Tools:**
- [Figma / Adobe XD / Sketch]

---

## Recommendations Summary

### Must Fix (Critical)

- [ ] [Issue 1] - [Timeline]
- [ ] [Issue 2] - [Timeline]

### Should Fix (High Priority)

- [ ] [Issue 3] - [Timeline]
- [ ] [Issue 4] - [Timeline]

### Nice To Have

- [ ] [Enhancement 1]
- [ ] [Enhancement 2]

---

## Verdict & Next Steps

### Final Verdict

**⚠️ VERDICT: [APPROVE / APPROVE WITH CHANGES / NEEDS REDESIGN]**

### Justification

**✅ APPROVE:**
- UX is excellent overall
- Minor issues don't significantly impact usability
- Accessible and follows best practices
- Ready for implementation/release

**⚠️ APPROVE WITH CHANGES:**
- Good foundation but improvements needed
- [#] issues should be addressed
- Can proceed with development while working on improvements

**❌ NEEDS REDESIGN:**
- Significant usability problems
- Critical accessibility issues
- User flow doesn't support user goals effectively
- Requires substantial rework

---

### Next Steps

1. **Immediate Actions:**
   - [Action 1]
   - [Action 2]

2. **Short-term (This Sprint):**
   - [Planned improvement 1]
   - [Planned improvement 2]

3. **Long-term (Backlog):**
   - [Enhancement 1]
   - [Enhancement 2]

---

## Appendices

### Appendix A: User Personas

[Brief persona descriptions if relevant]

### Appendix B: Screen Captures

[Reference to screenshots or annotated designs]

### Appendix C: Accessibility Audit Report

[Detailed accessibility findings]

---

## Review Metadata

**UX/UI Agent:** [Agent name]  
**Review Duration:** [Time spent]  
**Review Date:** [Date]  
**Review Version:** [Version number]

---

## Sign-off

**Reviewed by:** UX/UI Agent  
**Date:** [Date]  
**Status:** [APPROVED / CONDITIONAL / REJECTED]  
**Follow-up Required:** [YES / NO]
