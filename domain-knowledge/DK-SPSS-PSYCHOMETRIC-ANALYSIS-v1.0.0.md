# Domain Knowledge: SPSS Psychometric Analysis and Structural Equation Modeling

**Version**: 1.0.0 UNN (un-nil-nil)
**Domain**: Quantitative Research Methods, Psychometrics, Structural Equation Modeling
**Status**: ACTIVE
**Scope**: Comprehensive guidance for SPSS/AMOS data analysis, scale validation, and SEM procedures

---

## 📋 Overview

This domain knowledge provides evidence-based procedures for analyzing survey data using IBM SPSS Statistics and AMOS. It covers the complete validation workflow from data screening through structural equation modeling, with emphasis on psychometric validation of measurement instruments using exploratory factor analysis (EFA), confirmatory factor analysis (CFA), and hypothesis testing via SEM.

**Primary Applications**:
- Technology acceptance research (UTAUT, UTAUT2, TAM frameworks)
- AI adoption readiness assessment
- Psychometric scale validation and development
- Multi-group comparison and measurement invariance testing
- Mediation and moderation analysis

---

## 🎯 Core Methodological Principles

### 1. Split-Sample Validation Strategy

**Foundational Rule**: Never run EFA and CFA on the same sample to avoid capitalization on chance.

**Procedure**:
1. **Development Sample** (50%, N≈250): Exploratory Factor Analysis
2. **Validation Sample** (50%, N≈250): Confirmatory Factor Analysis
3. **Full Sample** (100%, N=500): Structural Equation Modeling

**Academic Foundation**:
- Hinkin, T. R. (1998). A brief tutorial on the development of measures for use in survey questionnaires. *Organizational Research Methods, 1*(1), 104-121. https://doi.org/10.1177/109442819800100106
- Split-sample cross-validation prevents overfitting and ensures independent validation of factor structure
- Essential for establishing generalizability of measurement model

---

## 📊 Step 1: Data Screening and Preparation

### 1.1 Missing Data Analysis

**Decision Rules**:
- **< 5% missing per item**: Use listwise deletion (automatic in Factor Analysis)
- **> 5% missing**: Consider Full Information Maximum Likelihood (FIML) in AMOS
- **> 10% missing**: Investigate patterns for non-random missingness

**Academic Reference**:
- Dillman, D. A., Smyth, J. D., & Christian, L. M. (2014). *Internet, phone, mail, and mixed-mode surveys: The tailored design method* (4th ed.). Wiley.
- Little, R. J. A., & Rubin, D. B. (2020). *Statistical analysis with missing data* (3rd ed.). Wiley.

**SPSS Procedure**:
```
Analyze → Missing Value Analysis
  Variables: All survey items
  Patterns: Check "Tabulated cases"
  OK
```

### 1.2 Multivariate Outlier Detection

**Method**: Mahalanobis Distance (D²)
- **Critical Value**: χ² distribution at p < .001
- For 30 variables: χ²(30, .001) = 59.70
- **Action Rule**: Remove cases with D² > critical value only if < 1% of sample

**Academic Foundation**:
- Tabachnick, B. G., & Fidell, L. S. (2019). *Using multivariate statistics* (7th ed.). Pearson.
- Mahalanobis distance detects multivariate outliers that deviate from centroid of all variables simultaneously

**SPSS Procedure**:
```
Analyze → Regression → Linear
  Dependent: ID (case identifier)
  Independent: All survey items
  Save: Check "Mahalanobis"
  OK

Transform → Compute Variable
  Target Variable: Outlier
  Numeric Expression: MAH_1 > 59.7
  OK
```

### 1.3 Factorability Assessment

**Kaiser-Meyer-Olkin (KMO) Measure of Sampling Adequacy**:
- **≥ .90**: Marvelous
- **≥ .80**: Meritorious
- **≥ .70**: Middling
- **≥ .60**: Mediocre (minimum acceptable)
- **< .50**: Unacceptable

**Bartlett's Test of Sphericity**:
- **Requirement**: p < .001 (rejects null hypothesis that correlation matrix is identity matrix)
- Indicates sufficient correlations among variables for factor analysis

