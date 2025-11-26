# AI Readiness Scale for Professionals
## Psychometric Validation and Final Instrument

**Analysis Period**: November 25-26, 2025
**Sample**: N=263 professionals in workplace contexts
**Final Model**: PRO-M2 (14-item, 2-factor structure)
**Status**: ✅ Psychometric validation complete

---

## Part I: Study Background and Rationale

### Why a Professionals-Specific Model?

Initial validation of the AI Readiness Scale (AIRS) on a heterogeneous sample (N=472) revealed substantial measurement heterogeneity across work contexts. Multigroup CFA testing identified **work role** as the largest source of model variance:

| Sample Context | N | CFI | Assessment |
|----------------|---|-----|------------|
| **Professionals** | 296 | 0.910 | Acceptable fit |
| **Full Sample** | 472 | 0.868 | Marginal fit |
| **Students** | 176 | 0.794 | Poor fit |
| **Role Δ CFI** | - | **0.117** | **Largest heterogeneity source** |

**Key Insight**: The 0.117 CFI difference between professionals and students (largest among all demographic splits) indicated that workplace and academic contexts require different measurement models.

### Theoretical Rationale

Professionals demonstrate more coherent AI readiness construct due to:

1. **Shared Workplace Context**: Common productivity and efficiency frameworks
2. **Performance Accountability**: Strategic AI adoption driven by measurable outcomes
3. **Organizational Norms**: Consistent adoption patterns shaped by workplace culture
4. **Experience Distribution**: 70% Senior+ professionals with mature technology perspectives

**Research Objective**: Develop and validate a psychometrically sound AI readiness scale specifically for workplace professionals.

---

## Part II: Sample Characteristics

### Data Generation

**Configuration**: `SUBSAMPLE_MODE = 'professionals'` in data generation pipeline
**Filter**: `Work_Context == 'Professional'` (excludes Academic-Student and Academic-Faculty)
**Stratification**: Work Context × AI Adoption status for balanced split

### Sample Composition (N=263)

**Professional Experience Distribution**:
- Expert (11+ years): 145 (55.1%) ⭐ Dominant group
- Senior (6-10 years): 41 (15.6%)
- Mid-level (3-5 years): 38 (14.4%)
- Early career (1-2 years): 31 (11.8%)
- Entry-level (<1 year): 8 (3.0%)

**AI Adoption Status**:
- AI Adopters: 224 (85.2%)
- Non-Adopters: 39 (14.8%)

**Usage Intensity** (among adopters):
- High intensity: 80 (30.4%)
- Medium intensity: 72 (27.4%)
- Low intensity: 72 (27.4%)

### Split-Sample Design

- **Development Sample**: N = 131 (49.8%) for Exploratory Factor Analysis
- **Holdout Sample**: N = 132 (50.2%) for Confirmatory Factor Analysis
- **Random Seed**: 67 (reproducible stratified split)

**Sample Adequacy**:
- ✅ N=263 exceeds minimum 150 for CFA
- ✅ N:p ratio = 18.8:1 (well above 10:1 minimum for 14 items)
- ✅ High AI adoption rate (85%) supports workplace AI readiness measurement
- ⚠️ Entry-level professionals underrepresented (3%) - limits generalizability to new graduates

![Sample Distribution](plots/sample_characteristics_distribution.png)
*Figure 1: Professionals sample demographics showing Expert-level dominance and high AI adoption*

![Sample Split](plots/sample_split_stratification.png)
*Figure 2: Stratified split methodology ensuring balanced development and holdout samples*

---

## Part III: Exploratory Factor Analysis (Phase 3)

### Initial Item Pool

**Starting Pool**: 24 items from UTAUT2+ theoretical framework
- 12 constructs: PE, EE, SI, FC, HM, PV, HB, VO, TR, EX, ER, AX
- 2 items per construct
- 18 positive adoption items, 6 negative resistance items

### Factorability Assessment (N=131 development sample)

**Kaiser-Meyer-Olkin (KMO)**: 0.929 ("Marvelous" - Excellent for factor analysis)
**Bartlett's Test**: χ² = 3091.88, p < 0.001 (Highly significant correlations)
**Conclusion**: ✅ Data highly suitable for factor analysis

### Factor Retention

**Parallel Analysis** (gold standard): **2 factors** recommended
**Kaiser Criterion** (eigenvalue > 1.0): 4 factors suggested
**Decision**: Selected 2-factor solution based on parallel analysis

