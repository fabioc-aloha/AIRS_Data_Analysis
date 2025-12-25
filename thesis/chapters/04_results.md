# Chapter 4: Findings

## 4.1 Introduction

This chapter presents the empirical findings from the AI Readiness Survey (AIRS) study examining factors influencing AI tool adoption in higher education. The chapter is organized to progress systematically from sample description through data preparation, quantitative results, and findings organized by research question. All analyses were conducted using Python (factor_analyzer, semopy, scipy, pandas) with a significance level of α = .05 unless otherwise specified.

The presentation separates findings from interpretation, following established methodological practice (Yin, 2018). Theoretical and practical implications are addressed in Chapter 5.

## 4.2 Research Questions and Hypotheses Overview

This section provides a summary of all research questions examined in this dissertation. Detailed hypothesis testing results are presented in §4.5.

### 4.2.1 Primary Research Question

**RQ: How can UTAUT2 be extended with AI-specific constructs to better predict behavioral intention to adopt AI tools in professional and academic contexts?**

| Aspect | Answer | Evidence |
|--------|--------|----------|
| **Extension Approach** | UTAUT2 extended with AI Trust construct | 8-factor, 16-item validated diagnostic instrument |
| **Predictive Power** | Model explains 85.2% variance in BI | R² = .852 (8-factor model) |
| **Key Finding** | Traditional UTAUT predictors less important for AI | PE, EE, FC, HB non-significant |
| **AI-Specific Insight** | Value perception dominates over utility | PV strongest predictor (β = .505) |

### 4.2.2 Secondary Research Questions

| RQ# | Question | Answer | Supporting Evidence |
|-----|----------|--------|---------------------|
| **RQ1** | What is the factor structure of an AI-specific adoption readiness instrument? | 8-factor structure with 16 items | CFI = .975, TLI = .960, RMSEA = .065; all α > .74 |
| **RQ2** | Does the instrument demonstrate measurement invariance across populations? | Configural invariance achieved; metric invariance partial | ΔCFI = .003, ΔRMSEA = .004; mean Δλ = .082 |
| **RQ3** | Which factors most strongly predict behavioral intention? | Price Value (β = .505), Hedonic Motivation (β = .217), Social Influence (β = .136) | All p < .05; PV accounts for largest variance |
| **RQ4** | Does AI Trust predict adoption beyond UTAUT2? | Marginal effect, not statistically significant | β = .106, p = .064; provides diagnostic value |
| **RQ5** | What moderating factors influence predictor-intention relationships? | Experience moderates HM→BI; Population moderates HM→BI | HM×Exp p = .009; Academic vs Professional Δβ = .750 |

: Table 4.1: Research Questions Summary

*Source: Compiled by Author*

## 4.3 Description of the Sample

The sample comprises N=523 United States adults with representation from both academic and professional contexts. Table 4.2 presents the demographic composition.

### 4.3.1 Population Composition

| Population | n | % | Subgroups |
|------------|---|---|----------|
| Students | 216 | 41.3% | Full-time (n=196), Part-time (n=20) |
| Professionals | 307 | 58.7% | Individual contributors (n=112), Managers (n=71), Executives (n=52), Freelancers (n=32), Other (n=23), Unemployed (n=17) |

: Table 4.2: Sample Composition by Population Type

*Source: Compiled by Author*

### 4.3.2 Sample Split for Validation

For psychometric validation, the sample was randomly split (seed=67) into development (n=261, 50%) and holdout (n=262, 50%) subsamples. This split-sample approach enables exploratory factor analysis on the development sample and independent confirmatory factor analysis on the holdout sample.

### 4.3.3 Disability Status

Participants with disabilities comprised 13.0% of the sample (n=68), with 11 participants selecting "Prefer not to answer." This representation enables examination of accessibility considerations in AI adoption.

## 4.4 Data Screening and Preparation

### 4.4.1 Data Quality Assessment

Data screening confirmed the suitability of the dataset for factor analytic procedures:

- **Missing Data**: Complete case analysis with no missing values on key UTAUT constructs
- **Outliers**: Mahalanobis distance identified 0 multivariate outliers at p < .001
- **Normality**: Mardia's test indicated multivariate non-normality; robust estimation (MLM) was employed

