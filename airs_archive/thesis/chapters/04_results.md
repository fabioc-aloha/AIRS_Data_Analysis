# Chapter 4: Findings

## 4.1 Introduction

This chapter presents the empirical findings from the AI Readiness Survey (AIRS) study examining factors influencing AI tool adoption in higher education. The chapter is organized to progress systematically from sample description through data preparation, quantitative results, and findings organized by research question. All analyses were conducted using Python (factor_analyzer, semopy, scipy, pandas) with a significance level of α = .05 unless otherwise specified.

The presentation separates findings from interpretation, following established methodological practice (Yin, 2018). Theoretical and practical implications are addressed in Chapter 5.

## 4.2 Research Questions and Hypotheses Overview

This section provides a summary of all research questions examined in this dissertation. Detailed hypothesis testing results are presented in §4.5.

### 4.2.1 Primary Research Question

**RQ: How can UTAUT2 be extended with AI-specific constructs to better predict behavioral intention to adopt AI tools in professional and academic contexts?**

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.1: Research Questions Summary}
\begin{tabular}{@{}>{\raggedright\arraybackslash}p{0.18\textwidth}>{\raggedright\arraybackslash}p{0.38\textwidth}>{\raggedright\arraybackslash}p{0.38\textwidth}@{}}
\toprule
\textbf{Aspect} & \textbf{Answer} & \textbf{Evidence} \\
\midrule
Extension Approach & UTAUT2 extended with AI Trust construct & 8-factor, 16-item validated diagnostic instrument \\
Predictive Power & Model explains 85.2\% variance in BI & R² = .852 (8-factor model) \\
Key Finding & Traditional UTAUT predictors less important for AI & PE, EE, FC, HB non-significant \\
AI-Specific Insight & Value perception dominates over utility & PV strongest predictor ($\beta$ = .505) \\
\bottomrule
\end{tabular}
\end{table}
```

### 4.2.2 Secondary Research Questions

```{=latex}
\begin{table}[H]
\centering
\small
\begin{tabular}{@{}c>{\raggedright\arraybackslash}p{0.25\textwidth}>{\raggedright\arraybackslash}p{0.30\textwidth}>{\raggedright\arraybackslash}p{0.30\textwidth}@{}}
\toprule
\textbf{RQ\#} & \textbf{Question} & \textbf{Answer} & \textbf{Supporting Evidence} \\
\midrule
RQ1 & What is the factor structure of an AI-specific adoption readiness instrument? & 8-factor structure with 16 items & CFI = .975, TLI = .960, RMSEA = .065; all $\alpha$ > .74 \\
RQ2 & Does the instrument demonstrate measurement invariance across populations? & Configural invariance achieved; metric invariance partial & $\Delta$CFI = .003, $\Delta$RMSEA = .004; mean $\Delta\lambda$ = .082 \\
RQ3 & Which factors most strongly predict behavioral intention? & Price Value ($\beta$ = .505), Hedonic Motivation ($\beta$ = .217), Social Influence ($\beta$ = .136) & All p < .05; PV accounts for largest variance \\
RQ4 & Does AI Trust predict adoption beyond UTAUT2? & Marginal effect, not statistically significant & $\beta$ = .106, p = .064; provides diagnostic value \\
RQ5 & What moderating factors influence predictor-intention relationships? & Experience moderates HM$\rightarrow$BI; Population moderates HM$\rightarrow$BI & HM$\times$Exp p = .009; Academic vs Professional $\Delta\beta$ = .750 \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

## 4.3 Description of the Sample

The sample comprises N=523 United States adults with representation from both academic and professional contexts. Table 4.2 presents the demographic composition.

### 4.3.1 Population Composition

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.2: Sample Composition by Population Type}
\begin{tabular}{@{}lrr>{\raggedright\arraybackslash}p{0.45\textwidth}@{}}
\toprule
\textbf{Population} & \textbf{n} & \textbf{\%} & \textbf{Subgroups} \\
\midrule
Students & 216 & 41.3\% & Full-time (n=196), Part-time (n=20) \\
Professionals & 307 & 58.7\% & Individual contributors (n=112), Managers (n=71), Executives (n=52), Freelancers (n=32), Other (n=23), Unemployed (n=17) \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

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

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.3: Exploratory Factor Analysis Model Comparison}
\begin{tabular}{@{}cccccccl@{}}
\toprule
\textbf{Model} & \textbf{Factors} & \textbf{Items} & \textbf{CFI (CFA)} & \textbf{TLI} & \textbf{RMSEA} & \textbf{SRMR} & \textbf{Decision} \\
\midrule
A & 7 & 21 & .938 & .923 & .078 & .058 & Poor fit \\
B & 8 & 20 & .952 & .940 & .070 & .052 & Adequate \\
C & 8 & 18 & .964 & .953 & .066 & .048 & Good \\
D & 8 & 16 & .975 & .960 & .065 & .046 & \textbf{Selected} \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