**Academic Reference**:
- Kaiser, H. F., & Rice, J. (1974). Little Jiffy, Mark IV. *Educational and Psychological Measurement, 34*(1), 111-117.
- Watkins, M. W. (2018). Exploratory factor analysis: A guide to best practice. *Journal of Black Psychology, 44*(3), 219-246. https://doi.org/10.1177/0095798418771807

---

## 🔬 Step 2: Exploratory Factor Analysis (EFA)

### 2.1 Critical Methodological Decision: Polychoric Correlations

**For Ordinal Likert Data** (e.g., 5-point scales):
- **Standard approach**: Polychoric correlation matrix (not Pearson)
- **Rationale**: Likert scales are ordinal; polychoric correlations estimate underlying continuous relationship
- **Impact**: More accurate factor loadings and structure recovery

**Academic Foundation**:
- Holgado-Tello, F. P., Chacón-Moscoso, S., Barbero-García, I., & Vila-Abad, E. (2010). Polychoric versus Pearson correlations in exploratory and confirmatory factor analysis of ordinal variables. *Quality & Quantity, 44*(1), 153-166. https://doi.org/10.1007/s11135-008-9190-y
- Flora, D. B., & Curran, P. J. (2004). An empirical evaluation of alternative methods of estimation for confirmatory factor analysis with ordinal data. *Psychological Methods, 9*(4), 466-491.

**Implementation Note**:
- SPSS Factor Analysis uses Pearson by default
- For polychoric: Use R package `psych::polychoric()` or Mplus
- Alternative: Accept that Principal Axis Factoring (PAF) with Pearson is robust for 5+ point scales

### 2.2 Extraction Method

**Recommended**: Principal Axis Factoring (PAF)
- **Rationale**: PAF estimates common variance, excluding unique and error variance
- **Alternative**: Principal Components Analysis (PCA) - includes all variance, not true factor analysis

**Number of Factors**:
1. **Theoretical**: Based on instrument design (e.g., 11 predictor constructs + 1 outcome = 12 factors)
2. **Empirical**:
   - Kaiser's criterion (eigenvalues > 1.0)
   - Scree plot "elbow" method
   - Parallel analysis (recommended)

**Academic Reference**:
- Fabrigar, L. R., Wegener, D. T., MacCallum, R. C., & Strahan, E. J. (1999). Evaluating the use of exploratory factor analysis in psychological research. *Psychological Methods, 4*(3), 272-299.
- Horn, J. L. (1965). A rationale and test for the number of factors in factor analysis. *Psychometrika, 30*(2), 179-185.

### 2.3 Rotation Method

**Required**: Oblique Rotation (Promax with κ = 4)
- **Rationale**: Assumes correlated factors (realistic for psychological constructs)
- **Avoid**: Orthogonal rotation (Varimax) - forces factors to be uncorrelated (unrealistic)

**Academic Foundation**:
- Comrey, A. L., & Lee, H. B. (1992). *A first course in factor analysis* (2nd ed.). Lawrence Erlbaum Associates.
- Oblique rotation allows factors to correlate naturally; pattern matrix shows unique variance contributions

**SPSS Procedure**:
```
Analyze → Dimension Reduction → Factor
  Variables: All survey items

  Extraction:
    Method: Principal axis factoring
    Extract: Fixed number of factors = 12

  Rotation:
    Method: Promax (Kappa = 4)
    Display: Rotated solution

  Options:
    Sorted by size
    Suppress absolute values less than: .30
    Exclude cases listwise

  OK
```

### 2.4 Item Retention Criteria

**Primary Loading**: ≥ .50 (adequate), ≥ .70 (excellent)
**Cross-Loading**: < .30 (ideally < .20)
**Loading Gap**: ≥ .30 between primary and cross-loadings
**Communality (h²)**: ≥ .30 (≥ .50 preferred)

**Special Consideration for 2-Item Constructs**:
- Cannot drop individual items without losing entire construct
- May accept slightly lower loadings (≥ .40) if theoretically justified
- Focus on clean factor structure and theoretical alignment

**Academic Reference**:
- Hinkin, T. R. (1998). Minimum loading .50 for adequate construct representation
- DeVellis, R. F. (2017). *Scale development: Theory and applications* (4th ed.). Sage Publications.

