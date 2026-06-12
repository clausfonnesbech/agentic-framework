---
name: atea-design-compliance-skill
description: >-
  Use this skill for any Atea project or Atea-branded digital experience. It translates
  the Atea Design Guide into practical requirements for discovery, UX, implementation,
  inspection, and QA. Load whenever PROJECT-MEMORY.md or the Orchestrator says the
  project is an Atea project.
---

# Atea Design Compliance Skill

**Skill Type:** Brand, Design System, Accessibility, and UX Compliance  
**Source:** Atea Design Guide - Complete.pdf and section exports from Atea Design  
**Purpose:** Ensure Atea projects follow Atea brand identity, design-system tokens, experience principles, accessibility expectations, and tone of voice.

## When to Use This Skill

Use this skill when any of the following are true:

- The user says the project is for Atea, an Atea customer/employee/partner experience, or an Atea-branded product.
- The project name, repo, domain, documentation, or stakeholder context clearly references Atea.
- `docs/[project-slug]/PROJECT-MEMORY.md` records `Atea Project: Yes` or a Key Decision that Atea Design applies.
- The Orchestrator asks agents to apply Atea Design compliance.

If applicability is unclear, the Orchestrator must ask the user once and record the answer before UX or UI implementation begins.

## Orchestrator Disclosure Requirement

At the start of every project or substantial enhancement, the Orchestrator must disclose one of these statuses to the user:

- `Atea Design applies` — the project is confirmed as an Atea project.
- `Atea Design does not apply` — the project is confirmed as non-Atea.
- `Atea applicability unclear` — ask: "Is this an Atea project or Atea-branded digital experience where the Atea Design Guide should apply?"

For confirmed Atea projects, record the decision in `PROJECT-MEMORY.md` and tell downstream agents to load this skill.

## Cross-Agent Responsibilities

### Business Analyst

- Capture whether the project is Atea-branded during intake.
- Add Atea Design compliance to scope, assumptions, risks, and success criteria for Atea projects.
- Identify whether Atea marketing/design approval is needed, especially for logo usage, secondary colors, campaign graphics, or public-facing pages.

### UX/UI Agent

- Load this skill before concept proposals and detail design.
- Use Atea tokens and interaction rules as the design baseline.
- Do not invent a separate visual identity unless the user explicitly approves an exception.
- Include an Atea compliance checklist in `handoff-checklist.md`.

### Coding Agent

- Implement Atea tokens and component behavior from the approved design package.
- Prefer existing Atea Design System packages/components when available for the selected framework.
- Do not hardcode off-brand colors, typography, radii, spacing, or motion values when a token exists.

### Code Inspector and QA Lead

- Treat Atea compliance as part of the quality gate for Atea projects.
- Verify tokens, accessibility, responsive behavior, focus states, keyboard behavior, and tone of voice against this skill and the approved design package.

## Brand Identity Rules

- Use the Atea name consistently as `Atea` in prose.
- Logo usage must preserve clear space, contrast, and readability.
- Do not distort, rotate, recolor, crop, place on low-contrast backgrounds, or use the logo decoratively as a pattern unless the approved guide exception applies.
- Use official logo assets from the project/design source. Do not recreate the logo from text or approximate shapes.
- If logo placement, background handling, campaign use, or secondary-color usage is uncertain, flag it for Atea marketing/design approval.

## Color Requirements

Use color purposefully to improve understanding, hierarchy, and relationships between UI elements.

### Main Usage

- Atea main colors are green and grey, supported by white/light negative space.
- Follow the 60-30-10 principle where practical:
  - 60% spacing/background color, usually white or light grey.
  - 30% supporting color, usually Atea grey.
  - 10% accent color, usually Atea green.
- Default digital usage:
  - Logotype: Grey 500 `#4D575D`
  - Heading/title: Grey 800 `#1F2325`
  - Paragraph/text: Grey 600 `#3E464A`
  - Link: Teal 500 `#097288`
  - Primary CTA: Green 500 `#008A00`

### Palette Tokens

