# UI/UX Research Skill

**Skill Type:** User Experience Analysis  
**Purpose:** Understanding how humans interact with digital interfaces to inform design decisions and research

## Overview

The UI/UX Research Skill enables agents to evaluate interface patterns, understand usability principles, and identify user experience best practices. This skill helps ensure that technical solutions are not only functional but also intuitive, accessible, and aligned with how users actually interact with digital systems.

## When to Use This Skill

- ✅ Researching interface patterns for specific use cases
- ✅ Evaluating usability of existing solutions
- ✅ Understanding accessibility requirements
- ✅ Analyzing user workflows and interactions
- ✅ Identifying best practices for specific user types
- ✅ Proposing interface solutions in business proposals

## Core Principles

### 1. User-Centered Design
Design decisions should be based on real user needs, not assumptions or technical preferences.

### 2. Accessibility First
Interfaces should be usable by people of all abilities—not an afterthought.

### 3. Consistency Over Novelty
Familiar patterns reduce cognitive load; innovate only when there's clear value.

### 4. Progressive Disclosure
Reveal complexity gradually; show what users need now, hide what they don't.

### 5. Feedback and Response
Users must always understand system state and results of their actions.

## Fundamental UX Principles

### Nielsen's 10 Usability Heuristics

#### 1. **Visibility of System Status**
**Principle:** Keep users informed about what's happening

**Examples:**
- Loading spinners during data fetch
- Progress bars for file uploads
- Success/error messages after actions
- "Last saved at 2:34 PM" indicators
- Unread badges on notifications

**Anti-patterns:**
- Actions with no feedback
- Long delays without indication
- Silent failures

---

#### 2. **Match Between System and Real World**
**Principle:** Speak the user's language, not technical jargon

**Examples:**
- "Trash" instead of "Delete permanently"
- "Folders" instead of "Directories"
- Calendar picker for dates (not YYYY-MM-DD text input)
- Icons that match real-world objects

**Anti-patterns:**
- Technical error messages ("Error 500: Internal Server Error")
- Database terminology in UI ("Join tables," "Foreign keys")
- Developer-centric language

---

#### 3. **User Control and Freedom**
**Principle:** Provide easy way to undo/redo and escape

**Examples:**
- Undo button for destructive actions
- "Cancel" option on all operations
- Back button works as expected
- Draft saving before submission
- "Are you sure?" for destructive actions

**Anti-patterns:**
- No way to cancel long operations
- Irreversible deletions without confirmation
- Modal dialogs with no close button

---

#### 4. **Consistency and Standards**
**Principle:** Follow platform conventions and be internally consistent

**Examples:**
- Primary action button on right (web standard)
- Ctrl+S to save (platform standard)
- Blue links, visited links in purple
- Consistent terminology ("Remove" everywhere, not "Delete" sometimes)

**Anti-patterns:**
- Different button styles for same action type
- Inconsistent icon meanings
- Changing terminology across pages

---

#### 5. **Error Prevention**
**Principle:** Prevent errors better than good error messages

**Examples:**
- Disable submit until form valid
- Inline validation as user types
- Confirmation dialogs for destructive actions
- Default values that make sense
- Date pickers instead of free-text dates

**Anti-patterns:**
- Only validating on submit (not inline)
- Allowing impossible values
- No confirmation for data loss

---

#### 6. **Recognition Rather Than Recall**
**Principle:** Make options visible; don't rely on memory

**Examples:**
- Dropdown menus showing options (not requiring memorization)
- Recently used items list
- Autocomplete suggestions
- Visual previews of actions
- Breadcrumbs showing current location

**Anti-patterns:**
- Command-line-style interfaces without help
- Requiring memorization of codes or shortcuts
- No indication of current context

---

#### 7. **Flexibility and Efficiency**
**Principle:** Provide shortcuts for expert users; remain accessible for novices

