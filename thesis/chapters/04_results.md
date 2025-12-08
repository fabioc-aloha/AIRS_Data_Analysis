# Chapter 4: Results

## 4.1 Introduction

This chapter presents the empirical findings from the AI Readiness Survey (AIRS) study examining factors influencing AI tool adoption in higher education. The analysis progresses systematically from scale validation through hypothesis testing to exploratory findings. All analyses were conducted using Python (factor_analyzer, semopy, scipy, pandas) with a significance level of α = .05 unless otherwise specified.

The sample comprises N=523 United States adults, classified by population into Students (n=216, 41.3%; full-time n=196, part-time n=20) and Professionals (n=307, 58.7%; individual contributors n=112, managers n=71, executives n=52, freelancers n=32, other n=23, unemployed n=17). For psychometric validation, the sample was randomly split (seed=67) into development (n=261, 50%) and holdout (n=262, 50%) subsamples.



## 4.2 Psychometric Validation

### 4.2.1 Exploratory Factor Analysis (Development Sample)

Exploratory factor analysis was conducted on the development subsample (n=261) to evaluate the underlying factor structure of the AIRS instrument. The Kaiser-Meyer-Olkin measure of sampling adequacy (KMO = .918) and Bartlett's test of sphericity (χ² = 4,827.42, p < .001) confirmed the suitability of the correlation matrix for factor analysis.

#### Model Selection Process

Multiple factor solutions were examined using principal axis factoring with oblimin rotation. The parallel analysis and scree plot suggested retention of 7-9 factors. Based on theoretical alignment with the extended UTAUT framework, the following models were evaluated:

| Model | Factors | Items | CFI (CFA) | TLI | RMSEA | SRMR | Decision |
|-------|---------|-------|-----------|-----|-------|------|----------|
| A | 7 | 21 | .938 | .923 | .078 | .058 | Poor fit |
| B | 8 | 20 | .952 | .940 | .070 | .052 | Adequate |
| C | 8 | 18 | .964 | .953 | .066 | .048 | Good |
| D | 8 | 16 | .975 | .960 | .065 | .048 | **Selected** |

**Model D** was selected as the final measurement model based on optimal balance of parsimony and fit, with all items demonstrating factor loadings ≥ .50 and no substantive cross-loadings (< .32).

#### Construct Exclusion Analysis

Four proposed constructs were excluded during EFA due to poor inter-item reliability:

| Construct | Cronbach's α | Decision | Rationale |
|-----------|--------------|----------|----------|
| Voluntariness (VO) | .41 | Dropped | Items measured choice vs. freedom—distinct dimensions |
| Explainability (EX) | .58 | Dropped | Items measured understanding vs. preference—distinct facets |
| Ethical Risk (ER) | .55 | Dropped | Items measured job displacement vs. privacy—distinct risk types |
| AI Anxiety (AX) | .30 (original) | Reconstructed | Items measured avoidance vs. approach anxiety |

**Interpretation**: The proposed two-item scales for these AI-specific constructs proved insufficient to capture multi-faceted phenomena. This finding highlights a key contribution: while these constructs are theoretically important for AI adoption, they require more comprehensive operationalization with additional items representing each sub-dimension.

**Anxiety Reconstruction**: The Anxiety construct was successfully retained after item revision, achieving acceptable reliability (α = .86) in the final model. The reconstructed AX items focus on apprehension and concern about AI technology, avoiding the original conflation of avoidance and approach motivations.

#### Final Factor Structure

The validated 8-factor, 16-item structure comprises:

| Factor | Items | Description | Sample Loading |
|--------|-------|-------------|----------------|
| Performance Expectancy (PE) | 2 | Perceived usefulness | .82 |
| Effort Expectancy (EE) | 2 | Perceived ease of use | .78 |
| Social Influence (SI) | 2 | Social normative pressure | .75 |
| Facilitating Conditions (FC) | 2 | Organizational support | .73 |
| Hedonic Motivation (HM) | 2 | Enjoyment and curiosity | .81 |
| Trust (TR) | 2 | Trust in AI systems | .77 |
| Anxiety (AX) | 2 | AI-related apprehension | .84 |
| Behavioral Intention (BI) | 2 | Intent to adopt AI tools | .89 |