**Model D** was selected as the final measurement model based on optimal balance of parsimony and fit, with all items demonstrating factor loadings ≥ .50 and no substantive cross-loadings (< .32). Figure 4.1 presents the scree plot supporting this factor structure.

![Figure 4.1: Scree plot showing eigenvalue decline across factors. The parallel analysis criterion (dashed line) supports retention of 8 factors. *Source: Compiled by Author*](figures/fig_efa_scree.png){#fig:scree-plot}

#### Construct Exclusion Analysis

Four proposed constructs were excluded during EFA due to poor inter-item reliability:

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.4: Construct Exclusion Analysis}
\begin{tabular}{@{}lclp{0.45\textwidth}@{}}
\toprule
\textbf{Construct} & \textbf{Cronbach's $\alpha$} & \textbf{Decision} & \textbf{Rationale} \\
\midrule
Voluntariness (VO) & .406 & Dropped & Items measured choice vs. freedom, distinct dimensions \\
Explainability (EX) & .582 & Dropped & Items measured understanding vs. preference, distinct facets \\
Ethical Risk (ER) & .546 & Dropped & Items measured job displacement vs. privacy, distinct risk types \\
AI Anxiety (AX) & .301 & Dropped & Items measured avoidance vs. approach anxiety, distinct motivations \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

**Interpretation**: The proposed two-item scales for these AI-specific constructs proved insufficient to capture multi-faceted phenomena. This finding highlights a key contribution: while these constructs are theoretically important for AI adoption, they require more comprehensive operationalization with additional items representing each sub-dimension.

**Future Development**: All four dropped constructs require item redesign for future validation studies. For AI Anxiety specifically, future scales should distinguish between technology avoidance anxiety and fear-of-missing-out (FOMO) or obsolescence anxiety, as these represent conceptually distinct motivational orientations.

#### Final Factor Structure

The validated measurement model comprises 8 predictor factors (16 items) plus Behavioral Intention as the outcome variable (4 items):

**Predictor Factors (8 factors, 16 items)**:

The final measurement model comprises 7 UTAUT2 constructs plus the AI Trust extension:

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.5: Final Factor Structure with Reliability and Validity Indices}
\small
\begin{tabular}{@{}l>{\raggedright\arraybackslash}p{0.12\textwidth}>{\raggedright\arraybackslash}p{0.28\textwidth}ccc@{}}
\toprule
\textbf{Factor} & \textbf{Items} & \textbf{Description} & \textbf{$\alpha$} & \textbf{CR} & \textbf{AVE} \\
\midrule
Performance Expectancy (PE) & PE1, PE2 & Perceived usefulness & .803 & .804 & .673 \\
Effort Expectancy (EE) & EE1, EE2 & Perceived ease of use & .859 & .861 & .756 \\
Social Influence (SI) & SI1, SI2 & Social normative pressure & .752 & .763 & .621 \\
Facilitating Conditions (FC) & FC1, FC2 & Organizational support & .743 & .750 & .601 \\
Hedonic Motivation (HM) & HM1, HM2 & Enjoyment and curiosity & .864 & .865 & .763 \\
Price Value (PV) & PV1, PV2 & Cost-benefit assessment & .883 & .883 & .790 \\
Habit (HB) & HB1, HB2 & Automaticity of use & .909 & .909 & .833 \\
AI Trust (TR) & TR1, TR2 & Trust in AI systems & .891 & .891 & .804 \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

*Note: BI (Behavioral Intention) serves as the outcome variable and is modeled separately in the structural model.*

### 4.5.2 Confirmatory Factor Analysis (Holdout Sample)

The 8-factor model was cross-validated on the independent holdout sample (n=262) using confirmatory factor analysis in semopy.

#### Model Fit Assessment

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.6: Confirmatory Factor Analysis Model Fit Indices}
\begin{tabular}{@{}lccl@{}}
\toprule
\textbf{Index} & \textbf{Value} & \textbf{Threshold} & \textbf{Interpretation} \\
\midrule
$\chi^2$ & 159.38 & -- & -- \\
df & 76 & -- & -- \\
$\chi^2$/df & 2.10 & < 3.0 & Excellent \\
CFI & .975 & $\geq$ .95 & Excellent \\
TLI & .960 & $\geq$ .95 & Excellent \\
RMSEA & .065 & $\leq$ .08 & Good \\
SRMR & .046 & $\leq$ .08 & Excellent \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

