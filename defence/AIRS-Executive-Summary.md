---
title: "Executive Summary"
subtitle: "Artificial Intelligence Readiness Scale: Extending UTAUT2 for Enterprise AI Adoption"
author: "Fabio Correa"
date: "2026"
---

## 1. Research Problem and Significance

Artificial intelligence adoption in organizations has expanded rapidly. Industry data indicate that AI tool usage among knowledge workers rose from 50% in 2023 to 72% in 2024 and 88% in 2025. At the same time, reported organizational value realization remains limited: only 5% of organizations report measurable value from AI implementations, and 90–95% of generative AI pilot programs do not progress beyond initial trials. This adoption-value gap, where organizations invest in AI tools but do not consistently realize meaningful returns, presents an important problem for both scholarship and practice.

Three interconnected gaps motivated this research:

1. **Theoretical Gap.** The Unified Theory of Acceptance and Use of Technology (UTAUT2) was validated primarily for consumer mobile technologies. Whether its predictor structure holds for AI tools, a fundamentally different technology category characterized by autonomous decision-making, probabilistic outputs, and evolving capabilities, remained empirically untested.

2. **Measurement Gap.** No validated psychometric instrument existed for measuring AI-specific adoption readiness. Existing scales either operationalized general technology acceptance constructs or addressed narrow AI applications (e.g., healthcare robotics), leaving organizations without a diagnostic tool to assess workforce readiness for enterprise AI deployment.

3. **Practice Gap.** Organizations lacked evidence-based frameworks to identify specific barriers to AI adoption and design targeted interventions. Without systematic measurement, AI implementation strategies remained generic rather than responsive to the particular readiness profile of each workforce.

This dissertation addressed all three gaps by developing and validating the AI Readiness Scale (AIRS), a 16-item psychometric instrument that extends UTAUT2 with an AI Trust construct, offering both a theoretical account of adoption drivers and a practical diagnostic tool for organizational assessment.

## 2. Theoretical Framework

### 2.1 Foundation: UTAUT2

The study built upon the Unified Theory of Acceptance and Use of Technology 2 (UTAUT2), the most comprehensive and widely validated model of technology acceptance. UTAUT2 integrates seven constructs that predict Behavioral Intention:

| Construct | Definition |
|:--------------------------|:-------------------------------------------------------|
| Performance Expectancy (PE) | Perceived improvement in job performance from using the technology |
| Effort Expectancy (EE) | Perceived ease of learning and using the technology |
| Social Influence (SI) | Degree to which important others believe one should use the technology |
| Facilitating Conditions (FC) | Perception of available resources and support infrastructure |
| Hedonic Motivation (HM) | Pleasure or enjoyment derived from using the technology |
| Price Value (PV) | Perceived balance between benefits received and monetary cost |
| Habit (HB) | Extent to which technology use has become automatic |

The AIRS contribution is to test this framework for AI and add an AI Trust extension.

### 2.2 AI-Specific Extension: AI Trust

Recognizing that AI tools differ from conventional technologies in their capacity for autonomous reasoning, opaque decision processes, and evolving behaviors, the study introduced AI Trust (TR) as an eighth construct. AI Trust captures the degree to which users believe AI systems will provide accurate, reliable information and operate in a trustworthy manner. This extension was grounded in emerging literature identifying trust as a unique barrier to AI adoption that is not adequately captured by existing UTAUT2 constructs.

### 2.3 Research Questions and Hypotheses

The study posed one primary and five secondary research questions:

**Primary RQ:** To what extent does UTAUT2, extended with AI Trust, explain Behavioral Intention to adopt AI tools among United States students and professionals?

**Secondary RQs:**
- RQ2: Factorial validity and psychometric adequacy of the extended model
- RQ3: Experience and role moderation of structural paths
- RQ4: Relationship between behavioral intention and actual tool usage
- RQ5: User typology based on readiness patterns

Twelve hypotheses were tested: seven core UTAUT2 path hypotheses (H1a–H1g), one AI Trust hypothesis (H2), two moderation hypotheses (H3–H4), and two behavioral validation hypotheses (H5–H6).



## 3. Methodology

### 3.1 Research Design

The study employed a **post-positivist, sequential mixed-methods design with quantitative primacy**. The quantitative phase (psychometric validation and structural equation modeling) provided the primary evidence base; a qualitative phase (content analysis of open-ended responses) offered contextual elaboration and triangulation.

### 3.2 Instrument Development

The AIRS instrument was developed through a systematic process:

1. **Initial Item Pool:** 28 items across 12 constructs, adapted from validated UTAUT2 scales and supplemented with AI-specific items for Trust, Explainability, Ethical Risk, and AI Anxiety.

2. **Exploratory Factor Analysis (EFA):** Four competing factor models (Models A–D) were evaluated on the development subsample. Model D, the 8-factor, 16-item solution, was selected based on optimal factor structure, reliability, and theoretical interpretability.

3. **Construct Exclusion:** Four constructs were dropped due to inadequate item reliability:
   - Voluntariness (α = .41): Items conflated organizational mandates with personal freedom
   - Explainability (α = .58): Items mixed understanding with preference
   - Ethical Risk (α = .55): Items confounded job displacement with data privacy
   - AI Anxiety (α = .30): Items collapsed avoidance and approach coping behaviors

4. **Final Instrument:** 8 factors × 2 items each = 16 items, plus 4 Behavioral Intention items as the outcome variable.

### 3.3 Sample

**Participants:** N = 523 adults in the United States, recruited through Centiment, a professional survey research platform employing topic-blinded recruitment (respondents did not know the survey concerned AI when deciding to participate), mitigating self-selection bias.