### 4.2.2 Confirmatory Factor Analysis (Holdout Sample)

The 8-factor model was cross-validated on the independent holdout sample (n=262) using confirmatory factor analysis in semopy.

#### Model Fit Assessment

| Index | Value | Threshold | Interpretation |
|-------|-------|-----------|----------------|
| χ² | 142.68 | — | — |
| df | 76 | — | — |
| χ²/df | 1.88 | < 3.0 | Excellent |
| CFI | .975 | ≥ .95 | Excellent |
| TLI | .960 | ≥ .95 | Excellent |
| RMSEA | .065 | ≤ .08 | Good |
| SRMR | .048 | ≤ .08 | Excellent |

The model demonstrated excellent fit across all indices, confirming the factor structure derived from the development sample.

#### Factor Correlations

Inter-factor correlations ranged from r = -.42 (Anxiety × Performance Expectancy) to r = .78 (Performance Expectancy × Behavioral Intention), indicating conceptually meaningful relationships while maintaining discriminant validity (all |r| < .85).

### 4.2.3 Reliability and Validity

#### Composite Reliability

All factors demonstrated acceptable internal consistency:

| Factor | Cronbach's α | Composite Reliability (CR) | AVE |
|--------|--------------|---------------------------|-----|
| PE | .85 | .86 | .76 |
| EE | .81 | .82 | .70 |
| SI | .79 | .80 | .67 |
| FC | .76 | .77 | .63 |
| HM | .84 | .85 | .74 |
| TR | .80 | .81 | .68 |
| AX | .86 | .87 | .77 |
| BI | .91 | .92 | .85 |

#### Convergent Validity

All standardized factor loadings exceeded .70, and all AVE values exceeded .50, supporting convergent validity (Fornell & Larcker, 1981).

#### Discriminant Validity

Discriminant validity was assessed using the Fornell-Larcker criterion. For each factor pair, the square root of AVE exceeded the inter-factor correlation, confirming discriminant validity.

### 4.2.4 Measurement Invariance (Multi-Group CFA)

Measurement invariance was tested across role groups (Student vs. Professional+Leader) to establish comparability of latent constructs.

| Level | χ² | df | Δχ² | Δdf | p | ΔCFI | Decision |
|-------|----|----|-----|-----|---|------|----------|
| Configural | 284.21 | 152 | — | — | — | — | Baseline |
| Metric | 292.45 | 160 | 8.24 | 8 | .411 | -.002 | Supported |
| Scalar | 308.67 | 168 | 16.22 | 8 | .039 | -.006 | Partial |

Full configural and metric invariance were supported. Partial scalar invariance was achieved after releasing constraints on two intercepts (SI2, AX1). The maximum factor loading difference across groups (Δλ = .33) occurred for the SI factor, though this did not compromise invariance conclusions using established criteria (ΔCFI < .01; Chen, 2007).



## 4.3 Hypothesis Testing (Structural Model)

The structural model was estimated using multi-group SEM to test hypothesized relationships between UTAUT constructs and Behavioral Intention to adopt AI tools. The model was estimated separately for Student (n=216) and Professional+Leader (n=307) groups.

### 4.3.1 Structural Model Fit

The structural model demonstrated acceptable fit:

| Index | Student | Professional+Leader | Threshold |
|-------|----------|---------------------|-----------|
| CFI | .968 | .972 | ≥ .95 |
| TLI | .954 | .958 | ≥ .95 |
| RMSEA | .072 | .068 | ≤ .08 |
| SRMR | .054 | .051 | ≤ .08 |

### 4.3.2 Primary Hypotheses (H1a–H1g)

Table 4.1 presents the standardized path coefficients and hypothesis test results for the full sample and by role group.

| Hypothesis | Path | β | p | Result |
|------------|------|---|---|--------|
| H1a | PE → BI | -.028 | .791 | ❌ Not Supported |
| H1b | EE → BI | -.008 | .875 | ❌ Not Supported |
| H1c | SI → BI | **.136** | .024 | ✅ Supported |
| H1d | FC → BI | .059 | .338 | ❌ Not Supported |
| H1e | HM → BI | **.217** | .014 | ✅ Supported |
| H1f | PV → BI | **.505** | <.001 | ✅ Supported (Strongest) |
| H1g | HB → BI | .023 | .631 | ❌ Not Supported |
| H2 | TR → BI | .106 | .064 | ❌ Marginal |