The model demonstrated excellent fit across all indices, confirming the factor structure derived from the development sample. Figure 4.2 presents the standardized factor loadings for the validated 8-factor model.

![Figure 4.2: Standardized factor loadings for the 8-factor AIRS measurement model. All loadings exceed .70, supporting convergent validity. *Source: Compiled by Author*](figures/fig_cfa_loadings.png){#fig:cfa-loadings}

#### Factor Correlations

Inter-factor correlations ranged from r = .25 (Social Influence × Price Value) to r = .72 (Hedonic Motivation × Performance Expectancy), indicating conceptually meaningful relationships while maintaining discriminant validity (all |r| < .85). Figure 4.3 presents the factor correlation matrix.

![Figure 4.3: Inter-factor correlations for the 8-factor AIRS model. All correlations fall below the .85 threshold for discriminant validity. *Source: Compiled by Author*](figures/fig_cfa_correlations.png){#fig:cfa-correlations}

### 4.5.3 Reliability and Validity

#### Composite Reliability

All predictor factors demonstrated acceptable internal consistency:

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.7: Composite Reliability and Validity Indices}
\begin{tabular}{@{}lccc@{}}
\toprule
\textbf{Factor} & \textbf{Cronbach's $\alpha$} & \textbf{Composite Reliability (CR)} & \textbf{AVE} \\
\midrule
PE & .803 & .804 & .673 \\
EE & .859 & .861 & .756 \\
SI & .752 & .763 & .621 \\
FC & .743 & .750 & .601 \\
HM & .864 & .865 & .763 \\
PV & .883 & .883 & .790 \\
HB & .909 & .909 & .833 \\
TR & .891 & .891 & .804 \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

Figure 4.4 provides a visual comparison of reliability indices across constructs.

![Figure 4.4: Comparison of Cronbach's α, Composite Reliability (CR), and Average Variance Extracted (AVE) across the 8 AIRS factors. All factors exceed minimum thresholds (α > .70, CR > .70, AVE > .50). *Source: Compiled by Author*](figures/fig_reliability.png){#fig:reliability}

#### Convergent Validity

All standardized factor loadings exceeded .70, and all AVE values exceeded .50, supporting convergent validity (Fornell & Larcker, 1981).

#### Discriminant Validity

Discriminant validity was assessed using the Fornell-Larcker criterion. For each factor pair, the square root of AVE exceeded the inter-factor correlation, confirming discriminant validity.

### 4.5.4 Measurement Invariance (Multi-Group CFA)

Measurement invariance was tested across role groups (Academic n=216 vs. Professional n=307) to establish comparability of latent constructs.

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.8: Measurement Invariance Testing Across Groups}
\begin{tabular}{@{}lcccccp{0.18\textwidth}@{}}
\toprule
\textbf{Group} & \textbf{$\chi^2$} & \textbf{df} & \textbf{CFI} & \textbf{TLI} & \textbf{RMSEA} & \textbf{Interpretation} \\
\midrule
Academic & 167.16 & 76 & .958 & .934 & .075 & Good fit \\
Professional & 135.88 & 76 & .988 & .981 & .051 & Excellent fit \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

**Configural invariance** was supported: the same factor structure held across both groups. **Metric invariance** was not fully achieved (mean loading difference = .082, max = .326), indicating some factor loadings differ across groups. However, configural invariance is sufficient for comparing structural relationships across groups. The maximum factor loading difference (Δλ = .326) occurred for the SI factor, though this did not compromise overall model validity. Figure 4.5 illustrates the loading differences across groups.

![Figure 4.5: Factor loading comparison across Student and Professional groups. While most loadings demonstrate equivalence, Social Influence shows the largest cross-group difference. *Source: Compiled by Author*](figures/fig_invariance_loadings.png){#fig:invariance-loadings}



## 4.6 Findings by Research Question

This section presents hypothesis testing results organized by research question. The structural model was estimated using multi-group SEM to test hypothesized relationships between UTAUT constructs and Behavioral Intention to adopt AI tools. The model was estimated separately for Student (n=216) and Professional+Leader (n=307) groups.

### 4.6.1 Structural Model Fit

The structural model demonstrated acceptable fit:

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.9: Structural Model Fit by Group}
\begin{tabular}{@{}lccc@{}}
\toprule
\textbf{Index} & \textbf{Student} & \textbf{Professional+Leader} & \textbf{Threshold} \\
\midrule
CFI & .968 & .972 & $\geq$ .95 \\
TLI & .954 & .958 & $\geq$ .95 \\
RMSEA & .072 & .068 & $\leq$ .08 \\
SRMR & .054 & .051 & $\leq$ .08 \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

### 4.6.2 Primary Hypotheses (H1a–H1g)

Table 4.10 presents the standardized path coefficients, 95% confidence intervals, and hypothesis test results for the full sample.

#### Core UTAUT2 Hypotheses

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.10: UTAUT2 Core Hypotheses with Confidence Intervals}
\small
\begin{tabular}{@{}llllclp{0.18\textwidth}@{}}
\toprule
\textbf{Hypothesis} & \textbf{Path} & \textbf{Pred.} & \textbf{$\beta$} & \textbf{p} & \textbf{95\% CI} & \textbf{Result} \\
\midrule
H1a & PE $\rightarrow$ BI & + & --.028 & .791 & [--.234, .178] & Not Supported \\
H1b & EE $\rightarrow$ BI & + & --.008 & .875 & [--.108, .092] & Not Supported \\
H1c & SI $\rightarrow$ BI & + & \textbf{.136} & \textbf{.024} & [.018, .254] & \textbf{Supported} \\
H1d & FC $\rightarrow$ BI & + & .059 & .338 & [--.062, .180] & Not Supported \\
H1e & HM $\rightarrow$ BI & + & \textbf{.217} & \textbf{.014} & [.044, .390] & \textbf{Supported} \\
H1f & PV $\rightarrow$ BI & + & \textbf{.505} & \textbf{<.001} & [.352, .658] & \textbf{Strongest} \\
H1g & HB $\rightarrow$ BI & + & .023 & .631 & [--.071, .117] & Not Supported \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

#### AI Extension Hypothesis

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.11: AI Trust Extension Hypothesis}
\begin{tabular}{@{}llllclp{0.22\textwidth}@{}}
\toprule
\textbf{Hypothesis} & \textbf{Path} & \textbf{Pred.} & \textbf{$\beta$} & \textbf{p} & \textbf{95\% CI} & \textbf{Result} \\
\midrule
H2 & TR $\rightarrow$ BI & + & .106 & .064 & [--.006, .218] & Marginal (Not Sig.) \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

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