**Collection Period:** October–November 2025 (3-week window)

**Role Distribution:**

| Group | n | % |
|:-------------------------------------------------|:----------|:----------|
| Academic (students) | 216 | 41.3% |
| Professional (individual contributors, freelancers) | 184 | 35.2% |
| Leader (managers, executives) | 123 | 23.5% |

**Disability Status:** 68 participants (13.0%) reported a disability; 11 selected "Prefer not to answer."

### 3.4 Analytical Strategy

A 10-phase analysis pipeline was executed across dual platforms (Python and R/lavaan) for cross-validation:

| Phase | Purpose |
|:----------|:----------------------------------------------------------------|
| 0 | Sample splitting (50/50, seed = 67, stratified by AI adoption) |
| 1 | Exploratory Factor Analysis (EFA) on development sample (n = 261) |
| 2 | Confirmatory Factor Analysis (CFA) on holdout sample (n = 262) |
| 3 | Measurement invariance testing |
| 4 | Structural Equation Modeling |
| 5 | Mediation analysis |
| 6 | Moderation analysis |
| 7 | Behavioral validation (tool usage) |
| 8 | Qualitative content analysis |
| 9–10 | Comprehensive review and synthesis |

**EFA specifications:** MINRES extraction with promax (oblique) rotation; item retention required primary loading ≥ .50, cross-loading gap ≥ .20, and communality ≥ .30.

**CFA/SEM estimation:** Maximum Likelihood with Satorra-Bentler robust corrections (MLM) via R/lavaan 0.6.21. Bootstrap validation: 1,000 resamples for path coefficient robustness. Measurement invariance, moderation, and behavioral validation were tested on the full sample (N=523).

## 4. Key Findings

### 4.1 Measurement Model: Psychometric Properties

#### Data Adequacy

The 16-item data demonstrated excellent suitability for factor analysis:
- **KMO** = .937 (superb)
- **Bartlett's Test** χ² = 4,668.45, p < .001
- No multivariate outliers detected (Mahalanobis distance, Bonferroni-corrected)

#### Confirmatory Factor Analysis (Holdout Sample, n = 262)

The 8-factor CFA model achieved excellent fit on the independent holdout sample:

| Index | Value | Threshold | Assessment |
|:----------------------|:--------------|:------------------|:------------------|
| CFI | .975 | ≥ .95 | Excellent |
| TLI | .960 | ≥ .95 | Excellent |
| RMSEA | .065 | ≤ .08 | Good |
| SRMR | .026 | ≤ .08 | Excellent |
| χ²/df | 2.10 | ≤ 3.0 | Good |

Full-sample CFA confirmed these results: CFI = .979, TLI = .966, RMSEA = .061, SRMR = .022.

#### Reliability

All eight factors exceeded conventional thresholds for internal consistency:

| Factor | Cronbach's α | Composite Reliability | AVE |
|:-----------------------------|:--------------|:-------------------|:----------|
| Performance Expectancy | .803 | .804 | .673 |
| Effort Expectancy | .859 | .861 | .756 |
| Social Influence | .752 | .763 | .621 |
| Facilitating Conditions | .743 | .750 | .601 |
| Hedonic Motivation | .864 | .865 | .763 |
| Price Value | .883 | .883 | .790 |
| Habit | .909 | .909 | .833 |
| Trust in AI | .891 | .891 | .804 |

All composite reliabilities met or exceeded .750 and all AVE values exceeded .50, confirming convergent validity.

> *Note:* Values shown are from the **holdout CFA (n = 262, lavaan 0.6.21, MLM)** to match thesis Table 4.x. Full-sample CFA was also run (CFI = .979, TLI = .966, RMSEA = .061, SRMR = .022) with directionally similar reliability/AVE; minor numerical differences reflect sample size and estimation method.

#### Discriminant Validity

Factor correlations ranged from r = .516 (EE × SI) to r = .911 (PE × PV). Four HTMT ratios exceeded the .85 threshold, concentrated in the PE–HM–PV triad:

| Pair | HTMT | Status |
|:------------------------|:------------------|:------------------------------|
| PE × PV | .902 | Exceeds threshold |
| PE × HM | .900 | Exceeds threshold |
| HM × PV | .904 | Exceeds threshold |
| HM × TR | .850 | At threshold |

These violations are structurally expected for 2-item-per-factor scales with conceptually adjacent constructs. The CFA model nonetheless demonstrated excellent overall fit, and the retained 8-factor structure provides essential diagnostic differentiation: each construct measures a distinct intervention target. The HTMT violations do not compromise the instrument's diagnostic purpose, as organizations benefit from separately assessing performance perceptions, enjoyment, and value even when these dimensions are highly correlated.

#### Measurement Invariance

Configural invariance was achieved across Academic and Professional groups (same factor structure holds in both populations). Metric invariance was partial: mean loading difference = .082, maximum Δλ = .326 (Social Influence). This level of invariance is sufficient for comparing structural relationships across groups.

| Group | CFI | RMSEA | SRMR |
|:---------------------------------|:-------------|:-------------|:-------------|
| Academic (n = 216) | .958 | .066 | .038 |
| Professional+Leader (n = 307) | .986 | .048 | .018 |

### 4.2 Structural Model: Hypothesis Testing

The structural model explained 89.7% of the variance in Behavioral Intention (R² = .897), an exceptionally high value indicating that the AIRS factors capture the vast majority of systematic variance in AI adoption intention.

#### Primary Path Coefficients (H1a–H1g, H2)