**Key Findings:**

- **Price Value** emerged as the strongest predictor (β = .505, p < .001), explaining the largest portion of variance in Behavioral Intention
- **Hedonic Motivation** was the second strongest predictor (β = .217, p = .014)
- **Social Influence** was a significant positive predictor (β = .136, p = .024)
- **AI Trust** approached but did not reach significance (β = .106, p = .064)
- **Performance Expectancy**, **Effort Expectancy**, **Facilitating Conditions**, and **Habit** were not significant predictors
- Traditional UTAUT predictors showed unexpectedly weak effects, suggesting AI may represent a distinct technology category

### 4.3.3 Moderation Hypotheses

Usage frequency was tested as a moderator of UTAUT relationships through multi-group SEM comparison.

#### Usage Group Path Comparison

| Predictor | β (Low Usage) | β (High Usage) | Interpretation |
|-----------|---------------|----------------|----------------|
| **PerfExp** | **0.371*** | -0.270 | PE matters for new users only |
| **PriceValue** | 0.224 | **0.878*** | PV stronger for heavy users |

#### Exploratory Experience Moderation (Regression Interactions)

| Moderator | Path | Interaction β | p | Status |
|-----------|------|---------------|---|--------|
| Experience | PE×Exp | 0.112 | .055 | ⚠️ Marginal |
| **Experience** | **HM×Exp** | **0.136** | **.007** | **✅ Significant** |
| Experience | EE×Exp | 0.122 | .161 | ❌ Not significant |
| Experience | TR×Exp | 0.081 | .145 | ❌ Not significant |

**Interpretation:**

- **Experience moderates HM → BI** (β = .136, p = .007): Experienced professionals (4+ years) weight hedonic motivation more heavily
- Usage-dependent mechanisms: Performance Expectancy matters for new users; Price Value for heavy users
- Habit is marginally moderated by usage frequency (p = .065)

### 4.3.4 Population Moderation

Multi-group comparison tested whether structural path coefficients differed significantly between Student and Professional populations.

| Path | Student β | Professional β | Δβ | Moderation |
|------|------------|----------------|-----|------------|
| PE → BI | -0.184 | 0.084 | 0.268 | No |
| EE → BI | 0.073 | -0.055 | -0.128 | No |
| SI → BI | 0.007 | 0.239 | 0.232 | No |
| FC → BI | -0.016 | 0.141 | 0.156 | No |
| HM → BI | 0.449 | -0.301 | -0.750 | ✓ (p = .041) |
| PV → BI | 0.638 | 0.808 | 0.170 | No |
| HB → BI | 0.075 | -0.064 | -0.140 | No |
| TR → BI | -0.011 | 0.153 | 0.164 | No |

Population moderation was partially supported. **Hedonic Motivation** showed a significant population difference (Δβ = -0.750, p = .041), with HM → BI stronger for Students (β = 0.449) than for Professionals (β = -0.301). This suggests enjoyment of AI tools is more important for student adoption than professional adoption. All other paths showed no significant population differences.

### 4.3.5 Incremental Validity: AIRS vs. UTAUT2-Only Model

To assess whether the AI-specific extension (AI Trust) provides incremental predictive validity beyond core UTAUT2 constructs, nested model comparison was conducted:

| Model | Constructs | AIC | BIC | Result |
|-------|------------|-----|-----|--------|
| UTAUT2-Only | PE, EE, SI, FC, HM, PV, HB | 148.58 | 192.34 | Preferred |
| AIRS (Extended) | PE, EE, SI, FC, HM, PV, HB, TR | 150.59 | 201.87 | — |

**Result**: H3 was not supported. Although AI Trust showed a marginal effect (β = .106, p = .064), the AIRS model has *higher* AIC (150.59) than UTAUT2-only (148.58), meaning the simpler model is preferred (ΔAIC = +2.01). Lower AIC indicates better parsimony.