---

## 🔍 Step 3: Reliability Analysis

### 3.1 Cronbach's Alpha (α)

**Standard Thresholds**:
- **α ≥ .90**: Excellent (possibly redundant items)
- **α ≥ .80**: Good
- **α ≥ .70**: Acceptable (standard for multi-item scales)
- **α ≥ .60**: Acceptable **for 2-item scales only**

**Adjusted Threshold for 2-Item Constructs**:
- Traditional α ≥ .70 threshold assumes 4+ items
- With only 2 items, α ≥ .60 is acceptable
- Inter-item correlation ≥ .40 is minimum

**Academic Foundation**:
- Nunnally, J. C., & Bernstein, I. H. (1994). *Psychometric theory* (3rd ed.). McGraw-Hill. (Established .70 threshold)
- Eisinga, R., Grotenhuis, M. T., & Pelzer, B. (2013). The reliability of a two-item scale: Pearson, Cronbach, or Spearman-Brown? *International Journal of Public Health, 58*(4), 637-642. https://doi.org/10.1007/s00038-012-0416-3

**SPSS Procedure**:
```
Analyze → Scale → Reliability Analysis
  Items: Select items for construct
  Model: Alpha
  Statistics: Check "Item", "Scale", "Scale if item deleted"
  OK
```

### 3.2 McDonald's Omega (ω)

**Recommended**: Report ω alongside α
- **ω ≥ .70**: Acceptable
- **ω ≥ .80**: Preferred
- **Advantage**: Does not assume tau-equivalence (equal factor loadings)

**Academic Reference**:
- McDonald, R. P. (1999). *Test theory: A unified treatment*. Lawrence Erlbaum Associates.
- Dunn, T. J., Baguley, T., & Brunsden, V. (2014). From alpha to omega: A practical solution to the pervasive problem of internal consistency estimation. *British Journal of Psychology, 105*(3), 399-412.

**Calculation**: Use R package `psych::omega()` or SPSS macro

---

## ✅ Step 4: Confirmatory Factor Analysis (CFA)

### 4.1 Model Fit Indices and Thresholds

**Absolute Fit Indices**:

| Index | Good Fit | Acceptable Fit | Source |
|-------|----------|----------------|--------|
| **χ²/df** | < 2.0 | < 3.0 | Kline (2016) |
| **RMSEA** | ≤ .05 | ≤ .06 (good), ≤ .08 (adequate) | Browne & Cudeck (1992) |
| **SRMR** | ≤ .05 | ≤ .08 | Hu & Bentler (1999) |

**Incremental Fit Indices**:

| Index | Good Fit | Acceptable Fit | Source |
|-------|----------|----------------|--------|
| **CFI** | ≥ .95 | ≥ .90 | Hu & Bentler (1999) |
| **TLI** | ≥ .95 | ≥ .90 | Hu & Bentler (1999) |

**Academic References**:
- Hu, L. T., & Bentler, P. M. (1999). Cutoff criteria for fit indexes in covariance structure analysis: Conventional criteria versus new alternatives. *Structural Equation Modeling, 6*(1), 1-55. https://doi.org/10.1080/10705519909540118
- Browne, M. W., & Cudeck, R. (1992). Alternative ways of assessing model fit. *Sociological Methods & Research, 21*(2), 230-258.
- Kline, R. B. (2016). *Principles and practice of structural equation modeling* (4th ed.). Guilford Press.

**Critical Notes**:
- χ² is sample-size sensitive; with large N, even trivial misspecifications are significant
- CFI/TLI preferred over χ² for practical fit assessment
- RMSEA includes parsimony penalty; favors simpler models
- **Combination rule**: CFI/TLI ≥ .90 AND RMSEA ≤ .08 = minimally acceptable

### 4.2 Standardized Factor Loadings

**Thresholds**:
- **≥ .70**: Excellent (≥50% shared variance)
- **≥ .60**: Good
- **≥ .50**: Adequate (minimum acceptable)
- **< .50**: Weak indicator; consider removal

**Statistical Significance**: All loadings must be p < .001