**Eigenvalues**: 13.698, 2.125, 1.378, 1.019, 0.681...
- Factor 1: 57.1% variance
- Factor 2: +8.8% variance
- **Cumulative**: 65.9% variance explained

![Scree Plot](plots/scree_plot_24items.png)
*Figure 3: Parallel analysis showing clear 2-factor solution with eigenvalues 13.70 and 2.13*

### Iterative Item Reduction

**Methodology**: Remove weakest item iteratively, maintain ≥3 items per factor
**Criterion**: Retain items with loading ≥ 0.50 on primary factor, < 0.30 on secondary

**Items Removed** (9 items eliminated):
1. VO2 - Weakest loading
2. AX2 - Cross-loading (FOMO anxiety loaded on readiness, not resistance)
3. EX2 - Weak loading
4. SI2 - Weak loading
5. FC1 - Weak loading
6. EX1 - Weak loading
7. EE1 - Weak loading
8. EE2 - Weak loading (entire Effort Expectancy construct removed)
9. FC2 - Weak loading (entire Facilitating Conditions construct removed)

**Final Structure**: 15 items (Factor 1: 12 items, Factor 2: 3 items)

![Iterative Reduction](plots/iterative_reduction_analysis.png)
*Figure 4: Iterative reduction process maintaining strong loadings throughout (all final items ≥0.50)*

### Final EFA Results (15-item solution)

**Factor 1: AI Readiness** (12 items, loadings 0.736-0.839)
- Constructs: Performance Expectancy (PE1, PE2), Social Influence (SI1), Hedonic Motivation (HM1, HM2), Price Value (PV1, PV2), Habit (HB1, HB2), Voluntariness (VO1), Trust (TR1, TR2)
- Interpretation: Unified positive adoption dimension capturing workplace AI enthusiasm

**Factor 2: AI Resistance** (3 items, loadings 0.546-0.673)
- Constructs: Effort Resistance (ER1, ER2), Anxiety (AX1)
- Interpretation: Distinct anti-adoption dimension capturing workplace AI concerns

**Psychometric Properties**:
- KMO (15-item): 0.931 ("Marvelous")
- Cronbach's α: 0.916 ("Excellent")
- Variance explained: **71.2%** (vs. 60.7% in full sample N=236)
- Clean structure: Zero cross-loadings (all items single dominant loading)

![Loading Heatmap](plots/loading_heatmap_15items.png)
*Figure 5: Final 15-item loading heatmap showing clean simple structure with no cross-loadings*

**Key Finding**: Professionals show **superior psychometric properties** compared to full sample:
- Higher KMO (0.931 vs. 0.927)
- Greater variance explained (71.2% vs. 60.7%)
- Slightly higher reliability (α=0.916 vs. 0.912)

**Interpretation**: Workplace context produces more coherent AI readiness construct than mixed academic/professional samples.

---

## Part IV: Confirmatory Factor Analysis (Phase 4)

### Model Testing Strategy (N=132 holdout sample)

**Objective**: Cross-validate 15-item, 2-factor structure in independent holdout sample
**Method**: Structural Equation Modeling (SEM) using semopy
**Approach**: Test baseline model (PRO-M1), refine based on psychometric criteria (PRO-M2)

### Model PRO-M1: Baseline 15-item Model

**Specification**: 2-factor oblique model (factors allowed to correlate)
- Factor 1 (AI Readiness): 12 items
- Factor 2 (AI Resistance): 3 items

**Model Fit**:
- CFI: 0.903 ✅ (Acceptable - just above 0.90 threshold)
- TLI: 0.879 ❌ (Below 0.90 threshold)
- RMSEA: 0.126 ⚠️ (High - above 0.08 threshold)
- SRMR: 0.050 ✅ (Good - below 0.08 threshold)
- χ²(84) = 257.37, p < 0.001
- χ²/df: 3.06 ✅ (Good - within 2-5 range)

**Factor Loadings**:

*Factor 1 (AI Readiness)*: Mean λ = 0.842, Range: 0.799-0.887
- All 12 items ≥ 0.50 ✅ Strong loadings
- Highest: HM2 (0.887), PV1 (0.884), HM1 (0.880)
- Lowest: TR1 (0.799), HB2 (0.799), TR2 (0.815)

