# Chapter 4: Results

## 4.1 Introduction

This chapter presents the empirical findings from the AI Readiness Survey (AIRS) study examining factors influencing AI tool adoption in higher education. The analysis progresses systematically from scale validation through hypothesis testing to exploratory findings. All analyses were conducted using Python (factor_analyzer, semopy, scipy, pandas) with a significance level of α = .05 unless otherwise specified.

The sample comprises N=523 respondents from a UK higher education institution, classified by role into Academic staff (n=216, 41.3%), Professional Services staff (n=184, 35.2%), and Leadership/Management (n=123, 23.5%). For psychometric validation, the sample was randomly split (seed=67) into development (n=261, 50%) and holdout (n=262, 50%) subsamples.

---

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

Measurement invariance was tested across role groups (Academic vs. Professional+Leader) to establish comparability of latent constructs.

| Level | χ² | df | Δχ² | Δdf | p | ΔCFI | Decision |
|-------|----|----|-----|-----|---|------|----------|
| Configural | 284.21 | 152 | — | — | — | — | Baseline |
| Metric | 292.45 | 160 | 8.24 | 8 | .411 | -.002 | Supported |
| Scalar | 308.67 | 168 | 16.22 | 8 | .039 | -.006 | Partial |

Full configural and metric invariance were supported. Partial scalar invariance was achieved after releasing constraints on two intercepts (SI2, AX1). The maximum factor loading difference across groups (Δλ = .33) occurred for the SI factor, though this did not compromise invariance conclusions using established criteria (ΔCFI < .01; Chen, 2007).

---

## 4.3 Hypothesis Testing (Structural Model)

The structural model was estimated using multi-group SEM to test hypothesized relationships between UTAUT constructs and Behavioral Intention to adopt AI tools. The model was estimated separately for Academic (n=216) and Professional+Leader (n=307) groups.

### 4.3.1 Structural Model Fit

The structural model demonstrated acceptable fit:

| Index | Academic | Professional+Leader | Threshold |
|-------|----------|---------------------|-----------|
| CFI | .968 | .972 | ≥ .95 |
| TLI | .954 | .958 | ≥ .95 |
| RMSEA | .072 | .068 | ≤ .08 |
| SRMR | .054 | .051 | ≤ .08 |

### 4.3.2 Primary Hypotheses (H1a–H1g)

Table 4.1 presents the standardized path coefficients and hypothesis test results for the full sample and by role group.

**Table 4.1: Hypothesis Testing Results**

| Hypothesis | Path | Full Sample β | SE | p | Academic β | Prof+Leader β | Result |
|------------|------|---------------|----|----|------------|---------------|--------|
| H1a | PE → BI | **.505** | .062 | <.001 | .491 | .518 | ✅ Supported |
| H1b | EE → BI | .089 | .058 | .126 | .102 | .079 | ❌ Not Supported |
| H1c | SI → BI | **.136** | .055 | .013 | .128 | .142 | ✅ Supported |
| H1d | FC → BI | .074 | .054 | .170 | .068 | .081 | ❌ Not Supported |
| H1e | HM → BI | **.217** | .061 | <.001 | .205 | .228 | ✅ Supported |
| H1f | TR → BI | .106 | .057 | .064 | .098 | .112 | ❌ Marginal |
| H1g | AX → BI | **-.152** | .048 | .002 | -.145 | -.158 | ✅ Supported |

**Key Findings:**
- **Performance Expectancy** emerged as the strongest predictor (β = .505, p < .001), explaining the largest portion of variance in Behavioral Intention
- **Hedonic Motivation** was the second strongest predictor (β = .217, p < .001)
- **Anxiety** showed a significant negative effect (β = -.152, p = .002)
- **Social Influence** was a significant positive predictor (β = .136, p = .013)
- **Trust** approached but did not reach significance (β = .106, p = .064)
- **Effort Expectancy** and **Facilitating Conditions** were not significant predictors

### 4.3.3 Moderation Hypotheses (H2)

Experience was tested as a moderator of UTAUT relationships using latent interaction modeling.

**Table 4.2: Moderation Effects of AI Experience**

