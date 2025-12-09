# Unexplored Variables Analysis
## AIRS Data Analysis - Variables Not Yet Analyzed

**Date**: November 23, 2025
**Status**: Phases 1-6 Complete
**Purpose**: Identify remaining survey questions and variables for potential future analysis

---

## Summary

Out of the **49 original survey items** (Appendix C) and additional demographic/usage variables, we have analyzed **12 items** in our final construct-balanced scale. This leaves **37 construct items + multiple demographic/usage variables** unexplored.

---

## 1. Unexplored UTAUT2 Items (14 items)

### Performance Expectancy (2 unexplored)
**Used**: PE2 - "Using AI improves the quality of my work or studies"
**Unexplored**:
- PE1 - "AI tools help me accomplish tasks more quickly"
- PE3 - "AI tools enhance my productivity" (if collected)
- PE4 - "AI tools make me more effective on complex tasks" (if collected)

### Effort Expectancy (1 unexplored)
**Used**: EE1 - "Learning to use AI tools is easy for me"
**Unexplored**:
- EE2 - "Interacting with AI tools is clear and understandable"

### Social Influence (1 unexplored)
**Used**: SI1 - "People whose opinions I value encourage me to use AI tools"
**Unexplored**:
- SI2 - "Leaders in my organization or school support the use of AI tools"

### Facilitating Conditions (1 unexplored)
**Used**: FC1 - "I have access to training or tutorials for the AI tools I use"
**Unexplored**:
- FC2 - "The AI tools I use are compatible with other tools or systems I use"

### Hedonic Motivation (1 unexplored)
**Used**: HM2 - "AI tools make my work or studies more interesting"
**Unexplored**:
- HM1 - "Using AI tools is stimulating and engaging"

### Price Value (1 unexplored)
**Used**: PV2 - "Using AI tools is worth the learning curve"
**Unexplored**:
- PV1 - "I get more value from AI tools than the effort they require"

### Habit (1 unexplored)
**Used**: HB2 - "I tend to rely on AI tools by default when I need help with tasks"
**Unexplored**:
- HB1 - "Using AI tools has become a habit for me"

### Voluntariness (1 unexplored)
**Used**: VO1 - "I choose to use AI tools in my work because I find them helpful, not because I am required to"
**Unexplored**:
- VO2 - "I could choose not to use AI tools in my work or studies if I preferred"

---

## 2. Unexplored AI-Specific Items (7 items)

### Trust in AI (1 unexplored)
**Used**: TR2 - "I trust the AI tools that are available to me"
**Unexplored**:
- TR1 - "I trust AI tools to provide reliable information"

### Explainability (1 unexplored)
**Used**: EX1 - "I understand how the AI tools I use generate their outputs"
**Unexplored**:
- EX2 - "I prefer AI tools that explain their recommendations"

### Perceived Ethical Risk (1 unexplored + 1 removed)
**Used**: ER2 - "I am concerned about privacy risks when using AI tools"
**Unexplored**:
- ER1 - "I worry that AI tools could replace jobs in my field"
- **REMOVED**: ER-R (Item 40) - "Organizations manage AI risks responsibly (R)" - Removed during EFA/CFA validation

### AI Anxiety (1 unexplored)
**Used**: AX1 - "I feel uneasy about the increasing use of AI"
**Unexplored**:
- AX2 - "I worry that I may be left behind if I do not keep up with AI"

---

## 3. Unexplored Behavioral Intention Items (3 items)

**Used in structural models as outcome variable, but individual items not separately analyzed**:
- BI1 - "I am ready to use more AI tools in my work or studies"
- BI2 - "I would recommend AI tools to others"
- BI3 - "I see AI as an important part of my future"
- BI4 - "I plan to increase my use of AI tools in the next six months"

**Potential Analysis**: Item-level predictive patterns, recommendation intentions as proxy for satisfaction

---

## 4. Completely Unexplored: AI Tool Usage Patterns (4 variables)

**Scale**: 1=Never, 2=Rarely, 3=Sometimes, 4=Often, 5=Very often (daily)

| Variable | Tool | Status |
|----------|------|--------|
| `Usage_MSCopilot` | Microsoft 365 Copilot / Microsoft Copilot | **PARTIALLY USED** (dichotomized for H4 moderation) |
| `Usage_ChatGPT` | ChatGPT | **UNEXPLORED** |
| `Usage_Gemini` | Google Gemini | **UNEXPLORED** |
| `Usage_Other` | Other AI tools (Claude, Perplexity, Grok) | **UNEXPLORED** |

### Potential Analyses

