# Source Evaluation Skill

**Skill Type:** Research Quality Assurance  
**Purpose:** Assess credibility, authority, bias, and currency of information sources to ensure research quality

## Overview

The Source Evaluation Skill enables agents to critically assess the quality and reliability of information sources. This skill helps distinguish between authoritative, well-researched content and potentially biased, outdated, or low-quality information, ensuring that research findings are built on solid evidence.

## When to Use This Skill

- ✅ Before citing any source in research
- ✅ When encountering conflicting information
- ✅ When evaluating technical documentation
- ✅ Before making recommendations based on research
- ✅ When assessing competitive intelligence
- ✅ During fact-checking and verification

## Core Principles

### 1. Authority Matters
Official documentation and primary sources carry more weight than third-party interpretations or opinions.

### 2. Currency Is Critical
Technology and market information becomes outdated quickly. Prefer recent sources, especially for technical topics.

### 3. Bias Awareness
Recognize commercial interests, marketing content, and opinion pieces vs. factual reporting.

### 4. Cross-Verification
Important claims should be verified across multiple independent sources.

### 5. Context Is Key
Consider the source's purpose, audience, and positioning when evaluating information.

## Source Credibility Hierarchy

### Tier 1: Highest Credibility ⭐⭐⭐⭐⭐

**Official Documentation**
- Product documentation from vendors
- API references and technical specs
- Platform documentation (Microsoft Learn, AWS Docs, etc.)
- Open-source project documentation (GitHub, official sites)
- RFC standards and specifications

**Why Trusted:** First-hand, authoritative, maintained by creators

**Example Sources:**
- docs.djangoproject.com
- learn.microsoft.com
- supabase.com/docs
- developer.mozilla.org (MDN)

**Verification:** Check publication date, version compatibility

---

### Tier 2: High Credibility ⭐⭐⭐⭐

**Industry Publications & Research**
- Technology research firms (Gartner, Forrester, IDC)
- Academic papers and journals
- Technical conferences (proceedings, presentations)
- Industry standards organizations (W3C, IETF, ISO)
- Established technology publications (InfoQ, IEEE, ACM)

**Why Trusted:** Professional review, expert authorship, editorial standards

**Example Sources:**
- InfoQ.com
- IEEE Xplore
- ACM Digital Library
- Gartner.com

**Verification:** Check author credentials, peer review status, publication reputation

---

### Tier 3: Good Credibility ⭐⭐⭐

**Expert Content & Technical Blogs**
- Technology-focused news sites (TechCrunch, The Verge - for trends)
- Recognized expert blogs and personal sites
- Company engineering blogs (Netflix Tech Blog, Spotify Engineering)
- Developer advocate content
- Stack Overflow (for common patterns, not gospel)

**Why Generally Reliable:** Written by practitioners, often peer-reviewed by community

**Example Sources:**
- netflixtechblog.com
- martinfowler.com
- CSS-Tricks.com
- Dev.to (by known experts)

**Verification:** Check author background, cross-reference claims, watch for dates

---

### Tier 4: Moderate Credibility ⭐⭐

**Community Content & Tutorials**
- Medium articles (quality varies widely)
- YouTube tutorials (from known educators)
- Community forums and discussions
- Third-party tutorials and guides
- Bootstrap templates and examples

**Why Use Cautiously:** Helpful for patterns and ideas, but verify technical accuracy

**Example Sources:**
- Medium.com
- Dev.to (unknown authors)
- YouTube (educational channels)
- Reddit (r/programming, etc.)

**Verification:** Cross-check all technical claims, verify code examples, check comments for corrections

---

### Tier 5: Low Credibility ⭐

**Marketing & Promotional Content**
- Vendor marketing pages (vs. documentation)
- Sales-focused case studies
- Sponsored content and advertorials
- Comparison sites with affiliate links
- AI-generated content farms

**Why Be Skeptical:** Commercial bias, potentially outdated, may lack technical depth

**Example Sources:**
- Product landing pages
- "Top 10" listicles with affiliate links
- Press releases
- Sponsored blog posts

**Verification:** Treat as leads only, verify all claims independently, seek objective sources

---

## Evaluation Framework

### The 5 C's of Source Evaluation

#### 1. **Credibility** (Authority)
**Questions to Ask:**
- Who is the author/organization?
- What are their credentials or expertise?
- Is this a primary source or interpretation?
- Is the organization authoritative in this domain?

