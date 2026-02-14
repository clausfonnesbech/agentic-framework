# Curiosity Skill

**Skill Type:** Information Gathering  
**Purpose:** Generate intelligent, contextual clarifying questions to deeply understand user needs

## Overview

The Curiosity Skill enables agents to systematically explore and understand requests by asking targeted, insightful questions across multiple dimensions. This skill helps uncover hidden requirements, identify assumptions, and ensure comprehensive understanding before solution design.

## When to Use This Skill

- ✅ At the beginning of any project or request
- ✅ When information provided is incomplete or vague
- ✅ Before creating specifications, designs, or proposals
- ✅ When assumptions need to be validated
- ✅ To explore the "why" behind requirements

## Core Principles

### 1. Question-Driven Discovery
Ask questions rather than make assumptions. Even obvious points may have nuances worth exploring.

### 2. Systematic Coverage
Cover all relevant dimensions systematically rather than randomly asking questions.

### 3. Progressive Depth
Start with high-level questions, then drill deeper based on responses.

### 4. Active Listening
Pay attention to what's said AND what's not said. Follow up on gaps.

### 5. Judgment-Free Inquiry
Ask questions to understand, not to challenge or critique.

## Question Categories

### 🎯 1. Objectives & Goals

**Purpose:** Understand the "why" behind the request

**Example Questions:**
- "What is the primary business objective you're trying to achieve?"
- "What problem are you trying to solve, and why is it important now?"
- "What does success look like for this project?"
- "What would happen if this wasn't built?"
- "Are there any secondary or long-term objectives?"

**Follow-up Triggers:**
- If answer is vague → "Could you be more specific about..."
- If answer mentions metrics → "What's the current baseline for..."
- If answer mentions pain points → "How frequently does this problem occur?"

### 👥 2. Stakeholders & Users

**Purpose:** Identify all affected parties and their needs

**Example Questions:**
- "Who are the primary users or beneficiaries of this solution?"
- "Who are the decision-makers and sponsors?"
- "Are there any secondary user groups we should consider?"
- "Who will be responsible for maintaining this after it's built?"
- "Are there any stakeholders who might resist this change?"

**Follow-up Triggers:**
- If multiple user types mentioned → "How do their needs differ?"
- If specific roles mentioned → "How many people in each role?"
- If resistance mentioned → "What are their concerns?"

### ⏰ 3. Constraints & Limitations

**Purpose:** Understand boundaries and restrictions

**Example Questions:**
- "Are there any budget constraints or limitations?"
- "What is your expected or required timeline?"
- "Are there any technology or platform constraints?"
- "Are there regulatory or compliance requirements to consider?"
- "What resources (people, tools, infrastructure) are available?"

**Follow-up Triggers:**
- If tight timeline → "What's driving this deadline?"
- If budget mentioned → "Is this a hard cap or flexible?"
- If compliance mentioned → "Which specific regulations apply?"

### 📦 4. Scope & Boundaries

**Purpose:** Define what's in and what's out

**Example Questions:**
- "What are the must-have features or capabilities?"
- "What would be nice-to-have but not essential?"
- "Are there any features or capabilities explicitly out of scope?"
- "How does this fit into the broader ecosystem or roadmap?"
- "What's the minimum viable version that would add value?"

**Follow-up Triggers:**
- If features listed → "How would you prioritize these?"
- If integrations mentioned → "How critical is each integration?"
- If MVP mentioned → "What could be deferred to later phases?"

### 🔧 5. Technical Context

**Purpose:** Understand the technical landscape

**Example Questions:**
- "Are there existing systems this needs to integrate with?"
- "Do you have preferred technologies or platforms?"
- "What's your current technical infrastructure?"
- "Are there any technical skills or expertise available in-house?"
- "What's your approach to security and data privacy?"

**Follow-up Triggers:**
- If systems mentioned → "What APIs or interfaces do they expose?"
- If preferences stated → "What's driving that preference?"
- If skills mentioned → "What's the team's experience level?"

### 📊 6. Success Metrics

**Purpose:** Define measurable outcomes

**Example Questions:**
- "How will you measure the success of this project?"
- "What key performance indicators (KPIs) matter most?"
- "What metrics are you tracking today that should improve?"
- "How will you know when this is ready to launch?"
- "What would make this project a complete failure?"

**Follow-up Triggers:**
- If qualitative goals → "How could we quantify that?"
- If specific numbers given → "What's the current baseline?"
- If multiple metrics → "Which is the most important?"

### ⚠️ 7. Risks & Concerns

**Purpose:** Identify potential challenges early

**Example Questions:**
- "What concerns or risks do you foresee with this project?"
- "Have you attempted something similar before? What happened?"
- "What could prevent this project from succeeding?"
- "Are there any dependencies on other projects or teams?"
- "What keeps you up at night about this initiative?"