**A. Tool-Specific Adoption Patterns**
- Which tools are most widely used? (descriptive statistics)
- Do different tools correlate with different adoption profiles?
- Is ChatGPT usage associated with higher/lower anxiety than MS Copilot?

**B. Multi-Tool Usage Profiles**
- Cluster analysis: Single-tool users vs. multi-tool power users
- Does tool diversity predict adoption intention?
- Are there "explorer" vs. "loyalist" segments?

**C. Tool Choice and Context**
- Students vs. Professionals: Different tool preferences?
- Do workplace users prefer MS Copilot (enterprise) while students prefer ChatGPT (open)?
- Industry-specific tool adoption patterns

**D. Tool-Specific Moderation**
- Does explainability matter more for "black box" tools (Gemini) vs. "integrated" tools (MS Copilot)?
- Tool-specific anxiety effects?
- Trust differences by tool provider (Microsoft vs. OpenAI vs. Google)?

---

## 5. Completely Unexplored: Demographics (5 variables)

### Education Level
**Variable**: `Education`
**Values**: 1=High school, 2=Some college, 3=Associate's, 4=Bachelor's, 5=Master's, 6=Doctoral
**Current Use**: Not analyzed as moderator or control variable

**Potential Analyses**:
- Does education level moderate UTAUT2 or AI construct effects?
- Are PhD students/holders more/less anxious about AI?
- Education as proxy for analytical thinking → explainability preferences?

---

### Industry/Field
**Variable**: `Industry`
**Values**: Technology, Education, Healthcare, Finance, Manufacturing, Retail, Government, Nonprofit, Other
**Current Use**: Not analyzed

**Potential Analyses**:
- Industry-specific adoption barriers? (Healthcare = privacy concerns, Finance = trust issues, Tech = habit formation)
- Regulated industries (Healthcare, Finance, Government) vs. non-regulated → ethical risk salience?
- Tech industry workers: Higher trust, lower anxiety baseline?
- Cross-industry differences in explainability requirements (regulated vs. non-regulated)?

**Hypothesis H4 Extension**: Original proposal mentioned "business unit" moderation, but we tested "role" instead. Industry IS the business unit proxy we collected.

---

### Work/Study Experience
**Variable**: `Experience`
**Values**: 1=<1 year, 2=1-3 years, 3=4-6 years, 4=7-10 years, 5=>10 years
**Current Use**: Not analyzed

**Potential Analyses**:
- Does domain expertise moderate AI adoption? (Experts may be more skeptical or more confident)
- Novice professionals vs. experienced professionals → different adoption drivers?
- Interaction between field experience and AI usage frequency?
- Career stage effects: Early career adoption enthusiasm vs. mid-career resistance?

---

### Disability Status
**Variable**: `Disability`
**Values**: 1=Yes, 2=No, 3=Prefer not to answer
**Current Use**: Not analyzed
**Ethics Note**: Sensitive variable requiring careful handling

**Potential Analyses** (if subsample size permits):
- Accessibility needs → different expectations for AI explainability or facilitating conditions?
- Do users with disabilities perceive AI as assistive technology (positive) or exclusionary risk (negative)?
- Ethical risk concerns heightened due to bias/fairness worries?

**Caution**: Likely small N for "Yes" responses. May only support descriptive statistics, not moderation testing.

---

### Open-Text Feedback
**Variable**: `Feedback`
**Type**: Open-text responses
**Current Use**: Not analyzed

**Potential Analyses**:
- Qualitative thematic analysis to identify emergent themes not captured by Likert items
- Sentiment analysis (positive/negative/mixed attitudes)
- Word frequency analysis (what topics dominate unsolicited feedback?)
- Validation check: Do open-text comments align with quantitative scale patterns?
- Discovery of construct gaps: What are people saying that we didn't measure?

---

## 6. Unexplored Items from Extended Survey Pool (16+ items)

If the **full 49-item pool** (Appendix C) was administered but only 28 items analyzed, we have additional unexplored items:

### Additional UTAUT2 Items (if collected)
- **PE3**: "AI tools enhance my productivity"
- **PE4**: "AI tools make me more effective on complex tasks"
- **EE3**: "It takes little effort for me to become skillful at using AI tools"
- **EE4**: "I can quickly learn how to use new AI tools"
- **SI3**: "Using AI tools is viewed as normal in my organization or school"
- **SI4**: "People who influence my work or studies think I should use AI tools"
- **FC3**: "I have the resources I need to use AI tools effectively"
- **FC4**: "A specific person or group is available to assist me when I have difficulties using AI tools"
- **HM3**: "I enjoy using AI tools"
- **HM4**: "I feel satisfied when I successfully use AI tools"
- **PV3**: "The benefits of using AI tools are worth the time it takes to learn them"
- **PV4**: "Investing my time in learning AI tools is worthwhile"
- **HB3**: "I use AI tools without having to think about it"
- **HB4**: "Using AI tools has become natural to me"