**Red Flags:**
- Anonymous authorship
- No verifiable credentials
- Third-party interpretation of technical details
- Unknown or questionable organization

**Green Flags:**
- Official documentation
- Recognized expert or authority
- Primary source material
- Established organization or publication

---

#### 2. **Currency** (Timeliness)
**Questions to Ask:**
- When was this published or last updated?
- Is the information still relevant?
- Have there been significant changes since publication?
- Is this the latest version of documentation?

**Red Flags:**
- No publication date visible
- Content >2 years old for rapidly evolving tech
- Refers to deprecated versions
- Uses outdated terminology

**Green Flags:**
- Published within last 12 months
- Shows last updated date
- References current versions
- Includes 2024-2026 information

**Special Cases:**
- Fundamental concepts: Age matters less
- Specific technologies: Recency critical
- Best practices: Check if still current

---

#### 3. **Coverage** (Depth & Scope)
**Questions to Ask:**
- Does this provide enough detail for my needs?
- Is the scope appropriate to the topic?
- Are important aspects missing?
- Is this comprehensive or superficial?

**Red Flags:**
- Overly simplistic for complex topics
- Missing critical details or caveats
- Narrow focus presented as comprehensive
- Glosses over important limitations

**Green Flags:**
- Appropriate depth for topic
- Acknowledges limitations and tradeoffs
- Provides concrete examples
- Covers edge cases and gotchas

---

#### 4. **Objectivity** (Bias & Balance)
**Questions to Ask:**
- Does the author have commercial interests?
- Is this presenting facts or opinions?
- Are alternatives fairly considered?
- Is there obvious marketing language?

**Red Flags:**
- Promotional language ("revolutionary," "amazing")
- Only positive aspects mentioned
- Dismissive of alternatives
- Affiliate links or sponsorship

**Green Flags:**
- Balanced pros and cons
- Acknowledges tradeoffs
- Cites limitations
- Compares options fairly
- Clear separation of fact and opinion

---

#### 5. **Corroboration** (Verification)
**Questions to Ask:**
- Can I verify this across multiple sources?
- Do other credible sources agree?
- Are there sources cited for key claims?
- Can I test or validate this myself?

**Red Flags:**
- Unique claims not found elsewhere
- No sources or citations provided
- Conflicts with official documentation
- "Secret" or "insider" information

**Green Flags:**
- Multiple independent sources agree
- Claims are well-cited
- Consistent with official docs
- Can be independently verified

---

## Practical Application

### Research Workflow Integration

**Step 1: Initial Discovery**
```
Find information → Quick credibility check → Assess if worth deeper evaluation
```

**Step 2: Detailed Evaluation**
```
Apply 5 C's framework → Score source → Decide: Use, Verify, or Reject
```

**Step 3: Citation**
```
Include source tier in notes → Cite with full URL and date → Note any limitations
```

### Example Evaluation

**Scenario:** Researching authentication options for Python web app

**Source Found:** Medium article "The Complete Guide to Python Authentication"

**Evaluation:**

1. **Credibility:** ⭐⭐
   - Author: Unknown developer, no credentials listed
   - Not official documentation
   - **Assessment:** Moderate credibility, verify claims

2. **Currency:** ⭐⭐⭐⭐
   - Published: January 2026
   - Discusses current frameworks
   - **Assessment:** Very current

3. **Coverage:** ⭐⭐⭐
   - Covers 3 authentication methods
   - Includes code examples
   - Missing security considerations
   - **Assessment:** Good but incomplete

4. **Objectivity:** ⭐⭐⭐
   - Presents pros/cons
   - Some promotional language for one method
   - **Assessment:** Mostly balanced

5. **Corroboration:** ⭐⭐
   - Claims match official docs (checked)
   - One approach not found elsewhere
   - **Assessment:** Partially verified

**Decision:** Use as supplementary source; verify technical details against official documentation; cite as Tier 3 source; note limitations in research notes.

---

## Bias Detection Patterns

### Commercial Bias Indicators
- Promotes specific product without alternatives
- Uses superlatives ("best," "only," "must-have")
- Focuses on features without mentioning limitations
- Written/sponsored by vendor
- Includes pricing/purchase information prominently

**Action:** Seek independent reviews and official docs

---