![Figure 4.6: Summary of hypothesis test results. Green indicates supported hypotheses, red indicates unsupported, and yellow indicates marginal significance. Price Value emerged as the dominant predictor. *Source: Compiled by Author*](figures/fig_hypothesis_summary.png){#fig:hypothesis-summary}

### 4.6.3 Moderation Hypotheses (H3–H4)

Usage frequency was tested as a moderator of UTAUT relationships through multi-group SEM comparison.

#### Usage Group Path Comparison

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.12: Usage Group Path Comparison}
\begin{tabular}{@{}lcc>{\raggedright\arraybackslash}p{0.35\textwidth}@{}}
\toprule
\textbf{Predictor} & \textbf{$\beta$ (Low Usage)} & \textbf{$\beta$ (High Usage)} & \textbf{Interpretation} \\
\midrule
PerfExp & \textbf{0.371*} & --0.270 & PE matters for new users only \\
PriceValue & 0.224 & \textbf{0.878*} & PV stronger for heavy users \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

#### Exploratory Experience Moderation (Regression Interactions)

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.13: Experience Moderation Analysis Results}
\begin{tabular}{@{}lllcl@{}}
\toprule
\textbf{Moderator} & \textbf{Path} & \textbf{Interaction $\beta$} & \textbf{p} & \textbf{Status} \\
\midrule
Experience & PE$\times$Exp & 0.112 & .055 & Marginal \\
\textbf{Experience} & \textbf{HM$\times$Exp} & \textbf{0.136} & \textbf{.009} & \textbf{Significant} \\
Experience & EE$\times$Exp & 0.122 & .161 & Not significant \\
Experience & TR$\times$Exp & 0.081 & .145 & Not significant \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

**Interpretation:**

- **Experience moderates HM -> BI** (β = .136, p = .009): Experienced professionals (4+ years) weight hedonic motivation more heavily
- Usage-dependent mechanisms: Performance Expectancy matters for new users; Price Value for heavy users
- Habit is marginally moderated by usage frequency (p = .065)

Figure 4.7 illustrates the structural model with standardized path coefficients.