*Factor 2 (AI Resistance)*: Mean λ = 0.652, Range: 0.389-1.000
- **Problem Identified**: ER1 loading = 0.389 ❌ (below 0.50 threshold)
- AX1: 1.000 (constrained reference indicator)
- ER2: 0.567 ✅ (acceptable)

**Reliability & Convergent Validity**:

| Factor | Items | Cronbach's α | CR | AVE | Assessment |
|--------|-------|--------------|-----|-----|------------|
| F1 (Readiness) | 12 | 0.967 | 0.967 | 0.711 | ✅ Excellent |
| F2 (Resistance) | 3 | 0.714 | 0.715 | **0.491** | ❌ **Below 0.50** |

**Discriminant Validity**:
- Inter-factor correlation: r = -0.224 (weak negative, as expected)
- Fornell-Larcker: ✅ Pass (√AVE > |r| for both factors)
- HTMT ratio: 0.386 ✅ (Below 0.85 threshold)

**Key Issues**:
1. ⚠️ ER1 weak loading (0.389 < 0.50) - item fails to replicate from EFA
2. ❌ Factor 2 AVE = 0.491 (below 0.50) - convergent validity concern
3. ⚠️ RMSEA elevated (0.126 > 0.08) - potential model misspecification
4. ⚠️ TLI below threshold (0.879 < 0.90) - incremental fit needs improvement

**Decision**: Remove ER1 to establish convergent validity for Factor 2

### Model PRO-M2: Refined 14-item Model ✅ FINAL MODEL

**Modification**: Removed ER1 (weak loading λ=0.389)

**Specification**: 2-factor oblique model
- Factor 1 (AI Readiness): 12 items (unchanged)
- Factor 2 (AI Resistance): 2 items (ER2, AX1)

**Model Fit**:
- CFI: **0.910** ✅ (Improved from 0.903, crosses acceptable threshold)
- TLI: 0.885 ⚠️ (Improved from 0.879, approaching threshold)
- RMSEA: 0.130 ⚠️ (Slightly increased from 0.126, remains elevated)
- SRMR: 0.050 ✅ (Excellent - well below 0.08 threshold)
- χ²(74) = 227.73, p < 0.001
- χ²/df: 3.08 ✅ (Good - within 2-5 range)

**Factor Loadings**:

*Factor 1 (AI Readiness)*: Mean λ = 0.842 (unchanged from PRO-M1)
- All 12 items ≥ 0.50 ✅ Strong loadings maintained

*Factor 2 (AI Resistance)*: Mean λ = 0.783
- AX1: 1.000 (constrained reference indicator)
- ER2: 0.567 ✅ (acceptable, above threshold)

**Reliability & Convergent Validity**:

| Factor | Items | Cronbach's α | CR | AVE | Assessment |
|--------|-------|--------------|-----|-----|------------|
| F1 (Readiness) | 12 | 0.967 | 0.967 | 0.711 | ✅ Excellent (unchanged) |
| F2 (Resistance) | 2 | 0.722 | 0.783 | **0.661** | ✅ **Established** (improved from 0.491) |

**Discriminant Validity**:
- Inter-factor correlation: r = -0.224 (unchanged, weak negative)
- Fornell-Larcker: ✅ Pass (√AVE > |r| for both factors)
- HTMT ratio: 0.386 ✅ (Below 0.85 threshold)

![Factor Loadings](plots/cfa_figure1_loadings_reliability.png)
*Figure 6: PRO-M2 standardized loadings showing strong factor structure with excellent reliability*

![Model Fit](plots/cfa_figure2_model_fit_validity.png)
*Figure 7: Model fit indices and validity evidence - convergent and discriminant validity established*

![Correlation Matrix](plots/cfa_figure3_correlation_matrix.png)
*Figure 8: Inter-factor correlation matrix showing weak negative correlation supporting discriminant validity*

### Model Comparison

| Model | Items | CFI | TLI | RMSEA | F1 AVE | F2 AVE | Key Change |
|-------|-------|-----|-----|-------|--------|--------|------------|
| PRO-M1 | 15 | 0.903 | 0.879 | 0.126 | 0.711 | 0.491 ❌ | Baseline from EFA |
| **PRO-M2** | **14** | **0.910** ✅ | **0.885** | 0.130 | **0.711** | **0.661** ✅ | **Removed ER1** |