```css
:root {
  --color-grey: #4D575D;
  --color-green: #008A00;
  --color-teal: #097288;
  --color-red: #D62429;
  --color-yellow: #F6BD18;
  --color-blue: #0965B1;
  --color-orange: #EC7A2E;

  --color-green-700: #005300;
  --color-green-600: #006E00;
  --color-green-500: #008A00;
  --color-green-400: #33A133;
  --color-green-200: #99D099;

  --color-grey-800: #1F2325;
  --color-grey-700: #2E3438;
  --color-grey-600: #3E464A;
  --color-grey-500: #4D575D;
  --color-grey-400: #71797D;
  --color-grey-300: #949A9E;
  --color-grey-200: #B8BCBE;
  --color-grey-100: #DBDDDF;
  --color-grey-50: #EDEEEE;
  --color-grey-25: #F7F7F7;

  --color-teal-700: #054452;
  --color-teal-600: #075B6D;
  --color-teal-500: #097288;
  --color-teal-400: #3A8EA0;
  --color-teal-200: #9DC7CF;

  --color-red-700: #801619;
  --color-red-600: #AB1D21;
  --color-red-500: #D62429;
  --color-red-400: #DE5054;
  --color-red-200: #EFA7A9;

  --color-yellow-700: #94710E;
  --color-yellow-600: #C59713;
  --color-yellow-500: #F6BD18;
  --color-yellow-400: #F8CA46;
  --color-yellow-200: #FBE5A3;

  --color-blue-700: #053D6A;
  --color-blue-600: #07518E;
  --color-blue-500: #0965B1;
  --color-blue-400: #3A84C1;
  --color-blue-200: #9DC1E0;

  --color-orange-700: #8E491C;
  --color-orange-600: #BD6225;
  --color-orange-500: #EC7A2E;
  --color-orange-400: #F09558;
  --color-orange-200: #F7CAAB;
}
```

### Color Constraints

- Primary green and grey must meet WCAG Level AA contrast requirements for their intended text/UI use.
- Never rely on color alone to communicate information.
- Secondary colors may support illustrations, charts, campaign graphics, and UI accents.
- Do not use secondary colors as the primary color for headlines, body copy, invitations, ads, banners, or profile products unless an approved exception exists.
- Do not use tints/shades for objects, images, or banner backgrounds with white text unless contrast is verified.

## Typography Requirements

- Use Inter as the primary typeface for web channels, systems, apps, banners, and other digital productions.
- Use logical heading hierarchy: one `h1` per page/view, no skipped heading levels.
- Keep body text readable and responsive. Avoid line lengths below about 50 characters or above about 120 characters where practical.
- Support text resizing up to 200%.

### Heading Scale

Use the augmented-fourth scale for content/marketing pages where clear hierarchy is needed:

| Name | Weight | Size | Line Height | Letter Spacing | Color |
|---|---:|---:|---:|---:|---|
| XL | bold | 64px | 84px | -1.5px | Grey 800 |
| L | bold | 46px | 62px | -1px | Grey 800 |
| M | bold | 32px | 46px | -0.75px | Grey 800 |
| S | bold | 24px | 38px | -0.35px | Grey 800 |
| XS | bold | 16px | 28px | 0 | Grey 800 |

Use the minor-third scale for data-rich dashboards and table interfaces:

| Name | Weight | Size | Line Height | Letter Spacing | Color |
|---|---:|---:|---:|---:|---|
| XXXL | semi-bold | 40px | 54px | -0.85px | Grey 800 |
| XXL | semi-bold | 34px | 46px | -0.75px | Grey 800 |
| XL | semi-bold | 28px | 38px | -0.5px | Grey 800 |
| L | semi-bold | 24px | 34px | -0.4px | Grey 800 |
| M | semi-bold | 20px | 28px | -0.3px | Grey 800 |

### Text Scale

| Name | Weight | Size | Line Height | Letter Spacing | Color |
|---|---:|---:|---:|---:|---|
| Intro | regular/medium/semi-bold | 18px | 32px | -0.25px | Grey 800 |
| Standard | regular/medium/semi-bold | 16px | 28px | -0.25px | Grey 600 |
| M | regular/medium/semi-bold | 14px | 24px | -0.25px | Grey 600 |
| S | regular/medium/semi-bold | 12px | 22px | -0.15px | Grey 600 |

## Layout, Spacing, Radius, and Grid