| Interaction | β | SE | p | Result |
|-------------|---|----|----|--------|
| PE × Experience | **.148** | .059 | .013 | ✅ Supported |
| EE × Experience | .062 | .055 | .264 | ❌ Not Supported |
| SI × Experience | .041 | .053 | .438 | ❌ Not Supported |
| FC × Experience | .038 | .054 | .484 | ❌ Not Supported |
| HM × Experience | **.136** | .052 | .009 | ✅ Supported |
| TR × Experience | .087 | .058 | .133 | ❌ Not Supported |
| AX × Experience | -.074 | .049 | .131 | ❌ Not Supported |

**Interpretation:**
- The PE → BI relationship is significantly **stronger** for those with more AI experience (β = .148, p = .013)
- The HM → BI relationship is significantly **stronger** for experienced users (β = .136, p = .009)
- Experience moderates the importance of utility and enjoyment perceptions but not other UTAUT factors

### 4.3.4 Role Group Moderation (H3)

Multi-group comparison tested whether path coefficients differed significantly between Academic and Professional+Leader groups.

**Table 4.3: Multi-Group Path Comparison**

| Path | Academic β | Prof+Leader β | Δβ | Δχ² | p | Significant? |
|------|------------|---------------|----|-----|---|--------------|
| PE → BI | .491 | .518 | -.027 | 0.42 | .517 | No |
| EE → BI | .102 | .079 | .023 | 0.38 | .539 | No |
| SI → BI | .128 | .142 | -.014 | 0.21 | .647 | No |
| FC → BI | .068 | .081 | -.013 | 0.18 | .671 | No |
| HM → BI | .205 | .228 | -.023 | 0.35 | .553 | No |
| TR → BI | .098 | .112 | -.014 | 0.20 | .655 | No |
| AX → BI | -.145 | -.158 | .013 | 0.22 | .639 | No |

**H3 Result: ❌ Not Supported**

No significant differences in path coefficients were observed between role groups, suggesting the structural relationships operate consistently across Academic and Professional service roles.

### 4.3.5 Variance Explained

The structural model explained substantial variance in Behavioral Intention:

| Group | R² | Interpretation |
|-------|----|--------------|
| Academic | .861 | 86.1% variance explained |
| Professional+Leader | .852 | 85.2% variance explained |
| **Full Sample** | **.857** | **85.7% variance explained** |

This exceptionally high R² indicates the UTAUT model, as adapted for AI adoption, captures the vast majority of systematic variance in intention to use AI tools.

---

## 4.4 Supplementary Analyses

### 4.4.1 Indirect and Total Effects

Mediation analysis examined potential indirect pathways through the model.

**Table 4.4: Indirect Effects on Behavioral Intention**

| Mediator Chain | β | 95% CI | p |
|----------------|---|--------|---|
| PE → HM → BI | .067 | [.029, .105] | .001 |
| TR → PE → BI | .089 | [.045, .133] | <.001 |
| AX → TR → BI | -.024 | [-.048, -.001] | .043 |

Performance Expectancy and Hedonic Motivation serve as partial mediators, suggesting that some predictors influence BI both directly and through intermediate attitudinal constructs.

### 4.4.2 AI Tool Usage Patterns (H4, H5)

Analysis of actual tool usage behaviors provides behavioral validation of intention constructs.

#### Tool Adoption Rates

| AI Tool | Awareness | Ever Tried | Active Use | Leader Effect (d) |
|---------|-----------|------------|------------|-------------------|
| ChatGPT | 98.3% | 89.2% | 63.7% | 0.74 |
| Microsoft Copilot | 92.1% | 71.4% | 49.1% | 0.89 |
| Google Bard/Gemini | 87.5% | 52.8% | 31.2% | 0.95 |
| Specialized AI Tools | 64.2% | 38.9% | 22.4% | 1.14 |

**Leadership Dominance:** Leaders demonstrated significantly higher usage across ALL tool categories (d = 0.74–1.14), with the largest effect for specialized AI tools.

#### Tool Usage and Behavioral Intention (H4)

The relationship between tool usage breadth and Behavioral Intention was examined using Spearman correlation due to non-normal tool usage distributions.

| Relationship | ρ | p | Interpretation |
|-------------|---|---|----------------|
| Tool Breadth × BI | .70 | <.001 | Strong positive |
| Usage Frequency × BI | .65 | <.001 | Strong positive |
| Usage Breadth × PE | .58 | <.001 | Moderate positive |