### Additional AI-Specific Items (if collected)
- **TR3**: "I believe AI tools can make unbiased decisions"
- **TR4**: "I feel confident relying on AI outputs"
- **EX3**: "The reasoning behind AI recommendations is clear to me"
- **EX4**: "When I understand how an AI tool works, I am more likely to use it"
- **ER3**: "I believe AI tools could introduce bias into important decisions"
- **AX3**: "I sometimes feel uncomfortable relying on AI tools"
- **AX4**: "The speed at which AI is evolving makes me anxious"
- **BI2-alt**: "I am open to learning about new AI technologies"

---

## 7. Potential Future Research Questions

### RQ6: Tool-Specific Adoption Patterns
**Question**: Do usage patterns differ significantly across AI tool types (enterprise-integrated vs. consumer-facing vs. specialized tools)?
**Variables**: Usage_MSCopilot, Usage_ChatGPT, Usage_Gemini, Usage_Other
**Methods**:
- Descriptive statistics (frequency distributions, means, correlations)
- Cluster analysis (user segments: single-tool, multi-tool, power users, non-users)
- ANOVA/regression: Tool usage predicting BI, controlling for UTAUT2/AIRS constructs
**Expected Findings**:
- ChatGPT dominance among students (accessibility, familiarity)
- MS Copilot dominance among professionals (enterprise integration)
- Multi-tool users = higher adoption readiness (exploration mindset)

---

### RQ7: Industry-Specific Adoption Barriers
**Question**: Do industry contexts moderate the relationships between AI constructs and adoption intention?
**Variables**: Industry (9 categories)
**Methods**:
- Multi-group SEM or separate-group structural models (similar to Phase 6 approach)
- Moderation hypotheses:
  - **H6a**: Regulated industries (Healthcare, Finance, Government) show stronger Ethical Risk effects
  - **H6b**: Technology industry workers show weaker AI Anxiety effects
  - **H6c**: Education sector shows stronger Explainability effects (teaching/learning context)
**Expected Findings**:
- Ethical Risk matters MORE in regulated industries (compliance, liability concerns)
- Tech workers have higher baseline trust, lower anxiety (familiarity)
- Education sector prioritizes transparency (pedagogical integrity)

---

### RQ8: Experience and Expertise Effects
**Question**: Does work/study experience moderate the strength of UTAUT2 and AI-specific construct effects?
**Variables**: Experience (5 levels)
**Methods**:
- Separate-group models: Novice (<1 year) vs. Expert (10+ years)
- Interaction terms: Experience × AI Constructs
**Hypotheses**:
- **H7a**: Novice professionals show stronger Social Influence effects (seek peer guidance)
- **H7b**: Experienced professionals show stronger Performance Expectancy effects (outcome-focused)
- **H7c**: Domain expertise moderates Explainability effects (experts demand MORE transparency to evaluate AI quality)
**Theoretical Contribution**: Expertise reversal hypothesis—experts may be MORE skeptical, demanding higher explainability to assess AI competence

---

### RQ9: Accessibility and Inclusive AI Design
**Question**: Do users with disabilities perceive AI adoption factors differently than non-disabled users?
**Variables**: Disability (Yes/No/Prefer not to answer)
**Methods**:
- **IF N permits** (likely N<30 for "Yes"): Descriptive comparisons, exploratory t-tests
- **IF N too small**: Qualitative analysis of open-text feedback from users with disabilities
**Ethical Considerations**:
- Ensure anonymity (N<30 risks deductive disclosure)
- Focus on system design insights, not deficit framing
- Potential finding: Facilitating Conditions and Explainability MORE critical for accessibility needs

---

### RQ10: Emergent Themes from Qualitative Feedback
**Question**: What themes emerge from open-text feedback that extend beyond quantitative constructs?
**Variables**: Feedback (open-text)
**Methods**:
- Thematic analysis (Braun & Clarke, 2006)
- NVivo or manual coding for emergent themes
- Sentiment analysis (positive/negative/ambivalent)
**Expected Themes**:
- **Skepticism about accuracy**: "AI gets things wrong, need to verify"
- **Job displacement fears**: "Will this replace my role?"
- **Excitement about potential**: "AI makes me more productive"
- **Ethical concerns**: "Bias in outputs, privacy risks"
- **Construct validation**: Do unsolicited comments align with Likert scale patterns?