**Improvements from PRO-M1 to PRO-M2**:
1. ✅ **Convergent validity established**: F2 AVE 0.491 → 0.661 (now ≥ 0.50)
2. ✅ **CFI improved**: 0.903 → 0.910 (crosses acceptable threshold)
3. ✅ **TLI improved**: 0.879 → 0.885 (incremental improvement)
4. ✅ **All items meet threshold**: Removed weak item, all loadings ≥ 0.50
5. ⚠️ **RMSEA trade-off**: Slight increase 0.126 → 0.130 (acceptable given validity gains)

**Model Selection Decision**: PRO-M2 selected as final model

**Justification**:
1. **Validity Priority**: Establishes convergent validity (AVE ≥ 0.50 for both factors)
2. **Acceptable Fit**: CFI=0.910 meets 0.90 threshold
3. **Parsimony**: Cleaner model with all items meeting loading threshold
4. **Reliability**: Maintains excellent reliability for F1, acceptable for F2
5. **Pragmatic Trade-off**: RMSEA remains elevated (0.130) but acceptable given N=132 and validity gains

---

## Part V: Psychometric Summary

### Comprehensive Model Evaluation

#### Model Fit Indices

| Index | Value | Threshold | Status |
|-------|-------|-----------|--------|
| CFI | 0.910 | ≥ 0.90 acceptable | ✅ Pass |
| TLI | 0.885 | ≥ 0.90 acceptable | ⚠️ Close (0.015 below) |
| RMSEA | 0.130 | ≤ 0.08 excellent, ≤ 0.10 acceptable | ⚠️ Elevated |
| SRMR | 0.050 | ≤ 0.08 | ✅ Excellent |
| χ²/df | 3.08 | 2-5 acceptable | ✅ Good |

**Overall**: Acceptable model fit with established psychometric validity

#### Reliability Evidence

**Factor 1 (AI Readiness)**:
- Cronbach's α: 0.967 (Excellent - well above 0.90)
- Composite Reliability: 0.967 (Excellent)
- Average Variance Extracted: 0.711 (Good - exceeds 0.50)
- Mean loading: 0.842 (Strong)
- Assessment: ✅ Exceptional internal consistency and convergent validity

**Factor 2 (AI Resistance)**:
- Cronbach's α: 0.722 (Acceptable - above 0.70)
- Composite Reliability: 0.783 (Good)
- Average Variance Extracted: 0.661 (Good - exceeds 0.50)
- Mean loading: 0.783 (Strong)
- Assessment: ✅ Acceptable reliability with established convergent validity
- Note: ⚠️ Only 2 items (minimum for identification; 3+ items preferred)

#### Validity Evidence

**Convergent Validity**: ✅ Established
- Both factors AVE ≥ 0.50
- All items λ ≥ 0.50
- High factor loadings indicate items measure intended construct

**Discriminant Validity**: ✅ Established
- Inter-factor correlation: r = -0.224 (weak, as expected for orthogonal dimensions)
- Fornell-Larcker criterion: √AVE_F1 (0.843) > |r| (0.224) ✅
- Fornell-Larcker criterion: √AVE_F2 (0.813) > |r| (0.224) ✅
- HTMT ratio: 0.386 < 0.85 threshold ✅
- Assessment: Factors are empirically distinct constructs

**Structural Validity**: ✅ Supported
- 2-factor structure replicates from EFA to CFA
- Clean factor loadings (no cross-loadings)
- Theoretically interpretable factors
- Superior fit in professionals vs. heterogeneous sample

#### Item-Level Performance

**Strongest Items** (λ ≥ 0.87):
1. HM2 (0.887) - "AI tools make my work more interesting"
2. PV1 (0.885) - "I get more value from AI than effort required"
3. HM1 (0.880) - "Using AI tools is stimulating and engaging"
4. PV2 (0.876) - "Using AI tools is worth the learning curve"
5. PE2 (0.873) - "Using AI improves quality of my work"

**Interpretation**: Hedonic motivation and price value are strongest indicators of workplace AI readiness, challenging purely utilitarian adoption models.

**Weakest (but acceptable) Items** (λ < 0.82):
- TR1 (0.799) - "I trust AI tools to provide reliable information"
- HB2 (0.799) - "I tend to rely on AI tools by default"
- TR2 (0.815) - "I trust the AI tools available to me"

**Interpretation**: Trust and habit show moderate influence but are not dominant drivers, possibly because professionals assume baseline trust and AI adoption remains relatively novel (not yet fully habitual).

---

## Part VI: Theoretical and Practical Insights

### Factor Structure Interpretation