![Figure 4.7: Structural equation model showing standardized path coefficients from UTAUT2 predictors and AI Trust to Behavioral Intention. Solid lines indicate significant paths; dashed lines indicate non-significant paths. *Source: Compiled by Author*](figures/fig_structural_paths.png){#fig:structural-paths}

#### Population Moderation (H4)

Multi-group comparison tested whether structural path coefficients differed significantly between Student and Professional populations.

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.14: Population Moderation of Structural Paths}
\begin{tabular}{@{}lcccc@{}}
\toprule
\textbf{Path} & \textbf{Student $\beta$} & \textbf{Professional $\beta$} & \textbf{$\Delta\beta$} & \textbf{Moderation} \\
\midrule
PE $\rightarrow$ BI & --0.184 & 0.084 & 0.268 & No \\
EE $\rightarrow$ BI & 0.073 & --0.055 & --0.128 & No \\
SI $\rightarrow$ BI & 0.007 & 0.239 & 0.232 & No \\
FC $\rightarrow$ BI & --0.016 & 0.141 & 0.156 & No \\
HM $\rightarrow$ BI & 0.449 & --0.301 & --0.750 & Yes (p = .041) \\
PV $\rightarrow$ BI & 0.638 & 0.808 & 0.170 & No \\
HB $\rightarrow$ BI & 0.075 & --0.064 & --0.140 & No \\
TR $\rightarrow$ BI & --0.011 & 0.153 & 0.164 & No \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

**H3 Result: [!] Partially Supported** – Experience significantly moderates the HM -> BI path (p = .009). Professionals with 4+ years of experience weight hedonic motivation more heavily in AI adoption decisions.

**H4 Result: [!] Partially Supported** – Population significantly moderates HM -> BI (p = .041). Hedonic Motivation is substantially stronger for Students (β = 0.449) than Professionals (β = -0.301), indicating that enjoyment of AI tools is more important for student adoption than professional adoption. All other paths showed no significant population differences. Figure 4.8 illustrates the experience moderation effect on hedonic motivation.

![Figure 4.8: Experience moderation of the Hedonic Motivation -> Behavioral Intention path. The effect of HM on BI is stronger for professionals with 4+ years of experience. *Source: Compiled by Author*](figures/fig_experience_moderation.png){#fig:experience-moderation}

### 4.6.4 Incremental Validity: AIRS vs. UTAUT2-Only Model

To assess whether the AI-specific extension (AI Trust) provides incremental predictive validity beyond core UTAUT2 constructs, nested model comparison was conducted:

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.15: Incremental Validity Model Comparison}
\begin{tabular}{@{}>{\raggedright\arraybackslash}p{0.22\textwidth}>{\raggedright\arraybackslash}p{0.35\textwidth}ccp{0.15\textwidth}@{}}
\toprule
\textbf{Model} & \textbf{Constructs} & \textbf{AIC} & \textbf{BIC} & \textbf{Result} \\
\midrule
UTAUT2-Only & PE, EE, SI, FC, HM, PV, HB & 148.58 & 192.34 & Preferred \\
AIRS (Extended) & PE, EE, SI, FC, HM, PV, HB, TR & 150.59 & 201.87 & Not preferred \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

**Result**: Although AI Trust showed a marginal effect (β = .106, p = .064), the AIRS model has *higher* AIC (150.59) than UTAUT2-only (148.58), meaning the simpler model is preferred (ΔAIC = +2.01). Lower AIC indicates better parsimony.

**Interpretation**: This incremental validity test evaluates **predictive parsimony** only. AI Trust may still have **diagnostic value** for identifying trust-related barriers to AI adoption, even if it doesn't improve overall model fit. The marginal significance of AI Trust (p = .064) suggests it may achieve significance with larger samples or in contexts where trust concerns are more salient.

### 4.6.5 Variance Explained

The structural models explained substantial variance in Behavioral Intention:

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.16: Variance Explained in Behavioral Intention}
\begin{tabular}{@{}l>{\raggedright\arraybackslash}p{0.25\textwidth}>{\raggedright\arraybackslash}p{0.45\textwidth}@{}}
\toprule
\textbf{Model} & \textbf{R\textsuperscript{2}} & \textbf{Interpretation} \\
\midrule
UTAUT2-Only (7 predictors) & .861 & 86.1\% variance explained \\
UTAUT2 + AI Trust (8 predictors) & .852 & 85.2\% variance explained \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

Both models demonstrate exceptionally high R² values, indicating that the UTAUT2 framework captures the vast majority of systematic variance in intention to use AI tools. While the UTAUT2-only model achieves marginally higher R², the 8-factor model including AI Trust is recommended as the diagnostic instrument because the trust construct enables practical intervention design: organizations can identify trust deficits and implement targeted confidence-building strategies, a capability essential for translating research into organizational practice.



### 4.6.6 Supplementary Analyses

#### Mediation Hypotheses

**Design Note**: The originally hypothesized mediation paths (EX -> TR -> BI, ER -> TR -> BI) were **not testable** because Explainability (EX), Ethical Risk (ER), and Anxiety (AX) were excluded from the final model due to inadequate item reliability identified in Phase 1 (α = .301–.582).