### 4.4.2 Factorability Assessment

The Kaiser-Meyer-Olkin measure of sampling adequacy (KMO = .937) and Bartlett's test of sphericity (χ² = 4,668.45, p < .001) confirmed the suitability of the correlation matrix for factor analysis.

## 4.5 Quantitative Findings

This section presents the psychometric validation results, including exploratory and confirmatory factor analyses, reliability assessment, and measurement invariance testing.

### 4.5.1 Exploratory Factor Analysis (Development Sample)

Exploratory factor analysis was conducted on the development subsample (n=261) to evaluate the underlying factor structure of the AIRS instrument.

#### Model Selection Process

Multiple factor solutions were examined using principal axis factoring with oblimin rotation. The parallel analysis and scree plot suggested retention of 7-9 factors. Based on theoretical alignment with the extended UTAUT framework, the following models were evaluated:

| Model | Factors | Items | CFI (CFA) | TLI | RMSEA | SRMR | Decision |
|-------|---------|-------|-----------|-----|-------|------|----------|
| A | 7 | 21 | .938 | .923 | .078 | .058 | Poor fit |
| B | 8 | 20 | .952 | .940 | .070 | .052 | Adequate |
| C | 8 | 18 | .964 | .953 | .066 | .048 | Good |
| D | 8 | 16 | .975 | .960 | .065 | .046 | **Selected** |

: Table 4.3: Exploratory Factor Analysis Model Comparison

*Source: Compiled by Author*

**Model D** was selected as the final measurement model based on optimal balance of parsimony and fit, with all items demonstrating factor loadings ≥ .50 and no substantive cross-loadings (< .32). Figure 4.1 presents the scree plot supporting this factor structure.

![](figures/fig_efa_scree.png){width=80%}

*Figure 4.1. Scree plot showing eigenvalue decline across factors. The parallel analysis criterion (dashed line) supports retention of 8 factors. Source: Compiled by Author*

#### Construct Exclusion Analysis

Four proposed constructs were excluded during EFA due to poor inter-item reliability:

| Construct | Cronbach's α | Decision | Rationale |
|-----------|--------------|----------|----------|
| Voluntariness (VO) | .406 | Dropped | Items measured choice vs. freedom, distinct dimensions |
| Explainability (EX) | .582 | Dropped | Items measured understanding vs. preference, distinct facets |
| Ethical Risk (ER) | .546 | Dropped | Items measured job displacement vs. privacy, distinct risk types |
| AI Anxiety (AX) | .301 | Dropped | Items measured avoidance vs. approach anxiety, distinct motivations |

: Table 4.4: Construct Exclusion Analysis

*Source: Compiled by Author*

**Interpretation**: The proposed two-item scales for these AI-specific constructs proved insufficient to capture multi-faceted phenomena. This finding highlights a key contribution: while these constructs are theoretically important for AI adoption, they require more comprehensive operationalization with additional items representing each sub-dimension.

**Future Development**: All four dropped constructs require item redesign for future validation studies. For AI Anxiety specifically, future scales should distinguish between technology avoidance anxiety and fear-of-missing-out (FOMO) or obsolescence anxiety, as these represent conceptually distinct motivational orientations.

#### Final Factor Structure

The validated measurement model comprises 8 predictor factors (16 items) plus Behavioral Intention as the outcome variable (4 items):

**Predictor Factors (8 factors, 16 items)**:

The final measurement model comprises 7 UTAUT2 constructs plus the AI Trust extension:

| Factor | Items | Description | α | CR | AVE |
|--------|-------|-------------|-----|-----|-----|
| Performance Expectancy (PE) | PE1, PE2 | Perceived usefulness | .803 | .804 | .673 |
| Effort Expectancy (EE) | EE1, EE2 | Perceived ease of use | .859 | .861 | .756 |
| Social Influence (SI) | SI1, SI2 | Social normative pressure | .752 | .763 | .621 |
| Facilitating Conditions (FC) | FC1, FC2 | Organizational support | .743 | .750 | .601 |
| Hedonic Motivation (HM) | HM1, HM2 | Enjoyment and curiosity | .864 | .865 | .763 |
| Price Value (PV) | PV1, PV2 | Cost-benefit assessment | .883 | .883 | .790 |
| Habit (HB) | HB1, HB2 | Automaticity of use | .909 | .909 | .833 |
| AI Trust (TR) | TR1, TR2 | Trust in AI systems | .891 | .891 | .804 |

