# Accessibility & Inclusive Design Skill

**Skill Type:** UX Quality & Compliance  
**Purpose:** Ensure interfaces are inclusive, perceivable, operable, understandable, and robust by default.

## Overview

This skill helps agents embed accessibility requirements into design and planning artifacts early, instead of treating accessibility as a post-implementation audit.

## When to Use This Skill

- ✅ Designing or reviewing UI flows and components
- ✅ Defining acceptance criteria for UI stories
- ✅ Creating form, navigation, and content patterns
- ✅ Evaluating responsive and keyboard-only usability
- ✅ Building QA-ready accessibility checklists

## Core Principles

### 1. Shift Left on Accessibility
Specify accessibility in design and story criteria before implementation starts.

### 2. Include All Interaction Modes
Every critical flow should work via keyboard, pointer, and assistive technology.

### 3. Use Semantic Structure
Prefer semantic HTML and meaningful landmarks over visual-only structure.

### 4. Provide Clear Feedback
Validation, errors, and status updates must be explicit and understandable.

### 5. Design for Real Constraints
Account for low vision, motor limitations, cognitive load, and reduced attention.

## WCAG 2.2 AA Baseline Checklist

### Perceivable
- Text contrast meets at least 4.5:1 for normal text
- Non-text UI elements have sufficient contrast
- Images conveying meaning include text alternatives
- Content remains usable under zoom and reflow

### Operable
- All interactive controls are keyboard accessible
- Focus order is logical and visible
- No keyboard trap
- Touch targets are appropriately sized and spaced

### Understandable
- Labels and instructions are explicit
- Errors explain what happened and how to fix
- Navigation and terminology remain consistent
- Critical actions include confirmation where needed

### Robust
- Semantic elements and ARIA are used correctly
- Dynamic updates are announced when relevant
- Forms expose proper names, roles, and values

## Component-Level Guidance

### Forms
- Associate labels with inputs
- Provide inline validation and summary for multiple errors
- Keep required/optional rules explicit
- Preserve user input on validation failures

### Dialogs and Overlays
- Trap focus while open
- Return focus to trigger on close
- Support `Esc` close where appropriate
- Provide meaningful dialog title and description

### Tables and Data Views
- Use semantic table structure for tabular data
- Keep sortable/filterable controls accessible
- Support keyboard navigation for dense data contexts

### Navigation
- Include skip links for keyboard users
- Provide current-page indicators
- Avoid ambiguous link text like “Click here”

## Accessibility Acceptance Criteria Pattern

Use this pattern in stories:

- Given keyboard-only navigation, when the user completes [flow], then all controls are reachable and operable without pointer input.
- Given a screen reader user, when the user enters [screen], then page landmarks, headings, and form labels are announced meaningfully.
- Given an invalid form submission, when validation fails, then errors are announced and clearly linked to affected fields.

## Evidence & Validation

For each screen/flow, provide:
- Accessibility assumptions
- Applicable WCAG criteria references
- Manual validation steps
- Known risks and mitigation

## Common Anti-Patterns

- ❌ Placeholder text used as only label
- ❌ Color as sole indicator of status
- ❌ Hidden focus outline without replacement
- ❌ Generic error messages without remediation steps
- ❌ Click-only controls with no keyboard path

## Output Artifacts to Create or Enrich

- `style-guide.md`: add accessibility section per component pattern
- `components.md`: include keyboard/focus/screen-reader notes
- `handoff-checklist.md`: include accessibility validation gates
- `user-stories/*.md`: include concrete a11y acceptance criteria

## Definition of Done (Accessibility)

- ✅ Critical flows are keyboard-complete
- ✅ Focus behavior is defined for all dialogs and transitions
- ✅ Form validation and error messaging is accessible
- ✅ Contrast and visual clarity requirements are specified
- ✅ Accessibility criteria are included in story-level acceptance tests

---

Use this skill whenever you want design and planning outputs to be implementation-ready and compliant by default, not by exception.