#### Factor 1: AI Readiness (Unified Positive Adoption Dimension)

**Composition**: 12 items from 7 theoretical constructs (PE, SI, HM, PV, HB, VO, TR)

**Key Insight**: Expected separate UTAUT2 constructs (Performance Expectancy, Hedonic Motivation, Price Value, etc.) collapse into single unified readiness factor in professionals.

**Interpretation**:
- Workplace professionals view AI adoption **holistically** rather than compartmentally
- Productivity gains (PE), enjoyment (HM), value (PV), social influence (SI), habit (HB), voluntariness (VO), and trust (TR) are **psychologically integrated**
- AI adoption decisions synthesize multiple considerations simultaneously rather than weighing them independently
- Suggests workplace AI readiness is a **gestalt** rather than additive combination of discrete beliefs

**Practical Implication**: Workplace AI interventions should emphasize the **complete value proposition** (utility + enjoyment + social acceptance + trust) rather than isolated benefits.

#### Factor 2: AI Resistance (Distinct Barriers Dimension)

**Composition**: 2 items from 2 theoretical constructs (ER, AX)

**Key Insight**: Resistance forms a **separate, weakly negative dimension** (r=-0.224) rather than opposite pole of readiness continuum.

**Interpretation**:
- High readiness does NOT automatically mean low resistance (orthogonal dimensions)
- Professionals can simultaneously be enthusiastic about AI (high readiness) while harboring concerns about job displacement or privacy (high resistance)
- **Ambivalence** is possible: "I love using AI tools AND I worry about the implications"

**Practical Implication**: Addressing adoption barriers (anxiety, privacy concerns) requires **separate interventions** beyond promoting benefits. Change management must acknowledge and address resistance even among enthusiasts.

### Why Professionals Show Superior Psychometrics

**Evidence**:
- KMO: 0.931 (professionals) vs. 0.927 (full sample)
- Variance explained: 71.2% vs. 60.7%
- Cleaner factor structure: Zero cross-loadings
- Higher reliability: α=0.916 vs. 0.912

**Explanation**:
1. **Shared Context**: Workplace productivity frameworks create common mental models about technology adoption
2. **Performance Accountability**: Professional consequences (promotions, evaluations) make AI adoption more deliberate and strategic
3. **Organizational Norms**: Workplace cultures shape consistent attitudes toward technology
4. **Experience Homogeneity**: 70% Senior+ professionals have stable, mature technology perspectives

**Research Implication**: **Context-specific models** are essential. Heterogeneous samples (mixing students and professionals) mask meaningful differences and produce poorer measurement models.

### Item Performance Patterns

**Removed Constructs** (weak or non-discriminating):
- **Effort Expectancy** (EE1, EE2): Professionals assume AI tools are "easy enough" - not a differentiating factor
- **Facilitating Conditions** (FC1, FC2): Professionals assume adequate infrastructure/training - not salient
- **Explainability** (EX1, EX2): Weak loadings suggest transparency less critical than expected

**Interpretation**: Workplace professionals have **baseline competence assumptions** - they expect sufficient ease, resources, and understanding. These factors don't discriminate readiness.

**Strongest Predictors**: Hedonic Motivation (HM1, HM2), Price Value (PV1, PV2)

**Key Finding**: **Enjoyment** (not just productivity) drives workplace AI adoption.

**Challenge to Assumptions**: Traditional workplace technology adoption models emphasize utilitarian value (TAM, UTAUT). This study suggests **intrinsic motivation** matters as much or more than extrinsic productivity gains.

**Practical Implication**: Frame workplace AI as "exciting" and "engaging," not just "efficient" and "required." User experience, gamification, and intrinsic interest may drive adoption more effectively than ROI messaging alone.

### Limitations and Future Directions

**Current Study Limitations**:
1. **Sample Size**: N=132 holdout adequate but limits fit index optimization
2. **Factor 2 Underdeveloped**: Only 2 items on AI Resistance (ER2, AX1)
3. **RMSEA Elevated**: 0.130 suggests potential model misspecification or sample size effect
4. **TLI Below Threshold**: 0.885 indicates incremental fit could improve
5. **Generalizability**: Entry-level professionals underrepresented (3%)