: Table 4.5: Final Factor Structure with Reliability and Validity Indices

*Source: Compiled by Author*

*Note: BI (Behavioral Intention) serves as the outcome variable and is modeled separately in the structural model.*

### 4.5.2 Confirmatory Factor Analysis (Holdout Sample)

The 8-factor model was cross-validated on the independent holdout sample (n=262) using confirmatory factor analysis in semopy.

#### Model Fit Assessment

| Index | Value | Threshold | Interpretation |
|-------|-------|-----------|----------------|
| χ² | 159.38 | - | - |
| df | 76 | - | - |
| χ²/df | 2.10 | < 3.0 | Excellent |
| CFI | .975 | ≥ .95 | Excellent |
| TLI | .960 | ≥ .95 | Excellent |
| RMSEA | .065 | ≤ .08 | Good |
| SRMR | .046 | ≤ .08 | Excellent |

: Table 4.6: Confirmatory Factor Analysis Model Fit Indices

*Source: Compiled by Author*

The model demonstrated excellent fit across all indices, confirming the factor structure derived from the development sample. Figure 4.2 presents the standardized factor loadings for the validated 8-factor model.

![](figures/fig_cfa_loadings.png){width=85%}

*Figure 4.2. Standardized factor loadings for the 8-factor AIRS measurement model. All loadings exceed .70, supporting convergent validity. Source: Compiled by Author*

#### Factor Correlations

Inter-factor correlations ranged from r = .25 (Social Influence × Price Value) to r = .72 (Hedonic Motivation × Performance Expectancy), indicating conceptually meaningful relationships while maintaining discriminant validity (all |r| < .85). Figure 4.3 presents the factor correlation matrix.

![](figures/fig_cfa_correlations.png){width=80%}

*Figure 4.3. Inter-factor correlations for the 8-factor AIRS model. All correlations fall below the .85 threshold for discriminant validity. Source: Compiled by Author*

### 4.5.3 Reliability and Validity

#### Composite Reliability

All predictor factors demonstrated acceptable internal consistency:

| Factor | Cronbach's α | Composite Reliability (CR) | AVE |
|--------|--------------|---------------------------|-----|
| PE | .803 | .804 | .673 |
| EE | .859 | .861 | .756 |
| SI | .752 | .763 | .621 |
| FC | .743 | .750 | .601 |
| HM | .864 | .865 | .763 |
| PV | .883 | .883 | .790 |
| HB | .909 | .909 | .833 |
| TR | .891 | .891 | .804 |

: Table 4.7: Composite Reliability and Validity Indices

*Source: Compiled by Author*

Figure 4.4 provides a visual comparison of reliability indices across constructs.

![](figures/fig_reliability.png){width=80%}

*Figure 4.4. Comparison of Cronbach's α, Composite Reliability (CR), and Average Variance Extracted (AVE) across the 8 AIRS factors. All factors exceed minimum thresholds (α > .70, CR > .70, AVE > .50). Source: Compiled by Author*

#### Convergent Validity

All standardized factor loadings exceeded .70, and all AVE values exceeded .50, supporting convergent validity (Fornell & Larcker, 1981).

#### Discriminant Validity

Discriminant validity was assessed using the Fornell-Larcker criterion. For each factor pair, the square root of AVE exceeded the inter-factor correlation, confirming discriminant validity.

### 4.5.4 Measurement Invariance (Multi-Group CFA)

Measurement invariance was tested across role groups (Academic n=216 vs. Professional n=307) to establish comparability of latent constructs.

| Group | χ² | df | CFI | TLI | RMSEA | Interpretation |
|-------|----|----|-----|-----|-------|----------------|
| Academic | 167.16 | 76 | .958 | .934 | .075 | Good fit |
| Professional | 135.88 | 76 | .988 | .981 | .051 | Excellent fit |

: Table 4.8: Measurement Invariance Testing Across Groups

*Source: Compiled by Author*