**Exploratory Mediation Analysis**: Bootstrap mediation testing explored whether AI Trust mediates the effect of Effort Expectancy on Behavioral Intention:

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.17: Exploratory Mediation Analysis}
\begin{tabular}{@{}>{\raggedright\arraybackslash}p{0.28\textwidth}cccl@{}}
\toprule
\textbf{Mediation Path} & \textbf{Indirect Effect} & \textbf{95\% CI} & \textbf{p} & \textbf{Result} \\
\midrule
EE $\rightarrow$ TR $\rightarrow$ BI & 0.232 & [--.023, .474] & > .05 & Not Significant \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

The confidence interval includes zero, indicating no significant mediation. While the theoretical pathway remains conceptually relevant, adding AI Trust as a mediator does not significantly improve the model.

### 4.6.7 Behavioral Validation Hypotheses (H5–H6)

Analysis of actual tool usage behaviors provides behavioral validation of intention constructs.

#### Tool Usage Frequency

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.18: AI Tool Usage Frequency by Population}
\begin{tabular}{@{}>{\raggedright\arraybackslash}p{0.28\textwidth}cccc@{}}
\toprule
\textbf{AI Tool} & \textbf{Mean Usage} & \textbf{Never Used (\%)} & \textbf{Active Use (\%)} & \textbf{Leader Effect (d)} \\
\midrule
ChatGPT & 3.03 & 23.9 & 64.2 & 0.74 \\
Microsoft Copilot & 2.49 & 36.1 & 48.4 & 1.14 \\
Google Bard/Gemini & 2.48 & 36.5 & 47.6 & 0.90 \\
Other AI Tools & 1.93 & 53.3 & 30.0 & 0.78 \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Note: Active Use = "Sometimes" or more frequent usage ($\geq$3 on 5-point scale). Leader Effect = Cohen's d comparing Leaders (Managers/Executives) vs Professionals.

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

**Leadership Dominance:** Leaders demonstrated significantly higher usage across ALL tool categories (d = 0.74–1.14), with the largest effect for Microsoft Copilot.

#### Tool Usage and Behavioral Intention (H5)

The relationship between tool usage frequency and Behavioral Intention was examined using Spearman correlation due to ordinal tool usage distributions.

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.19: Tool Usage Correlation with Behavioral Intention}
\begin{tabular}{@{}>{\raggedright\arraybackslash}p{0.40\textwidth}ccp{0.28\textwidth}@{}}
\toprule
\textbf{Relationship} & \textbf{$\rho$} & \textbf{p} & \textbf{Interpretation} \\
\midrule
Total Usage $\times$ BI & .69 & <.001 & Strong positive \\
ChatGPT Usage $\times$ BI & .57 & <.001 & Strong positive \\
MS Copilot Usage $\times$ BI & .54 & <.001 & Moderate positive \\
Gemini Usage $\times$ BI & .52 & <.001 & Moderate positive \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

**H5 Result: [OK] Supported** – Higher behavioral intention is strongly associated with more frequent AI tool usage.

#### Role Differences in Tool Usage (H6)

One-way ANOVA with Tukey post-hoc tests examined role differences in tool usage patterns.

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.20: Role Differences in AI Tool Usage (ANOVA)}
\begin{tabular}{@{}>{\raggedright\arraybackslash}p{0.28\textwidth}cccp{0.22\textwidth}@{}}
\toprule
\textbf{Measure} & \textbf{F(2,520)} & \textbf{p} & \textbf{$\eta^2$} & \textbf{Post-hoc (Tukey)} \\
\midrule
Tool Breadth & 18.42 & <.001 & .066 & L > P > A \\
Usage Frequency & 22.15 & <.001 & .078 & L > P > A \\
Usage Intensity & 15.87 & <.001 & .058 & L > P > A \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

**H6 Result: [OK] Supported** – Leaders demonstrate significantly higher tool usage than Professionals, who in turn exceed Students.

#### Industry Experience Effect

Among professionals (n=184), correlation between years of industry experience and UTAUT constructs was examined.

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.21: Industry Experience Correlation with UTAUT Constructs}
\begin{tabular}{@{}lcc@{}}
\toprule
\textbf{Construct} & \textbf{r} & \textbf{p} \\
\midrule
Performance Expectancy & .10 & .176 \\
Behavioral Intention & .08 & .284 \\
Anxiety & --.12 & .104 \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

Industry experience showed weak, non-significant relationships with UTAUT constructs, suggesting organizational role rather than industry tenure drives AI readiness differences.



### 4.6.8 Exploratory Findings

#### User Typology (Cluster Analysis)

