# Market Research Skill

**Skill Type:** Competitive Analysis & Market Intelligence  
**Purpose:** Conduct competitive analysis, understand market landscapes, identify trends, and evaluate market positioning

## Overview

The Market Research Skill enables agents to systematically analyze competitive landscapes, compare product features and positioning, evaluate pricing strategies, and identify market trends. This skill transforms market data into actionable insights for product strategy and business decisions.

## When to Use This Skill

- ✅ Identifying competitors in a market space
- ✅ Comparing product features across vendors
- ✅ Analyzing pricing strategies and models
- ✅ Understanding market positioning and differentiation
- ✅ Identifying market trends and opportunities
- ✅ Evaluating market entry strategies
- ✅ Assessing competitive threats

## Core Principles

### 1. Define the Market First
Understand the boundaries of the market you're analyzing (geography, segment, price range).

### 2. Direct vs. Indirect Competition
Direct competitors solve the same problem the same way. Indirect competitors solve the same problem differently.

### 3. Features vs. Benefits
Features are what a product has. Benefits are what customers get. Focus on benefits.

### 4. Customer Perspective
Analyze from the customer's point of view, not just product capabilities.

### 5. Trends Over Snapshots
One-time data points are limited. Look for patterns and direction.

## Competitive Landscape Mapping

### Step 1: Identify Competitors

**Categories:**

**Direct Competitors:**
- Solve the same problem
- Target the same customers
- Use similar approaches
- Example: If building project management tool → Asana, Monday.com, Jira

**Indirect Competitors:**
- Solve the same problem differently
- May target slightly different customers
- Example: If building project management tool → Notion, Excel, Email workflows

**Emerging Competitors:**
- New entrants with different approaches
- Often leveraging new technology
- Example: AI-powered solutions disrupting traditional tools

**Non-Consumption:**
- People not using any solution
- Often the biggest "competitor"
- Example: Teams using paper/whiteboards instead of digital tools

**Discovery Methods:**

1. **Google Search Patterns:**
   - "[problem space] software"
   - "alternatives to [known competitor]"
   - "[industry] tools"
   - "best [use case] solutions"

2. **Review Sites:**
   - G2.com
   - Capterra
   - TrustRadius
   - Product Hunt
   - Software Advice

3. **Industry Reports:**
   - Gartner Magic Quadrant
   - Forrester Wave
   - IDC MarketScape

4. **Social Signals:**
   - LinkedIn: What tools do target users mention?
   - Reddit: What solutions are discussed in relevant subreddits?
   - Twitter: What do industry influencers use?

**Output Format:**

```markdown
## Competitive Landscape

**Direct Competitors:**
1. [Company A] - Description, primary focus
2. [Company B] - Description, primary focus
3. [Company C] - Description, primary focus

**Indirect Competitors:**
1. [Company D] - How they solve the problem differently
2. [Company E] - How they solve the problem differently

**Emerging Threats:**
1. [Startup F] - What makes them different/disruptive

**Non-Consumption:**
- Current manual processes being used
- Why people aren't using existing solutions
```

---

### Step 2: Feature Comparison Matrix

**Framework:**

Identify features across **5 categories:**

1. **Core Features:** Must-have capabilities that define the category
2. **Advanced Features:** Nice-to-have, power-user capabilities
3. **Integration Features:** Connects to other tools
4. **Platform Features:** Mobile, API, enterprise capabilities
5. **Support Features:** Documentation, training, customer support

**Comparison Matrix Template:**

```markdown
| Feature Category | [Our Solution] | Competitor A | Competitor B | Competitor C |
|-----------------|----------------|--------------|--------------|--------------|
| **CORE FEATURES** |
| Feature 1 | ✅ Full | ✅ Full | ⚠️ Limited | ❌ No |
| Feature 2 | ✅ Full | ⚠️ Limited | ✅ Full | ✅ Full |
| Feature 3 | ⚠️ Planned | ✅ Full | ✅ Full | ⚠️ Limited |
| **ADVANCED FEATURES** |
| Feature 4 | ✅ Full | ❌ No | ⚠️ Limited | ✅ Full |
| Feature 5 | ✅ Full | ✅ Full | ❌ No | ❌ No |
| **INTEGRATIONS** |
| Platform X | ✅ Native | ✅ Native | ⚠️ Zapier | ❌ No |
| Platform Y | ⚠️ Roadmap | ✅ Native | ✅ Native | ⚠️ API |
| **PLATFORM** |
| Mobile App | ✅ iOS + Android | ✅ iOS + Android | ⚠️ iOS only | ❌ No |
| API Access | ✅ Full | ⚠️ Limited | ✅ Full | ❌ No |
| White-label | ❌ No | ❌ No | ✅ Enterprise | ✅ Yes |
| **SUPPORT** |
| Documentation | ✅ Excellent | ⚠️ Good | ⚠️ Limited | ✅ Excellent |
| Live Support | ⚠️ Paid plans | ✅ All plans | ❌ Email only | ✅ All plans |

**Legend:**
- ✅ Full: Complete implementation
- ⚠️ Limited/Planned: Partial or in development
- ❌ No: Not available
```