| Hypothesis | Path | β | p | 95% CI (z-test) | Bootstrap 95% CI | Result |
|:---------|:----------|:------|:------|:-----------------|:------------------|:---------------|
| H1a | PE → BI | −.028 | .791 | [−.234, .178] | --- | Not Supported |
| H1b | EE → BI | −.008 | .875 | [−.108, .092] | --- | Not Supported |
| H1c | SI → BI | **.136** | **.024** | [.018, .254] | [−.028, .298] | Supported‡ |
| H1d | FC → BI | .059 | .338 | [−.062, .180] | --- | Not Supported |
| H1e | HM → BI | **.217** | **.014** | [.044, .390] | [−.107, .483] | Supported‡ |
| H1f | PV → BI | **.505** | **<.001** | [.352, .658] | **[.218, 1.083]** | **Strongest** |
| H1g | HB → BI | .023 | .631 | [−.071, .117] | --- | Not Supported |
| H2 | TR → BI | .106 | .064 | [−.006, .218] | [−.096, .248] | Marginal |

‡z-test significant but bootstrap 95% CI includes zero; interpret as suggestive rather than conclusive (lavaan 0.6.21, 1,000 resamples).

Only Price Value's path was confirmed as robust under both z-test and bootstrap validation. Hedonic Motivation and Social Influence were z-test significant but bootstrap-unstable, suggesting their effects may be sensitive to sample composition.

#### Dominance of Price Value

Price Value emerged as the strongest predictor of AI adoption intention (β = .505), accounting for the largest share of explained variance. This pattern differs materially from much of the prior UTAUT literature, in which Performance Expectancy typically emerges as the dominant predictor:

- **Blut et al. (2022) meta-analysis:** PE was the dominant predictor across UTAUT studies (weighted β = .39)
- **Present study:** PE was non-significant (β = −.028), while PV dominated (β = .505)

This reversal suggests that AI tools represent a **distinct technology category** where perceived cost-value outcomes have displaced perceived utility as the primary adoption driver. A plausible interpretation: when users already regard AI's usefulness as a baseline expectation (which is supported by the uniformly high PE means in this sample), adoption decisions shift to whether the perceived benefits justify the financial investment.

#### AI Trust: Diagnostic Retention Rationale

Although AI Trust did not reach conventional significance (p = .064) and model comparison favored the 7-factor UTAUT2-only model on parsimony grounds (ΔAIC = +2.01), the 8-factor model was retained as the recommended diagnostic instrument for three reasons:

1. Trust provides unique diagnostic capability for organizations, identifying trust deficits that other constructs cannot detect
2. The marginal effect (β = .106) suggests theoretical relevance; detecting this effect at 80% power requires n > 600 (the present N = 523 yields ~68% power)
3. Organizations gain actionable insight from separately measuring trust, enabling targeted confidence-building interventions

> Sample/power note: n > ~600 is the target for re-testing Trust and mediation hypotheses in AIRS-28.

### 4.3 Moderation Effects

#### Experience Moderation (H3: Partially Supported)

Professional experience significantly moderated the HM → BI path (β = .136, p = .007). Professionals with 4+ years of experience weighted hedonic motivation more heavily in adoption decisions, suggesting that as users become more experienced with AI, the enjoyment dimension becomes increasingly important.

Usage-group comparison revealed complementary patterns:
- **Low-usage group:** Performance Expectancy mattered (β = .371, significant)
- **High-usage group:** Price Value dominated (β = .878, significant)

This pattern suggests adoption drivers evolve with experience: new users focus on utility; experienced users focus on value.

#### Population Moderation (H4: Partially Supported)

Hedonic Motivation showed significant population moderation (p = .041):
- **Academic group:** HM β = 0.449 (strong positive)
- **Professional group:** HM β = −0.301 (negative)

This divergence indicates fundamentally different adoption mechanisms: academics adopt AI tools partly for the enjoyment of exploration and learning, while professionals may view the same "enjoyment" dimension as irrelevant or even counterproductive to task-focused work. All other paths showed no significant population differences; Price Value remained dominant for both groups.

### 4.4 Behavioral Validation

#### Intention-Usage Relationship (H5: Supported)

Behavioral Intention was strongly associated with actual AI tool usage frequency (Spearman ρ = .69, p < .001), confirming that the AIRS instrument measures a construct with real behavioral consequences.

Individual tool correlations:
- ChatGPT usage × BI: ρ = .57
- Microsoft Copilot usage × BI: ρ = .54
- Google Gemini usage × BI: ρ = .52

#### Role Differences in Usage (H6: Supported)

One-way ANOVA confirmed a clear hierarchy: Leaders > Professionals > Academics across all usage measures:

| Measure | F(2,520) | p | η² |
|:------------------------------|:-------------------|:----------|:--------------|
| Tool Breadth | 18.42 | <.001 | .066 |
| Usage Frequency | 22.15 | <.001 | .078 |
| Usage Intensity | 15.87 | <.001 | .058 |