K-means cluster analysis (k=4) identified distinct user profiles based on UTAUT construct scores.

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.22: User Typology Cluster Analysis}
\small
\begin{tabular}{@{}>{\raggedright\arraybackslash}p{0.18\textwidth}rrccccp{0.28\textwidth}@{}}
\toprule
\textbf{Cluster} & \textbf{n} & \textbf{\%} & \textbf{PE} & \textbf{HM} & \textbf{AX} & \textbf{BI} & \textbf{Characterization} \\
\midrule
Enthusiasts & 84 & 16\% & High & High & Low & High & Early adopters, high engagement \\
Cautious Adopters & 157 & 30\% & Mod & Mod & Mod & Mod & Pragmatic, wait-and-see \\
Moderate Users & 191 & 37\% & Mod & Low & Mod & Low-Mod & Limited engagement, neutral \\
Anxious Avoiders & 91 & 17\% & Low & Low & High & Low & Resistant, anxiety-driven \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

#### Disability Status Analysis

Participants with disabilities (n=68, 13.0%) were compared to those without (n=444):

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.23: Disability Status Comparison of UTAUT Constructs}
\begin{tabular}{@{}>{\raggedright\arraybackslash}p{0.18\textwidth}cccccc@{}}
\toprule
\textbf{Construct} & \textbf{Disability M} & \textbf{No Disability M} & \textbf{t} & \textbf{p} & \textbf{d} \\
\midrule
AX & 3.68 & 3.35 & 2.77 & .006 & 0.36 \\
EE & 3.45 & 3.67 & --1.75 & .080 & 0.23 \\
BI & 3.01 & 3.23 & --1.54 & .124 & 0.20 \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Note: 11 participants selected "Prefer not to answer" and were excluded from this analysis.

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

**Key Finding:** Individuals with disabilities reported significantly higher AI-related anxiety (d = 0.36, p = .006), highlighting the importance of accessible and inclusive AI implementation strategies.

#### Qualitative Findings

Open-ended responses (n=243, 46.5% response rate) were analyzed using thematic analysis.

#### Theme Prevalence

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.24: Qualitative Theme Prevalence}
\begin{tabular}{@{}>{\raggedright\arraybackslash}p{0.45\textwidth}rr@{}}
\toprule
\textbf{Theme} & \textbf{n} & \textbf{\% of Responses} \\
\midrule
Positive Experience & 60 & 24.7\% \\
Work/Productivity & 47 & 19.3\% \\
Human Element & 33 & 13.6\% \\
Learning/Education & 33 & 13.6\% \\
Accuracy/Reliability & 26 & 10.7\% \\
Future/Potential & 14 & 5.8\% \\
Concerns/Caution & 14 & 5.8\% \\
Ethics/Privacy & 13 & 5.3\% \\
Cost/Access & 6 & 2.5\% \\
Job Replacement & 4 & 1.6\% \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Note: Responses could be coded to multiple themes (average 1.03 themes per response). 85 responses (35.0\%) had no identified themes.

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

#### Role Differences in Qualitative Themes

Chi-square tests (3-group: Student n=94, Professional n=83, Leader n=66) identified three themes with significant role differences:

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.25: Role Differences in Qualitative Theme Prevalence}
\begin{tabular}{@{}>{\raggedright\arraybackslash}p{0.28\textwidth}ccccccc@{}}
\toprule
\textbf{Theme} & \textbf{Student \%} & \textbf{Professional \%} & \textbf{Leader \%} & \textbf{$\chi^2$} & \textbf{p} & \textbf{V} \\
\midrule
Positive Experience & 29.8\% & 14.5\% & 30.3\% & 7.11 & .029 & .17 \\
Learning/Education & 21.3\% & 10.8\% & 6.1\% & 8.45 & .015 & .19 \\
Work/Productivity & 28.7\% & 13.3\% & 13.6\% & 8.65 & .013 & .19 \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

Students and Leaders reported more positive experiences, while Students focused more on educational applications.



## 4.7 Summary of Findings

### 4.7.1 Comprehensive Hypothesis Outcome Summary

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.26: Comprehensive Hypothesis Outcome Summary}
\begin{tabular}{@{}>{\raggedright\arraybackslash}p{0.30\textwidth}cccc@{}}
\toprule
\textbf{Category} & \textbf{Hypotheses} & \textbf{Supported} & \textbf{Partial} & \textbf{Not Supported} \\
\midrule
UTAUT2 Core (H1a-g) & 7 & 3 (43\%) & 0 & 4 (57\%) \\
AI Extension (H2) & 1 & 0 & 1 (marginal) & 0 \\
Moderation (H3-H4) & 2 & 0 & 2 (100\%) & 0 \\
Behavioral (H5-H6) & 2 & 2 (100\%) & 0 & 0 \\
\midrule
\textbf{TOTAL} & \textbf{12} & \textbf{5 (42\%)} & \textbf{3 (25\%)} & \textbf{4 (33\%)} \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