**Analysis Template:**

```markdown
## Feature Comparison Insights

**Our Strengths:**
- Feature 2: Full implementation vs. mixed competition
- Feature 5: Only we and Competitor A have this
- Mobile: Full platform parity with top competitors

**Our Gaps:**
- Feature 3: We're planned, but competition already has it
- White-label: Available in competitors C and B for enterprise
- Live Support: Only available on paid plans (competitive disadvantage)

**Differentiation Opportunities:**
- Feature 5 + Mobile: Only we and Competitor A offer both
- Could emphasize this combination in positioning

**Priority Gaps to Address:**
1. Feature 3 (planned) - critical for feature parity
2. White-label (if targeting enterprise) - blocks large deals
3. Live support on more plans (retention risk)
```

---

### Step 3: Pricing Analysis

**Pricing Model Categories:**

1. **Freemium:** Free core features, paid advanced features
2. **Tiered:** Multiple pricing tiers (Starter, Pro, Enterprise)
3. **Usage-Based:** Pay for what you use (per API call, per GB, etc.)
4. **Per-Seat:** Price per user/month
5. **Flat-Rate:** Fixed price regardless of users/usage
6. **Hybrid:** Combination (e.g., per-seat with usage limits)

**Pricing Research Template:**

```markdown
## Competitive Pricing Analysis

### [Competitor A]
**Model:** Tiered + Per-Seat

**Free Tier:**
- Up to 10 users
- Core features only
- 1 GB storage
- Community support

**Pro Tier:** $12/user/month
- Unlimited users minimum 3 seats = $36/mo
- All features except white-label
- 10 GB storage per user
- Email support
- 14-day free trial

**Enterprise Tier:** Custom pricing
- Volume discounts
- White-label
- Dedicated support
- SSO/SAML
- SLA guarantee
- Starts ~$500/month (estimated from reviews)

**Annual Discount:** 20% (2 months free)

**Payment Options:** Credit card, invoice (Enterprise)

---

### [Competitor B]
**Model:** Usage-Based + Base Fee

**Starter:** $29/month
- 1,000 API calls included
- $0.01 per additional call
- 5 GB storage
- All features

**Growth:** $99/month
- 10,000 API calls included
- $0.008 per additional call
- 50 GB storage
- Priority support

**Enterprise:** Custom
- Negotiated rates
- Dedicated infrastructure
- Custom SLAs

**Annual Discount:** 15%

---

### Pricing Positioning Matrix

```
Price (per user/month)
↑
$50+ │           [Enterprise]
     │              ⬤ Competitor C (full-featured, enterprise focus)
$30  │        ⬤ Competitor A Pro
     │      ⬤ Our Solution (proposed $25)
$20  │   
     │  ⬤ Competitor B Starter (usage-based, unpredictable costs)
$10  │
     │
Free │ ⬤ All free tiers
     └──────────────────────────────────────────────→
       Basic           Standard           Advanced
                   Features
```

## Pricing Insights

**Price Bands:**
- **Free/Freemium:** Most competitors offer free tier (10-15 users)
- **Entry Tier:** $10-$15/user/month (small teams)
- **Mid Tier:** $25-$35/user/month (growing companies)
- **Enterprise:** $50+/user/month or custom (large orgs)

**Our Positioning ($25/user/month):**
- ✅ Competitive with mid-market (between Competitor A and C)
- ✅ Predictable pricing vs. Competitor B's usage-based
- ⚠️ No free tier (unlike Competitor A) - acquisition challenge
- 🎯 Sweet spot for 10-50 user teams

**Pricing Strategy Recommendations:**
1. **Consider free tier:** Competitor A's free tier is a strong acquisition tool
2. **Annual discount:** Match or beat 20% standard
3. **Minimum seats:** Avoid Competitor A's 3-seat minimum (barrier for small teams)
4. **Value metric:** Per-user pricing works for collaboration tools
5. **Enterprise tier:** Add for >100 users with custom features (SSO, white-label)
```

---

### Step 4: Market Positioning

**Positioning Framework:**