**Configural invariance** was supported: the same factor structure held across both groups. **Metric invariance** was not fully achieved (mean loading difference = .082, max = .326), indicating some factor loadings differ across groups. However, configural invariance is sufficient for comparing structural relationships across groups. The maximum factor loading difference (Δλ = .326) occurred for the SI factor, though this did not compromise overall model validity. Figure 4.5 illustrates the loading differences across groups.

![](figures/fig_invariance_loadings.png){width=85%}

*Figure 4.5. Factor loading comparison across Student and Professional groups. While most loadings demonstrate equivalence, Social Influence shows the largest cross-group difference. Source: Compiled by Author*



## 4.6 Findings by Research Question

This section presents hypothesis testing results organized by research question. The structural model was estimated using multi-group SEM to test hypothesized relationships between UTAUT constructs and Behavioral Intention to adopt AI tools. The model was estimated separately for Student (n=216) and Professional+Leader (n=307) groups.

### 4.6.1 Structural Model Fit

The structural model demonstrated acceptable fit:

| Index | Student | Professional+Leader | Threshold |
|-------|----------|---------------------|-----------|
| CFI | .968 | .972 | ≥ .95 |
| TLI | .954 | .958 | ≥ .95 |
| RMSEA | .072 | .068 | ≤ .08 |
| SRMR | .054 | .051 | ≤ .08 |

: Table 4.9: Structural Model Fit by Group

### 4.6.2 Primary Hypotheses (H1a–H1g)

Table 4.10 presents the standardized path coefficients, 95% confidence intervals, and hypothesis test results for the full sample.

#### Core UTAUT2 Hypotheses

| Hypothesis | Path | Prediction | β | p | 95% CI | Result |
|------------|------|------------|---|---|--------|--------|
| H1a | PE -> BI | Positive | -.028 | .791 | [-.234, .178] | **[X] Not Supported** |
| H1b | EE -> BI | Positive | -.008 | .875 | [-.108, .092] | **[X] Not Supported** |
| H1c | SI -> BI | Positive | **.136** | **.024** | [.018, .254] | **[OK] Supported** |
| H1d | FC -> BI | Positive | .059 | .338 | [-.062, .180] | **[X] Not Supported** |
| H1e | HM -> BI | Positive | **.217** | **.014** | [.044, .390] | **[OK] Supported** |
| H1f | PV -> BI | Positive | **.505** | **<.001** | [.352, .658] | **[OK] Supported (Strongest)** |
| H1g | HB -> BI | Positive | .023 | .631 | [-.071, .117] | **[X] Not Supported** |

: Table 4.10: UTAUT2 Core Hypotheses with Confidence Intervals

*Source: Compiled by Author*

#### AI Extension Hypothesis

| Hypothesis | Path | Prediction | β | p | 95% CI | Result |
|------------|------|------------|---|---|--------|--------|
| H2 | TR -> BI | Positive | .106 | .064 | [-.006, .218] | **[X] Marginal (Not Significant)** |

: Table 4.11: AI Trust Extension Hypothesis

*Source: Compiled by Author*

**UTAUT2 Summary**: 3 of 7 UTAUT2 hypotheses supported. Price Value emerged as dominant predictor, departing from traditional UTAUT findings where Performance Expectancy typically dominates.

**AI Trust Interpretation**: AI Trust approached but did not reach conventional significance (p = .064). However, the 8-factor model including AI Trust was retained as the recommended diagnostic instrument because: (1) Trust provides essential diagnostic capability for organizational assessment, (2) Organizations can identify trust deficits and design targeted interventions, and (3) The marginal effect suggests theoretical relevance warranting further investigation with larger samples.

**Key Findings:**

- **Price Value** emerged as the strongest predictor (β = .505, p < .001), explaining the largest portion of variance in Behavioral Intention
- **Hedonic Motivation** was the second strongest predictor (β = .217, p = .014)
- **Social Influence** was a significant positive predictor (β = .136, p = .024)
- **AI Trust** approached but did not reach significance (β = .106, p = .064)
- **Performance Expectancy**, **Effort Expectancy**, **Facilitating Conditions**, and **Habit** were not significant predictors
- Traditional UTAUT predictors showed unexpectedly weak effects, suggesting AI may represent a distinct technology category

Figure 4.6 summarizes the hypothesis test results for the structural model.

![](figures/fig_hypothesis_summary.png){width=90%}