- Use an 8px spacing system as the default shared language.
- Use 4px increments as a secondary option where visual balance needs finer steps.
- Choose the nearest spacing token instead of arbitrary custom spacing.
- Treat the grid as a foundation, not a cage: content may drive purposeful deviations, but deviations must support understanding.
- Default max content container: `calc(1440px - (16px * 2))`, equivalent to `1408px`.
- Use any flexbox/column grid inside the content container.

```css
:root {
  --radius-none: 0;
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 16px;
  --radius-xl: 32px;
  --radius-round: 100%;

  --border-width-thin: 1px;
  --border-width-regular: 2px;
  --border-width-strong: 3px;

  --spacing-space-1: 2px;
  --spacing-space-2: 4px;
  --spacing-space-3: 8px;
  --spacing-space-4: 16px;
  --spacing-space-5: 24px;
  --spacing-space-6: 32px;
  --spacing-space-7: 40px;
  --spacing-space-8: 48px;
  --spacing-space-9: 56px;
  --spacing-space-10: 64px;
  --spacing-space-11: 72px;
  --spacing-space-12: 80px;
  --spacing-space-13: 88px;
  --spacing-space-14: 96px;

  --spacing-irregular-space-1: 6px;
  --spacing-irregular-space-2: 12px;
  --spacing-irregular-space-3: 20px;
  --spacing-irregular-space-4: 28px;
  --spacing-irregular-space-5: 36px;
}
```

## Elevation Requirements

- Use elevation to differentiate layered surfaces, signal interactivity, and prioritize key content.
- Avoid noisy shadow overuse; shadows alone are not enough for accessibility.
- Use a consistent five-level ladder:
  - Level 1: subtle lift for cards in grids/lists.
  - Level 2: sticky elements moving over content.
  - Level 3: fixed elements above general content, such as floating buttons.
  - Level 4: notifications and popups without a blocking background.
  - Level 5: modals and large elements above everything, especially with a backdrop.

## Iconography Requirements

- Icons should be functional, modern, inclusive, bold, simple, and self-explanatory.
- Base icons on a 48x48px grid and verify readability at 16x16, 24x24, 36x36, and 48x48.
- Use consistent outline thickness and rounded corners; place icons pixel-perfectly in the grid.
- If an icon represents a complex concept, pair it with a visible label or description.
- Every image must have an `alt` attribute. Decorative images use `alt=""`.
- SVG icons must include a meaningful `<title>` when they are not decorative and are not already described by nearby text.

## Motion Requirements

- Motion must communicate: guide attention, maintain continuity, provide feedback, establish hierarchy/context, and express brand personality.
- Prefer fast, snappy, natural interactions.
- Enter motion is usually longer than leave motion; users should not wait for dismissals.
- Respect reduced-motion and high-contrast user preferences.

```css
:root {
  --motion-easing-linear: cubic-bezier(0, 0, 1, 1);
  --motion-easing-ease-out: cubic-bezier(0, 0, 0.58, 1);
  --motion-easing-ease-in-out: cubic-bezier(0.42, 0, 0.58, 1);
  --motion-easing-bounce: cubic-bezier(0.175, 0.885, 0.32, 1.275);
  --motion-easing-spring: cubic-bezier(0.7, -0.4, 0.4, 1.4);

  --motion-duration-level-1: 50ms;
  --motion-duration-level-2: 75ms;
  --motion-duration-level-3: 100ms;
  --motion-duration-level-4: 150ms;
  --motion-duration-level-5: 200ms;
  --motion-duration-level-6: 250ms;
  --motion-duration-level-7: 300ms;
  --motion-duration-level-8: 400ms;
  --motion-duration-level-9: 500ms;
}
```

Motion mapping:

- Small controls such as buttons and checkboxes: Level 2, linear/ease-out, Level 1-5 range.
- Medium elements such as cards, modals, and dropdowns: Level 4, ease-out, Level 3-7 range.
- Large transitions/popups: Level 7, ease-in-out, Level 6-9 range.
- Unique expressive animations may use bounce/spring/custom easing, but must remain purposeful.

## Accessibility Requirements