Every solution occupies a position on multiple axes. Identify where you and competitors sit.

**Common Positioning Axes:**

1. **Price:** Budget vs. Premium
2. **Complexity:** Simple vs. Feature-Rich
3. **Target Customer:** SMB vs. Enterprise
4. **Specialization:** Generalist vs. Specialist
5. **Technology:** Traditional vs. Cutting-Edge

**2x2 Positioning Map Template:**

```
Simple/Easy to Use
        ↑
        │    [Quadrant Q2: Simple + Premium]
        │       ⬤ Competitor C (expensive, user-friendly)
        │
Premium ├────────────────┼────────────────┤ Budget
        │                │
        │    [Q3: Feature-Rich + Premium]    [Q1: Simple + Budget]
        │       ⬤ Competitor A (powerful,         ⬤ Our Solution (easy, affordable)
        │         expensive)                
        │                │
        │    [Q4: Feature-Rich + Budget]
        │       ⬤ Competitor B (complex, cheap)
        │
        ↓
Complex/Feature-Rich
```

**Positioning Statement Template:**

```markdown
## Market Positioning

**Our Position:**
For [target customer] who [problem/need], [product name] is a [category] that [key benefit]. Unlike [competitors], we [unique differentiator].

**Example:**
For **small to mid-sized development teams** who need to **manage projects without complexity**, **DevBoard** is a **lightweight project management tool** that provides **just the essentials without bloat**. Unlike **Jira** (complex) and **Asana** (expensive), we offer **simplicity at an affordable price**.

---

**Positioning Analysis:**

**Competitor A:** "The powerful platform for enterprise teams"
- Position: Feature-rich, enterprise-focused
- Strength: Comprehensive capabilities
- Weakness: Complex for small teams, expensive

**Competitor B:** "Project management for everyone"
- Position: Accessible, budget-friendly
- Strength: Low barrier to entry
- Weakness: Usage-based pricing creates uncertainty

**Competitor C:** "Beautiful, intuitive collaboration"
- Position: Design-focused, premium
- Strength: Best user experience
- Weakness: Expensive, fewer integrations

**Our Position:** "Essential project management, done right"
- Position: Simple + affordable + reliable
- Target: 10-50 person teams who don't need enterprise complexity
- Differentiator: Right-sized features at predictable pricing

**Message Hierarchy:**
1. Primary: "Simple enough for any team, powerful enough for real projects"
2. Secondary: "Affordable pricing that grows with you"
3. Proof points: "Set up in minutes, not weeks"
```

---

## Trend Identification

### Technology Trends

**Where to Find Trends:**

1. **Industry Reports:**
   - Gartner Hype Cycle
   - Forrester predictions
   - IDC technology forecasts

2. **Developer Surveys:**
   - Stack Overflow Developer Survey
   - State of JS/CSS/etc.
   - GitHub Octoverse

3. **Thought Leaders:**
   - Twitter/X industry experts
   - Technical blogs (Martin Fowler, etc.)
   - Conference talks (Re:Invent, Google I/O, etc.)

4. **GitHub Trends:**
   - Trending repositories
   - Star growth rates
   - New framework releases

5. **Google Trends:**
   - Search interest over time
   - Regional interest
   - Related queries

**Trend Analysis Template:**

```markdown
## Market Trends

### Trend 1: AI Integration
**Description:** Products adding AI-powered features (summarization, suggestions, automation)

**Evidence:**
- Competitor A added AI task suggestions (Q4 2025)
- Competitor C launched AI document analysis (January 2026)
- 73% of SaaS products added "AI" features in 2025 (Gartner report)
- Search interest for "[category] AI" up 340% YoY

**Maturity:** Early majority adoption

**Impact on Our Product:**
- ✅ Opportunity: Add AI task prioritization to differentiate
- ⚠️ Risk: Becoming "table stakes" - must have AI features to compete
- 🎯 Recommendation: Prioritize AI roadmap items for Q2 2026

---

### Trend 2: Usage-Based Pricing
**Description:** Shift from per-seat to usage-based pricing models

**Evidence:**
- Competitor B moved to usage pricing (2025)
- Multiple SaaS companies following (Snowflake model)
- CFOs prefer predictable costs, but developers prefer usage-based

**Maturity:** Early adopters

**Impact on Our Product:**
- ⚠️ Mixed: Usage-based can increase revenue but adds complexity
- ✅ Opportunity: Hybrid model (base + overages)
- 🎯 Recommendation: Monitor but don't rush - per-seat still dominant in our category

---

### Trend 3: No-Code/Low-Code Customization
**Description:** Users want to customize without developers

**Evidence:**
- Notion's database formulas
- Airtable's automations
- Survey: 68% of users want customization without IT (Forrester)

**Maturity:** Mainstream adoption

**Impact on Our Product:**
- ✅ Opportunity: Add workflow automation (like Competitor A)
- ✅ Differentiator: Make it simpler than competitors (our positioning)
- 🎯 Recommendation: High priority - becoming expected feature
```