**Examples:**
- Keyboard shortcuts (with visual reminders)
- Bulk actions
- Recent/frequent items
- Customizable workflows
- Quick actions from context menus

**Anti-patterns:**
- Forcing all users through wizard-style flows
- No keyboard navigation
- Hiding power features completely

---

#### 8. **Aesthetic and Minimalist Design**
**Principle:** Every element should serve a purpose; remove the unnecessary

**Examples:**
- Clear visual hierarchy
- Adequate whitespace
- Progressive disclosure (hide advanced options)
- Focus on primary actions
- Clean, uncluttered layouts

**Anti-patterns:**
- Every feature on main screen
- Cluttered dashboards
- Excessive decoration
- Too many CTAs competing for attention

---

#### 9. **Help Users Recognize, Diagnose, and Recover from Errors**
**Principle:** Error messages should be helpful and actionable

**Examples:**
- "Email format invalid. Example: user@example.com"
- "Password must be 8+ characters with number and symbol"
- Clear indication of which field has error
- Suggestions for fixing the problem
- "Retry" buttons when appropriate

**Anti-patterns:**
- "Error 422: Unprocessable Entity"
- Red highlighting without explanation
- Generic "Something went wrong"
- Technical stack traces shown to users

---

#### 10. **Help and Documentation**
**Principle:** Ideally not needed, but provide when necessary

**Examples:**
- Contextual help tooltips (? icons)
- Inline hints ("e.g., user@example.com")
- Searchable help center
- Video tutorials for complex workflows
- Onboarding guides for new users

**Anti-patterns:**
- Only PDF manual available
- Help requires leaving the application
- No search function in documentation
- Outdated help content

---

## Interface Pattern Categories

### Navigation Patterns

#### 1. **Top Navigation / Header Menu**
**Best For:** Sites with 5-7 main sections  
**Used When:** Clear hierarchy, global navigation needed  
**Examples:** Corporate sites, dashboards, main applications

**Pros:** Always visible, familiar pattern  
**Cons:** Limited space, mobile challenges

---

#### 2. **Sidebar Navigation**
**Best For:** Applications with many features or deep hierarchies  
**Used When:** Admin panels, complex applications, multi-level navigation  
**Examples:** Gmail, Slack, admin dashboards

**Pros:** More space for options, can show hierarchy  
**Cons:** Takes horizontal space, requires toggle pattern

---

#### 3. **Breadcrumbs**
**Best For:** Showing hierarchical position  
**Used When:** Deep content structures, e-commerce, documentation  
**Examples:** Amazon product pages, documentation sites

**Pros:** Shows where you are, easy navigation up  
**Cons:** Doesn't help if lost at top level

---

#### 4. **Tabs**
**Best For:** Related content in same context  
**Used When:** Settings pages, profile sections, product details  
**Examples:** Browser tabs, multi-step forms, settings panels

**Pros:** Clear organization, one-click switching  
**Cons:** Limited number (5-7 max), mobile challenges

---

### Form Patterns

#### 1. **Single-Column Vertical Form**
**Best For:** Most forms, especially on mobile  
**Research Shows:** Faster completion, fewer errors

**Pattern:**
```
[Label]
[Input field - full width]

[Label]
[Input field - full width]

[Submit Button]
```

---

#### 2. **Inline Validation**
**Best For:** Real-time feedback as user types  
**Reduces:** Form abandonment, frustration

**Pattern:**
- ✅ Green checkmark when valid
- ❌ Red X with helpful message when invalid
- Validate on blur or after short delay
- Don't validate until user has finished typing

---

#### 3. **Progressive Disclosure**
**Best For:** Complex forms, optional fields  
**Reduces Overwhelm:** Show advanced options only when needed

**Pattern:**
- Required fields first
- "Show advanced options" link/button
- Conditional fields (appear based on selections)

---

#### 4. **Wizard/Stepper**
**Best For:** Multi-step processes with logical flow  
**Good For:** Onboarding, checkout, complex setup