**Follow-up Triggers:**
- If past failures mentioned → "What would you do differently this time?"
- If dependencies identified → "How firm are those dependencies?"
- If concerns shared → "How can we mitigate that risk?"

## Question Generation Framework

### Step 1: Analyze the Request

Review the initial request and identify:
- What information IS provided
- What information is MISSING
- What assumptions might be being made
- Which categories need the most clarification

### Step 2: Prioritize Questions

Determine which questions are:
- **Critical** - Must be answered to proceed
- **Important** - Should be answered for quality
- **Nice-to-know** - Would add context but not essential

### Step 3: Sequence Questions Logically

Group and order questions to create a natural conversation flow:
1. Start with high-level "why" questions
2. Move to "who" and "what" questions
3. Progress to "how" and "when" questions
4. End with risks and concerns

### Step 4: Ask Questions Progressively

- Start with 5-8 core questions
- Listen to responses carefully
- Ask follow-up questions based on answers
- Continue until you have sufficient clarity

## How to Apply This Skill

### For Agents Using This Skill:

1. **Activate the Skill**
   - Reference this document when you need to gather information
   - Think through which question categories are most relevant

2. **Generate Initial Questions**
   - Select 5-8 questions across relevant categories
   - Ensure coverage of critical dimensions
   - Word questions clearly and specifically

3. **Conduct Q&A Session**
   - Ask questions one at a time or in small groups
   - Wait for and listen to responses
   - Identify vague or incomplete answers

4. **Ask Follow-ups**
   - Use the "Follow-up Triggers" for each category
   - Drill deeper into areas that are unclear
   - Confirm understanding by paraphrasing

5. **Synthesize Understanding**
   - Review all answers together
   - Identify any remaining gaps
   - Ask final clarifying questions if needed

6. **Document Findings**
   - Record questions and answers systematically
   - Note any assumptions still being made
   - Highlight areas needing further research

## Example Usage

### Initial Request:
```
"I need a customer feedback system for my small business."
```

### Applying Curiosity Skill:

**Objectives:**
- "What's the main problem you're trying to solve with customer feedback?"
- "How are you collecting feedback today, and what's not working?"

**Stakeholders:**
- "Who will be using this system? Your team, your customers, or both?"
- "How many people will need access to view or manage feedback?"

**Constraints:**
- "What's your budget and timeline for getting this implemented?"

**Scope:**
- "What types of feedback do you want to collect? (surveys, ratings, comments, etc.)"
- "Do you need to respond to feedback within the system, or just collect it?"

**Technical:**
- "Do you need this to integrate with any existing tools (CRM, email, etc.)?"

**Success Metrics:**
- "How will you know if this feedback system is working well for your business?"

### After Receiving Answers:

**Follow-up Questions:**
- If they mention "improve response time" → "What's your current response time, and what's your target?"
- If they mention "50 employees" → "Are they all in one location or distributed?"
- If they mention "tight budget" → "Do you have a specific number in mind?"

## Quality Indicators

### Good Questions Are:

- ✅ **Open-ended** - Cannot be answered with just yes/no
- ✅ **Specific** - Target a particular aspect or dimension
- ✅ **Neutral** - Don't lead toward a particular answer
- ✅ **Clear** - Easy to understand without jargon
- ✅ **Relevant** - Directly related to the project
- ✅ **Progressive** - Build on previous answers

### Avoid Questions That Are:

- ❌ **Leading** - "Don't you think it would be better to..."
- ❌ **Multiple-in-one** - "What's your budget, timeline, and team size?"
- ❌ **Too technical** - Use jargon without knowing user's expertise
- ❌ **Hypothetical** - "What if in the future you wanted to..."
- ❌ **Judgmental** - "Why would you do it that way?"

## Integration with Other Skills

This skill complements:
- **Research Skill** - Questions identify what needs to be researched
- **Analysis Skill** - Answers provide data for analysis
- **Design Skill** - Understanding informs design decisions
- **Planning Skill** - Clarity enables better planning

## Tips for Effectiveness

1. **Don't rush** - Take time to formulate good questions
2. **Listen actively** - Pay attention to nuances in answers
3. **Be curious, not interrogative** - Make it a conversation
4. **Confirm understanding** - Paraphrase answers back
5. **Know when to stop** - Recognize when you have sufficient information
6. **Document thoroughly** - Capture both questions and answers

## Skill Mastery

You've mastered this skill when you can:
- Generate relevant questions quickly across all categories
- Identify gaps in information without being told
- Ask follow-ups naturally based on responses
- Balance breadth and depth of inquiry
- Know when you have sufficient information to proceed
- Make users feel heard and understood

---

**Skill Version:** 1.0  
**Category:** Information Gathering  
**Difficulty:** Intermediate  
**Prerequisites:** None  
**Complements:** Research, Analysis, Planning skills