### Customer Behavior Trends

**Sources:**
- User interviews
- Support tickets (what do people ask for?)
- Feature requests
- Churn reasons
- Win/loss analysis (why did customers choose/reject you?)

**Pattern Recognition:**

Look for repeated themes in:
- Feature requests → What's missing?
- Complaints → What's frustrating?
- Workarounds → What are users hacking together?
- Praise → What's working well?

**Example:**

```markdown
## Customer Behavior Insights

**Pattern 1: Mobile-First Usage**
- 45% of daily active users access primarily via mobile (up from 28% in 2024)
- Support requests: "Mobile app is missing [feature]"
- Competitor comparison: Users cite mobile as decision factor

**Implication:**
- Must achieve feature parity for mobile app
- Desktop-first development no longer sufficient

---

**Pattern 2: Integration Requests**
- Top 5 requested integrations: Slack, Google Drive, Microsoft Teams, Zoom, GitHub
- 62% of churn mentions "doesn't work with our tools" (exit surveys)

**Implication:**
- Integration strategy is competitive requirement
- Prioritize top 5 integrations before adding more features
```

---

## Competitive Intelligence Gathering

### Ethical Information Sources

**✅ Legitimate Sources:**
- Public websites and marketing materials
- Product demos and free trials
- Public financial filings (for public companies)
- Press releases and news articles
- Conference presentations
- Public reviews and testimonials
- Social media (Twitter, LinkedIn)
- Job postings (reveal strategy and tech stack)
- Patent filings

**❌ Unethical/Illegal:**
- Impersonating customers to get sales info
- Accessing private systems or documents
- Bribing employees for information
- Corporate espionage

### Monitoring Competitor Updates

**Set Up Alerts:**

1. **Google Alerts:**
   - "[Competitor name]"
   - "[Competitor name] new feature"
   - "[Competitor name] pricing"

2. **Changelog Monitoring:**
   - Subscribe to competitor newsletters
   - Check changelog pages monthly
   - Use ChangeDetection.io for automated monitoring

3. **Social Listening:**
   - Follow competitor accounts on Twitter/LinkedIn
   - Monitor hashtags related to the space
   - Track industry influencers

4. **Job Posting Analysis:**
   - "Competitor + job openings" search
   - Reveals what they're building (hiring for React Native = building mobile)

**Quarterly Competitive Review:**

```markdown
## Q1 2026 Competitive Update

### Competitor A
**Changes:**
- Launched AI-powered task suggestions (Feb 2026)
- Pricing increase: Pro tier $12→$15/user (+25%)
- New integration: Microsoft Teams

**Analysis:**
- AI feature getting positive reviews (4.5★ average on G2)
- Pricing increase may create switching opportunity
- Teams integration closes gap with us

**Action Items:**
- Accelerate our AI roadmap (close gap)
- Target price-sensitive Competitor A users (marketing campaign)
- Maintain Teams integration parity

---

### Competitor B
**Changes:**
- Raised $50M Series B (January 2026)
- Acquired small competitor in whiteboard space
- No significant product updates

**Analysis:**
- Funding indicates aggressive growth plans
- Whiteboard acquisition suggests expanding beyond core
- May be spreading too thin vs. focusing

**Action Items:**
- Monitor for product integration announcements
- Stay focused on core use case (our advantage)

---

### Market Changes
**New Entrants:**
- StartupX launched with AI-first approach (free beta)
- Getting buzz on Product Hunt (3.2K upvotes)

**Analysis:**
- Early stage (expect bugs, limited features)
- AI-first angle resonating with early adopters
- Watch for product-market fit signals (retention, growth)

**Action Items:**
- Trial their product (understand AI approach)
- Consider AI features table stakes (see StartupX success)
```

---

## Market Entry Assessment

### When evaluating a new market:

**Market Attractiveness Checklist:**

**Market Size:**
- [ ] Total Addressable Market (TAM): How many potential customers?
- [ ] Serviceable Available Market (SAM): How many can you realistically reach?
- [ ] Serviceable Obtainable Market (SOM): How many can you capture year 1?

**Market Growth:**
- [ ] Growing (>10% YoY): Attractive
- [ ] Stable (0-10% YoY): Okay, but competitive
- [ ] Declining (<0% YoY): Challenging