*Figure 4.6. Summary of hypothesis test results. Green indicates supported hypotheses, red indicates unsupported, and yellow indicates marginal significance. Price Value emerged as the dominant predictor. Source: Compiled by Author*

### 4.6.3 Moderation Hypotheses (H3–H4)

Usage frequency was tested as a moderator of UTAUT relationships through multi-group SEM comparison.

#### Usage Group Path Comparison

| Predictor | β (Low Usage) | β (High Usage) | Interpretation |
|-----------|---------------|----------------|----------------|
| **PerfExp** | **0.371*** | -0.270 | PE matters for new users only |
| **PriceValue** | 0.224 | **0.878*** | PV stronger for heavy users |

#### Exploratory Experience Moderation (Regression Interactions)

| Moderator | Path | Interaction β | p | Status |
|-----------|------|---------------|---|--------|
| Experience | PE×Exp | 0.112 | .055 | [!] Marginal |
| **Experience** | **HM×Exp** | **0.136** | **.009** | **[OK] Significant** |
| Experience | EE×Exp | 0.122 | .161 | [X] Not significant |
| Experience | TR×Exp | 0.081 | .145 | [X] Not significant |

: Table 4.12: Experience Moderation Analysis Results

*Source: Compiled by Author*

**Interpretation:**

- **Experience moderates HM -> BI** (β = .136, p = .009): Experienced professionals (4+ years) weight hedonic motivation more heavily
- Usage-dependent mechanisms: Performance Expectancy matters for new users; Price Value for heavy users
- Habit is marginally moderated by usage frequency (p = .065)

Figure 4.7 illustrates the structural model with standardized path coefficients.

![](figures/fig_structural_paths.png){width=90%}

*Figure 4.7. Structural equation model showing standardized path coefficients from UTAUT2 predictors and AI Trust to Behavioral Intention. Solid lines indicate significant paths; dashed lines indicate non-significant paths. Source: Compiled by Author*

#### Population Moderation (H4)

Multi-group comparison tested whether structural path coefficients differed significantly between Student and Professional populations.

| Path | Student β | Professional β | Δβ | Moderation |
|------|------------|----------------|-----|------------|
| PE -> BI | -0.184 | 0.084 | 0.268 | No |
| EE -> BI | 0.073 | -0.055 | -0.128 | No |
| SI -> BI | 0.007 | 0.239 | 0.232 | No |
| FC -> BI | -0.016 | 0.141 | 0.156 | No |
| HM -> BI | 0.449 | -0.301 | -0.750 | [OK] (p = .041) |
| PV -> BI | 0.638 | 0.808 | 0.170 | No |
| HB -> BI | 0.075 | -0.064 | -0.140 | No |
| TR -> BI | -0.011 | 0.153 | 0.164 | No |

: Table 4.13: Population Moderation of Structural Paths

*Source: Compiled by Author*

**H3 Result: [!] Partially Supported** – Experience significantly moderates the HM -> BI path (p = .009). Professionals with 4+ years of experience weight hedonic motivation more heavily in AI adoption decisions.

**H4 Result: [!] Partially Supported** – Population significantly moderates HM -> BI (p = .041). Hedonic Motivation is substantially stronger for Academics (β = 0.449) than Professionals (β = -0.301), indicating that enjoyment of AI tools is more important for student adoption than professional adoption. All other paths showed no significant population differences. Figure 4.8 illustrates the experience moderation effect on hedonic motivation.

![](figures/fig_experience_moderation.png){width=80%}

*Figure 4.8. Experience moderation of the Hedonic Motivation -> Behavioral Intention path. The effect of HM on BI is stronger for professionals with 4+ years of experience. Source: Compiled by Author*

### 4.6.4 Incremental Validity: AIRS vs. UTAUT2-Only Model

To assess whether the AI-specific extension (AI Trust) provides incremental predictive validity beyond core UTAUT2 constructs, nested model comparison was conducted:

| Model | Constructs | AIC | BIC | Result |
|-------|------------|-----|-----|--------|
| UTAUT2-Only | PE, EE, SI, FC, HM, PV, HB | 148.58 | 192.34 | Preferred |
| AIRS (Extended) | PE, EE, SI, FC, HM, PV, HB, TR | 150.59 | 201.87 | Not preferred |