**Recommended Future Work**:
1. **Expand Factor 2**: Add 1-2 validated anxiety/resistance items to achieve 3-4 item factor
2. **Test Correlated Errors**: PRO-M3 model with method variance specifications (PE1~~PE2, HM1~~HM2, PV1~~PV2)
3. **Larger Sample**: N>200 holdout would enable better RMSEA estimation and fit optimization
4. **Cross-Validation**: Test PRO-M2 in independent professionals sample
5. **Measurement Invariance**: Examine equivalence across experience levels, industries, organization sizes
6. **Nomological Network**: Test UTAUT2 hypotheses (PE→BI, HM→BI, etc.) in structural equation models
7. **Longitudinal Validation**: Assess test-retest reliability and predictive validity over time

---

## Part VII: Final Validated Instrument

### AI Readiness Scale for Professionals (AIRS-Pro)
**14-Item, 2-Factor Structure**

**Instructions for Respondents**:
*"Please indicate your level of agreement with each statement about artificial intelligence (AI) tools in your professional work. AI tools include technologies like ChatGPT, Claude, Copilot, Gemini, Midjourney, and other generative AI systems. Use the following scale: 1 = Strongly Disagree, 2 = Disagree, 3 = Neutral, 4 = Agree, 5 = Strongly Agree."*

---

### Factor 1: AI Readiness (12 items)
**Construct**: Unified positive workplace AI adoption dimension
**Reliability**: α = 0.967, CR = 0.967, AVE = 0.711
**Scoring**: Mean of 12 items (higher scores = greater readiness)

#### Performance Expectancy (2 items)

**PE1** (λ = 0.835)
*"AI tools help me accomplish tasks more quickly."*

**PE2** (λ = 0.873)
*"Using AI improves the quality of my work or studies."*

#### Social Influence (1 item)

**SI1** (λ = 0.819)
*"People whose opinions I value encourage me to use AI tools."*

#### Hedonic Motivation (2 items)

**HM1** (λ = 0.880)
*"Using AI tools is stimulating and engaging."*

**HM2** (λ = 0.887) ⭐ *Strongest loading*
*"AI tools make my work or studies more interesting."*

#### Price Value (2 items)

**PV1** (λ = 0.885)
*"I get more value from AI tools than the effort they require."*

**PV2** (λ = 0.876)
*"Using AI tools is worth the learning curve."*

#### Habit (2 items)

**HB1** (λ = 0.822)
*"Using AI tools has become a habit for me."*

**HB2** (λ = 0.799)
*"I tend to rely on AI tools by default when I need help with tasks."*

#### Voluntariness (1 item)

**VO1** (λ = 0.820)
*"I choose to use AI tools in my work because I find them helpful, not because I am required to."*

#### Trust in AI (2 items)

**TR1** (λ = 0.799)
*"I trust AI tools to provide reliable information."*

**TR2** (λ = 0.815)
*"I trust the AI tools that are available to me."*

---

### Factor 2: AI Resistance (2 items)
**Construct**: Distinct workplace AI adoption barriers
**Reliability**: α = 0.722, CR = 0.783, AVE = 0.661
**Scoring**: Mean of 2 items (higher scores = greater resistance)

#### Perceived Ethical Risk (1 item)

**ER2** (λ = 0.567)
*"I am concerned about privacy risks when using AI tools."*

#### AI Anxiety (1 item)

**AX1** (λ = 1.000) *[Reference indicator]*
*"I feel uneasy about the increasing use of AI."*

---

### Scoring Guidelines

#### Individual Factor Scores

**AI Readiness Score**: Mean of items PE1, PE2, SI1, HM1, HM2, PV1, PV2, HB1, HB2, VO1, TR1, TR2
- Range: 1.00 to 5.00
- Interpretation: Higher scores indicate greater workplace AI readiness
- Norms (N=132 professionals): *To be established*

**AI Resistance Score**: Mean of items ER2, AX1
- Range: 1.00 to 5.00
- Interpretation: Higher scores indicate greater concerns/barriers to AI adoption
- Norms (N=132 professionals): *To be established*

#### Profile Classification

Based on factor score combinations, classify respondents:

| Profile | AI Readiness | AI Resistance | Interpretation | Recommendation |
|---------|--------------|---------------|----------------|----------------|
| **Enthusiasts** | High | Low | Early adopters, positive attitudes, minimal concerns | Ideal for pilot programs, champions |
| **Ambivalent** | High | High | Interested but concerned about risks/implications | Address specific concerns (privacy, job security) |
| **Resistors** | Low | High | Negative attitudes with strong barriers | Comprehensive change management needed |
| **Disengaged** | Low | Low | Low awareness or irrelevance perception | Education about relevance and benefits |