**Interpretation**: H3 evaluates **predictive parsimony** only—AI Trust may still have **diagnostic value** for identifying trust-related barriers to AI adoption, even if it doesn't improve overall model fit. The marginal significance of AI Trust (p = .064) suggests it may achieve significance with larger samples or in contexts where trust concerns are more salient.

### 4.3.6 Variance Explained

The structural model explained substantial variance in Behavioral Intention:

| Group | R² | Interpretation |
|-------|----|--------------|
| Student | .861 | 86.1% variance explained |
| Professional+Leader | .852 | 85.2% variance explained |
| **Full Sample** | **.857** | **85.7% variance explained** |

This exceptionally high R² indicates the UTAUT model, as adapted for AI adoption, captures the vast majority of systematic variance in intention to use AI tools.



## 4.4 Supplementary Analyses

### 4.4.1 Mediation Hypotheses

**Design Note**: The originally hypothesized mediation paths (EX → TR → BI, ER → TR → BI) were **not testable** because Explainability (EX), Ethical Risk (ER), and Anxiety (AX) were excluded from the final model due to inadequate item reliability identified in Phase 1 (α = .30–.58).

**Exploratory Mediation Analysis**: Bootstrap mediation testing explored whether AI Trust mediates the effect of Effort Expectancy on Behavioral Intention:

| Mediation Path | Indirect Effect | 95% CI | p | Result |
|----------------|-----------------|--------|---|--------|
| EE → TR → BI | 0.204 | [-.039, .430] | > .05 | ❌ Not Significant |

The confidence interval includes zero, indicating no significant mediation. While the theoretical pathway remains conceptually relevant, adding AI Trust as a mediator does not significantly improve the model.

### 4.4.2 AI Tool Usage Patterns (H4, H5)

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

#### Tool Usage and Behavioral Intention (H4)

The relationship between tool usage frequency and Behavioral Intention was examined using Spearman correlation due to ordinal tool usage distributions.

| Relationship | ρ | p | Interpretation |
|-------------|---|---|----------------|
| Total Usage × BI | .69 | <.001 | Strong positive |
| ChatGPT Usage × BI | .57 | <.001 | Strong positive |
| MS Copilot Usage × BI | .54 | <.001 | Moderate positive |
| Gemini Usage × BI | .52 | <.001 | Moderate positive |

**H4 Result: ✅ Supported** – Higher behavioral intention is strongly associated with more frequent AI tool usage.

#### Role Differences in Tool Usage (H5)

One-way ANOVA with Tukey post-hoc tests examined role differences in tool usage patterns.

| Measure | F(2,520) | p | η² | Post-hoc (Tukey) |
|---------|----------|---|----|--------------------|
| Tool Breadth | 18.42 | <.001 | .066 | L > P > A |
| Usage Frequency | 22.15 | <.001 | .078 | L > P > A |
| Usage Intensity | 15.87 | <.001 | .058 | L > P > A |

**H5 Result: ✅ Supported** – Leaders demonstrate significantly higher tool usage than Professionals, who in turn exceed Academics.

### 4.4.3 Industry Experience Effect

Among professionals (n=184), correlation between years of industry experience and UTAUT constructs was examined.

| Construct | r | p |
|-----------|---|---|
| Performance Expectancy | .10 | .176 |
| Behavioral Intention | .08 | .284 |
| Anxiety | -.12 | .104 |

Industry experience showed weak, non-significant relationships with UTAUT constructs, suggesting organizational role rather than industry tenure drives AI readiness differences.



## 4.5 Exploratory Findings

### 4.5.1 User Typology (Cluster Analysis)

K-means cluster analysis (k=4) identified distinct user profiles based on UTAUT construct scores.

| Cluster | n | % | PE | HM | AX | BI | Characterization |
|---------|---|---|----|----|----|----|------------------|
| Enthusiasts | 84 | 16% | High | High | Low | High | Early adopters, high engagement |
| Cautious Adopters | 157 | 30% | Mod | Mod | Mod | Mod | Pragmatic, wait-and-see |
| Moderate Users | 191 | 37% | Mod | Low | Mod | Low-Mod | Limited engagement, neutral |
| Anxious Avoiders | 91 | 17% | Low | Low | High | Low | Resistant, anxiety-driven |

### 4.5.2 Disability Status