**Pattern:**
```
[Step 1: Basic Info] → [Step 2: Details] → [Step 3: Review]
    [Active]             [Upcoming]           [Upcoming]
```

**Requirements:**
- Show progress (Step 2 of 4)
- Allow back navigation
- Save progress between steps
- Validate before allowing forward

---

### Data Display Patterns

#### 1. **Table/Data Grid**
**Best For:** Tabular data, comparisons, many records  
**Features Needed:**
- Sortable columns
- Filterable/searchable
- Pagination or infinite scroll
- Row selection for bulk actions
- Responsive (stack on mobile)

---

#### 2. **Cards**
**Best For:** Heterogeneous content, visual emphasis  
**Used When:** E-commerce, dashboards, content galleries

**Pattern:**
```
┌─────────────┐  ┌─────────────┐
│ [Image]     │  │ [Image]     │
│             │  │             │
│ Title       │  │ Title       │
│ Description │  │ Description │
│ [Action]    │  │ [Action]    │
└─────────────┘  └─────────────┘
```

**Pros:** Flexible, visual, mobile-friendly  
**Cons:** Uses more space than tables

---

#### 3. **Lists**
**Best For:** Simple, scannable content  
**Types:**
- Simple list (text only)
- List with icons/avatars
- List with secondary actions
- Expansion lists (accordion-style)

**Best Practices:**
- Adequate spacing (44px touch targets)
- Clear visual grouping
- Actions aligned consistently

---

### Feedback & Notification Patterns

#### 1. **Toast/Snackbar**
**Best For:** Non-critical confirmations  
**Duration:** 3-5 seconds  
**Position:** Bottom or top center

**Use Cases:**
- "Item added to cart"
- "Changes saved"
- "Email sent"

**Don't Use For:** Errors requiring action

---

#### 2. **Modal Dialog**
**Best For:** Critical decisions, focused tasks  
**Requires:** User action to dismiss

**Use Cases:**
- "Delete this item?"
- Login/signup forms
- Forms that need focus