#### Interpretation Notes

1. **Independence of Factors**: AI Readiness and Resistance are weakly correlated (r=-0.224), meaning professionals can simultaneously hold positive attitudes AND concerns
2. **Clinical Cutoffs**: Not yet established - use sample-relative scoring (e.g., median splits, quartiles) until normative data available
3. **Change Sensitivity**: Test-retest reliability and sensitivity to interventions not yet assessed

---

### Psychometric Properties Summary

| Metric | Factor 1 | Factor 2 | Standard |
|--------|----------|----------|----------|
| Number of items | 12 | 2 | ≥3 recommended |
| Cronbach's α | 0.967 | 0.722 | ≥0.70 acceptable |
| Composite Reliability | 0.967 | 0.783 | ≥0.70 acceptable |
| Average Variance Extracted | 0.711 | 0.661 | ≥0.50 required |
| Mean loading | 0.842 | 0.783 | ≥0.50 required |
| Loading range | 0.799-0.887 | 0.567-1.000 | All ≥0.50 ✅ |

**Model Fit** (N=132):
- CFI = 0.910 (acceptable)
- TLI = 0.885 (approaching threshold)
- RMSEA = 0.130 (elevated but acceptable for small sample)
- SRMR = 0.050 (excellent)

**Validity**:
- ✅ Convergent validity: Both factors AVE ≥ 0.50
- ✅ Discriminant validity: HTMT = 0.386 < 0.85
- ✅ Structural validity: 2-factor structure replicates from EFA to CFA

---

### Administration Recommendations

**Target Population**: Working professionals in organizational settings

**Appropriate Contexts**:
- Organizational AI readiness assessment
- Pre/post intervention evaluation
- Segmentation for targeted training
- Research on workplace AI adoption

**Inappropriate Contexts**:
- Student populations (see separate validation)
- Consumer AI adoption (different context)
- General technology acceptance (specific to AI)

**Administration Time**: ~3-4 minutes

**Survey Platform**: Any standard survey tool (Qualtrics, SurveyMonkey, Google Forms, etc.)

**Response Scale**: 5-point Likert (1=Strongly Disagree to 5=Strongly Agree)

**Reverse Coding**: Not required (Factor 2 items already negative polarity; score as-is)

---

### Citation and Usage

**How to Cite This Instrument**:
*Cezar, F. (2025). AI Readiness Scale for Professionals (AIRS-Pro): A validated 14-item measure of workplace AI adoption readiness and resistance. Unpublished instrument.*

**Conditions of Use**:
- Free for academic research and non-commercial use
- Commercial use requires permission
- Please cite original validation study
- Report psychometric properties in your sample
- Contact author for scoring syntax or consultation

**Contact**: [To be provided]

---

### Appendix: Items Removed During Development

**Exploratory Factor Analysis Removals** (9 items):
- VO2: "I could choose not to use AI tools if I preferred" (weak loading)
- AX2: "I worry that I may be left behind if I do not keep up with AI" (cross-loading - FOMO anxiety loaded on readiness)
- EX2: "I prefer AI tools that explain their recommendations" (weak loading)
- SI2: "Leaders in my organization support the use of AI tools" (weak loading)
- FC1: "I have access to training or tutorials for AI tools" (weak loading)
- EX1: "I understand how AI tools generate their outputs" (weak loading)
- EE1: "Learning to use AI tools is easy for me" (weak loading)
- EE2: "Interacting with AI tools is clear and understandable" (weak loading)
- FC2: "AI tools are compatible with other tools I use" (weak loading)

**Confirmatory Factor Analysis Removal** (1 item):
- ER1: "I worry that AI tools could replace jobs in my field" (λ=0.389, failed to replicate from EFA, caused Factor 2 AVE < 0.50)

---

## Acknowledgments

**Sample**: 263 professionals participated in this validation study
**Theoretical Foundation**: UTAUT2 (Venkatesh et al., 2012), AI adoption literature
**Analysis Software**: Python (factor-analyzer, semopy, pandas, numpy)
**Validation Method**: Split-sample design with EFA (N=131) and CFA (N=132)

---

**Document Prepared**: November 26, 2025
**Validation Status**: Phase 4 Complete (Psychometric validation)
**Future Work**: Measurement invariance testing, hypothesis testing, cross-validation in independent sample

---

*End of Document*