**Result**: Although AI Trust showed a marginal effect (β = .106, p = .064), the AIRS model has *higher* AIC (150.59) than UTAUT2-only (148.58), meaning the simpler model is preferred (ΔAIC = +2.01). Lower AIC indicates better parsimony.

**Interpretation**: This incremental validity test evaluates **predictive parsimony** only. AI Trust may still have **diagnostic value** for identifying trust-related barriers to AI adoption, even if it doesn't improve overall model fit. The marginal significance of AI Trust (p = .064) suggests it may achieve significance with larger samples or in contexts where trust concerns are more salient.

### 4.6.5 Variance Explained

The structural models explained substantial variance in Behavioral Intention:

| Model | R² | Interpretation |
|-------|----|--------------|
| UTAUT2-Only (7 predictors) | .861 | 86.1% variance explained |
| UTAUT2 + AI Trust (8 predictors) | .852 | 85.2% variance explained |

Both models demonstrate exceptionally high R² values, indicating that the UTAUT2 framework captures the vast majority of systematic variance in intention to use AI tools. While the UTAUT2-only model achieves marginally higher R², the 8-factor model including AI Trust is recommended as the diagnostic instrument because the trust construct enables practical intervention design: organizations can identify trust deficits and implement targeted confidence-building strategies, a capability essential for translating research into organizational practice.



### 4.6.6 Supplementary Analyses

#### Mediation Hypotheses

**Design Note**: The originally hypothesized mediation paths (EX -> TR -> BI, ER -> TR -> BI) were **not testable** because Explainability (EX), Ethical Risk (ER), and Anxiety (AX) were excluded from the final model due to inadequate item reliability identified in Phase 1 (α = .301–.582).

**Exploratory Mediation Analysis**: Bootstrap mediation testing explored whether AI Trust mediates the effect of Effort Expectancy on Behavioral Intention:

| Mediation Path | Indirect Effect | 95% CI | p | Result |
|----------------|-----------------|--------|---|--------|
| EE -> TR -> BI | 0.232 | [-.023, .474] | > .05 | [X] Not Significant |

The confidence interval includes zero, indicating no significant mediation. While the theoretical pathway remains conceptually relevant, adding AI Trust as a mediator does not significantly improve the model.

### 4.6.7 Behavioral Validation Hypotheses (H5–H6)

Analysis of actual tool usage behaviors provides behavioral validation of intention constructs.

#### Tool Usage Frequency

| AI Tool | Mean Usage | Never Used (%) | Active Use (%) | Leader Effect (d) |
|---------|------------|----------------|----------------|-------------------|
| ChatGPT | 3.03 | 23.9 | 64.2 | 0.74 |
| Microsoft Copilot | 2.49 | 36.1 | 48.4 | 1.14 |
| Google Bard/Gemini | 2.48 | 36.5 | 47.6 | 0.90 |
| Other AI Tools | 1.93 | 53.3 | 30.0 | 0.78 |

*Note: Active Use = "Sometimes" or more frequent usage (≥3 on 5-point scale). Leader Effect = Cohen's d comparing Leaders (Managers/Executives) vs Professionals.*

**Leadership Dominance:** Leaders demonstrated significantly higher usage across ALL tool categories (d = 0.74–1.14), with the largest effect for Microsoft Copilot.

#### Tool Usage and Behavioral Intention (H5)

The relationship between tool usage frequency and Behavioral Intention was examined using Spearman correlation due to ordinal tool usage distributions.

| Relationship | ρ | p | Interpretation |
|-------------|---|---|----------------|
| Total Usage × BI | .69 | <.001 | Strong positive |
| ChatGPT Usage × BI | .57 | <.001 | Strong positive |
| MS Copilot Usage × BI | .54 | <.001 | Moderate positive |
| Gemini Usage × BI | .52 | <.001 | Moderate positive |

**H5 Result: [OK] Supported** – Higher behavioral intention is strongly associated with more frequent AI tool usage.

#### Role Differences in Tool Usage (H6)

One-way ANOVA with Tukey post-hoc tests examined role differences in tool usage patterns.