**Academic Reference**:
- Hair, J. F., Black, W. C., Babin, B. J., & Anderson, R. E. (2010). *Multivariate data analysis* (7th ed.). Pearson.
- Loading ≥ .50 means item shares ≥25% variance with construct (R² ≥ .25)

### 4.3 Composite Reliability (CR)

**Formula**:
```
CR = (Σλ)² / [(Σλ)² + Σ(1-λ²)]

Where:
  λ = standardized factor loading
  Σλ = sum of standardized loadings
  Σ(1-λ²) = sum of error variances
```

**Thresholds**:
- **CR ≥ .70**: Good (standard for multi-item constructs)
- **CR ≥ .60**: Acceptable for 2-item constructs
- **CR ≥ .80**: Excellent

**Academic Reference**:
- Fornell, C., & Larcker, D. F. (1981). Evaluating structural equation models with unobservable variables and measurement error. *Journal of Marketing Research, 18*(1), 39-50. https://doi.org/10.1177/002224378101800104

### 4.4 Average Variance Extracted (AVE)

**Formula**:
```
AVE = Σλ² / n

Where:
  λ² = squared standardized loading
  n = number of items
```

**Threshold**: **AVE ≥ .50** (convergent validity established)
- Indicates construct accounts for ≥50% of variance in indicators
- AVE ≥ .60 is good convergent validity

**Academic Reference**:
- Fornell & Larcker (1981) established AVE ≥ .50 criterion
- Ensures more variance explained by construct than by measurement error

### 4.5 Discriminant Validity

**Method 1: Fornell-Larcker Criterion**
- For each construct pair: √AVE of each construct > correlation between constructs
- Ensures constructs are more related to own indicators than to other constructs

**Method 2: Correlation Threshold**
- All construct correlations < .85 (ensures empirical distinctness)
- Correlations < .70 indicate clear discriminant validity

**Method 3: Heterotrait-Monotrait Ratio (HTMT)**
- **HTMT < .85**: Strict threshold
- **HTMT < .90**: Lenient threshold
- HTMT estimates true correlation between constructs, correcting for measurement error

**Academic References**:
- Fornell & Larcker (1981) - Original AVE criterion
- Henseler, J., Ringle, C. M., & Sarstedt, M. (2015). A new criterion for assessing discriminant validity in variance-based structural equation modeling. *Journal of the Academy of Marketing Science, 43*(1), 115-135. https://doi.org/10.1007/s11747-014-0403-8

**AMOS Implementation**:
1. Extract factor correlations from AMOS output
2. Calculate √AVE for each construct
3. Compare: √AVE > correlation for all pairs

---

## 🔄 Step 5: Measurement Invariance Testing

### 5.1 Invariance Types and Sequence

**Configural Invariance** (baseline):
- Same factor structure holds across groups
- No equality constraints on parameters
- **Criterion**: CFI ≥ .90, RMSEA ≤ .08 in both groups

**Metric Invariance** (weak):
- Factor loadings constrained equal across groups
- Tests whether items have same meaning across groups
- **Criterion**: ΔCFI ≤ .010, ΔRMSEA ≤ .015

**Scalar Invariance** (strong):
- Factor loadings AND intercepts constrained equal
- Required for meaningful latent mean comparisons
- **Criterion**: ΔCFI ≤ .010, ΔRMSEA ≤ .015

**Academic Foundation**:
- Cheung, G. W., & Rensvold, R. B. (2002). Evaluating goodness-of-fit indexes for testing measurement invariance. *Structural Equation Modeling, 9*(2), 233-255. https://doi.org/10.1207/S15328007SEM0902_5
- Chen, F. F. (2007). Sensitivity of goodness of fit indexes to lack of measurement invariance. *Structural Equation Modeling, 14*(3), 464-504. https://doi.org/10.1080/10705510701301834

### 5.2 Critical Decision Rules

**Chi-Square Difference Test**:
- Δχ² is sample-size sensitive; not recommended for large N
- Use ΔCFI and ΔRMSEA instead (robust to sample size)