**H4 Result: ✅ Supported** – Higher behavioral intention is strongly associated with broader and more frequent AI tool usage.

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

---

## 4.5 Exploratory Findings

### 4.5.1 User Typology (Cluster Analysis)

K-means cluster analysis (k=4) identified distinct user profiles based on UTAUT construct scores.

**Table 4.5: AI User Typology**

| Cluster | n | % | PE | HM | AX | BI | Characterization |
|---------|---|---|----|----|----|----|------------------|
| Enthusiasts | 84 | 16% | High | High | Low | High | Early adopters, high engagement |
| Cautious Adopters | 157 | 30% | Mod | Mod | Mod | Mod | Pragmatic, wait-and-see |
| Moderate Users | 193 | 37% | Mod | Low | Mod | Low-Mod | Limited engagement, neutral |
| Anxious Avoiders | 89 | 17% | Low | Low | High | Low | Resistant, anxiety-driven |

#### Typology Distribution by Role

Chi-square analysis revealed significant role × typology association:

χ²(6) = 24.31, p < .001, Cramér's V = .15

- **Leaders** overrepresented in Enthusiasts (28% vs. 16% overall)
- **Academics** overrepresented in Anxious Avoiders (22% vs. 17% overall)

### 4.5.2 Demographic Predictors

Demographic variables were examined as potential correlates of AI readiness.

#### Gender Differences

| Construct | Male M | Female M | t | p | d |
|-----------|--------|----------|---|---|---|
| PE | 3.82 | 3.65 | 2.14 | .033 | 0.19 |
| AX | 2.41 | 2.68 | -2.89 | .004 | 0.26 |
| BI | 3.71 | 3.52 | 1.98 | .048 | 0.18 |

Small but significant gender differences emerged, with males showing slightly higher performance expectancy and lower anxiety.

#### Age Effects

Linear regression with age predicting UTAUT constructs:

| Construct | β | p | Direction |
|-----------|---|---|-----------|
| PE | -.08 | .071 | NS |
| EE | -.15 | .001 | Older = Lower |
| AX | .12 | .006 | Older = Higher |
| BI | -.11 | .012 | Older = Lower |

Age showed small negative relationships with ease of use and intention, with a positive relationship to anxiety.

#### Disability Status

Participants with disabilities (n=78, 14.9%) were compared to those without:

| Construct | Disability M | No Disability M | t | p | d |
|-----------|--------------|-----------------|---|---|---|
| AX | 2.89 | 2.48 | 2.76 | .006 | 0.36 |
| PE | 3.54 | 3.76 | -1.72 | .086 | 0.22 |
| BI | 3.41 | 3.64 | -1.64 | .102 | 0.21 |

**Key Finding:** Individuals with disabilities reported significantly higher AI-related anxiety (d = 0.36, p = .006), highlighting the importance of accessible and inclusive AI implementation strategies.

### 4.5.3 Qualitative Findings

Open-ended responses (n=243, 46.5% response rate) were analyzed using thematic analysis.

#### Theme Prevalence

**Table 4.6: Qualitative Theme Distribution**

| Theme | n | % of Responses | Example |
|-------|---|----------------|---------|
| Positive AI Experience | 67 | 27.6% | "AI has transformed how I prepare materials" |
| Concerns about Quality/Accuracy | 52 | 21.4% | "I worry about hallucinations and errors" |
| Learning/Education Focus | 48 | 19.8% | "Great for student support and feedback" |
| Work/Productivity Enhancement | 45 | 18.5% | "Saves significant time on routine tasks" |
| Ethical/Policy Concerns | 38 | 15.6% | "Need clearer guidelines on appropriate use" |
| Need for Training | 35 | 14.4% | "Would use more with proper training" |
| Academic Integrity Concerns | 32 | 13.2% | "Student misuse is a significant worry" |
| Resistance/Skepticism | 28 | 11.5% | "Not convinced AI adds value to my work" |
| Technical Barriers | 24 | 9.9% | "Access and technical issues limit usage" |
| Enthusiasm/Future Potential | 21 | 8.6% | "Excited about what AI will enable" |

*Note: Responses could be coded to multiple themes; percentages do not sum to 100%.*

#### Role Differences in Qualitative Themes

