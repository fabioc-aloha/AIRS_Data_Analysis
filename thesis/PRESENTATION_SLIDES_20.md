# Artificial Intelligence Readiness Scale (AIRS): Dissertation Defense

**Artificial Intelligence Readiness Scale: Extending UTAUT2 for Enterprise AI Adoption**

Fabio Correa
Doctoral Candidate, Doctor of Business Administration
Touro University Worldwide
December 2025

---

## Slide 1: Title Slide

**Artificial Intelligence Readiness Scale**
*Extending UTAUT2 for Enterprise AI Adoption*

Fabio Correa
Doctoral Candidate, Doctor of Business Administration
Touro University Worldwide

Dissertation Committee:
- Dr. Karina Kasztelnik (Chair)
- Dr. Jerome Jones
- Dr. Donna Day

December 2025

---

## Slide 2: The AI Adoption Paradox

**Organizations are adopting AI at unprecedented rates—but struggling to capture value.**

| Metric | Value | Source |
|--------|-------|--------|
| Enterprise AI Adoption (2024) | 72% | McKinsey |
| Enterprise AI Adoption (2025) | 88% | McKinsey |
| Companies achieving measurable ROI | 5% | BCG |
| GenAI pilots that fail to scale | 90-95% | MIT Media Lab |

**Research Questions:**
1. Can we develop a psychometrically valid AI Readiness Scale extending UTAUT2?
2. What factors most strongly predict AI adoption intention?
3. Do traditional UTAUT predictors behave differently for AI?
4. How do professional experience and population type moderate adoption?

---

## Slide 3: Theoretical Foundation - UTAUT2

**Building on 25+ years of technology acceptance research.**

| Construct | Definition | Meta-Analytic Effect (rc) |
|-----------|------------|--------------------------|
| Performance Expectancy (PE) | Belief technology improves performance | .64 (strongest) |
| Effort Expectancy (EE) | Perceived ease of use | .51 |
| Social Influence (SI) | Important others' opinions | .43 |
| Facilitating Conditions (FC) | Organizational/technical support | .39 |
| Hedonic Motivation (HM) | Enjoyment from use | .53 |
| Price Value (PV) | Cost-benefit assessment | .52 |
| Habit (HB) | Automaticity from repeated use | .66 |

*Source: Blut et al. (2022) meta-analysis, Table 1: 737,112 users, 1,935 samples. rc = corrected correlation.*

**Proposed Extension**: AI Trust (TR) as a new construct capturing trust in AI systems

---

## Slide 4: Research Design

**A rigorous 10-phase psychometric validation approach.**

| Phase | Analysis | Sample |
|-------|----------|--------|
| 1 | Sample Split | N=523 -> 261/262 |
| 2 | Exploratory Factor Analysis (EFA) | Development (n=261) |
| 3 | Confirmatory Factor Analysis (CFA) | Holdout (n=262) |
| 4 | Measurement Invariance | Student vs Professional |
| 5 | Structural Equation Modeling (SEM) | Full sample |
| 6-7 | Moderation Analysis | Experience, Population |
| 8-9 | Behavioral & Qualitative Validation | Tool usage, Feedback |
| 10 | Final Synthesis | Integration |

**Sample**: 523 U.S. adults spanning the career development spectrum

| Population | n | % |
|------------|---|---|
| Students | 216 | 41.3% |
| Professionals | 184 | 35.2% |
| Leaders | 123 | 23.5% |

---

## Slide 5: Instrument Validation Results

**Excellent psychometric properties across all indices.**

**Model Fit Indices:**

| Index | Value | Threshold | Result |
|-------|-------|-----------|--------|
| CFI | .975 | ≥ .95 | [OK] Excellent |
| TLI | .960 | ≥ .95 | [OK] Excellent |
| RMSEA | .065 | ≤ .08 | [OK] Good |
| SRMR | .046 | ≤ .08 | [OK] Excellent |
| χ²/df | 2.10 | < 3.0 | [OK] Excellent |