### Recency Bias Indicators
- Presents newest as always best
- Dismisses established solutions as "outdated"
- Overemphasizes "cutting-edge" or "modern"
- Ignores stability and maturity considerations

**Action:** Balance innovation with proven reliability

---

### Confirmation Bias (Your Own!)
- Preferring sources that agree with existing assumptions
- Dismissing contradictory evidence
- Cherry-picking favorable findings

**Action:** Actively seek diverse perspectives; note disagreements

---

### Authority Bias
- Accepting claims solely based on source reputation
- Not verifying even credible sources
- Assuming official = always correct

**Action:** Verify important claims even from Tier 1 sources

---

## Conflicting Information Protocol

**When sources disagree:**

1. **Check Currency**
   - Is one source outdated?
   - Has the technology/practice changed?

2. **Assess Context**
   - Are they discussing different use cases?
   - Different versions or configurations?

3. **Evaluate Credibility**
   - Which source is more authoritative?
   - Primary vs. secondary source?

4. **Test or Verify**
   - Can you test the claim?
   - Check official documentation?

5. **Document Both Views**
   - Note the disagreement in research
   - Present both perspectives with sources
   - Explain which you're recommending and why

---

## Special Source Types

### GitHub Repositories
**Evaluation Criteria:**
- Stars and forks (popularity indicator)
- Recent commits (actively maintained?)
- Open vs. closed issues (health indicator)
- Documentation quality
- License and backing organization

**Red Flags:** No commits in >6 months, many unresolved issues, poor documentation

---

### Stack Overflow
**Evaluation Criteria:**
- Answer score (community validation)
- Answer date (still relevant?)
- Comments (corrections or updates?)
- Accepted answer status

**Red Flags:** Negative or zero score, very old (>3 years), contradicted in comments

---

### Academic Papers
**Evaluation Criteria:**
- Peer-reviewed? Conference/journal tier?
- Citation count (influence indicator)
- Author institution and credentials
- Reproducibility and methodology

**Red Flags:** Preprint only, predatory journal, no citations, poor methodology

---

### API Documentation
**Evaluation Criteria:**
- Official source? (company domain)
- Version clearly indicated?
- Changelog available?
- Examples provided and tested?

**Red Flags:** Third-party docs vs. official, version unclear, broken examples

---

## Red Flags Checklist

⚠️ **Immediate Skepticism Warranted:**
- [ ] No author or organization identified
- [ ] No publication date visible
- [ ] Content is behind paywall from unknown source
- [ ] Excessive marketing language
- [ ] Claims seem too good to be true
- [ ] No sources cited for factual claims
- [ ] Conflicts with multiple credible sources
- [ ] AI-generated content with no human review
- [ ] Affiliate links prominently displayed
- [ ] Anonymous or pseudonymous authorship on technical topics

---

## Citation Best Practices

### Complete Citation Format
```
Source Name - Full URL - Date Accessed
Source Tier: [1-5]
Key Information: [What you used from this source]
Limitations: [Any caveats or concerns]
```

### Example
```
Django Authentication Documentation - https://docs.djangoproject.com/en/5.0/topics/auth/ - Feb 12, 2026
Source Tier: 1 (Official Documentation)
Key Information: Built-in authentication system, User model, permissions framework
Limitations: None (authoritative source)
```

---

## Quick Reference Guide

### "Should I Use This Source?" Decision Tree

```
Is it official documentation? 
  YES → Use (Tier 1) ✅
  NO → Continue...

Is it published in last 12 months?
  NO → Be cautious, check for updates ⚠️
  YES → Continue...

Can I verify key claims across 2+ sources?
  NO → Note as unverified; seek corroboration ⚠️
  YES → Continue...

Is there obvious commercial bias?
  YES → Verify independently; cite with caution ⚠️
  NO → Continue...

Does author have verifiable expertise?
  NO → Use as supplementary only; verify all claims ⚠️
  YES → Use (Tier 2-3) ✅
```

---

## Quality Self-Check

Before citing a source, ask:

- ✅ Have I checked the source tier?
- ✅ Is this source current enough for my topic?
- ✅ Have I noted any potential biases?
- ✅ Have I verified key claims across sources?
- ✅ Have I documented limitations?
- ✅ Could I defend this citation to a skeptical reviewer?

---

**Skill Owner:** Research Agents, Research Manager  
**Skill Version:** 1.0  
**Last Updated:** February 12, 2026