---

## 8. Methodological Considerations

### Sample Size Constraints
**Current N**: 362 (full sample analyzed in Phases 4-6)
**Minimum N for moderation**: ~50-100 per group (Hair et al., 2010)

**Feasibility Check** for unexplored moderators:
| Moderator | Expected Distribution | Feasibility |
|-----------|----------------------|-------------|
| **Education** | Likely skewed toward Bachelor's/Master's | ✅ High (sufficient variance) |
| **Industry** | 9 categories, uneven distribution | ⚠️ Medium (may need to collapse categories) |
| **Experience** | 5 levels, likely bell curve | ✅ High |
| **Disability** | Likely <10% "Yes" | ❌ Low (N<40 expected, descriptive only) |
| **Tool Usage** | 4 tools, varying adoption | ✅ High (can create usage profiles) |

---

### Prioritization Framework

**Phase 7 Candidates** (High Impact, Feasible with N=362):
1. **Tool-Specific Usage Patterns** (RQ6) - Descriptive + exploratory, no moderation needed
2. **Industry Moderation** (RQ7) - Extends H4, high theoretical value, sufficient N if categories collapsed
3. **Qualitative Feedback Analysis** (RQ10) - Validation check, triangulation, emergent themes

**Future Research** (Requires Larger Sample or Targeted Collection):
4. **Experience Moderation** (RQ8) - Possible with N=362 if collapsed into 3 groups (Novice/Mid/Expert)
5. **Disability Accessibility** (RQ9) - Likely underpowered, qualitative focus recommended

---

## 9. Implications for Dissertation

### Current Scope
- **Phases 1-6 Complete**: EFA, CFA, Invariance, Structural Models, Mediation, Moderation (role, usage, adoption)
- **12-Item Diagnostic Scale**: Validated, publication-ready
- **Theoretical Contributions**: 5 major findings (dual-pathway suppression, "Who vs What" pattern, exposure effect, explainability paradox, ethical disconnect robustness)

### Unexplored Variables: Two Options

**Option A: Incorporate into Dissertation (Phase 7 Extension)**
- Add **RQ6** (Tool Usage Patterns) as exploratory descriptive analysis
- Add **RQ10** (Qualitative Feedback) as triangulation/validation chapter section
- **Pros**: Richer findings, demonstrates comprehensive data utilization, qualitative + quantitative integration
- **Cons**: Extends timeline 2-3 weeks, requires additional literature review, potential scope creep

**Option B: Reserve for Post-Dissertation Publications**
- Complete dissertation with Phases 1-6 (sufficient for degree requirements)
- Publish unexplored analyses separately:
  - **Paper 1**: Tool-specific adoption patterns across AI platforms (RQ6)
  - **Paper 2**: Industry moderation effects in enterprise AI adoption (RQ7)
  - **Paper 3**: Qualitative insights from open-text feedback (RQ10)
- **Pros**: Focused dissertation, additional publication pipeline, extended research program
- **Cons**: Delays dissemination of findings, data may age

---

## 10. Recommendations

### Immediate Actions (Week 28-29)
1. **Assess Dissertation Scope**: Discuss with committee whether unexplored variables should be incorporated or reserved for future work
2. **Descriptive Statistics**: Run basic frequencies/distributions for all unexplored variables to inform future research design
3. **Qualitative Scan**: Read open-text feedback to identify emergent themes for potential Chapter 5 discussion

### Short-Term (Weeks 30-32)
4. **IF incorporating**: Add exploratory RQ6 (tool usage) and RQ10 (qualitative) to Chapter 4 Results
5. **IF reserving**: Document unexplored variables in Chapter 5 Limitations and Future Research sections

### Long-Term (Post-Dissertation)
6. **Publication Pipeline**: Prioritize RQ6 (tool usage) and RQ7 (industry moderation) for journal submissions
7. **Data Archive**: Preserve complete dataset with documentation for longitudinal comparison (re-survey in 2-3 years to track AI adoption evolution)

---

## References

**Survey Documentation**:
- AIRS Survey Instrument v5.md - Original 49-item pool with literature mapping (Appendix C)
- DATA_DICTIONARY.md - Complete variable documentation

**Methodological**:
- Hair, J. F., et al. (2010). *Multivariate data analysis* (7th ed.). Pearson.
- Braun, V., & Clarke, V. (2006). Using thematic analysis in psychology. *Qualitative Research in Psychology, 3*(2), 77-101.

---

**Document Status**: Draft for discussion with committee
**Next Update**: After Phase 7 scope decision
**Contact**: Fabio Correa, fcorrea@student.touro.edu
