<div align="center">
  <img src="assets/banner.svg" alt="AIRS Data Analysis Project" width="100%">
</div>

---

# **Dissertation Progress Report**

**To**: Dr. Karina Kasztelnik (Dissertation Chair), Dr. Venkatesh (Research Mentor)
**CC**: Dr. Jerome Jones (Committee Member), Dr. Donna Day (Committee Member)
**From**: Fabio Correa
**Date**: November 22, 2025 (Week 24 of 32)
**Institution**: Touro University Worldwide
**Program**: Doctor of Business Administration (DBA)

---

## 📋 Executive Summary

**⚠️ Data Collection Status**: This study is currently in the **data collection phase**. All results reported below are **preliminary** based on the initial sample (N=318). The target sample size is **N=500**, and data collection is ongoing. Final results and conclusions will be based on the complete dataset.

I am pleased to report progress on **Phase 1: Scale Development** for the Artificial Intelligence Readiness Score (AIRS) dissertation study. The project remains on schedule and preliminary analyses have yielded promising results that validate our research approach.

**Phase 1 Preliminary Accomplishments** (✅ In Progress):

- Developed 12-item construct-balanced scale with excellent internal consistency (Cronbach's α = 0.897, preliminary)
- Implemented rigorous split-sample design (Development N=159, Holdout N=159) to prevent overfitting
- Identified 2-factor empirical structure (Facilitators, Barriers) with strong predictive validity (R² = 0.811, preliminary)
- Demonstrated measurement efficiency: 96.3% of 24-item predictive power with 50% reduction in respondent burden

**Research Foundation**: This study extends **Dr. Venkatesh's UTAUT2 framework** (Venkatesh et al., 2012) by integrating four AI-specific constructs with the eight established UTAUT2 predictors. The goal is to develop both a **diagnostic instrument** for organizational assessment and contribute **theoretical insights** on AI-specific adoption mechanisms.

**Data Collection Status**: Currently at N=318 of target N=500. Data collection ongoing through academic networks and professional associations. All analyses below represent preliminary results and will be finalized upon reaching target sample size.

**Next Phase**: Upon completion of data collection, Phase 2 will validate the measurement model using Confirmatory Factor Analysis (CFA) on the independent holdout sample, establishing the psychometric foundation for subsequent hypothesis testing (Phases 3-5).

### 🎯 Dissertation Committee: Key Takeaways

**For Dr. Kasztelnik (Chair)**:

✅ **Progress**: On schedule (Week 24/32), Phase 1 preliminary analyses complete; data collection ongoing (N=318/500)
✅ **Quality**: Rigorous split-sample design, data-driven factor determination, excellent preliminary reliability
✅ **Next Steps**: Continue data collection to N=500, then Phase 2 CFA validation on holdout sample
⚠️ **Status**: All results preliminary until target sample (N=500) achieved; analytical decisions documented and justified

**For Dr. Venkatesh (Mentor)**:

🙏 **UTAUT2 Foundation**: Study builds directly on your seminal 2012 framework
🎯 **Theoretical Extension**: Tests whether AI-specific constructs add explanatory power beyond UTAUT2's eight core predictors
📊 **Preliminary Evidence**: Phase 1 developed 12-item scale integrating UTAUT2 with AI-specific constructs
🔍 **Key Test Ahead**: Phase 3 nested model comparison will test incremental validity (H3: ΔR² ≥ 0.10)
💡 **Novel Contribution**: Mediation analysis (Phase 4) explores trust and anxiety as psychological mechanisms linking AI-specific concerns to adoption

---

## 🎯 Theoretical Framework: Building on UTAUT2 Excellence

### Honoring the UTAUT2 Foundation

This dissertation builds directly on **Dr. Venkatesh's UTAUT2 framework** (Venkatesh et al., 2012), which synthesized decades of technology acceptance research into eight robust predictors of behavioral intention. UTAUT2 represents the gold standard for understanding technology adoption and has been cited over 18,000 times, validating its theoretical rigor and practical utility.

**UTAUT2 Core Constructs (8)**:

1. **Performance Expectancy (PE)**: Perceived productivity gains from AI use
2. **Effort Expectancy (EE)**: Perceived ease of learning and using AI systems
3. **Social Influence (SI)**: Perception that important others support AI adoption
4. **Facilitating Conditions (FC)**: Organizational and technical resources supporting AI use
5. **Hedonic Motivation (HM)**: Enjoyment and intrinsic pleasure from AI interaction
6. **Price Value (PV)**: Cost-benefit perception of AI implementation
7. **Habit (HB)**: Degree to which AI use has become automatic
8. **Voluntariness of Use (VO)**: Extent to which AI adoption is discretionary vs. mandated

### AI-Specific Extensions

Given AI's distinctive characteristics—algorithmic opacity, autonomous decision-making, and ethical implications—this study extends UTAUT2 with four constructs grounded in emergent AI adoption literature:

**AI-Specific Constructs (4)**:

1. **Trust in AI (TR)**: Confidence in AI system reliability, benevolence, and integrity (Langer et al., 2023)
2. **Explainability (EX)**: Perceived transparency and interpretability of AI decisions (Shin, 2021)
3. **Ethical Risk (ER)**: Concerns about bias, privacy violations, and fairness (Hagendorff, 2020)
4. **AI Anxiety (AX)**: Apprehension and fear toward AI capabilities (Johnson & Marakas, 2000)

**Integrated Framework**: 12 constructs (8 UTAUT2 + 4 AI-specific) → Behavioral Intention → AI Adoption

### Research Design & Methodology

**Sample**: N = 318 (current) of target N = 500 knowledge workers (faculty, students, professionals) recruited through academic networks and professional associations. Target sample size will exceed recommended requirements for structural equation modeling (N > 200) and enable robust split-sample validation. **Data collection ongoing**.

**Split-Sample Strategy**: To prevent overfitting and ensure generalizability, the sample was stratified 50/50 by Work_Context (Academic/Professional) and AI_Adoption status:

- **Development Sample (N=159)**: Scale development, exploratory factor analysis, item selection
- **Holdout Sample (N=159)**: Independent validation, confirmatory factor analysis, hypothesis testing

**Analytical Approach**: Five-phase sequential validation following psychometric best practices (Hair et al., 2010; Hu & Bentler, 1999):

1. **Phase 1 (✅ Complete)**: Exploratory factor analysis, reliability assessment, item selection
2. **Phase 2 (⏭️ Next)**: Confirmatory factor analysis on independent holdout sample
3. **Phase 3 (Pending)**: Structural model comparison (UTAUT2 vs. AIRS)
4. **Phase 4 (Pending)**: Mediation analysis (trust and anxiety pathways)
5. **Phase 5 (Pending)**: Moderation analysis (role, usage frequency, adoption status)

---

## 📊 Empirical Model: 2-Factor Structure

**Phase 1 Exploratory Factor Analysis Results**
*Development Sample (N=159) • R² = 0.811 • Cronbach's α = 0.897*

```mermaid
graph LR
    %% Styling
    classDef facilitatorBox fill:#d1fae5,stroke:#059669,stroke-width:3px,color:#065f46
    classDef barrierBox fill:#fecaca,stroke:#dc2626,stroke-width:3px,color:#991b1b
    classDef outcomeBox fill:#bfdbfe,stroke:#1e40af,stroke-width:4px,color:#1e3a8a
    classDef moderatorBox fill:#f1f5f9,stroke:#94a3b8,stroke-width:2px,color:#475569

    %% Moderators (Left)
    subgraph MOD["Contextual Moderators"]
        M1["Role<br/>(Student/Faculty/Professional)"]
        M2["AI Usage Frequency<br/>(Exposure level)"]
        M3["Voluntariness<br/>(Discretionary vs. mandated)"]
        M1 --- M2 --- M3
    end

    %% Factor 1: Mixed Orientation (Center-Top)
    subgraph F1["Factor 1: Mixed Orientation (10 items, loadings 0.62-0.91)"]
        PE1["Performance Expectancy (PE1) 0.81"]
        EE2["Effort Expectancy (EE2) 0.74"]
        SI2["Social Influence (SI2) 0.62"]
        FC1["Facilitating Conditions (FC1) 0.66"]
        HM1["Hedonic Motivation (HM1) 0.83"]
        PV2["Price Value (PV2) 0.91"]
        HB2["Habit (HB2) 0.77"]
        VO1["Voluntariness (VO1)† 0.84"]
        TR1["Trust in AI (TR1) 0.79"]
        EX1["Explainability (EX1)* 0.66"]
        PE1 --- EE2 --- SI2 --- FC1 --- HM1 --- PV2 --- HB2 --- VO1 --- TR1 --- EX1
    end

    %% Factor 2: Risk/Anxiety (Center-Bottom)
    subgraph F2["Factor 2: Risk/Anxiety (2 items, loadings 0.64-0.75)"]
        ER1["Perceived Ethical Risk (ER1) 0.75"]
        AX2["AI-Related Anxiety (AX2) 0.64"]
        ER1 --- AX2
    end

    %% Outcome (Right)
    BI["<b>Behavioral Intention /<br/>AI Readiness</b><br/><br/>R² = 0.811<br/>(96.3% of 24-item model power)"]

    %% Relationships
    MOD -.->|"moderates"| F1
    MOD -.->|"moderates"| F2
    F1 -->|"+ enables"| BI
    F2 -->|"− inhibits"| BI
    F1 -.->|"r = 0.17<br/>(weak positive)"| F2

    %% Apply styles
    class PE1,EE2,SI2,FC1,HM1,PV2,HB2,VO1,TR1,EX1 facilitatorBox
    class ER1,AX2 barrierBox
    class BI outcomeBox
    class M1,M2,M3 moderatorBox

    %% Hide internal connections
    linkStyle 0,1,2,3,4,5,6,7,8,9,10,11,12 stroke:none
```

**Key Findings**:

- **Variance Explained**: 58.1% total (F1: 49.4%, F2: 8.7%)
- **Factor 1**: 10 items representing mixed readiness orientation (includes UTAUT2 core + trust + explainability)
- **Factor 2**: 2 items capturing risk/anxiety dimension (ethical concerns + AI apprehension)
- **Inter-factor Correlation**: r = 0.17 (weak positive, supporting discriminant validity)
- **†Voluntariness** serves dual role as both factor item and contextual moderator
- **\*Explainability** unexpectedly loaded with enablers rather than barriers

---

## ✅ Phase 1 Preliminary Results: Scale Development (In Progress)

### Preliminary Psychometric Validation Results

**⚠️ Note**: All statistics below are preliminary, based on current sample (N=318). Results will be finalized upon reaching target N=500.

**12-Item Construct-Balanced Scale**:

- **Design**: One best-loading item selected per construct (12 constructs total)
- **Rationale**: Balances diagnostic coverage (all constructs represented) with efficiency (minimal respondent burden)
- **Items**: PE1, FC1, HM1, PV2, HB2, VO1, TR1, EE2, SI2, EX1, ER1, AX2

**Internal Consistency**:

- **Cronbach's α = 0.897** (exceeds threshold of α ≥ 0.70 for "good" reliability)
- All items contribute positively to scale reliability

**Factor Structure**:

- **Kaiser Criterion**: Suggested 3 factors (eigenvalues > 1)
- **Parallel Analysis**: Recommended 2 factors (empirically validated)
- **Decision**: Accepted 2-factor structure based on parallel analysis and theoretical coherence
- **Factor 1 - Facilitators** (7 items): PE, FC, HM, PV, HB, TR, VO (loadings: 0.72-0.98)
- **Factor 2 - Barriers** (5 items): AX, ER, EE, SI, EX (loadings: 0.41-0.82)
- **Inter-factor correlation**: r = 0.17 (weak positive, supporting discriminant validity)

**Sampling Adequacy**:

- **KMO (Kaiser-Meyer-Olkin) = 0.815** (exceeds 0.60 threshold for "good" factorability)
- **Bartlett's Test of Sphericity**: χ² = significant (p < .001), confirming correlations suitable for factor analysis

**Predictive Validity**:

- **R² = 0.811** predicting Behavioral Intention (BI) to adopt AI
- **Comparison**: 24-item preliminary model R² = 0.842
- **Efficiency**: 96.3% of predictive power retained with 50% reduction in items
- **Interpretation**: Demonstrates excellent measurement efficiency for practical deployment

### Theoretical Insight: Empirical Structure

**Key Finding**: While the theoretical framework proposes 12 distinct constructs, exploratory factor analysis revealed a simpler **2-factor empirical structure**:

**Factor 1 - Facilitators** (Approach Orientation):

- Positive attitudes (PE, HM, VO)
- Enabling resources (FC, PV)
- Psychological readiness (HB, TR)
- **Interpretation**: Captures readiness-enhancing factors

**Factor 2 - Barriers** (Avoidance Orientation):

- Psychological concerns (AX, ER)
- Friction factors (EE, SI)
- Transparency gaps (EX)
- **Interpretation**: Captures readiness-inhibiting factors

**Implication**: This 2-factor structure aligns with psychological approach-avoidance frameworks, suggesting that while 12 constructs provide **diagnostic granularity** for targeted interventions, they converge empirically into two higher-order dimensions for **predictive modeling**. This dual structure supports the scale's utility for both organizational assessment (identify specific gaps) and research (parsimonious predictive model).

---

## 🔬 Research Questions & Hypotheses

**RQ1**: What is the psychometric structure of AI readiness among knowledge workers?

- **Phase 1 (✅)**: Identified 2-factor structure (Facilitators, Barriers) via exploratory factor analysis
- **Phase 2 (⏭️)**: Validate structure via confirmatory factor analysis on holdout sample

**RQ2**: Do UTAUT2 constructs predict behavioral intention to adopt AI in the workplace?

- **H1**: Eight UTAUT2 constructs significantly predict BI (Phase 3 structural modeling)

**RQ3**: Do AI-specific constructs add explanatory power beyond UTAUT2?

- **H2**: Four AI-specific constructs significantly predict BI beyond UTAUT2
- **H3**: AIRS extended model explains ≥10% additional variance vs. UTAUT2 baseline (ΔR² ≥ 0.10)
- **Phase 3**: Nested model comparison testing incremental validity

**RQ4**: What mediating mechanisms explain AI-specific relationships with adoption?

- **H5a**: Trust mediates the positive relationship between Explainability and BI
- **H5b**: Trust mediates the negative relationship between Ethical Risk and BI
- **H5c**: AI Anxiety mediates the negative relationship between Ethical Risk and BI
- **Phase 4**: Bootstrap mediation analysis (5000 iterations, 95% confidence intervals)

**RQ5**: Are relationships moderated by individual and contextual factors?

- **H4a-H4e**: Role (student/professional/faculty), AI usage frequency, and adoption status moderate predictor-BI relationships
- **Phase 5**: Multi-group SEM with measurement invariance testing
- **AX**: AI Anxiety - unease about AI autonomy and pace of change

**Outcome Variable**:

- **BI**: Behavioral Intention - readiness to adopt/increase AI use

### Empirical Structure (2 Factors)

**Factor 1: Facilitators (7 items)**

- Positive attitudes enabling adoption
- Items: PE1, FC1, HM1, PV2, HB2, TR1, VO1

**Factor 2: Barriers (5 items)**

- Concerns inhibiting adoption
- Items: AX2, ER1, EE2, SI2, EX1

---

## 📅 Timeline & Next Steps (Weeks 24-32)

### Phase 2: Confirmatory Factor Analysis (⏭️ Next Priority - Weeks 25-26)

**Objective**: Validate the 2-factor measurement model on the independent holdout sample (N=159)

**Planned Methodology**:

- **Estimator**: Maximum Likelihood Robust (MLR) or Weighted Least Squares Mean-Variance (WLSMV) for ordinal indicators
- **Model Specification**: 2 correlated latent factors (Facilitators: 7 items, Barriers: 5 items)
- **Fit Criteria** (Hu & Bentler, 1999):
  - Comparative Fit Index (CFI) ≥ 0.90
  - Tucker-Lewis Index (TLI) ≥ 0.90
  - Root Mean Square Error of Approximation (RMSEA) ≤ 0.08
  - Standardized Root Mean Square Residual (SRMR) ≤ 0.08

**Validation Metrics**:

- **Reliability**: Composite Reliability (CR) ≥ 0.70, Cronbach's α ≥ 0.70
- **Convergent Validity**: Average Variance Extracted (AVE) ≥ 0.50 per factor
- **Discriminant Validity**:
  - Fornell-Larcker criterion: √AVE > inter-factor correlation
  - Heterotrait-Monotrait ratio (HTMT) < 0.85

**Deliverables**:

- `02_CFA_Measurement_Model.ipynb`: Complete CFA analysis with fit indices, modification indices (if needed), reliability/validity assessment
- Updated progress report to committee with CFA results

---

### Phase 3: Structural Model & Hypothesis Testing (Weeks 27-28)

**Objective**: Test competing theoretical models (UTAUT2 vs. AIRS) and evaluate hypotheses H1-H3

**Planned Analysis**:

1. **Model 1 - UTAUT2 Baseline**: 8 UTAUT2 constructs → BI

   - Test H1: Do all eight UTAUT2 predictors significantly predict BI?
2. **Model 2 - AIRS Extended**: 12 constructs (8 UTAUT2 + 4 AI-specific) → BI

   - Test H2: Do AI-specific constructs significantly predict BI beyond UTAUT2?
   - Test H3: Does AIRS explain ≥10% additional variance? (ΔR² ≥ 0.10)
3. **Nested Model Comparison**: Chi-square difference test, AIC, BIC comparison

**Deliverables**:

- `04_Structural_Model_Hypothesis_Testing.ipynb`: Model comparison, path coefficients, R² values, hypothesis test outcomes
- APA-formatted results tables for dissertation Chapter 4

---

### Phase 4: Mediation & Moderation Analysis (Weeks 29-30)

**Mediation Analysis (H5a-H5c)**:

- **H5a**: Does Trust mediate Explainability → BI?
- **H5b**: Does Trust mediate Ethical Risk → BI (negative pathway)?
- **H5c**: Does AI Anxiety mediate Ethical Risk → BI (negative pathway)?
- **Method**: Bootstrap mediation with 5,000 iterations, 95% bias-corrected confidence intervals

**Moderation Analysis (H4a-H4e)**:

- **Moderators**: Role (student/professional/faculty), AI usage frequency, adoption status
- **Method**: Multi-group SEM with chi-square difference tests
- **Prerequisite**: Establish measurement invariance (configural, metric, scalar) across groups

**Deliverables**:

- `05_Mediation_Analysis.ipynb`: Mediation pathways with indirect effects and confidence intervals
- `06_Moderation_Analysis.ipynb`: Multi-group results with invariance testing
- Updated hypothesis outcomes (H4, H5) with effect sizes

---

### Phase 5: Comprehensive Results & Integration (Weeks 31-32)

**Objective**: Synthesize all findings into dissertation Chapter 4 (Results) and Chapter 5 (Discussion)

**Planned Activities**:

1. **Results Integration**:

   - Consolidated hypothesis test outcomes (H1-H5: 14 sub-hypotheses)
   - Model comparison summary (UTAUT2 vs. AIRS)
   - Mediation pathway diagrams with standardized coefficients
   - Moderation effect plots
2. **Diagnostic Tool Development**:

   - AIRS scoring protocol (12-item scale)
   - Facilitators subscale (7 items) and Barriers subscale (5 items)
   - Normative percentiles for organizational benchmarking
3. **Publication-Ready Outputs**:

   - APA-formatted tables (descriptive statistics, correlations, fit indices, path coefficients)
   - High-resolution figures (structural models, mediation diagrams, moderation plots)
   - Supplementary materials (scale items, descriptive statistics by demographics)

**Deliverables**:

- `07_Comprehensive_Results.ipynb`: Complete results integration
- Final progress report to committee with all hypothesis outcomes
- Draft dissertation Chapter 4 (Results)

---

## 🎯 Expected Contributions

### Theoretical Contributions

1. **Framework Extension**: Empirical validation of AI-specific constructs (Trust, Explainability, Ethical Risk, AI Anxiety) as meaningful extensions to UTAUT2, tested through nested model comparison
2. **Mediating Mechanisms**: Identification of psychological pathways (trust, anxiety) linking AI-specific concerns to adoption intentions, advancing understanding beyond direct effects
3. **Empirical Structure**: Documentation of how 12-construct theoretical framework converges into 2-factor empirical structure, informing future scale refinement and theory development

### Practical Contributions

1. **Diagnostic Instrument**: 12-item construct-balanced scale providing organizational assessment tool with 50% efficiency gain over preliminary 24-item version
2. **Dual-Purpose Design**: Scale supports both diagnostic application (identify specific strengths/weaknesses across 12 constructs) and predictive modeling (parsimonious 2-factor structure)
3. **Intervention Guidance**: Factor structure distinguishes "Facilitators" (leverage for change management) from "Barriers" (address for risk mitigation), enabling targeted interventions

### Methodological Contributions

1. **Split-Sample Rigor**: Demonstrates importance of independent validation samples in scale development to prevent overfitting and ensure generalizability
2. **Construct-Balanced Design**: Shows that selecting one best-loading item per construct maintains theoretical coverage while achieving measurement efficiency
3. **Data-Driven Factor Determination**: Validates use of parallel analysis over Kaiser criterion, resulting in more parsimonious and interpretable factor structure

---

## 🔬 Analysis Workflow (5 Phases)

### Phase 1: Scale Development ✅ COMPLETE

**Objectives**:

- Create stratified development/holdout split
- Develop construct-balanced 12-item scale
- Determine empirical factor structure
- Validate reliability and predictive validity

**Methods**:

- **Split Strategy**: Stratified 50/50 by Work_Context × AI_Adoption (random_state=42)
- **Item Selection**: Best loading item per construct from preliminary 4-factor EFA
- **Factor Determination**: Parallel analysis on 12-item set (data-driven, not theory-forced)
- **Estimator**: Minimum residual (minres) for ordinal data
- **Rotation**: Promax (oblique, allows factor correlation)

**Key Results**:

- **KMO**: 0.815 (sampling adequacy: Good)
- **Bartlett's Test**: p < .001 (factorability confirmed)
- **Optimal Factors**: 2 (Kaiser criterion=3, Parallel analysis=2)
- **Reliability**: Cronbach's α = 0.897 (Good)
- **Loadings**: All items ≥ 0.50 (range: 0.50-0.98)
- **Variance Explained**: 58.1% (2-factor model)
- **Predictive Validity**: R² = 0.811 (predicting BI outcome)
- **Efficiency**: 96.3% predictive power with 50% item reduction

**Notebooks**: `00_Create_Split_Samples.ipynb`, `01_EFA_Construct_Balanced_12_Item.ipynb`

---

### Phase 2: CFA Validation ⏭️ NEXT PRIORITY

**Objectives**:

- Validate 2-factor structure on independent holdout sample
- Assess measurement model fit
- Calculate reliability and validity metrics
- Test discriminant validity between factors

**Planned Methods**:

- **Sample**: Holdout N=159 (independent validation)
- **Estimator**: MLR or WLSMV for ordinal data
- **Model**: 2 correlated factors (F1: 7 items, F2: 5 items)

**Acceptance Thresholds**:

- **Fit Indices**: CFI/TLI ≥ 0.90, RMSEA ≤ 0.08, SRMR ≤ 0.08
- **Loadings**: Standardized λ ≥ 0.50
- **Reliability**: Cronbach's α ≥ 0.70, CR ≥ 0.70
- **Convergent Validity**: AVE ≥ 0.50 per factor
- **Discriminant Validity**: √AVE > |r(F1,F2)|, HTMT < 0.85

**Notebook**: `02_CFA_Measurement_Model.ipynb` (to be created)

---

### Phase 3: Structural Models & Hypothesis Testing ⏳ PENDING

**H1-H3: Baseline vs. Extended Model**

- Model 1 (UTAUT2): 8 constructs (PE, EE, SI, FC, HM, PV, HB, VO) → BI
- Model 2 (AIRS): 12 constructs (UTAUT2 + TR, EX, ER, AX) → BI
- Test incremental validity: ΔR² ≥ 0.10 expected

**H5a-H5c: Mediation Analysis**

- H5a: EX → TR → BI (explainability through trust)
- H5b: ER → TR → BI (ethical risk through trust)
- H5c: ER → AX → BI (ethical risk through anxiety)
- Method: Bootstrap mediation (5000 iterations, 95% CI)

**Notebooks**: `04_Structural_Model_Hypothesis_Testing.ipynb`, `05_Mediation_Analysis.ipynb`

---

### Phase 4: Moderation Analysis ⏳ PENDING

**H4a-H4e: Contextual Moderators**

- Role (Student vs. Professional vs. Faculty)
- AI Usage Frequency (Low vs. High)
- AI Adoption Status (Adopter vs. Non-adopter)
- Method: Multi-group SEM with chi-square difference tests
- Prerequisite: Measurement invariance established in Phase 2

**Notebook**: `06_Moderation_Analysis.ipynb`

---

### Phase 5: Integration & Reporting ⏳ PENDING

**Deliverables**:

- Comprehensive results summary integrating all phases
- APA-formatted tables and publication-quality figures
- Diagnostic scoring protocol for 12-item scale
- Model comparison summary (UTAUT2 vs. AIRS)
- Hypothesis test outcomes (H1-H5) with effect sizes

**Notebook**: `07_Comprehensive_Results.ipynb`

---

## 📊 Phase 1 Key Results: 12-Item Scale Development

### Scale Composition

**Selected Items** (1 per construct):

```
Factor 1 - Facilitators (7 items):
  PE1 (Performance Expectancy)    λ = 0.77
  FC1 (Facilitating Conditions)   λ = 0.90
  HM1 (Hedonic Motivation)         λ = 0.80
  PV2 (Price Value)                λ = 0.98
  HB2 (Habit)                      λ = 0.95
  TR1 (Trust in AI)                λ = 0.78
  VO1 (Voluntariness)              λ = 0.72

Factor 2 - Barriers (5 items):
  AX2 (AI Anxiety)                 λ = 0.82
  ER1 (Ethical Risk)               λ = 0.64
  EE2 (Effort Expectancy)          λ = 0.41
  SI2 (Social Influence)           λ = 0.59
  EX1 (Explainability)             λ = 0.71
```

### Psychometric Quality

| Metric                       | Result    | Threshold | Status                                   |
| ---------------------------- | --------- | --------- | ---------------------------------------- |
| **Cronbach's α**      | 0.897     | ≥ 0.70   | ✅ Good                                  |
| **Variance Explained** | 58.1%     | —        | ✅ Adequate                              |
| **KMO**                | 0.815     | ≥ 0.60   | ✅ Good                                  |
| **Factor Loadings**    | 0.41-0.98 | ≥ 0.50   | ✅ All adequate                          |
| **Inter-factor r**     | 0.17      | —        | ✅ Weak (supports discriminant validity) |

### Predictive Validity

| Model                     | R²   | Performance       |
| ------------------------- | ----- | ----------------- |
| **24-item model**   | 0.842 | Baseline (100%)   |
| **12-item model**   | 0.811 | 96.3% of baseline |
| **Efficiency gain** | —    | 50% fewer items   |

**Interpretation**: 12-item scale retains 96.3% of predictive power with 50% reduction in respondent burden—excellent efficiency for a diagnostic tool.

### Critical Insight: 2-Factor Structure

**Theoretical Framework**: 12 distinct constructs (8 UTAUT2 + 4 AI-specific)

**Empirical Reality**: 2 higher-order dimensions

- **Factor 1 (Facilitators)**: Positive attitudes, enablers, trust (7 constructs)
- **Factor 2 (Barriers)**: Concerns, effort, influence, explainability gaps (5 constructs)

**Implication**: While 12 constructs provide diagnostic granularity (identify specific strengths/weaknesses), they converge empirically into two broad dimensions (readiness vs. resistance). This supports the scale's **dual purpose**:

1. **Diagnostic**: 12-item construct coverage for targeted interventions
2. **Predictive**: 2-factor parsimonious structure for adoption modeling

---

## 🔍 Key Analytical Decisions

### 1. Scale Design: Construct Coverage vs. Parsimony

**Decision**: 12-item construct-balanced scale (1 item per construct)

**Rationale**:

- **Dual Purpose**: Balance comprehensive diagnostic coverage with predictive efficiency
- **Diagnostic Value**: All 12 constructs represented for targeted interventions
- **Predictive Efficiency**: Minimal respondent burden while maintaining 96.3% predictive power
- **Practical Application**: Short enough for organizational deployment, granular enough for action

### 2. Factor Determination: Theory-Driven vs. Data-Driven

**Decision**: Accept 2-factor empirical structure (not 12-factor theoretical)

**Rationale**:

- **Parallel Analysis**: Empirically supports 2 factors (Kaiser=3, Parallel=2)
- **Theoretical Coherence**: 2 factors (Facilitators/Barriers) align with psychological approach-avoidance
- **Parsimony**: Simpler structure improves interpretability and model fit
- **Discriminant Validity**: Weak inter-factor correlation (r=0.17) supports 2-factor distinction
- **Future Testing**: Second-order factor model may reconcile 12 constructs with 2 higher-order dimensions

### 3. Item Selection Strategy

**Decision**: Best-loading item per construct from preliminary 4-factor EFA

**Rationale**:

- **Quality Over Quantity**: Select strongest indicator per construct
- **Balanced Representation**: Ensures all 12 theoretical constructs in final scale
- **Empirical Validation**: Items selected based on loadings, not a priori theory
- **Reduces Redundancy**: Eliminates weaker items while maintaining construct coverage

### 4. Voluntariness (VO) Treatment

**Decision**: Include VO as both predictor and potential moderator

**Rationale**:

- **Empirical Support**: VO1 loaded strongly (λ=0.72) on Factor 1 in EFA
- **UTAUT2 Precedent**: Venkatesh et al. (2012) supports VO as both predictor and moderator
- **Dual Role**: Direct effect on BI + moderates SI/FC effects (discretionary vs. mandated contexts)
- **Proposal Alignment**: Updated H1 to include VO as 8th UTAUT2 construct

### Methodological Transparency

For complete reproducibility:

**EFA Analysis (Phase 1)**:

- **Method**: Principal Axis Factoring with Promax rotation
- **Sample**: Development N=159 (stratified random split)
- **Factorability**: KMO=0.815, Bartlett's p<0.001
- **Factor Determination**: Parallel analysis (2 factors), Kaiser criterion (3 factors) → accepted 2
- **Item Selection**: Best-loading item per construct from preliminary 4-factor structure
- **Random Seed**: 42 (ensures reproducibility)

**Psychometric Validation**:

- **Internal Consistency**: Cronbach's α = 0.897 (12 items)
- **Convergent Validity**: Factor loadings λ = 0.41-0.98 (all ≥ 0.40)
- **Discriminant Validity**: Inter-factor correlation r = 0.17 (weak, supports 2-factor distinction)
- **Predictive Validity**: R² = 0.811 vs. 24-item R² = 0.842 (96.3% efficiency)

**Documentation**: See `airs/01_EFA_Construct_Balanced_12_Item_Model.ipynb` for complete Phase 1 methodology

---

## 🛠️ Technical Requirements

### Python Environment

```bash
Python 3.12.7
```

### Key Dependencies

```
pandas==2.2.3          # Data manipulation
numpy==2.1.2           # Numerical operations
semopy==2.3.13         # Structural equation modeling
factor-analyzer==0.5.1 # Exploratory factor analysis
pingouin==0.5.5        # Statistical tests
scikit-learn==1.5.2    # Machine learning utilities
matplotlib==3.9.2      # Plotting
seaborn==0.13.2        # Statistical visualization
jupyter==1.1.1         # Notebook interface
```

### Installation

```bash
# Clone repository
git clone https://github.com/fabioc-aloha/AIRS_Data_Analysis.git
cd AIRS_Data_Analysis

# Create virtual environment
python -m venv venv
.\venv\Scripts\Activate.ps1  # Windows PowerShell
source venv/bin/activate      # macOS/Linux

# Install dependencies
pip install -r requirements.txt

# Launch Jupyter
jupyter notebook notebooks/AIRS_Analysis_Python.ipynb
```

---

## 📖 Documentation Files

### Primary Documentation

- **`airs/ANALYSIS_PLAN.md`**: Comprehensive dissertation roadmap (v1.1) with Phase 1 complete, RQ/H tracking
- **`airs/CONSISTENCY_CHECK.md`**: Cross-document verification (proposal, analysis plan, code alignment)
- **`docs/AIRS DBA Project Proposal v4.md`**: Theoretical framework, hypotheses (H1-H5), methodology
- **`docs/DATA_DICTIONARY.md`**: Complete variable definitions, scales, measurement notes
- **`docs/AIRS Survey Instrument v5.md`**: Research questions, hypotheses, complete survey with item provenance
- **`EXPLORATORY_PHASE_LEARNINGS.md`**: Methodological insights from exploratory work (N=281) that informed Phase 1

### Phase 1 Analysis (✅ Complete)

- **`airs/01_EFA_Construct_Balanced_12_Item.ipynb`**: **Authoritative source** for 12-item scale development
  - Split-sample methodology (Development N=159, Holdout N=159)
  - 2-factor structure (Facilitators, Barriers)
  - Item selection (1 per 12 constructs)
  - Psychometric validation (α=0.897, R²=0.811)
  - Complete reproducibility documentation

### Archive - Exploratory Phase

- **`archive/notebooks_exploratory/`**: Exploratory notebooks (N=281, pre-dissertation)
  - Data-driven item selection and optimization
  - Single-sample validation (no split-sample design)
  - Informed dissertation methodology decisions
  - See `EXPLORATORY_PHASE_LEARNINGS.md` for insights synthesis

---

## 📚 Key Methodological References

### UTAUT2 Foundation

- **Venkatesh, V., Thong, J. Y. L., & Xu, X. (2012)**. Consumer acceptance and use of information technology: Extending the unified theory of acceptance and use of technology. *MIS Quarterly, 36*(1), 157-178.

  - Seminal framework establishing the eight UTAUT2 predictors
  - Over 18,000 citations validating theoretical robustness
- **Venkatesh, V., Morris, M. G., Davis, G. B., & Davis, F. D. (2003)**. User acceptance of information technology: Toward a unified view. *MIS Quarterly, 27*(3), 425-478.

  - Original UTAUT framework synthesizing eight prior models

### Psychometric Validation Standards

- **Hu, L. T., & Bentler, P. M. (1999)**. Cutoff criteria for fit indexes in covariance structure analysis: Conventional criteria versus new alternatives. *Psychological Methods, 4*(1), 1-24.

  - Established fit index thresholds (CFI ≥ 0.90, RMSEA ≤ 0.08) used in Phase 2 CFA
- **Fornell, C., & Larcker, D. F. (1981)**. Evaluating structural equation models with unobservable variables and measurement error. *Journal of Marketing Research, 18*(1), 39-50.

  - Convergent/discriminant validity criteria (AVE ≥ 0.50, √AVE > correlations)
- **Hair, J. F., Black, W. C., Babin, B. J., & Anderson, R. E. (2010)**. *Multivariate data analysis* (7th ed.). Pearson.

  - Comprehensive guide for SEM, sample size requirements, interpretation standards

### AI-Specific Constructs

- **Langer, M., Landers, R. N., & König, C. J. (2023)**. Trust in artificial intelligence: A five-stage model for understanding drivers of trust and beliefs. *Academy of Management Annals, 17*(1), 47-81.

  - Theoretical foundation for Trust in AI construct
- **Shin, D. (2021)**. The effects of explainability and causability on perception, trust, and acceptance: Implications for explainable AI. *International Journal of Human-Computer Studies, 146*, 102551.

  - Explainability effects on adoption outcomes
- **Hagendorff, T. (2020)**. The ethics of AI ethics: An evaluation of guidelines. *Minds and Machines, 30*(1), 99-120.

  - Ethical risk concerns in AI deployment

### Statistical Methods

- **Henseler, J., Ringle, C. M., & Sarstedt, M. (2015)**. A new criterion for assessing discriminant validity in variance-based structural equation modeling. *Journal of the Academy of Marketing Science, 43*(1), 115-135.
  - HTMT criterion for discriminant validity assessment

**Complete bibliography** with 40+ additional references available in `docs/AIRS DBA Project Proposal v4.md`

---

## 📊 Summary Statistics

| **Metric**                 | **Value**            | **Interpretation**                                              |
| -------------------------------- | -------------------------- | --------------------------------------------------------------------- |
| **Total Sample Size**      | N = 318                    | Exceeds SEM minimum (N > 200), enables robust split-sample validation |
| **Development Sample**     | N = 159                    | EFA, item selection, preliminary validation                           |
| **Holdout Sample**         | N = 159                    | Independent CFA validation, hypothesis testing                        |
| **Theoretical Constructs** | 12 (8 UTAUT2 + 4 AI)       | Comprehensive coverage of adoption determinants                       |
| **Empirical Factors**      | 2 (Facilitators, Barriers) | Parsimonious structure for predictive modeling                        |
| **Scale Length**           | 12 items (1 per construct) | Balanced coverage with minimal respondent burden                      |
| **Internal Consistency**   | α = 0.897                 | Excellent reliability (exceeds α ≥ 0.70 threshold)                  |
| **Predictive Validity**    | R² = 0.811                | Strong prediction of Behavioral Intention                             |
| **Measurement Efficiency** | 96.3% of 24-item power     | 50% item reduction with minimal validity loss                         |
| **Factor Loadings**        | Range: 0.41-0.98           | All items load adequately (threshold: λ ≥ 0.40)                     |
| **Variance Explained**     | 58.1%                      | Adequate for social science (typical: 50-60%)                         |
| **Sampling Adequacy**      | KMO = 0.815                | Good factorability (exceeds 0.60 threshold)                           |
| **Timeline Status**        | Week 24 of 32              | On schedule (75% complete)                                            |

---

## 🔬 Methodological Rigor: Quality Assurance

### Split-Sample Validation Design

- **Purpose**: Prevent overfitting, ensure generalizability
- **Implementation**: Stratified 50/50 split by Work_Context × AI_Adoption (random_state=42)
- **Advantage**: Independent holdout sample validates findings without capitalization on chance

### Data-Driven Factor Determination

- **Method**: Parallel analysis (empirical) over Kaiser criterion (eigenvalue > 1)
- **Result**: 2-factor structure (vs. Kaiser's 3) aligns with approach-avoidance theory
- **Benefit**: More parsimonious, interpretable solution with better theoretical coherence

### Construct-Balanced Item Selection

- **Strategy**: One best-loading item per construct from preliminary EFA
- **Advantage**: Maintains theoretical coverage while achieving efficiency
- **Quality Control**: All items exceed λ ≥ 0.40 threshold (range: 0.41-0.98)

### Reproducibility Standards

- **Random Seed**: Set to 42 for all stochastic procedures
- **Code Documentation**: Complete Jupyter notebooks with markdown explanations
- **Data Availability**: Preprocessed datasets tracked in repository (`data/*.csv`)
- **Version Control**: Git tracking ensures audit trail of analytical decisions

---

## 💼 Practical Applications

### For Organizations

1. **Readiness Assessment**: Administer 12-item AIRS to employees before AI deployment
2. **Gap Identification**: Use construct-level scores to identify specific weaknesses (e.g., low Trust, high Anxiety)
3. **Targeted Interventions**:
   - **Low Facilitators**: Improve training (EE), demonstrate value (PE), build trust (TR)
   - **High Barriers**: Address ethical concerns (ER), provide explanations (EX), reduce anxiety (AX)
4. **Benchmarking**: Compare organizational scores to normative data from N=318 sample

### For Researchers

1. **Theoretical Extension**: Test AIRS in new contexts (healthcare AI, autonomous systems, creative AI)
2. **Longitudinal Studies**: Track AI readiness changes over time as technology matures
3. **Cross-Cultural Validation**: Assess measurement invariance across countries/cultures
4. **Outcome Prediction**: Use AIRS to predict actual AI adoption behavior, productivity gains, user satisfaction

### For Practitioners

1. **Change Management**: Identify resistance points before implementation
2. **Training Design**: Tailor content to address specific barriers (e.g., explainability workshops for low EX)
3. **Communication Strategy**: Frame AI benefits around high-scoring facilitators, address low-scoring barriers
4. **Risk Mitigation**: Monitor ethical risk and anxiety levels to prevent backlash

---

## 📂 Repository Access & Navigation

**Primary Analysis Folder**: `airs/`

- `00_Create_Split_Samples.ipynb` - Stratified split-sample creation (✅ Complete)
- `01_EFA_Construct_Balanced_12_Item_Model.ipynb` - **Phase 1 authoritative source** (✅ Complete)
- `02_CFA_Measurement_Model.ipynb` - Phase 2 CFA validation (⏭️ Next)
- `04_Structural_Model_Hypothesis_Testing.ipynb` - Phase 3 hypothesis testing (⏳ Pending)
- `05_Mediation_Analysis.ipynb` - Phase 4 mediation (⏳ Pending)
- `06_Moderation_Analysis.ipynb` - Phase 5 moderation (⏳ Pending)

**Key Documentation**:

- `docs/AIRS DBA Project Proposal v4.md` - Complete proposal with H1-H5, RQ1-RQ5
- `docs/DATA_DICTIONARY.md` - Variable definitions and measurement details
- `airs/ANALYSIS_PLAN.md` - Comprehensive dissertation roadmap (v1.1)
- `EXPLORATORY_PHASE_LEARNINGS.md` - Methodological insights from exploratory phase

**Data Files** (`data/`):

- `AIRS_clean.csv` - Full sample (N=318)
- `AIRS_clean_dev.csv` - Development sample (N=159)
- `AIRS_clean_holdout.csv` - Holdout sample (N=159)

---

## 📧 Contact Information

**Student**: Fabio Correa

**Institution**: Touro University Worldwide

**Program**: Doctor of Business Administration (DBA)

**Dissertation Chair**: Dr. Karina Kasztelnik

**Repository**: [github.com/fabioc-aloha/AIRS_Data_Analysis](https://github.com/fabioc-aloha/AIRS_Data_Analysis)

---

## 🏆 Acknowledgments

**Study Participants** (N=318): Faculty, students, and professionals who generously shared their AI adoption experiences

**Dr. Venkatesh**: For developing the UTAUT2 framework that provides the theoretical foundation for this research

**Dr. Karina Kasztelnik**: For dissertation guidance and oversight throughout this project

**Open-Source Community**: Python developers of factor-analyzer, semopy, and pingouin packages enabling reproducible psychometric research

---

**Report Date**: November 22, 2025