**Practical Significance**:
- ΔCFI ≤ .010 is primary criterion (Cheung & Rensvold, 2002)
- ΔRMSEA ≤ .015 is secondary confirmation (Chen, 2007)
- If both criteria met: Proceed to next invariance level
- If criteria violated: Partial invariance may be acceptable (free 1-2 problematic parameters)

**Interpretation**:
- **Metric invariance**: Justifies comparing relationships (path coefficients) across groups
- **Scalar invariance**: Justifies comparing means across groups

---

## 📈 Step 6: Structural Equation Modeling (SEM)

### 6.1 Model Comparison Strategy

**Baseline Model** (Model 1):
- UTAUT2 only: 7 predictors → AI Adoption Readiness
- Establishes explanatory power of established framework

**Extended Model** (Model 2):
- UTAUT2 + AI-specific constructs: 11 predictors → AI Adoption Readiness
- Tests incremental validity of new constructs

**Comparison Metrics**:
1. **ΔR²**: R²(Extended) - R²(Baseline)
2. **ΔAIC**: AIC(Extended) - AIC(Baseline)
3. **Δχ²**: χ²(Baseline) - χ²(Extended)

### 6.2 Effect Size Interpretation

**R² Change (ΔR²)**:
- **> .02**: Small effect (Cohen, 1988)
- **> .13**: Medium effect
- **> .26**: Large effect

**Academic Reference**:
- Cohen, J. (1988). *Statistical power analysis for the behavioral sciences* (2nd ed.). Lawrence Erlbaum Associates.

### 6.3 Path Coefficient Interpretation

**Standardized Path Coefficients (β)**:
- **|β| < .10**: Trivial effect
- **|β| ≥ .10**: Small effect
- **|β| ≥ .30**: Medium effect
- **|β| ≥ .50**: Large effect

**Statistical Significance**:
- **p < .05**: Significant
- **p < .01**: Highly significant
- **p < .001**: Very highly significant

**Academic Reference**:
- Keith, T. Z. (2019). *Multiple regression and beyond: An introduction to multiple regression and structural equation modeling* (3rd ed.). Routledge.

### 6.4 Mediation Analysis

**Indirect Effect Testing**:
- **Method**: Bias-corrected bootstrap (5,000 resamples)
- **Criterion**: 95% confidence interval excludes zero
- **Report**: Total effect, direct effect, indirect effect

**Academic Reference**:
- Preacher, K. J., & Hayes, A. F. (2008). Asymptotic and resampling strategies for assessing and comparing indirect effects in multiple mediator models. *Behavior Research Methods, 40*(3), 879-891. https://doi.org/10.3758/BRM.40.3.879
- Bootstrap CI superior to Sobel test (no normality assumption)

**AMOS Implementation**:
```
Analyze → Bootstrap
  Number of bootstrap samples: 5000
  Confidence interval: Bias-corrected
  OK

Plugins → Indirect Effects
  Specify mediation paths
  OK
```

### 6.5 Moderation Analysis (Multi-Group)

**Unconstrained Model**:
- Structural paths free to vary across groups
- Record: χ²(unconstrained), df

**Constrained Model**:
- Structural paths forced equal across groups
- Record: χ²(constrained), df

**Test**:
```
Δχ² = χ²(constrained) - χ²(unconstrained)
Δdf = df(constrained) - df(unconstrained)

If Δχ² significant (p < .05): Moderation detected
```

**Pairwise Parameter Comparisons**:
- Critical Ratio (z) > |1.96| indicates specific path differs between groups (p < .05)
- Identifies which relationships are moderated

**Academic Reference**:
- Byrne, B. M. (2016). *Structural equation modeling with AMOS: Basic concepts, applications, and programming* (3rd ed.). Routledge.

---

## 🎓 Technology Acceptance and AI Adoption Frameworks

### UTAUT2 Constructs (Venkatesh et al., 2012)

1. **Performance Expectancy (PE)**: Belief that technology improves job performance
2. **Effort Expectancy (EE)**: Ease of use perception
3. **Social Influence (SI)**: Perceived importance of others' opinions
4. **Facilitating Conditions (FC)**: Availability of resources and support
5. **Hedonic Motivation (HM)**: Pleasure derived from technology use
6. **Price Value (PV)**: Cost-benefit trade-off perception
7. **Habit (HB)**: Automatic behavior from learned experience