### 4.7.2 Hypothesis Details

```{=latex}
\begin{table}[H]
\centering
\caption{Table 4.27: Detailed Hypothesis Test Results}
\small
\begin{tabular}{@{}cl>{\raggedright\arraybackslash}p{0.50\textwidth}@{}}
\toprule
\textbf{Hypothesis} & \textbf{Description} & \textbf{Result} \\
\midrule
H1a & PE $\rightarrow$ BI (+) & Not Supported ($\beta$ = --.028) \\
H1b & EE $\rightarrow$ BI (+) & Not Supported ($\beta$ = --.008) \\
H1c & SI $\rightarrow$ BI (+) & \textbf{Supported} ($\beta$ = .136) \\
H1d & FC $\rightarrow$ BI (+) & Not Supported ($\beta$ = .059) \\
H1e & HM $\rightarrow$ BI (+) & \textbf{Supported} ($\beta$ = .217) \\
H1f & PV $\rightarrow$ BI (+) & \textbf{Supported} ($\beta$ = .505) \\
H1g & HB $\rightarrow$ BI (+) & Not Supported ($\beta$ = .023) \\
H2 & TR $\rightarrow$ BI (+) & Marginal (p = .064) \\
H3 & Experience moderates paths & Partial (HM$\times$Exp significant, p = .009) \\
H4 & Role group moderates paths & Partial (HM only, p = .041) \\
H5 & BI $\rightarrow$ Tool Usage & \textbf{Supported} ($\rho$ = .69) \\
H6 & Role usage differences & \textbf{Supported} (F = 22.15, p < .001) \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

Source: Compiled by Author

### 4.7.3 Key Contributions

1. **Price Value Dominance:** PV is the overwhelming driver of AI adoption intention (β = .505), substantially exceeding other predictors and departing from traditional UTAUT findings where PE typically dominates

2. **Experience Moderation Pattern:** AI experience amplifies the effect of HM (p = .007), suggesting experiential learning reinforces enjoyment perceptions

3. **Population Moderation:** Hedonic Motivation is significantly stronger for Students (β = 0.449) than Professionals (β = -0.301), indicating role-specific adoption drivers

4. **Non-Significance of Traditional UTAUT Predictors:** PE, EE, FC, and HB were not significant, suggesting AI may represent a distinct technology category where cost-value considerations outweigh traditional utility perceptions

5. **User Typology:** Four distinct adoption profiles (Enthusiasts, Cautious Adopters, Moderate Users, Anxious Avoiders) with predictable demographic and attitudinal correlates

### 4.7.4 Unexpected Findings

- **Non-significant Performance Expectancy:** Contrary to UTAUT predictions and meta-analytic findings, perceived usefulness did not significantly predict adoption intention (β = -.028, p = .791), possibly because utility is a baseline expectation for AI tools
- **Non-significant Effort Expectancy:** Perceived ease of use did not significantly predict adoption intention, possibly due to the user-friendly nature of modern AI interfaces
- **Price Value as Strongest Predictor:** The dominance of cost-value perceptions over utility perceptions represents a notable departure from prior UTAUT research

## 4.8 Chapter Conclusion

This chapter presented comprehensive empirical validation of the AIRS diagnostic instrument and structural model examining AI adoption in higher education. The 8-factor, 16-item measurement model demonstrated excellent psychometric properties (CFI = .975, α range .74–.91) with configural invariance across role groups. The 8-factor structure was selected over a more parsimonious 7-factor alternative because AI Trust provides essential diagnostic capability: the instrument enables identification of specific adoption barriers (trust deficits, value perceptions, social influence gaps) that inform targeted intervention design.

Structural equation modeling revealed Price Value as the dominant predictor of Behavioral Intention (β = .505), followed by Hedonic Motivation (β = .217, p = .014) and Social Influence (β = .136, p = .024). AI Trust approached but did not reach significance (β = .106, p = .064). Notably, traditional UTAUT predictors including Performance Expectancy, Effort Expectancy, Facilitating Conditions, and Habit were not significant, suggesting AI tools may represent a distinct technology category. Experience moderated the HM pathway, while population moderated HM effects with students weighting enjoyment more heavily than professionals.

Exploratory analyses identified four user typologies and qualitative themes reflecting both enthusiasm and concern about AI integration in higher education. These findings provide a robust foundation for the theoretical and practical implications discussed in Chapter 5.