| Measure | F(2,520) | p | η² | Post-hoc (Tukey) |
|---------|----------|---|----|--------------------|
| Tool Breadth | 18.42 | <.001 | .066 | L > P > A |
| Usage Frequency | 22.15 | <.001 | .078 | L > P > A |
| Usage Intensity | 15.87 | <.001 | .058 | L > P > A |

**H6 Result: [OK] Supported** – Leaders demonstrate significantly higher tool usage than Professionals, who in turn exceed Academics.

#### Industry Experience Effect

Among professionals (n=184), correlation between years of industry experience and UTAUT constructs was examined.

| Construct | r | p |
|-----------|---|---|
| Performance Expectancy | .10 | .176 |
| Behavioral Intention | .08 | .284 |
| Anxiety | -.12 | .104 |

Industry experience showed weak, non-significant relationships with UTAUT constructs, suggesting organizational role rather than industry tenure drives AI readiness differences.



### 4.6.8 Exploratory Findings

#### User Typology (Cluster Analysis)

K-means cluster analysis (k=4) identified distinct user profiles based on UTAUT construct scores.

| Cluster | n | % | PE | HM | AX | BI | Characterization |
|---------|---|---|----|----|----|----|------------------|
| Enthusiasts | 84 | 16% | High | High | Low | High | Early adopters, high engagement |
| Cautious Adopters | 157 | 30% | Mod | Mod | Mod | Mod | Pragmatic, wait-and-see |
| Moderate Users | 191 | 37% | Mod | Low | Mod | Low-Mod | Limited engagement, neutral |
| Anxious Avoiders | 91 | 17% | Low | Low | High | Low | Resistant, anxiety-driven |

#### Disability Status Analysis

Participants with disabilities (n=68, 13.0%) were compared to those without (n=444):

| Construct | Disability M | No Disability M | t | p | d |
|-----------|--------------|-----------------|---|---|---|
| AX | 3.68 | 3.35 | 2.77 | .006 | 0.36 |
| EE | 3.45 | 3.67 | -1.75 | .080 | 0.23 |
| BI | 3.01 | 3.23 | -1.54 | .124 | 0.20 |

*Note: 11 participants selected "Prefer not to answer" and were excluded from this analysis.*

**Key Finding:** Individuals with disabilities reported significantly higher AI-related anxiety (d = 0.36, p = .006), highlighting the importance of accessible and inclusive AI implementation strategies.

#### Qualitative Findings

Open-ended responses (n=243, 46.5% response rate) were analyzed using thematic analysis.

#### Theme Prevalence

| Theme | n | % of Responses |
|-------|---|----------------|
| Positive Experience | 60 | 24.7% |
| Work/Productivity | 47 | 19.3% |
| Human Element | 33 | 13.6% |
| Learning/Education | 33 | 13.6% |
| Accuracy/Reliability | 26 | 10.7% |
| Future/Potential | 14 | 5.8% |
| Concerns/Caution | 14 | 5.8% |
| Ethics/Privacy | 13 | 5.3% |
| Cost/Access | 6 | 2.5% |
| Job Replacement | 4 | 1.6% |

*Note: Responses could be coded to multiple themes (average 1.03 themes per response). 85 responses (35.0%) had no identified themes.*

#### Role Differences in Qualitative Themes

Chi-square tests (3-group: Student n=94, Professional n=83, Leader n=66) identified three themes with significant role differences:

| Theme | Student % | Professional % | Leader % | χ² | p | V |
|-------|------------|----------------|----------|----|----|---|
| Positive Experience | 29.8% | 14.5% | 30.3% | 7.11 | .029 | .17 |
| Learning/Education | 21.3% | 10.8% | 6.1% | 8.45 | .015 | .19 |
| Work/Productivity | 28.7% | 13.3% | 13.6% | 8.65 | .013 | .19 |

Academics and Leaders reported more positive experiences, while Academics focused more on educational applications.



## 4.7 Summary of Findings

### 4.7.1 Comprehensive Hypothesis Outcome Summary

| Category | Hypotheses | Supported | Partial | Not Supported |
|----------|------------|-----------|---------|---------------|
| **UTAUT2 Core (H1a-g)** | 7 | 3 (43%) | 0 | 4 (57%) |
| **AI Extension (H2)** | 1 | 0 | 1 (marginal) | 0 |
| **Moderation (H3-H4)** | 2 | 0 | 2 (100%) | 0 |
| **Behavioral (H5-H6)** | 2 | 2 (100%) | 0 | 0 |
| **TOTAL** | **12** | **5 (42%)** | **3 (25%)** | **4 (33%)** |