**Best Practices:**
- Dim background
- Close button + Cancel action
- Keyboard escape to close
- Max width (don't span full screen)

---

#### 3. **Banner/Alert**
**Best For:** Persistent, contextual messages  
**Types:**
- Info (blue)
- Success (green)
- Warning (yellow/orange)
- Error (red)

**Stays Visible Until:**
- User dismisses
- Issue resolved
- Context changes

---

## Mobile-First Considerations

### Touch Target Sizing
**Minimum:** 44x44 pixels (iOS), 48x48 dp (Android)  
**Ideal:** 60x60 pixels for primary actions  
**Spacing:** Minimum 8px between touch targets

### Thumb Zone Design
**Easy-to-Reach Zone:** Bottom third of screen, especially bottom corners  
**Hard-to-Reach Zone:** Top corners

**Pattern:**
- Primary actions in bottom zone
- Navigation often at bottom (iOS standard)
- Less frequently used items at top

### Mobile Navigation Patterns

**Hamburger Menu:**
- Pros: Saves space, familiar
- Cons: Hidden, requires tap to reveal
- Use: For secondary navigation

**Bottom Tab Bar:**
- Pros: Always visible, thumb-friendly
- Cons: Limited to 5 items
- Use: For primary navigation sections

**Scrollable Top Tabs:**
- Pros: More options visible
- Cons: Not all visible at once
- Use: For categories, filters

---

## Accessibility (A11y) Fundamentals

### WCAG 2.1 Key Requirements

#### 1. **Perceivable**
Users must be able to perceive the information

**Checklist:**
- [ ] Alt text for all images
- [ ] Transcripts for audio
- [ ] Captions for video
- [ ] Color contrast ratio ≥ 4.5:1 (text)
- [ ] Don't rely on color alone to convey information

---

#### 2. **Operable**
Users must be able to operate the interface

**Checklist:**
- [ ] All functionality available via keyboard
- [ ] Visible focus indicators
- [ ] Skip links to main content
- [ ] No time limits (or easy to extend)
- [ ] No flashing content (seizure risk)

---

#### 3. **Understandable**
Information and UI must be understandable

**Checklist:**
- [ ] Clear, simple language
- [ ] Consistent navigation
- [ ] Error messages are helpful
- [ ] Labels for all form fields
- [ ] Predictable behavior

---

#### 4. **Robust**
Content must work with assistive technologies

**Checklist:**
- [ ] Valid HTML
- [ ] ARIA labels where needed
- [ ] Semantic HTML elements
- [ ] Testing with screen readers

---

### Quick Accessibility Wins

1. **Use Semantic HTML**
   - `<button>` for buttons (not `<div onclick="">`)
   - `<nav>` for navigation
   - `<header>`, `<main>`, `<footer>` for structure
   - `<label>` for form labels

2. **Keyboard Navigation**
   - Tab order makes sense
   - Enter activates buttons/links
   - Escape closes modals
   - Arrow keys navigate menus

3. **Color Contrast**
   - Use contrast checker tools
   - 4.5:1 for normal text
   - 3:1 for large text (18pt+)
   - Don't use color as only indicator

4. **Alternative Text**
   - Descriptive alt text for images
   - Empty alt (`alt=""`) for decorative images
   - Descriptive link text ("Read the report" not "Click here")

---

## Information Architecture

### Card Sorting
**Purpose:** Understand how users mentally organize information  
**When to Research:** Designing navigation, categorization

**Types:**
- Open card sort: Users create categories
- Closed card sort: Users assign to predefined categories

**Research Pattern:**
- Present content items on cards
- Ask users to group related items
- Identify patterns across users
- Design navigation based on mental models

---

### Navigation Hierarchy

**Depth vs. Breadth Trade-off:**

**Shallow/Broad:**
- Many options at top level
- Fewer clicks to destination
- Can overwhelm

**Example:** News site with 10 top-level categories

**Deep/Narrow:**
- Fewer options at each level
- More clicks to destination
- Easier to scan

**Example:** E-commerce with category → subcategory → product

**Sweet Spot:** 5-9 top-level items, 2-3 levels deep

---

### Search and Findability

**When to Include Search:**
- Content sites with 100+ pages
- E-commerce with many products
- Documentation sites
- Applications with many features

**Search Best Practices:**
- Prominent placement (top right common)
- Auto-suggest / autocomplete
- Show recent searches
- Filters to refine results
- "No results" should suggest alternatives

---

## Cognitive Load Principles

### Miller's Law: 7±2 Items
**Principle:** People can hold 7±2 items in working memory

**Application:**
- Limit menu items to 7 (or chunk into groups)
- Phone numbers chunked (555-1234)
- Pagination items limited
- Tabs limited to 5-7

---

### Hick's Law: Choice Paralysis
**Principle:** Decision time increases with number of options

**Application:**
- Limit choices at each decision point
- Progressive disclosure (don't show all options at once)
- Smart defaults
- Categorize large option sets

---

### Fitts's Law: Target Size and Distance
**Principle:** Time to target = function of distance and size

**Application:**
- Make important buttons larger
- Place related actions near each other
- Make frequent actions easy to reach
- Group related functionality spatially

---

## User Workflow Patterns

### Task Analysis Framework

**For Research:**

1. **Identify User Goals**
   - What are users trying to accomplish?
   - Why are they using this interface?

2. **Map User Journey**
   - Entry point
   - Steps to complete task
   - Exit/completion point

3. **Identify Pain Points**
   - Where do users get stuck?
   - What causes errors or confusion?
   - What takes too long?

4. **Optimize Flow**
   - Reduce steps
   - Eliminate friction
   - Provide shortcuts

**Example: Team Document Upload**

```
User Goal: Upload team roster document

Current Flow Problems:
1. Login → Dashboard → Team Area → Documents → Upload (5 clicks)
2. No indication of accepted file types
3. No progress indicator during upload
4. Success message not prominent

Optimized Flow:
1. Login → Dashboard with quick action "Upload Document" (2 clicks)
2. Drag-and-drop zone with accepted types listed
3. Progress bar during upload
4. Clear success toast with "View Document" link
```

---

## Responsive Design Patterns

### Breakpoint Strategy

**Mobile First:** Design for mobile, progressively enhance

**Common Breakpoints:**
- **Mobile:** 320-480px
- **Tablet:** 768-1024px
- **Desktop:** 1280px+

### Responsive Patterns

**1. Column Drop:**
- Desktop: 3 columns
- Tablet: 2 columns
- Mobile: 1 column (stacked)

**2. Mostly Fluid:**
- Flexible grid adapts to width
- Max-width on very large screens
- Columns reflow at breakpoints

**3. Off Canvas:**
- Side navigation off-screen on mobile
- Slides in when hamburger clicked
- Always visible on desktop

---

## Research Application Checklist

When researching UI/UX for a project:

### Understanding the Audience
- [ ] Who are the primary users? (roles, tech proficiency)
- [ ] What devices will they use? (mobile, desktop, tablet)
- [ ] What are their accessibility needs?
- [ ] What's their context of use? (rushed, focused, multitasking)

### Analyzing Similar Solutions
- [ ] What interfaces serve similar user needs?
- [ ] What patterns do they use?
- [ ] What do users praise in reviews?
- [ ] What frustrates users in reviews?
- [ ] Are there accessibility issues noted?

### Pattern Research
- [ ] What's the standard pattern for this interaction?
- [ ] Why is this pattern common? (evidence)
- [ ] Are there successful alternatives?
- [ ] What are the tradeoffs?

### Documenting Findings
- [ ] Screenshots/descriptions of effective patterns
- [ ] Sources cited (design systems, apps, articles)
- [ ] Rationale for recommendations
- [ ] Accessibility considerations noted
- [ ] Responsive behavior specified

---

## Design System References

### Popular Design Systems to Research

**Material Design (Google):**
- Comprehensive components
- Mobile-first
- Well documented
- Link: https://material.io

**Human Interface Guidelines (Apple):**
- iOS/macOS patterns
- Platform conventions
- Accessibility focused
- Link: https://developer.apple.com/design/

**Fluent Design (Microsoft):**
- Windows/web patterns
- Office-style interfaces
- Enterprise focus
- Link: https://fluent2.microsoft.design/

**Ant Design:**
- Enterprise applications
- Rich component library
- React ecosystem
- Link: https://ant.design

**Shopify Polaris:**
- E-commerce focus
- Merchant-facing interfaces
- Clear guidelines
- Link: https://polaris.shopify.com

---

## UX Research Questions

When evaluating or proposing interfaces:

### Navigation & Information Architecture
- How will users find key features?
- How many clicks to primary tasks?
- Is hierarchy clear and logical?
- Can users recover from getting lost?

### Forms & Data Entry
- How many fields are truly necessary?
- Can we provide smart defaults?
- Is inline validation implemented?
- How are errors communicated?

### Feedback & Communication
- How does system communicate status?
- Are success states clear?
- Are error messages helpful?
- Do users know what to do next?

### Accessibility
- Can this be used keyboard-only?
- Is color contrast sufficient?
- Are touch targets large enough?
- How does this work with screen readers?

### Mobile Experience
- How does this adapt to mobile?
- Are touch targets appropriately sized?
- Is navigation thumb-friendly?
- Does critical content fit above fold?

---

**Skill Owner:** Research Agents, Business Analysts, UX Designers  
**Skill Version:** 1.0  
**Last Updated:** February 12, 2026