Participants with disabilities (n=68, 13.0%) were compared to those without (n=444):

| Construct | Disability M | No Disability M | t | p | d |
|-----------|--------------|-----------------|---|---|---|
| AX | 3.68 | 3.35 | 2.77 | .006 | 0.36 |
| EE | 3.45 | 3.67 | -1.75 | .080 | 0.23 |
| BI | 3.01 | 3.23 | -1.54 | .124 | 0.20 |

*Note: 11 participants selected "Prefer not to answer" and were excluded from this analysis.*

**Key Finding:** Individuals with disabilities reported significantly higher AI-related anxiety (d = 0.36, p = .006), highlighting the importance of accessible and inclusive AI implementation strategies.

### 4.5.3 Qualitative Findings

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



## 4.6 Summary of Findings

### 4.6.1 Hypothesis Summary

| Hypothesis | Description | Result |
|------------|-------------|--------|
| H1a | PE → BI (+) | ❌ Not Supported (β = -.028) |
| H1b | EE → BI (+) | ❌ Not Supported (β = -.008) |
| H1c | SI → BI (+) | ✅ Supported (β = .136) |
| H1d | FC → BI (+) | ❌ Not Supported (β = .059) |
| H1e | HM → BI (+) | ✅ Supported (β = .217) |
| H1f | PV → BI (+) | ✅ Supported (β = .505) |
| H1g | HB → BI (+) | ❌ Not Supported (β = .023) |
| H2 | TR → BI (+) | ❌ Marginal (p = .064) |
| H3 | AIRS > UTAUT2 (parsimony) | ❌ Not Supported (ΔAIC = +2.01) |
| H4 | Population moderates paths | ⚠️ Partial (HM only, p = .041) |

### 4.6.2 Key Contributions

1. **Price Value Dominance:** PV is the overwhelming driver of AI adoption intention (β = .505), substantially exceeding other predictors and departing from traditional UTAUT findings where PE typically dominates

2. **Experience Moderation Pattern:** AI experience amplifies the effect of HM (p = .007), suggesting experiential learning reinforces enjoyment perceptions

3. **Population Moderation:** Hedonic Motivation is significantly stronger for Academics (β = 0.449) than Professionals (β = -0.301), indicating role-specific adoption drivers

4. **Non-Significance of Traditional UTAUT Predictors:** PE, EE, FC, and HB were not significant, suggesting AI may represent a distinct technology category where cost-value considerations outweigh traditional utility perceptions

5. **User Typology:** Four distinct adoption profiles (Enthusiasts, Cautious Adopters, Moderate Users, Anxious Avoiders) with predictable demographic and attitudinal correlates

### 4.6.3 Unexpected Findings

- **Non-significant Performance Expectancy:** Contrary to UTAUT predictions and meta-analytic findings, perceived usefulness did not significantly predict adoption intention (β = -.028, p = .791), possibly because utility is a baseline expectation for AI tools
- **Non-significant Effort Expectancy:** Perceived ease of use did not significantly predict adoption intention, possibly due to the user-friendly nature of modern AI interfaces
- **Price Value as Strongest Predictor:** The dominance of cost-value perceptions over utility perceptions represents a notable departure from prior UTAUT research

## 4.7 Chapter Conclusion

This chapter presented comprehensive empirical validation of the AIRS instrument and structural model examining AI adoption in higher education. The 8-factor, 16-item measurement model demonstrated excellent psychometric properties (CFI = .975, α range .76–.91) with partial scalar invariance across role groups.

Structural equation modeling revealed Price Value as the dominant predictor of Behavioral Intention (β = .505), followed by Hedonic Motivation (β = .217, p = .014) and Social Influence (β = .136, p = .024). AI Trust approached but did not reach significance (β = .106, p = .064). Notably, traditional UTAUT predictors including Performance Expectancy, Effort Expectancy, Facilitating Conditions, and Habit were not significant, suggesting AI tools may represent a distinct technology category. Experience moderated the HM pathway, while population moderated HM effects with academics weighting enjoyment more heavily than professionals.

Exploratory analyses identified four user typologies and qualitative themes reflecting both enthusiasm and concern about AI integration in higher education. These findings provide a robust foundation for the theoretical and practical implications discussed in Chapter 5.