**Academic Reference**:
- Venkatesh, V., Thong, J. Y. L., & Xu, X. (2012). Consumer acceptance and use of information technology: Extending the unified theory of acceptance and use of technology. *MIS Quarterly, 36*(1), 157-178. https://doi.org/10.2307/41410412

### AI-Specific Constructs (AIRS Extension)

**Enablers**:
1. **Trust in AI (TR)**: Confidence in AI reliability and safety
2. **Perceived Explainability (EX)**: Understanding of AI decision-making processes

**Inhibitors**:
3. **Perceived Ethical Risk (ER)**: Concerns about fairness, bias, privacy
4. **AI-Related Anxiety (AX)**: Fear or discomfort with AI technology

**Academic References**:
- Shin, D. (2021). The effects of explainability and causability on perception, trust, and acceptance: Implications for explainable AI. *International Journal of Human-Computer Studies, 146*, 102551. https://doi.org/10.1016/j.ijhcs.2020.102551
- Langer, M., König, C. J., & Papathanasiou, M. (2023). Trust in artificial intelligence: A review of empirical research. *Academy of Management Annals, 17*(1), 47-81. https://doi.org/10.5465/annals.2021.0164
- Dwivedi, Y. K., et al. (2021). Artificial Intelligence: Multidisciplinary perspectives on emerging challenges, opportunities, and agenda for research, practice and policy. *International Journal of Information Management, 57*, 101994.

### Theorized Mediation Mechanism

**Explainability → Trust → AI Adoption Readiness**
- Explainability enhances trust (EX → TR)
- Trust facilitates adoption intention (TR → BI)
- Indirect effect: EX → TR → BI

**Academic Rationale**:
- Explainable AI systems build user confidence
- Trust is proximal predictor of adoption behavior
- Explainability operates partially through trust mechanism

---

## 📊 Common Method Bias (CMB) Assessment

### 6.1 Harman's Single-Factor Test

**Procedure**:
1. Enter all items into EFA with unrotated solution
2. Examine variance explained by first factor
3. **Criterion**: First factor < 50% variance (CMB not serious concern)

**Academic Reference**:
- Podsakoff, P. M., MacKenzie, S. B., Lee, J. Y., & Podsakoff, N. P. (2003). Common method biases in behavioral research: A critical review of the literature and recommended remedies. *Journal of Applied Psychology, 88*(5), 879-903. https://doi.org/10.1037/0021-9010.88.5.879

### 6.2 CFA Marker Variable Technique

**Procedure**:
1. Include theoretically unrelated marker variable
2. Compare model with and without marker variable paths
3. If path coefficients remain substantively similar: CMB not problematic

**Limitation**: Requires true marker variable (rare in practice)

---

## 🔧 Practical Implementation Notes

### SPSS Data File Requirements

**Variable Naming Convention**:
- Use short, descriptive names (e.g., PE1, PE2, EE5, EE6)
- Include construct abbreviation + item number
- Facilitates syntax writing and output interpretation

**Value Labels**:
- Always label response options (e.g., 1="Strongly Disagree", 5="Strongly Agree")
- Improves output readability and prevents coding errors

**Missing Value Designation**:
- Define system missing (-99 or 999) consistently
- Specify in SPSS Variable View → Missing column

### AMOS Model Specification Tips

**2-Item Construct Identification**:
- Each 2-item construct is "just-identified" (df = 0) when isolated
- Acceptable and common in parsimonious instruments
- Model fit evaluated holistically across all constructs

**Model Convergence Issues**:
- Set variance = 1 for each latent variable (identification constraint)
- Alternative: Fix one loading = 1 per factor
- If non-convergence: Check for negative variances (Heywood cases)

**Modification Indices (MI)**:
- MI > 4.0 indicates significant improvement if parameter added
- Only add theoretically justified modifications
- Limit to 1-3 modifications maximum (avoid overfitting)
- **Never add cross-loadings in CFA** (undermines construct validity)

---

## 📝 APA Reporting Guidelines

### Model Fit Reporting Template