- Accessibility is a requirement from the start, not a late QA add-on.
- Target WCAG 2.2 AA unless the project explicitly sets a stricter requirement.
- Text contrast: 4.5:1 minimum for regular text, 3:1 minimum for large text.
- Interactive elements require visible focus styles.
- Keyboard focus order must match visual layout orientation.
- Native keyboard behavior must work for standard controls.
- Components and text must be resizable.
- Support accessible media queries such as reduced motion and high contrast.
- Component documentation must include accessibility checks before reuse.

## Experience Principles

Use these principles to evaluate flows and screen decisions:

- **Simplifies my full workflow:** Consider what the user did before arriving and what they need next. Use data and integrations to reduce effort.
- **Show me that you know me:** Prioritize what is relevant to the user, use preferences/behavior responsibly, and offer contextual guidance.
- **Guides me to improve my work:** Help users learn and make better choices through timely, relevant content.
- **Empowers me to act independently:** Make functionality intuitive without requiring users to learn internal systems or terminology.
- **Ensures me I am doing the right thing:** Recommend preferred paths, explain constraints, show consequences, and keep users in control.

## Tone of Voice Requirements

Atea communication should feel hungry, curious, sincere, bold, collaborative, witty, and responsible.

Do:

- Be bold, excited, curious, confident, and willing to challenge the status quo.
- Be truthful, humble, warm, empathetic, and helpful.
- Use a team-first and partnership-oriented tone.
- Be approachable, clear, playful when appropriate, and easy to understand.
- Own mistakes and explain how they will be addressed.

Do not:

- Be vague, arrogant, generic, lukewarm, indecisive, or overly pragmatic.
- Overuse IT jargon or internal lingo.
- Oversell, overplay humor, or lose sight of the audience and core message.
- Treat customers or partners as outsiders.
- Blame others or avoid responsibility.

## Component Rules

Prefer official Atea Design System components for Angular, React, Vue, or Figma when available. Components must be modern, encapsulated, easy to implement/migrate, UX/UI reviewed, code reviewed, accessible, and documented.

### Checkbox

- Use checkboxes for independent binary or multi-select options.
- Keep labels short and informative. If more explanation is needed, use helper text, an info toggle, or group-level legend/paragraph text.
- Use error state only when needed to continue a form; include a visual cue and clear error message.
- Use disabled state only when the user cannot change the input or must wait for another interaction.
- Use indeterminate state for parent selections where only some children are selected.
- Focus-visible outline: 2.5px around the input.
- Keyboard: Tab focuses each enabled checkbox; Space toggles checked/unchecked.
- ARIA: `aria-checked="true"`, `false`, or `mixed`; required fields use `aria-required` and validation messaging.
- Group related checkboxes with `fieldset` and `legend`.

### Modal

- Use modals only when content requires immediate focus and interaction.
- Modal anatomy: dialog container, close button, backdrop/overlay.
- Use descriptive headings that accurately describe the modal purpose.
- Footer actions should be tied directly to the modal task.
- Default max height: `93svh` to handle mobile viewport changes.
- Standard widths: large `1000px`, medium `800px`, small `650px`; use custom width only when the flow requires it.
- Left/right variants may be used to provide spatial cues for workflows or complementary information.
- Use skeleton loading in modals to preserve layout and signal loading.
- Accessibility: move focus to the first meaningful element on open, trap focus while open, restore focus to the trigger on close, and hide background content from assistive technologies.
- Keyboard: Tab/Shift+Tab stays inside; Escape closes unless the modal is intentionally non-dismissable.

## Atea Compliance Checklist

For every Atea user-facing story, verify:

- Atea applicability is recorded in `PROJECT-MEMORY.md`.
- UX outputs state how Atea tokens, components, accessibility, and tone are applied.
- Primary colors, typography, spacing, radius, grid, elevation, iconography, and motion use Atea tokens or documented exceptions.
- Secondary color use is limited and approved where required.
- Text, labels, errors, empty states, and guidance use Atea tone and avoid internal jargon.
- WCAG 2.2 AA checks are included for contrast, focus, keyboard behavior, semantics, alt text, resizing, reduced motion, and high contrast.
- Implementation uses existing Atea Design System components when available.
- QA validates the final UI against the approved Atea design package and this skill.