Chi-square tests identified three themes with significant role differences:

| Theme | Academic % | Professional % | Leader % | χ² | p |
|-------|------------|----------------|----------|----|----|
| Positive Experience | 22.4% | 28.1% | 38.5% | 7.11 | .029 |
| Learning/Education | 28.3% | 12.4% | 14.2% | 8.45 | .015 |
| Work/Productivity | 14.2% | 24.8% | 21.3% | 8.65 | .013 |

Academics focused more on educational applications, while Professionals emphasized productivity gains.

#### Typology × Theme Association

Chi-square analysis examined whether user typology predicted qualitative theme expression:

χ²(27) = 42.31, p = .031, Cramér's V = .24

Notable pattern: **Anxious Avoiders** were 3.2× more likely to express Ethical/Policy Concerns compared to Enthusiasts.

---

## 4.6 Summary of Findings

### 4.6.1 Hypothesis Summary

| Hypothesis | Description | Result |
|------------|-------------|--------|
| H1a | PE → BI (+) | ✅ Supported (β = .505) |
| H1b | EE → BI (+) | ❌ Not Supported |
| H1c | SI → BI (+) | ✅ Supported (β = .136) |
| H1d | FC → BI (+) | ❌ Not Supported |
| H1e | HM → BI (+) | ✅ Supported (β = .217) |
| H1f | TR → BI (+) | ❌ Marginal (p = .064) |
| H1g | AX → BI (−) | ✅ Supported (β = -.152) |
| H2 | Experience moderates UTAUT | ⚠️ Partial (PE, HM only) |
| H3 | Role moderates UTAUT paths | ❌ Not Supported |
| H4 | BI predicts tool usage | ✅ Supported (ρ = .70) |
| H5 | Role differences in usage | ✅ Supported (L > P > A) |

### 4.6.2 Key Contributions

1. **Performance Expectancy Dominance:** PE is the overwhelming driver of AI adoption intention (β = .505), substantially exceeding other predictors

2. **Experience Moderation Pattern:** AI experience amplifies the effects of PE and HM but not other constructs, suggesting experiential learning reinforces utility and enjoyment perceptions

3. **Role-Based Usage Hierarchy:** Despite equivalent structural relationships, Leaders substantially outperform other roles in actual tool adoption (d = 0.74–1.14)

4. **Disability-Anxiety Link:** First evidence of elevated AI anxiety among individuals with disabilities (d = 0.36), with implications for inclusive design

5. **User Typology:** Four distinct adoption profiles (Enthusiasts, Cautious Adopters, Moderate Users, Anxious Avoiders) with predictable demographic and attitudinal correlates

6. **Model Validity:** R² = .857 indicates exceptional model fit, with the extended UTAUT framework capturing most systematic variance in AI adoption intention

### 4.6.3 Unexpected Findings

- **Non-significant Effort Expectancy:** Contrary to UTAUT predictions, perceived ease of use did not significantly predict adoption intention, possibly due to the user-friendly nature of modern AI interfaces
- **Non-significant Facilitating Conditions:** Organizational support did not directly predict intention, suggesting individual attitudes may override institutional factors
- **Marginal Trust Effect:** Trust approached but did not reach significance (p = .064), indicating trust may be a necessary but not sufficient condition for adoption

---

## 4.7 Chapter Conclusion

This chapter presented comprehensive empirical validation of the AIRS instrument and structural model examining AI adoption in higher education. The 8-factor, 16-item measurement model demonstrated excellent psychometric properties (CFI = .975, α range .76–.91) with partial scalar invariance across role groups.

Structural equation modeling revealed Performance Expectancy as the dominant predictor of Behavioral Intention (β = .505), followed by Hedonic Motivation (β = .217) and negatively by Anxiety (β = -.152). Experience moderated the PE and HM pathways, while role group did not moderate structural relationships despite substantial group differences in actual tool usage.

Exploratory analyses identified four user typologies, significant disability-related anxiety differences (d = 0.36), and qualitative themes reflecting both enthusiasm and concern about AI integration in higher education. These findings provide a robust foundation for the theoretical and practical implications discussed in Chapter 5.

---

*Word Count: ~3,200*
*Tables: 6 primary, 4 supplementary*
*Last Updated: [Date]*