**Competition:**
- [ ] Number of competitors: <5 (less crowded) vs. >20 (saturated)
- [ ] Competitor strength: Are there dominant players? (>50% market share)
- [ ] Differentiation possibility: Can you be meaningfully different?

**Customer Acquisition:**
- [ ] CAC (Customer Acquisition Cost): Can you acquire customers profitably?
- [ ] Sales cycle: How long does it take to close a deal?
- [ ] Channel availability: Can you reach customers effectively?

**Barriers to Entry:**
- [ ] Technical barriers: How hard to build?
- [ ] Regulatory barriers: Are there compliance requirements?
- [ ] Network effects: Do existing players have unfair advantages?

**Example Assessment:**

```markdown
## Market Entry: Project Management for Construction Industry

**Market Size:**
- TAM: 733K construction companies in US
- SAM: 25K companies with >20 employees (our target)
- SOM (Year 1): 100 customers (0.4% of SAM) = aggressive but achievable

**Market Growth:**
- Construction tech growing 15% YoY (Gartner)
- Digital adoption accelerating post-COVID
- ✅ Attractive growth rate

**Competition:**
- 3 main players (Procore, Buildertrend, CoConstruct)
- Procore dominates large enterprise (>5,000 employees)
- Mid-market (20-500 employees) more fragmented
- ✅ Opportunity in mid-market

**Differentiation:**
- Existing players are complex (built for enterprise)
- Our angle: "Simple project management built for contractors"
- Focus on field workers (mobile-first) vs. office workers
- ✅ Clear differentiation path

**Customer Acquisition:**
- CAC estimate: $2,000 (industry events, digital ads)
- ACV (Annual Contract Value): $300/month × 20 users × 12 = $72K
- LTV:CAC ratio: 36:1 (excellent if retention >3 years)
- ✅ Economically viable

**Barriers:**
- Technical: Medium (complex industry knowledge needed)
- Regulatory: Low (no special licensing)
- Network effects: Low (no strong network effects in PM tools)
- ⚠️ Domain expertise required (hire construction PM consultants)

**Decision: GO**
- Attractive market with clear opportunity
- Must invest in domain expertise
- Target mid-market contractors (20-500 employees)
- Differentiate on simplicity + mobile-first
```

---

## Quick Reference

### Competitive Research Checklist

For any market analysis:

**Competitor Identification:**
- [ ] List 5-10 direct competitors
- [ ] Identify 3-5 indirect competitors
- [ ] Note 1-2 emerging threats
- [ ] Define non-consumption (what are people using today?)

**Feature Comparison:**
- [ ] Create feature matrix (our solution vs. top 3 competitors)
- [ ] Identify our strengths (what do we do better?)
- [ ] Identify our gaps (what are we missing?)
- [ ] Find differentiation opportunities (unique combinations)

**Pricing Analysis:**
- [ ] Document competitor pricing models
- [ ] Identify price bands (low/mid/high)
- [ ] Analyze our positioning (where do we fit?)
- [ ] Calculate price/value ratio

**Market Positioning:**
- [ ] Create 2×2 positioning map
- [ ] Write positioning statement (target + problem + solution + vs. competition)
- [ ] Identify our unique angle
- [ ] Validate with customer feedback

**Trend Analysis:**
- [ ] Identify 3-5 relevant trends
- [ ] Assess trend maturity (early/growth/mature)
- [ ] Evaluate impact on our product
- [ ] Prioritize response actions

**Ongoing Monitoring:**
- [ ] Set up Google Alerts for competitors
- [ ] Subscribe to competitor newsletters/blogs
- [ ] Monitor changelog pages
- [ ] Track social media mentions
- [ ] Review quarterly (update competitive intelligence)

---

## Common Pitfalls to Avoid

**❌ Analysis Paralysis:**
Don't wait for perfect information. Make decisions with 70% confidence.

**❌ Feature Checklist Mentality:**
Having more features doesn't make you better. Focus on benefits, not feature count.

**❌ Ignoring Indirect Competition:**
The biggest threat often comes from a different category (Notion disrupting project management).

**❌ Static Analysis:**
Markets change. Review competitive intelligence quarterly, not once.

**❌ Copying Competitors:**
Differentiation matters more than feature parity. Don't just copy what others do.

**❌ Underestimating Switching Costs:**
Even if you're better, customers have inertia. Need to be 10× better to overcome switching costs.

---

**Skill Owner:** Research Agents, Business Analysts, Product Strategists  
**Skill Version:** 1.0  
**Last Updated:** February 12, 2026