**Reliability (Cronbach's α):**

| Construct | α | Construct | α |
|-----------|-----|-----------|-----|
| Performance Expectancy | .803 | Hedonic Motivation | .864 |
| Effort Expectancy | .859 | Price Value | .883 |
| Social Influence | .752 | Habit | .909 |
| Facilitating Conditions | .743 | AI Trust | .891 |

---

## Slide 6: Constructs Excluded

**Four AI-specific constructs failed to demonstrate adequate reliability.**

| Construct | Cronbach's α | Reason for Exclusion |
|-----------|--------------|---------------------|
| Voluntariness (VO) | .406 | Items measured choice vs. freedom—distinct dimensions |
| Explainability (EX) | .582 | Items measured understanding vs. preference—distinct facets |
| Ethical Risk (ER) | .546 | Items measured job displacement vs. privacy—distinct risk types |
| AI Anxiety (AX) | .301 | Items measured avoidance vs. approach anxiety—distinct motivations |

**Implication**: These constructs require 3-4 items per dimension for future operationalization. The theoretical importance remains; only the measurement proved insufficient.

---

## Slide 7: KEY FINDING - Hypothesis Testing Results

**Price Value, not Performance Expectancy, drives AI adoption.**

| Hypothesis | Path | β | p | Result |
|------------|------|-----|------|--------|
| H1f | PV -> BI | **.505** | <.001 | [OK] **STRONGEST** |
| H1e | HM -> BI | **.217** | .014 | [OK] Supported |
| H1c | SI -> BI | **.136** | .024 | [OK] Supported |
| H2 | TR -> BI | .106 | .064 | [!] Marginal |
| H1d | FC -> BI | .059 | .338 | [X] Not Supported |
| H1g | HB -> BI | .023 | .631 | [X] Not Supported |
| H1b | EE -> BI | -.008 | .875 | [X] Not Supported |
| H1a | PE -> BI | -.028 | .791 | [X] Not Supported |

**Model R² = .852** (85.2% of variance explained, 8-factor diagnostic model)

---

## Slide 8: Traditional Predictors Don't Work for AI

**Performance Expectancy and Effort Expectancy—typically the strongest predictors—are non-significant for AI.**

| Construct | Meta-Analytic rc (Traditional) | AIRS β (AI) | Change |
|-----------|------------------------------|-------------|--------|
| Performance Expectancy | .64 | -.028 | [DOWN] Collapsed |
| Effort Expectancy | .51 | -.008 | [DOWN] Collapsed |
| Price Value | .52 | **.505** | [UP] Dominant |
| Hedonic Motivation | .53 | .217 | Similar |
| Social Influence | .43 | .136 | [DOWN] Reduced |

**Interpretation**: For AI, utility is assumed or uncertain; users evaluate through a value lens ("Is it worth it?") rather than a utility lens ("Will it help me?").

---

## Slide 9: What Drives AI Adoption?

**Three factors significantly predict AI adoption intention.**

1. **Price Value (β = .505, p < .001)**: "Is the value worth the cost/effort?"
   - The cognitive trade-off between benefits received and resources invested
   - Includes time, learning curve, workflow disruption—not just money

2. **Hedonic Motivation (β = .217, p = .014)**: "Is it engaging and enjoyable?"
   - Intrinsic satisfaction from using AI tools
   - Curiosity and stimulation drive continued engagement

3. **Social Influence (β = .136, p = .024)**: "Do important others support AI use?"
   - Peer influence and organizational norms
   - AI champions and visible leadership matter

**Near-Significant:**
- AI Trust (β = .106, p = .064): Approaching significance—larger samples may confirm

---

## Slide 10: Moderation Effects

**Experience and population moderate AI adoption pathways.**

**Experience Moderation:**

| Interaction | β | p | Result |
|-------------|------|------|--------|
| HM × Experience | **.136** | **.009** | [OK] Significant |
| PE × Experience | .112 | .055 | [!] Marginal |

**Population Moderation (Student vs Professional):**

| Path | Student β | Professional β | Δβ | p |
|------|-----------|----------------|-----|------|
| HM -> BI | **+0.449** | -0.301 | -0.750 | **.041** |
| PV -> BI | +0.638 | +0.808 | +0.170 | ns |

**Key Insight**:
- **Students**: "Make it fun and I'll use it"
- **Professionals**: "Show me the value and I'll use it"

---

## Slide 11: Four User Segments Identified

**Cluster analysis reveals distinct adoption readiness profiles.**

| Segment | n | % | Profile | Organizational Role |
|---------|---|---|---------|---------------------|
| AI Enthusiasts | 84 | 16% | High trust, high intention, low anxiety | Champions |
| Cautious Adopters | 157 | 30% | High adoption but also high anxiety | Need reassurance |
| Moderate Users | 191 | 37% | Neutral stance, average engagement | Can be influenced |
| Anxious Avoiders | 91 | 17% | Low adoption, high anxiety | Need intervention |

**Cluster Centroids (Standardized):**

| Segment | PE (z) | Trust (z) | Anxiety (z) | Intention (z) |
|---------|--------|-----------|-------------|---------------|
| AI Enthusiasts | +1.42 | +1.37 | -0.86 | +1.32 |
| Cautious Adopters | +1.16 | +0.86 | +0.84 | +0.88 |
| Moderate Users | +0.26 | +0.01 | +0.42 | -0.07 |
| Anxious Avoiders | -1.16 | -1.49 | +0.76 | -1.53 |

---

## Slide 12: Behavioral Validation

**Intentions strongly predict actual AI tool usage.**

| Metric | Value |
|--------|-------|
| BI-Usage Correlation | ρ = .69, p < .001 |
| Interpretation | Strong positive relationship |

**Tool Usage by Role (Effect Sizes):**

| Comparison | Cohen's d | Interpretation |
|------------|-----------|----------------|
| Leaders vs. Others | 0.74-1.14 | Large to Very Large |

**Key Insight**: Organizational leaders demonstrate substantially higher AI tool usage, suggesting leadership engagement may be critical for organizational AI adoption.

---

## Slide 13: Theoretical Contributions

**Four primary contributions to technology acceptance theory.**

**Contribution 1: UTAUT2 Extension for AI**
- Demonstrated that traditional frameworks require modification for AI contexts
- AI Trust approaches significance, warranting further investigation

**Contribution 2: Price Value Dominance**
- First empirical evidence that PV > PE for AI adoption
- Challenges 25+ years of UTAUT findings where PE consistently dominates

**Contribution 3: Career Development Integration**
- Experience moderates HM effect (p = .009)
- Connects technology acceptance to vocational psychology

**Contribution 4: User Typology Framework**
- Four-segment model for adoption heterogeneity
- Foundation for future intervention research

---

## Slide 14: Practical Implications

**Evidence-informed recommendations for organizations.**

**For AI Implementation:**

| Finding | Implication | Strategy |
|---------|-------------|----------|
| PV dominance (β=.505) | Lead with value, not features | Clear ROI demonstrations |
| HM significance (β=.217) | Design for engagement | Gamification, curiosity |
| SI significance (β=.136) | Leverage social proof | Champions, peer communities |
| PE non-significance | Don't assume utility sells | Focus on value proposition |

**For Different Populations:**

| Population | Priority | Approach |
|------------|----------|----------|
| Students | Hedonic Motivation | Make it engaging and fun |
| Professionals | Price Value | Demonstrate clear ROI |
| Leaders | Already high adopters | Leverage as champions |

---

## Slide 15: Study Limitations

**Important boundaries for interpretation.**

1. **Cross-Sectional Design**
   - Cannot establish causality; longitudinal research needed
   - Temporal dynamics of adoption not captured

2. **Self-Report Measures**
   - Common method variance possible despite procedural controls
   - Behavioral validation helps mitigate but doesn't eliminate

3. **Sample Characteristics**
   - U.S. adults only; cultural generalization requires replication
   - Panel sampling via Centiment (topic-blinded recruitment mitigates self-selection)

4. **Excluded Constructs**
   - Voluntariness, Explainability, Ethical Risk, AI Anxiety require revised operationalization
   - Two-item scales insufficient for multidimensional constructs

---

## Slide 16: Future Research Directions

**Building on this foundation.**

1. **Longitudinal Studies**
   - Track adoption trajectories over time
   - Examine how predictors change with experience

2. **Construct Development**
   - Multi-item scales for excluded constructs (3-4 items per dimension)
   - Validate AI Anxiety, Ethical Risk with expanded operationalization

3. **Population Replication**
   - Cross-cultural validation
   - Industry-specific applications (healthcare, finance, education)

4. **Intervention Research**
   - Test segment-specific interventions
   - Experimental validation of practical recommendations

---

## Slide 17: Conclusion

**Key Takeaways**

1. **The AIRS instrument is psychometrically sound** (CFI = .975, α = .74-.91)

2. **Price Value dominates AI adoption** (β = .505), not Performance Expectancy

3. **Traditional UTAUT predictors (PE, EE) collapse** for AI technology

4. **Enjoyment matters** (HM β = .217), especially for students

5. **Four distinct user segments** exist with different intervention needs

6. **Experience moderates adoption pathways** (HM×Exp p = .009)

**Bottom Line**: AI adoption requires a fundamentally different approach than traditional technology—lead with value and engagement, not utility.

---

## Slide 18: Questions & Discussion

**Thank you for your attention.**

I welcome your questions and feedback.

**Contact Information:**
- Email: fabio@correax.com

**Resources:**
- GitHub Repository: https://github.com/fabioc-aloha/AIRS_Data_Analysis
- Full dissertation available upon request

---

## Slide 19: Appendix A - Ethics & Data Retention

**IRB Approval and Data Protection**

| Item | Detail |
|------|--------|
| IRB Protocol Number | T00571337 |
| Application Date | October 29, 2025 |
| Status | Approved - Exempt (45 CFR 46.104(d)(2)) |
| Data Retention | Until January 2028 (per 45 CFR 46) |
| Repository | GitHub (public, de-identified) |

---

## Slide 20: Appendix B - Complete Hypothesis Summary

| Hypothesis | Path/Effect | Result |
|------------|-------------|--------|
| H1a | PE -> BI | [X] Not Supported (β = -.028, p = .791) |
| H1b | EE -> BI | [X] Not Supported (β = -.008, p = .875) |
| H1c | SI -> BI | [OK] Supported (β = .136, p = .024) |
| H1d | FC -> BI | [X] Not Supported (β = .059, p = .338) |
| H1e | HM -> BI | [OK] Supported (β = .217, p = .014) |
| H1f | PV -> BI | [OK] Supported (β = .505, p < .001) |
| H1g | HB -> BI | [X] Not Supported (β = .023, p = .631) |
| H2 | TR -> BI | [!] Marginal (β = .106, p = .064) |
| H3 | Experience Moderation | [!] Partial (HM×Exp p = .009) |
| H4 | Population Moderation | [!] Partial (HM only, p = .041) |
| H5 | BI -> Tool Usage | [OK] Supported (ρ = .69) |

**Summary: 3/7 UTAUT paths supported, Trust marginal, Behavioral validation confirmed**

---

*End of Presentation*