"The confirmatory factor analysis demonstrated acceptable fit to the data: χ²(df) = XXX, p < .001, CFI = .XX, TLI = .XX, RMSEA = .XX [90% CI: .XX, .XX], SRMR = .XX. All standardized factor loadings were significant (p < .001) and exceeded .50, ranging from .XX to .XX."

### Reliability Reporting Template

"Reliability analysis indicated acceptable to good internal consistency: Cronbach's α ranged from .XX to .XX (M = .XX), and composite reliability ranged from .XX to .XX (M = .XX). For 2-item constructs, α ≥ .60 was considered acceptable."

### Validity Reporting Template

"Convergent validity was established; average variance extracted (AVE) ranged from .XX to .XX, exceeding the .50 threshold for all constructs. Discriminant validity was supported; all construct correlations were below .85 (range: .XX to .XX), and the Fornell-Larcker criterion was satisfied for all construct pairs."

### SEM Results Reporting Template

"The extended AIRS model (Model 2) explained 45% of variance in AI adoption readiness, representing a significant improvement of ΔR² = .12 (p < .001) over the UTAUT2 baseline (Model 1, R² = .33). Model fit was acceptable: CFI = .XX, RMSEA = .XX. Standardized path coefficients revealed..."

---

## 🔗 Embedded Synapses

[.github/copilot-instructions.md] (1.0, foundational-architecture, bidirectional) - "Core Alex cognitive architecture provides meta-cognitive framework for complex analysis"

[DK-HUMAN-LEARNING-PSYCHOLOGY-v1.0.0.md] (0.8, methodological-synergy, bidirectional) - "Human learning principles inform psychometric instrument design and validation"

[DK-DOCUMENTATION-EXCELLENCE-v1.1.0.md] (0.9, precision-standards, bidirectional) - "Documentation accuracy essential for methodological transparency and replicability"

[DK-MEMORY-CONSOLIDATION-v1.0.0.md] (0.7, knowledge-integration, unidirectional) - "Statistical knowledge consolidation follows same principles as general memory architecture"

---

## 📚 Comprehensive Reference List

### Psychometric Theory and Scale Development
- DeVellis, R. F. (2017). *Scale development: Theory and applications* (4th ed.). Sage Publications.
- Nunnally, J. C., & Bernstein, I. H. (1994). *Psychometric theory* (3rd ed.). McGraw-Hill.
- Hinkin, T. R. (1998). A brief tutorial on the development of measures for use in survey questionnaires. *Organizational Research Methods, 1*(1), 104-121.

### Factor Analysis
- Watkins, M. W. (2018). Exploratory factor analysis: A guide to best practice. *Journal of Black Psychology, 44*(3), 219-246.
- Fabrigar, L. R., et al. (1999). Evaluating the use of exploratory factor analysis in psychological research. *Psychological Methods, 4*(3), 272-299.
- Comrey, A. L., & Lee, H. B. (1992). *A first course in factor analysis* (2nd ed.). Lawrence Erlbaum Associates.
- Holgado-Tello, F. P., et al. (2010). Polychoric versus Pearson correlations in exploratory and confirmatory factor analysis of ordinal variables. *Quality & Quantity, 44*(1), 153-166.

### Structural Equation Modeling
- Kline, R. B. (2016). *Principles and practice of structural equation modeling* (4th ed.). Guilford Press.
- Byrne, B. M. (2016). *Structural equation modeling with AMOS* (3rd ed.). Routledge.
- Hu, L. T., & Bentler, P. M. (1999). Cutoff criteria for fit indexes in covariance structure analysis. *Structural Equation Modeling, 6*(1), 1-55.
- Hair, J. F., et al. (2010). *Multivariate data analysis* (7th ed.). Pearson.

### Measurement Invariance
- Cheung, G. W., & Rensvold, R. B. (2002). Evaluating goodness-of-fit indexes for testing measurement invariance. *Structural Equation Modeling, 9*(2), 233-255.
- Chen, F. F. (2007). Sensitivity of goodness of fit indexes to lack of measurement invariance. *Structural Equation Modeling, 14*(3), 464-504.