: Table 4.14: Comprehensive Hypothesis Outcome Summary

*Source: Compiled by Author*

### 4.7.2 Hypothesis Details

| Hypothesis | Description | Result |
|------------|-------------|--------|
| H1a | PE -> BI (+) | [X] Not Supported (β = -.028) |
| H1b | EE -> BI (+) | [X] Not Supported (β = -.008) |
| H1c | SI -> BI (+) | [OK] Supported (β = .136) |
| H1d | FC -> BI (+) | [X] Not Supported (β = .059) |
| H1e | HM -> BI (+) | [OK] Supported (β = .217) |
| H1f | PV -> BI (+) | [OK] Supported (β = .505) |
| H1g | HB -> BI (+) | [X] Not Supported (β = .023) |
| H2 | TR -> BI (+) | [X] Marginal (p = .064) |
| H3 | Experience moderates paths | [!] Partial (HM×Exp significant, p = .009) |
| H4 | Role group moderates paths | [!] Partial (HM only, p = .041) |
| H5 | BI -> Tool Usage | [OK] Supported (ρ = .69) |
| H6 | Role usage differences | [OK] Supported (F = 22.15, p < .001) |

### 4.7.3 Key Contributions

1. **Price Value Dominance:** PV is the overwhelming driver of AI adoption intention (β = .505), substantially exceeding other predictors and departing from traditional UTAUT findings where PE typically dominates

2. **Experience Moderation Pattern:** AI experience amplifies the effect of HM (p = .007), suggesting experiential learning reinforces enjoyment perceptions

3. **Population Moderation:** Hedonic Motivation is significantly stronger for Academics (β = 0.449) than Professionals (β = -0.301), indicating role-specific adoption drivers

4. **Non-Significance of Traditional UTAUT Predictors:** PE, EE, FC, and HB were not significant, suggesting AI may represent a distinct technology category where cost-value considerations outweigh traditional utility perceptions

5. **User Typology:** Four distinct adoption profiles (Enthusiasts, Cautious Adopters, Moderate Users, Anxious Avoiders) with predictable demographic and attitudinal correlates

### 4.7.4 Unexpected Findings

- **Non-significant Performance Expectancy:** Contrary to UTAUT predictions and meta-analytic findings, perceived usefulness did not significantly predict adoption intention (β = -.028, p = .791), possibly because utility is a baseline expectation for AI tools
- **Non-significant Effort Expectancy:** Perceived ease of use did not significantly predict adoption intention, possibly due to the user-friendly nature of modern AI interfaces
- **Price Value as Strongest Predictor:** The dominance of cost-value perceptions over utility perceptions represents a notable departure from prior UTAUT research

## 4.8 Chapter Conclusion

This chapter presented comprehensive empirical validation of the AIRS diagnostic instrument and structural model examining AI adoption in higher education. The 8-factor, 16-item measurement model demonstrated excellent psychometric properties (CFI = .975, α range .74–.91) with configural invariance across role groups. The 8-factor structure was selected over a more parsimonious 7-factor alternative because AI Trust provides essential diagnostic capability: the instrument enables identification of specific adoption barriers (trust deficits, value perceptions, social influence gaps) that inform targeted intervention design.

Structural equation modeling revealed Price Value as the dominant predictor of Behavioral Intention (β = .505), followed by Hedonic Motivation (β = .217, p = .014) and Social Influence (β = .136, p = .024). AI Trust approached but did not reach significance (β = .106, p = .064). Notably, traditional UTAUT predictors including Performance Expectancy, Effort Expectancy, Facilitating Conditions, and Habit were not significant, suggesting AI tools may represent a distinct technology category. Experience moderated the HM pathway, while population moderated HM effects with academics weighting enjoyment more heavily than professionals.

Exploratory analyses identified four user typologies and qualitative themes reflecting both enthusiasm and concern about AI integration in higher education. These findings provide a robust foundation for the theoretical and practical implications discussed in Chapter 5.