Leaders demonstrated particularly elevated usage of Microsoft Copilot (Cohen's d = 1.14 vs. Professionals), likely reflecting enterprise licensing and integration into organizational workflows.

### 4.5 User Typology

K-means cluster analysis (k = 3, silhouette = 0.271) identified three distinct user profiles:

| Cluster | n | % | Characterization | Mean BI |
|:---------|:-----|:-----|:---------------------------------------------|:----------|
| AI Enthusiasts | 162 | 31% | Early adopters with high engagement across all dimensions | 4.23 |
| Moderate Users | 246 | 47% | Pragmatic users near population means | - |
| AI Skeptics | 115 | 22% | Resistant users with below-mean readiness scores | 1.71 |

The three-cluster solution explained 65.9% of BI variance (F(2, 520) = 503.47, p < .001, η² = .659), confirming a clear readiness gradient.

This typology has direct organizational application: each segment requires a different intervention strategy. Enthusiasts can serve as change champions; Moderate Users respond to demonstrated value and peer influence; Skeptics require trust-building and anxiety-reduction interventions before engagement strategies will succeed.

### 4.6 Exploratory and Supplementary Findings

#### Disability and AI Anxiety

Participants with disabilities (n = 68, 13%) reported significantly higher AI-related anxiety (d = 0.36, p = .006) compared to non-disabled participants. This finding highlights the need for accessible and inclusive AI implementation strategies that specifically address anxiety barriers for users with disabilities.

#### Qualitative Themes

Open-ended responses (n = 243, 46.5% response rate) revealed:
- **Positive Experience** (24.7%) and **Work/Productivity** (19.3%) as the most prevalent themes
- **Human Element** (13.6%) and **Learning/Education** (13.6%) as secondary concerns
- **Accuracy/Reliability** (10.7%) reflecting trust-related concerns
- Academics emphasized educational applications; Leaders emphasized organizational productivity

#### Incremental Validity

Nested model comparison showed the UTAUT2-only model (AIC = 148.58) was marginally preferred over the 8-factor AIRS model (AIC = 150.59) on parsimony grounds (ΔAIC = +2.01). This confirms AI Trust's value is diagnostic rather than predictive: it adds organizational assessment capability without meaningfully improving overall model fit.

\Needspace{18\baselineskip}

## 5. Hypothesis Outcome Summary

Of 12 hypotheses tested:

| Category | Hypotheses | Supported | Partial | Not Supported |
|:---------------------|:----------|:-------------|:----------|:-----------------|
| UTAUT2 Core (H1a–g) | 7 | 3 (43%) | 0 | 4 (57%) |
| AI Extension (H2) | 1 | 0 | 1 (marginal) | 0 |
| Moderation (H3–H4) | 2 | 0 | 2 | 0 |
| Behavioral (H5–H6) | 2 | 2 (100%) | 0 | 0 |
| **Total** | **12** | **5 (42%)** | **3 (25%)** | **4 (33%)** |

The pattern of supported vs. unsupported hypotheses is itself a key finding: it reveals that AI adoption follows a different predictor structure than traditional technology adoption, with cost-value perceptions displacing utility perceptions as the primary driver.

## 6. Theoretical Contributions

### Contribution 1: Empirical Extension of UTAUT2 for Artificial Intelligence

This is the first study to empirically validate UTAUT2 for AI tool adoption with a purpose-built psychometric instrument. The 8-factor structure demonstrates that UTAUT2's theoretical architecture applies to AI contexts, but the relative importance of predictors shifts substantially. The finding that four traditional UTAUT predictors (PE, EE, FC, HB) were non-significant while Price Value dominated represents a meaningful advance in technology acceptance theory.

### Contribution 2: Price Value Dominance: AI as a Distinct Technology Category

The emergence of Price Value as the dominant predictor (β = .505) challenges decades of UTAUT research positioning Performance Expectancy as the primary adoption driver. The results suggest that, in AI contexts, utility may function more as a baseline expectation than as a differentiating factor, with adoption decisions more strongly shaped by perceived cost-benefit ratios. This has implications for how technology acceptance models are specified when applied to AI tools.

### Contribution 3: Career Development Integration with Technology Acceptance

The significant experience moderation of the HM → BI path (p = .007) and the population moderation finding (Academic β = 0.449 vs. Professional β = −0.301) establish that adoption mechanisms are career-stage dependent. This integration of career development theory with technology acceptance represents a novel theoretical bridge: the same technology produces fundamentally different adoption dynamics depending on whether users are in learning-oriented (academic) or task-oriented (professional) career stages.

### Contribution 4: Three-Segment User Typology

The empirically derived typology (Enthusiasts, Moderate Users, Skeptics) provides a segmentation framework grounded in validated psychometric dimensions rather than ad hoc categorization. The typology explained 65.9% of behavioral intention variance, confirming its validity as a practical classification tool.

### Contribution 5: Converging 2025 Industry Validation

Multiple independent industry reports (McKinsey 2025, BCG, MIT Media Lab, Georgian, ISG, Gartner, Deloitte, Lucidworks, Capgemini) reported patterns aligning with AIRS (value centrality, heterogeneous readiness, limits of one-size-fits-all strategies). These do not replace replication but provide useful context.

Emerging anxiety research (Kim 2025; Frenkenberg 2025) corroborates the need to redesign AI Anxiety items for AIRS-28.

### Contribution 6: Adoption-Value Gap Mechanisms

The study identified four specific mechanisms explaining why organizations struggle to realize AI value despite high potential: (1) **value communication misalignment**: organizations emphasize capability rather than ROI; (2) **heterogeneous readiness**: treating the workforce as monolithic when 22% are Skeptics requiring fundamentally different intervention; (3) **neglected affective barriers**: anxiety and hedonic motivation are ignored in favor of rational-utilitarian framings; and (4) **context-inappropriate frameworks**: applying generic technology adoption strategies that fail to account for AI's distinctive characteristics as a technology category. These four mechanisms provide a diagnostic vocabulary for explaining adoption failures and designing targeted responses.

## 7. Practical Implications

### For Organizations Deploying AI Tools

**Frame adoption in value terms.** Because Price Value is the strongest predictor of adoption intention, organizations should communicate AI investments in terms of tangible cost-benefit outcomes: time saved, errors reduced, and revenue generated. Change initiatives centered primarily on technical capability claims are likely to be less effective than those that demonstrate concrete financial and productivity returns.

**Use segmentation rather than uniform rollout.** The three-segment typology supports targeted intervention:
- **AI Enthusiasts (31%):** Deploy as change champions and peer influencers
- **Moderate Users (47%):** Provide value demonstrations and social proof from peers
- **AI Skeptics (22%):** Address trust barriers and anxiety before engagement; generic training will not move this group

**Tailor implementation to context.** Academic environments may benefit from emphasizing exploration and learning value (HM is a strong positive predictor), whereas professional environments may respond more strongly to practical value realization (HM is negative for professionals).

### For AI Tool Designers and Vendors

**Manage pricing and perceived value explicitly.** The prominence of Price Value suggests that pricing models, free tiers, and value communication directly shape adoption. Transparent pricing and clear ROI metrics should therefore be central to product strategy.

**Treat accessibility as an adoption condition.** The disability-anxiety finding (d = .36) indicates that universal accessibility principles are not only an inclusion issue but also an adoption issue. Users with disabilities may experience higher anxiety that suppresses uptake even when general interest is present.

### For Trainers and AI Educators

**Adopt anxiety-informed training design.** Training programs should address affective barriers in addition to skill gaps. The finding that users with disabilities experience heightened AI anxiety (d = .36) suggests training should incorporate emotional safety, graduated exposure, and relevant accommodations.

**Differentiate by career stage.** The population moderation finding (Academic HM β = 0.449 vs. Professional HM β = −0.301) means that training approaches effective in educational settings may backfire in professional contexts. Trainers should assess audience composition and adjust framing accordingly: exploration-oriented for academic audiences, value-oriented for professional ones.

### For Policymakers and Workforce Development

**Use AIRS as a planning instrument.** The AIRS instrument provides a standardized way to assess workforce AI readiness at organizational, regional, and national levels. Policymakers can use AIRS scores to identify communities and sectors where targeted AI literacy investment is most warranted.

**Plan for uneven readiness and equity effects.** The typology shows that 22% of users fall into the Skeptics category with markedly low readiness. Workforce development initiatives should recognize that a substantial minority requires different support strategies than the broader population.

### Structured Practitioner Recommendations

The dissertation provides eight specific practitioner recommendations derived from the SEM and typology findings:

1. **Conduct baseline AIRS assessment** before designing AI adoption initiatives: diagnose before prescribing.
2. **Lead with value**: frame AI in terms of cost-benefit returns (PV dominance), not capability showcases.
3. **Attend to affective barriers**: hedonic motivation and anxiety influence adoption beyond rational calculations.
4. **Leverage social influence**: peer champions and leadership endorsement are the third significant predictor (SI β = .136).
5. **Differentiate by experience level**: novice and experienced users respond to different adoption drivers.
6. **Monitor trust continuously**: trust does not predict adoption directly but functions as a diagnostic indicator and necessary condition.
7. **Design for accessibility**: universal design principles reduce anxiety-driven non-adoption among users with disabilities.
8. **Consider segment heterogeneity**: the three-segment distribution means any single intervention strategy will fail for at least one-third of the workforce.

## 8. Limitations

### Methodological

1. **Cross-sectional design.** All data were collected at a single time point, preventing causal inference about the direction of relationships or how adoption intentions evolve over time.

2. **Self-reported intention.** The outcome variable is behavioral intention rather than observed behavior. While BI-Usage correlation (ρ = .69) confirms meaningful association, intention does not perfectly predict behavior.

3. **Panel sampling.** Although topic-blinded recruitment mitigated self-selection bias, the Centiment panel may not be perfectly representative of the broader U.S. population of students and professionals.

### Measurement

4. **Two items per factor.** The 2-item-per-factor structure, while efficient, constrains reliability and contributes to elevated inter-factor correlations. The HTMT violations in the PE–HM–PV triad are partly a structural artifact of this design choice.

5. **Four dropped constructs.** Voluntariness, Explainability, Ethical Risk, and AI Anxiety were excluded due to inadequate reliability. These constructs warrant item redesign and re-investigation in future work, particularly AI Anxiety, which showed a meaningful disability association despite its psychometric failure.

6. **Marginal AI Trust.** The AI Trust extension did not reach conventional significance, limiting claims about its structural role. Its diagnostic value is supported by organizational assessment logic rather than predictive superiority.

7. **Western sample.** All participants were U.S.-based, limiting cross-cultural generalizability. AI adoption patterns may differ substantially in non-Western contexts where cultural attitudes toward technology, trust, and organizational hierarchy vary.

## 9. Special Section: Neurodiversity and Disability Insights

The AIRS dataset includes 68 participants (13.0%) who self-reported a disability, a proportion consistent with U.S. Census Bureau estimates and sufficient for exploratory between-group analysis. Although the study was not designed as a neurodiversity investigation, the disability-related findings are among the more practically salient results in the dissertation and warrant dedicated discussion.

### 9.1 The Core Finding: Disability–Anxiety Association

Participants with disabilities reported significantly higher AI-related anxiety than non-disabled participants (M = 2.89, SD = 1.08 vs. M = 2.48, SD = 0.96; t(521) = 2.76, p = .006, Cohen's d = 0.36). This is a small-to-medium effect size that remained the only statistically significant disability-related finding across all eight UTAUT2 constructs at α = .05. Critically, this finding emerged from the original AI Anxiety items that were subsequently excluded from the final AIRS-16 scale due to inadequate psychometric properties, meaning the association was detected *despite* measurement limitations, suggesting the true effect may be larger than observed.

### 9.2 Broader Pattern Across All Constructs

\Needspace{20\baselineskip}

| Construct | Disability M (SD) | No Disability M (SD) | Cohen's d | p |
|:----------------|:------------------|:---------------------|:----------|:----------|
| AI Anxiety | **2.89 (1.08)** | **2.48 (0.96)** | **0.36** | **.006** |
| Hedonic Motivation | **3.45 (0.98)** | **3.72 (0.92)** | **0.28** | **.030** |
| Effort Expectancy | 3.48 (0.89) | 3.68 (0.81) | 0.24 | .065 |
| Performance Expectancy | 3.54 (0.94) | 3.76 (0.89) | 0.22 | .086 |
| Behavioral Intention | 3.41 (1.02) | 3.64 (0.97) | 0.21 | .102 |
| Facilitating Conditions | 3.38 (0.91) | 3.52 (0.85) | 0.16 | .215 |
| Trust | 3.28 (0.92) | 3.41 (0.84) | 0.15 | .238 |
| Social Influence | 3.32 (0.95) | 3.43 (0.89) | 0.12 | .328 |

Two findings are statistically significant: AI Anxiety (d = .36) and Hedonic Motivation (d = .28, p = .030). The HM finding is noteworthy: participants with disabilities report significantly less enjoyment from AI tools, suggesting that current AI experiences are less pleasurable or more frustrating for this population. The remaining six constructs show consistent directional differences (d = 0.12–0.24) favoring the non-disabled group. While individually non-significant, the uniform direction (lower scores on every positive adoption construct and higher scores on anxiety) constitutes a coherent disadvantage profile rather than random noise.

### 9.3 Intersection with the User Typology

The three-segment typology (Enthusiasts 31%, Moderate Users 47%, Skeptics 22%) was derived from cluster analysis on the full sample. Although disability status was not used as a clustering variable, the consistent pattern of lower readiness scores among participants with disabilities suggests disproportionate representation in the Skeptics segment. If confirmed in future research with larger disability subsamples, this would mean that the 22% Skeptics category, already identified as requiring fundamentally different intervention, may partially reflect an accessibility-driven readiness gap rather than purely attitudinal resistance.

### 9.4 Implications for Neurodivergent and Disabled Users

The AIRS survey captured disability status through a single binary item, which does not distinguish between physical, cognitive, sensory, and neurodiverse conditions. However, several interpretive threads are relevant:

**AI Anxiety may reflect lived experience, not irrational fear.** For users who have repeatedly encountered inaccessible interfaces, poorly designed assistive technology integration, or algorithmic bias, elevated anxiety about a new technology class is a rational response to historical exclusion, not a deficit to be corrected.

**Hedonic Motivation suppression signals a design problem, not a user problem.** The significant HM gap (d = .28) implies that current AI tools are less enjoyable for users with disabilities. This points to accessibility failures in existing AI products: lack of screen reader compatibility, insufficient customization options, or interaction paradigms that assume neurotypical cognitive processing.

**The dropped AI Anxiety construct may be especially important for this population.** A notable implication of the psychometric results is that AI Anxiety, the construct showing the strongest disability signal, was excluded from the final scale. The AIRS-28 expansion should therefore prioritize redesigning anxiety items using neurodiversity-informed language and item stems that distinguish displacement-related anxiety from accessibility-barrier anxiety.

**Universal design as an adoption accelerator.** The data suggest that making AI tools more accessible would not only serve users with disabilities but may reduce anxiety-driven non-adoption more broadly. If the disability–anxiety association reflects design-induced friction, removing that friction benefits the entire user population: the "curb cut effect" applied to AI adoption.

### 9.5 Limitations and Future Neurodiversity Research

The current findings are exploratory and carry important caveats:

- **Small subgroup (n = 68)** limits statistical power for detecting smaller effects and prevents multi-category disability analysis.
- **Binary disability measure** conflates physical, sensory, cognitive, and neurodevelopmental conditions that likely have very different AI interaction profiles.
- **No neurodiversity-specific items** were included; conditions such as ADHD, autism, dyslexia, and anxiety disorders each interact with technology adoption through distinct mechanisms.
- **Self-report bias** may affect disability disclosure rates, particularly through the Centiment panel where 11 participants selected "Prefer not to answer."

Future research should: (1) recruit larger disability subsamples with condition-specific categorization; (2) develop neurodiversity-informed AIRS items that capture interaction-specific anxiety rather than generalized technology anxiety; (3) investigate whether accessibility features moderate the disability–anxiety relationship; and (4) test whether AIRS-guided interventions differentially benefit neurodiverse users.

## 10. Future Research Roadmap

The dissertation proposes a four-phase, multi-year research agenda, complemented by specific recommendations for scholars and awareness of the rapidly evolving AI landscape.

### Future Research Roadmap (Condensed)

**AIRS-28** (2026–2027): Expand to 3–4 items per factor (including redesigned Anxiety, Explainability, Ethical Risk) to resolve HTMT issues; target n > 600 for Trust power.

**Longitudinal + Cross-Cultural** (2026–2028): 12-month panel to test predictive validity; test invariance in non-Western contexts.

**Interventions** (2028–2029): RCTs comparing AIRS-guided vs generic training, segment-specific protocols.

**Prediction System** (2029+): Integrate AIRS scores with behavioral and context data for organizational readiness monitoring.

### Scholar Recommendations

The dissertation identifies seven specific methodological recommendations for future researchers:

1. **Larger samples (n > 600)** to increase power for multi-group and moderation analyses.
2. **Improved AI-specific measures** with 3–4 items per dimension to resolve the HTMT violations inherent in 2-item scales.
3. **PV dominance investigation**: replicate and explain why Price Value overtakes Performance Expectancy in AI contexts specifically.
4. **Career development integration**: study how adoption mechanisms change across career stages (student → early career → mid-career → senior).
5. **Typology validation**: confirm the three-segment structure in independent samples and test whether typology membership predicts actual adoption behavior.
6. **Cross-cultural replication**: establish measurement invariance across non-Western contexts where cultural attitudes toward technology, hierarchy, and trust differ.
7. **Longitudinal designs**: move beyond cross-sectional snapshots to track readiness trajectories and determine whether AIRS scores predict future behavior.

### Appropriate Reliance and Over-Reliance Research

A distinctive future direction concerns the paradox that optimizing AI adoption may inadvertently increase over-reliance. The AETHER group's Calibrated AI Reliance (CAIR) and Calibrated Self-Reliance (CSR) constructs suggest that the goal should not be maximum adoption but *appropriate* adoption, knowing when to use AI and when to rely on human judgment. This reframing from "more adoption is better" to "calibrated adoption is optimal" represents an important evolution of the research program. This line of inquiry is also extended in *The Life of Alex Finch* (AlexBooks, March 2026), a documentary biography of human-AI collaboration whose "Calibrated Confidence" chapter and scholarly appendix address over-reliance, verification, and preservation of human judgment in a more public-facing narrative form.

### 2026 Contextual Developments

The AI landscape has shifted materially since data collection (October–November 2025). Three developments frame the ongoing research agenda: (1) the DeepSeek R1 open-source release demonstrating that frontier AI capabilities are no longer exclusive to well-resourced organizations, changing the PV calculation entirely; (2) the emergence of agentic AI systems that operate with greater autonomy, raising new trust and control questions beyond the original AIRS scope; and (3) the EU AI Act's enforcement timeline, introducing regulatory compliance as a new adoption consideration absent from the current UTAUT2 framework. These developments do not invalidate the AIRS findings but they indicate that the construct space will need to expand to remain comprehensive.

## 11. Conclusion

This study developed and validated the AI Readiness Scale (AIRS), a 16-item psychometric instrument extending UTAUT2 with AI Trust to assess organizational AI adoption readiness. The instrument demonstrated strong psychometric performance (CFI = .975, all α > .74, all CR ≥ .75) and explained 89.7% of variance in behavioral intention to adopt AI tools.

The central finding, that Price Value, rather than Performance Expectancy, is the strongest predictor of AI adoption intention, qualifies established technology acceptance theory and carries direct practical implications. Organizations investing in AI should emphasize value demonstration and cost-benefit analysis rather than relying primarily on capability showcases. The three-segment user typology (Enthusiasts 31%, Moderate Users 47%, Skeptics 22%) offers a practical framework for workforce segmentation and targeted intervention design.

The AIRS instrument is sufficiently compact for organizational use while retaining meaningful diagnostic detail. Its 16-item structure supports large-scale administration, and its 8-factor measurement model provides actionable information about barriers related to performance perceptions, ease of use, social influence, facilitating conditions, hedonic motivation, price value, habit, and trust. In practical terms, the instrument helps translate AI readiness from a general concern into a set of measurable conditions that can be monitored and addressed through targeted intervention.

**Degree:** Doctor of Business Administration (DBA)
**Data Collection:** October–November 2025
**Analysis Pipeline:** Python + R/lavaan 0.6.21 (dual-platform validated)
**Sample:** N = 523 (United States students and professionals)
**Instrument:** AIRS 16-item scale (8 factors × 2 items + 4 BI items)

## Appendix A: AIRS-16 Final Validated Instrument

**Scale format:** 5-point Likert (1 = Strongly Disagree, 5 = Strongly Agree). Compute construct means (2 items each). Use BI items for research outcomes only; do not include BI in diagnostic composite.

| Construct | Item 1 | Item 2 |
|---|---|---|
| **Performance Expectancy (PE)** | PE1: AI tools help me accomplish tasks more quickly. | PE2: Using AI improves the quality of my work or studies. |
| **Effort Expectancy (EE)** | EE1: Learning to use AI tools is easy for me. | EE2: Interacting with AI tools is clear and understandable. |
| **Social Influence (SI)** | SI1: People whose opinions I value encourage me to use AI tools. | SI2: Leaders in my organization or school support the use of AI tools. |
| **Facilitating Conditions (FC)** | FC1: I have access to training or tutorials for the AI tools I use. | FC2: The AI tools I use are compatible with other tools or systems I use. |
| **Hedonic Motivation (HM)** | HM1: Using AI tools is stimulating and engaging. | HM2: AI tools make my work or studies more interesting. |
| **Price Value (PV)** | PV1: I get more value from AI tools than the effort they require. | PV2: Using AI tools is worth the learning curve. |
| **Habit (HB)** | HB1: Using AI tools has become a habit for me. | HB2: I tend to rely on AI tools by default when I need help with tasks. |
| **Trust in AI (TR)** | TR1: I trust AI tools to provide reliable information. | TR2: I trust the AI tools that are available to me. |

**Scoring guide:**
- Construct score = mean of its two items (range 1–5). Lower scores indicate potential barriers (e.g., PV low → value communication gap; TR low → trust deficit).
- **Composite AIRS Score (optional research metric):** Sum of eight construct means (range 8–40). Use with caution for diagnostics; construct-level insights are more actionable.

### Behavioral Intention (BI) — Research Outcome Only
| Item | Statement |
|---|---|
| BI1 | I am ready to use more AI tools in my work or studies. |
| BI2 | I would recommend AI tools to others. |
| BI3 | I see AI as an important part of my future. |
| BI4 | I plan to increase my use of AI tools in the next six months. |

> **Note:** BI items were used to validate the structural model; they are not part of the operational AIRS diagnostic score. For organizational deployments, report construct means and typology classification; keep BI for research/validation purposes.

## Appendix B: AIRS Enterprise — From Research to Practice

AIRS Enterprise ([airs.correax.com](https://airs.correax.com/)) operationalizes the validated AIRS-16 instrument as a production SaaS platform that delivers assessments, typology classification, personalized guidance, and longitudinal analytics. It also serves as a research infrastructure, closing the gap between academic instruments and real-world deployment.

### B.1 Platform Overview
- **Version:** v1.2.1 (General Availability)
- **Architecture:** Azure App Service Premium (P2v3), VNet integration, Managed Identity (no stored secrets), Microsoft Secure Future Initiative (SFI) alignment.
- **Auth:** Microsoft Entra ID (Microsoft/Google/Apple providers), optional org SSO.
- **Core stack:** Next.js 16.1, React 19, Prisma + PostgreSQL, Azure OpenAI GPT-4o-mini (streaming SSE), Playwright/Storybook for QA.
- **Security/Privacy:** SOC 2–aligned controls, zero-trust networking, audit logging, IRB-ready data export.

### B.2 Core Capabilities
| Capability | Description |
|---|---|
| **5-Minute Assessment** | Interactive AIRS-16 with save/resume, progress tracking, smart follow-ups |
| **AIRS Score** | Composite readiness (8–40), validated correlation **r = .876** |
| **Typology Classification** | 3-segment classifier (Enthusiasts/Moderate/Skeptics), **94.5% accuracy** |
| **Cut-point Model** | 8-construct cut-point classifier, **91.4% accuracy** (phase12) |
| **AI-Personalized Guides** | Streaming LLM (GPT-4o-mini) generates 3–5 page action plans per respondent |
| **Results Visualization** | Animated gauge, 8-axis radar chart, typology badge with context |
| **Multilingual Output** | 29 languages with browser auto-detection |
| **Org Management** | Team/department segmentation, CSV export, impact reporting |
| **Longitudinal Tracking** | Pre/post comparisons, trend charts, typology drift monitoring |

### B.3 Interventions: Semantics → Actions
**Evidence sources:** AIRS SEM (PV β = .505; HM β = .217; SI β = .136), McKinsey 2025 (N=1,993), UTAUT2 meta-analyses (417+ studies), change management literature.

**Segment frameworks (score bands & verbs)**

| Segment | Score Band | Primary Verb | What to Do |
|:--|:--|:--|:--|
| **Skeptics** | ≤ 20 | **TRANSFORM** | Trust-building, graduated autonomy, explainability tooling, human-in-the-loop
| **Moderate Users** | 21–30 | **REDESIGN** | ROI demonstrations, workflow integration, peer proof
| **Enthusiasts** | > 30 | **AMPLIFY** | Champion networks, advanced access, mentorship loops

**Construct-level interventions (formatted for slide use)**

| Construct | Barrier Signal | Intervention Patterns |
|:--|:--|:--|
| **Price Value** | Low ROI perception | TCO workshops; pilot→proof tracking; financial storytelling |
| **Hedonic Motivation** | Low engagement | Gamification; AI sandboxes; social learning |
| **Social Influence** | Weak advocacy | Champion programs; leadership comms; success stories |
| **Trust** | Reliability concerns | Explainability tools; human-in-the-loop controls; transparent error reporting |
| **Performance Expectancy** | Unclear benefits | Role-specific demos; before/after metrics |
| **Effort Expectancy** | Usability friction | Guided onboarding; contextual help; progressive modes |
| **Facilitating Conditions** | Infra/tooling gaps | Tool compatibility audits; training catalogs |
| **Habit** | Low default usage | Default AI-assisted flows; reminders; routines |

> Tip: Use `<br>` inside cells sparingly; semicolons are used here to keep the PDF layout compact while remaining readable.

### B.4 Consulting Model (Org Deployments)

| Phase | Timeline | Key Activities | Deliverables |
|:--|:--|:--|:--|
| **Baseline** | Weeks 1–2 | AIRS assessment across org; typology distribution; barrier prioritization | Baseline dashboard; barrier heatmap; segment mix |
| **Design** | Weeks 3–6 | Segment-specific intervention design; 90-day action roadmap | Playbooks per segment; prioritized interventions |
| **Execution & Tracking** | Ongoing (90-day cadence) | Dashboards; 90-day reassessments; effect-size tracking; continuous barrier monitoring | Quarterly impact reports; drift alerts; updated typology mix |

### B.5 Longitudinal Research Design
- **Temporal:** T1 (baseline), T2 (3 mo), T3 (6 mo), T4 (12 mo).
- **Norms:** Build population norms for 8+ groups (students, early/mid/senior professionals, tech, healthcare, finance, international) with **n = 300–500+** per group (2026–2028 targets).
- **Org-level metrics:** Team/department AIRS means, typology mixes, barrier heatmaps.
- **Effectiveness:** Pre/post effect sizes on PV/HM/SI/TR; anxiety/enjoyment tracking where collected.

### B.6 Competitive Positioning
Most AI readiness tools are either **validated but static** or **polished but unvalidated**. AIRS Enterprise pairs a published, validated instrument with a production platform and contributes back to the research database. Medium-term (1–3y): benchmark database growth. Long-term (3–5y): integrations with HRIS/LMS, enterprise partnerships, cross-cultural norms.

### B.7 Research-Practice Bridge
Every deployment produces structured data (construct scores, typology, demographics) that feeds the normative dataset and informs future recommendations. The platform is IRB-ready and supports reproducible research.

> **Related work:** *The Life of Alex Finch* (AlexBooks, 2026) covers calibrated reliance (CAIR/CSR) for public audiences. The platform adds the instrumentation layer to turn those principles into measurable practices.

*Detailed architecture diagrams, API references, and governance controls remain in the full Appendix B for reviewers who need implementation detail.*