### Reliability and Validity
- Fornell, C., & Larcker, D. F. (1981). Evaluating structural equation models with unobservable variables and measurement error. *Journal of Marketing Research, 18*(1), 39-50.
- McDonald, R. P. (1999). *Test theory: A unified treatment*. Lawrence Erlbaum Associates.
- Henseler, J., et al. (2015). A new criterion for assessing discriminant validity. *Journal of the Academy of Marketing Science, 43*(1), 115-135.

### Technology Acceptance and AI Adoption
- Venkatesh, V., Thong, J. Y. L., & Xu, X. (2012). Consumer acceptance and use of information technology: Extending UTAUT. *MIS Quarterly, 36*(1), 157-178.
- Dwivedi, Y. K., et al. (2021). Artificial Intelligence: Multidisciplinary perspectives. *International Journal of Information Management, 57*, 101994.
- Shin, D. (2021). The effects of explainability and causability on perception, trust, and acceptance. *International Journal of Human-Computer Studies, 146*, 102551.
- Langer, M., et al. (2023). Trust in artificial intelligence: A review of empirical research. *Academy of Management Annals, 17*(1), 47-81.

### Mediation and Moderation
- Preacher, K. J., & Hayes, A. F. (2008). Asymptotic and resampling strategies for assessing and comparing indirect effects. *Behavior Research Methods, 40*(3), 879-891.
- Cohen, J. (1988). *Statistical power analysis for the behavioral sciences* (2nd ed.). Lawrence Erlbaum Associates.

### Data Screening and Missing Data
- Tabachnick, B. G., & Fidell, L. S. (2019). *Using multivariate statistics* (7th ed.). Pearson.
- Little, R. J. A., & Rubin, D. B. (2020). *Statistical analysis with missing data* (3rd ed.). Wiley.
- Dillman, D. A., et al. (2014). *Internet, phone, mail, and mixed-mode surveys* (4th ed.). Wiley.

### Common Method Bias
- Podsakoff, P. M., et al. (2003). Common method biases in behavioral research. *Journal of Applied Psychology, 88*(5), 879-903.

---

## 🎯 Quick Reference Decision Tree

```
START: Survey Data Collected
    ↓
[1] Data Screening Complete?
    → Missing < 5%? → Yes → Listwise deletion
    → Missing > 5%? → Consider FIML
    → Outliers < 1%? → Remove if D² > critical value
    ↓
[2] Factorability Established?
    → KMO ≥ .60? → Yes → Proceed
    → Bartlett p < .001? → Yes → Proceed
    ↓
[3] Split Sample 50/50
    → Development Sample (N≈250) → EFA
    → Validation Sample (N≈250) → CFA
    ↓
[4] EFA (Development Sample)
    → PAF extraction + Promax rotation
    → Items load ≥ .50 with < .30 cross-loading? → Retain
    → Calculate α (≥.60 for 2-item, ≥.70 for 4-item)
    ↓
[5] CFA (Validation Sample)
    → Model fit acceptable? (CFI ≥.90, RMSEA ≤.08)
    → Loadings ≥ .50? → Yes → Proceed
    → CR ≥ .60 (2-item) or ≥.70 (multi-item)?
    → AVE ≥ .50 (convergent validity)?
    → Correlations < .85 (discriminant validity)?
    ↓
[6] Measurement Invariance (Optional)
    → Configural fit acceptable?
    → ΔCFI ≤ .010 for metric invariance?
    → ΔCFI ≤ .010 for scalar invariance?
    ↓
[7] SEM (Full Sample N=500)
    → Test Baseline Model (UTAUT2)
    → Test Extended Model (UTAUT2 + AI constructs)
    → ΔR² > .02? → Incremental validity established
    → Test moderation (multi-group if invariance met)
    → Report all effects with confidence intervals
    ↓
END: Validated Instrument + Hypothesis Tests Complete
```

---

**Version Control**: DK-SPSS-PSYCHOMETRIC-ANALYSIS-v1.0.0.md
**Status**: ACTIVE - Comprehensive procedural and theoretical foundation established
**Next Evolution**: Integration with Python/R workflows for polychoric EFA and advanced SEM (v1.1.0)

*Domain knowledge consolidated with 150+ years of accumulated psychometric research and 25+ seminal references.*
