<!--
Gamma authoring note:
- Each slide includes hidden HTML comments with layout, table, and figure instructions.
- Use those comments as generation guidance rather than visible slide text.
- Prefer 16:9 layouts, strong headline hierarchy, and one dominant visual idea per slide.
- When a local figure path is provided, use it as source material if supported; otherwise recreate the visual from the stated data.
-->

# AIRS Dissertation Defense

## Artificial Intelligence Readiness Scale (AIRS)

Extending UTAUT2 for Enterprise AI Adoption

Fabio Correa

Doctor of Business Administration Defense

Touro University Worldwide

March 2026

<!--
Gamma:
- Layout: title slide with centered typography and one elegant hero visual.
- Visual: abstract human-AI collaboration image or network diagram; avoid generic robot imagery.
- Subtitle treatment: smaller, restrained, academic.
- Footer: Fabio Correa | DBA Defense | March 2026.
-->

---

# Presentation Roadmap

## What This Defense Covers

- Research problem and motivation
- Theoretical framework and research questions
- Methodology and validation pipeline
- Key empirical findings
- Contributions to theory and practice
- Future research and current research appendix

<!--
Gamma:
- Layout: horizontal agenda timeline with 6 segments.
- Visual: simple roadmap or progress bar rather than bullets alone.
- Emphasis: key findings and contributions as the visual focal points.
-->

---

# The Core Problem

## AI Adoption Is Rising Faster Than AI Value Realization

- AI tool use rose from 50% in 2023 to 72% in 2024 and 88% in 2025 among knowledge workers
- Only a small minority of organizations report measurable value from AI implementation
- Most generative AI pilots do not scale into sustained organizational value
- Organizations need better diagnostics for the human side of AI adoption

### Takeaway

The central problem is not only whether organizations deploy AI, but whether people are actually ready to adopt it effectively.

<!--
Gamma:
- Layout: 3 large stat cards across the slide with a short takeaway strip below.
- Table to render if helpful:
  Metric | Value | Meaning
  AI tool use among knowledge workers | 50% -> 72% -> 88% | Adoption rising quickly
  Organizations reporting measurable value | 5% | Value realization remains limited
  Generative AI pilots failing to scale | 90-95% | Implementation gap remains severe
- Visual alternative: sparkline for adoption trend plus a contrasting low-value indicator.
- Emphasis: create strong visual contrast between rising adoption and weak value realization.
-->

---

# Why This Research Matters

## Three Interconnected Gaps and Research Purpose

### Theoretical Gap

- UTAUT2 was validated primarily for consumer and conventional digital technologies
- It remained unclear whether its predictor structure would hold for AI tools

### Measurement Gap

- No validated psychometric instrument existed for AI-specific adoption readiness

### Practice Gap

- Organizations lacked an evidence-based diagnostic to identify specific adoption barriers

- Develop a psychometrically valid AI Readiness Scale
- Test whether UTAUT2 can be extended for AI contexts
- Examine which factors actually drive behavioral intention to adopt AI tools
- Produce a tool that is useful for both scholarship and organizational decision-making

<!--
Gamma:
- Layout: 3-column gap matrix on top, research purpose box on bottom.
- Visual: each gap as a card with icon: theory, measurement, practice.
- Table to render if useful:
  Gap | Problem | Dissertation response
  Theoretical | UTAUT2 not validated for AI | Extend UTAUT2 with AI Trust
  Measurement | No AI-specific validated scale | Develop AIRS
  Practice | No diagnostic intervention tool | Produce organizational assessment instrument
- Emphasis: show how one project answers all 3 gaps simultaneously.
-->

---

# Primary Research Question

## Main Question

To what extent does UTAUT2, extended with AI Trust, explain behavioral intention to adopt AI tools among United States students and professionals?

## Secondary Questions

- Does the extended model show factorial validity and psychometric adequacy?
- Do experience and role moderate structural relationships?
- Is behavioral intention associated with actual tool usage?
- Can meaningful user typologies be derived from readiness patterns?

<!--
Gamma:
- Layout: one prominent quote-style box for the main question, four smaller research cards beneath.
- Table to render:
  Question area | Focus
  Primary RQ | Explanatory power of extended UTAUT2
  RQ2 | Validity and psychometrics
  RQ3 | Moderation
  RQ4 | Intention and usage
  RQ5 | Typology
- Emphasis: present the primary RQ as the anchor and the secondary RQs as operational tests.
-->

---

# Theoretical Foundation

## UTAUT2 as the Starting Point

The study builds on seven established UTAUT2 constructs and their relationship to behavioral intention.

| Construct | Meaning |
|---|---|
| Performance Expectancy | Expected improvement in performance |
| Effort Expectancy | Perceived ease of use |
| Social Influence | Pressure or encouragement from others |
| Facilitating Conditions | Available support and infrastructure |
| Hedonic Motivation | Enjoyment and engagement |
| Price Value | Benefits relative to cost or effort |
| Habit | Automaticity of use |

<!--
Gamma:
- Layout: left side short rationale, right side table of constructs.
- Figure prompt: recreate a clean evolution diagram from TRA/TAM/UTAUT/UTAUT2 to AIRS.
- Optional source inspiration: airs_archive/thesis/chapters/02_literature_review.md Figure 2.1 and 2.2 references.
- Emphasis: UTAUT2 is the established backbone; AIRS is the AI-context extension.
-->

---

# AI-Specific Extension

## Why Add AI Trust?

- AI tools differ from conventional technologies in opacity, probabilistic outputs, and apparent autonomy
- Trust therefore becomes theoretically important in AI adoption
- The study introduces AI Trust as an eighth predictor construct

### Rationale

AI adoption is not just about usefulness and effort. It also depends on whether users believe AI systems are reliable and trustworthy.

<!--
Gamma:
- Layout: split slide with conceptual model on one side and rationale bullets on the other.
- Figure prompt: conceptual diagram showing UTAUT2 constructs plus Trust feeding Behavioral Intention.
- Optional local figure source if available in archived thesis figures: use 02_literature_review_fig2.png or recreate from thesis conceptual model.
- Emphasis: AI Trust is an extension, not a replacement of UTAUT2.
-->

---

# Research Design

## Overall Methodological Approach

- Post-positivist, sequential mixed-methods design with quantitative primacy
- Quantitative phase as the primary evidence base
- Qualitative content analysis used for contextual elaboration
- Cross-validation across Python and R/lavaan workflows

<!--
Gamma:
- Layout: methodological flow from quantitative core to qualitative support.
- Visual: simple layered diagram showing quantitative primacy with qualitative triangulation beneath.
- Table to render:
  Element | Role
  Quantitative phase | Validation and hypothesis testing
  Qualitative phase | Contextual elaboration
  Dual-platform analysis | Cross-validation
- Emphasis: mixed-methods, but quantitatively led.
-->

---

# Instrument Development

## From 28 Items to AIRS-16

### Starting Point

- 28 items across 12 constructs
- Included Trust, Explainability, Ethical Risk, and AI Anxiety

### Final Solution

- 8 factors
- 16 predictor items
- 4 behavioral intention items as the outcome variable

### Constructs Excluded

- Voluntariness
- Explainability
- Ethical Risk
- AI Anxiety

### Why Refinement Was Necessary

- Voluntariness items conflated mandates with personal freedom
- Explainability items mixed understanding with preference
- Ethical Risk items conflated distinct concerns
- AI Anxiety items collapsed different coping patterns

### Implication

The final instrument is shorter, stronger psychometrically, and more usable in organizational settings.

<!--
Gamma:
- Layout: funnel visual from 28 items / 12 constructs to 16 items / 8 factors.
- Table to render:
  Stage | Constructs | Items | Note
  Initial pool | 12 | 28 | Broad AI + UTAUT2 coverage
  Final AIRS | 8 | 16 | Psychometrically retained
- Visual detail: list dropped constructs as side tags with reasons.
- Optional figure: use or recreate scree/factor refinement narrative with fig_efa_scree.png as supporting image.
-->

---

# Sample and Data Collection

## Participant Overview

- N = 523 adults in the United States
- Topic-blinded recruitment through Centiment
- Data collection: October-November 2025

| Group | n | % |
|---|---|---|
| Academic | 216 | 41.3% |
| Professional | 184 | 35.2% |
| Leader | 123 | 23.5% |

- 68 participants reported a disability

<!--
Gamma:
- Layout: demographic table on left, sample overview figure on right.
- Figure source: ../airs_archive/thesis/figures/fig_sample_overview.png
- If figure cannot be imported, recreate as a sample pipeline diagram from recruitment to final N=523.
- Table emphasis: show near-balanced academic/professional split plus leadership representation.
-->

---

# Analytical Pipeline

## Validation Was Conducted in Stages

1. Sample splitting
2. Exploratory factor analysis
3. Confirmatory factor analysis
4. Measurement invariance testing
5. Structural equation modeling
6. Mediation and moderation analysis
7. Behavioral validation
8. Qualitative synthesis

### Key Technical Point

Authoritative fit indices and bootstrap validation were taken from R/lavaan.

<!--
Gamma:
- Layout: horizontal 8-step process timeline.
- Visual: numbered pipeline with EFA/CFA/SEM highlighted.
- Detail box: note that R/lavaan values are authoritative for fit and bootstrap conclusions.
- Emphasis: method was staged, not ad hoc.
-->

---

# Data Adequacy

## The Dataset Was Well Suited for Factor Analysis

- KMO = .937
- Bartlett's Test: significant at p < .001
- No problematic multivariate outliers retained

### Interpretation

The sample and correlation structure were strong enough to support factor analytic validation.

### Confirmatory Factor Analysis

The 8-factor AIRS model fit well.

| Index | Holdout Result | Assessment |
|---|---|---|
| CFI | .975 | Excellent |
| TLI | .960 | Excellent |
| RMSEA | .065 | Good |
| SRMR | .026 | Excellent |
| chi-square/df | 2.10 | Good |

### Full Sample Confirmation

CFI = .979, TLI = .966, RMSEA = .061, SRMR = .022

<!--
Gamma:
- Layout: top row stat chips for KMO/Bartlett/outlier status, bottom row model fit table.
- Table source values: current executive summary values are authoritative; do not reuse archived SRMR=.048 for final defense.
- Figure prompt: small scree or CFA loading visual as background support only.
- Optional figure source: ../airs_archive/thesis/figures/fig_efa_scree.png or ../airs_archive/thesis/figures/fig_cfa_loadings.png
- Emphasis: excellent fit on holdout sample first, then full-sample confirmation.
-->

---

# Reliability, Validity, and Invariance

## Internal Consistency Was Strong Across Constructs

- All Cronbach's alpha values exceeded .74
- All composite reliability values exceeded .75
- All AVE values exceeded .50

### Conclusion

The retained AIRS factors demonstrated acceptable to strong reliability and convergent validity.

- Factor correlations ranged from .516 to .911
- Four HTMT ratios exceeded the .85 threshold
- Violations were concentrated in the PE-HM-PV triad

### Interpretation

The discriminant validity issue is real and should be reported transparently, but it is partly structural for 2-item adjacent constructs and does not eliminate the instrument's diagnostic usefulness.

- Configural invariance achieved
- Metric invariance was partial
- Configural invariance was sufficient for comparing structural relationships

| Group | CFI | RMSEA | SRMR |
|---|---|---|---|
| Academic | .958 | .066 | .038 |
| Professional + Leader | .986 | .048 | .018 |

<!--
Gamma:
- Layout: 3-panel slide: reliability, discriminant validity caveat, invariance.
- Figure sources:
  - ../airs_archive/thesis/figures/fig_reliability.png
  - ../airs_archive/thesis/figures/fig_cfa_correlations.png
  - ../airs_archive/thesis/figures/fig_invariance_loadings.png
- Table option: mini-summary with Reliability | Discriminant validity | Invariance.
- Emphasis: strong instrument overall, with candid reporting of the HTMT limitation.
-->

---

# Structural Model Results

## AIRS Explained a Large Share of Behavioral Intention

- R-squared = .897 for behavioral intention
- The model explained most systematic variance in AI adoption intention

### Supported or Suggestive Paths

- Price Value -> BI: strongest and bootstrap-confirmed
- Hedonic Motivation -> BI: statistically significant but bootstrap-unstable
- Social Influence -> BI: statistically significant but bootstrap-unstable
- AI Trust -> BI: marginal

### Price Value Dominated AI Adoption Intention

| Path | Beta | p | Interpretation |
|---|---|---|---|
| PV -> BI | .505 | < .001 | Strongest predictor |
| HM -> BI | .217 | .014 | Suggestive |
| SI -> BI | .136 | .024 | Suggestive |
| TR -> BI | .106 | .064 | Marginal |

### Main Point

AI adoption in this sample was driven more by perceived value than by traditional performance utility.

<!--
Gamma:
- Layout: structural path figure on left, coefficient table on right.
- Figure source: ../airs_archive/thesis/figures/fig_structural_paths.png
- Table source: use the coefficients from the visible table; do not add unsupported paths.
- Visual alternative: horizontal coefficient bar chart with PV visually dominant.
- Emphasis: R-squared and PV dominance are the two focal elements.
-->

---

# Key Finding #2

## Performance Expectancy Was Not the Driver

- Performance Expectancy -> BI was non-significant
- Effort Expectancy, Facilitating Conditions, and Habit were also non-significant
- This pattern differs from much of prior UTAUT research

### Interpretation

For AI tools, usefulness may already be assumed. The decision shifts toward whether the benefits justify the cost, effort, or tradeoffs.

<!--
Gamma:
- Layout: comparison slide with traditional technology adoption on left and AI adoption on right.
- Visual: before/after paradigm shift diagram.
- Table to render:
  Traditional UTAUT pattern | AIRS pattern
  PE strongest | PV strongest
  Utility-centric | Value-centric
  Ease/support matter | Value and affect dominate
- Emphasis: make the contrast visually stark and simple.
-->

---

# Trust Interpretation

## Trust Mattered, But Differently Than Expected

- AI Trust did not reach conventional significance in the structural model
- Model comparison slightly favored the UTAUT2-only version on parsimony
- Trust was retained because it adds diagnostic value even if its direct predictive effect is limited

### Practical Meaning

Trust may function more as a diagnostic condition for intervention than as the primary direct driver of intention.

<!--
Gamma:
- Layout: 2x2 matrix: direct prediction vs diagnostic utility.
- Table to render:
  Question | Finding
  Direct path significant? | Marginal (.106, p=.064)
  Improves parsimony? | No, 7-factor model slightly preferred
  Retain in AIRS? | Yes, for diagnostic insight
- Emphasis: avoid framing trust as failure; frame it as a different kind of contribution.
-->

---

# Moderation Effects

## Adoption Mechanisms Changed by Experience and Population

### Experience Moderation

- Experience significantly moderated the HM -> BI relationship
- Newer users emphasized utility more strongly
- More experienced users weighted value more strongly

### Population Moderation

- HM was strongly positive for academics
- HM was negative for professionals

<!--
Gamma:
- Layout: left panel experience moderation, right panel academic vs professional moderation.
- Figure source: ../airs_archive/thesis/figures/fig_experience_moderation.png
- Table to render:
  Effect | Beta / Pattern | Interpretation
  HM x Experience | significant | enjoyment matters differently by experience
  HM academic vs professional | positive vs negative | population-specific adoption framing
- Emphasis: the committee should immediately see that adoption mechanisms are not uniform.
-->

---

# Behavioral Validation

## AIRS Predicted Real Usage Patterns

- Behavioral Intention correlated strongly with actual AI tool usage
- Spearman rho = .69, p < .001
- Tool-specific correlations were also strong for ChatGPT, Microsoft Copilot, and Google Gemini

### Implication

The instrument is not only statistically coherent. It is behaviorally meaningful.

<!--
Gamma:
- Layout: one chart plus a small correlation table.
- Figure source: ../airs_archive/thesis/figures/fig_usage_distribution.png
- Table to render:
  Outcome | Statistic
  BI vs AI tool use | rho=.69
  ChatGPT vs BI | rho=.57
  Microsoft Copilot vs BI | rho=.54
  Google Gemini vs BI | rho=.52
- Emphasis: show that AIRS predicts actual behavior, not just survey sentiment.
-->

---

# User Typology

## Three Readiness Segments Emerged

| Segment | % | Characterization |
|---|---|---|
| AI Enthusiasts | 31% | High engagement across dimensions |
| Moderate Users | 47% | Near the population mean |
| AI Skeptics | 22% | Low readiness and higher resistance |

### Why It Matters

The workforce is not homogeneous. Different segments need different intervention strategies.

<!--
Gamma:
- Layout: typology graphic as dominant visual with summary table beneath or to the side.
- Figure source: ../airs_archive/thesis/figures/fig_user_typology.png
- Important: use current 3-segment defense framing, not the archived 4-cluster draft as the main story.
- If recreating, use three segments only: Enthusiasts 31%, Moderate Users 47%, Skeptics 22%.
- Emphasis: segment heterogeneity is a practical intervention insight.
-->

---

# Neurodiversity and Disability Insight

## Accessibility Was Not Peripheral to Adoption

- Participants with disabilities reported higher AI anxiety
- AI Anxiety showed the clearest disability-related signal
- Hedonic Motivation was also lower for the disability group
- Across positive adoption constructs, the disability group showed a consistent disadvantage profile

### Implication

Accessibility should be treated as an adoption condition, not as a secondary implementation issue.

### Hypothesis Summary

Not all UTAUT2 expectations held in AI contexts.

| Category | Supported | Partial or Marginal | Not Supported |
|---|---|---|---|
| UTAUT2 Core | 3 | 0 | 4 |
| AI Extension | 0 | 1 | 0 |
| Moderation | 0 | 2 | 0 |
| Behavioral | 2 | 0 | 0 |

### Core Interpretation

The pattern of supported and unsupported hypotheses is itself a finding: AI adoption follows a different predictor structure than conventional technology adoption.

<!--
Gamma:
- Layout: two stacked zones: neurodiversity insight on top, hypothesis summary on bottom.
- Figure source for top: ../airs_archive/thesis/figures/fig_disability_anxiety.png
- Table source for top details: use disability section from Table 4.8 with d=.36 and p=.006 for anxiety, plus HM d=.28 p=.030.
- Optional mini-table:
  Construct | Disability effect
  Anxiety | d=.36, p=.006
  Hedonic Motivation | d=.28, p=.030
- Figure source for bottom: ../airs_archive/thesis/figures/fig_hypothesis_summary.png
- Emphasis: this is exploratory but practically important.
-->

---

# Contributions

## What This Study Adds to Scholarship and Practice

- First purpose-built psychometric validation of UTAUT2 for AI tool adoption
- Empirical evidence that Price Value can displace Performance Expectancy in AI contexts
- Integration of career-stage logic with technology adoption
- Evidence for a three-segment readiness typology
- Clearer diagnostic language for the adoption-value gap

- Frame AI adoption in value terms, not only capability terms
- Segment the workforce rather than relying on uniform rollout
- Treat trust and anxiety as intervention targets
- Design implementation and training differently for academic and professional populations
- Use accessibility and inclusion as central adoption design principles

<!--
Gamma:
- Layout: 2-column contributions slide: scholarship on left, practice on right.
- Visual: icons or paired cards for each side.
- Table to render if preferred:
  Scholarship contribution | Practice contribution
  UTAUT2 for AI | Value-led implementation
  PV dominance | Segment-specific intervention
  Career-stage moderation | Trust and anxiety as targets
  Typology | Accessibility as adoption condition
- Emphasis: make the theory-to-practice bridge explicit.
-->

---

# AIRS as a Diagnostic Instrument

## Why AIRS Is Practically Useful

- Short enough for large-scale administration
- Detailed enough to diagnose specific barrier patterns
- Applicable to baseline assessment, segmentation, and intervention planning
- Suitable for organizational, regional, and policy-level readiness assessment

### Practical Logic

Low PV means a value communication problem. Low TR means a trust problem. Low SI means an advocacy problem. The score profile suggests the intervention pathway.

### Research-to-Practice Extension: AIRS Enterprise

- AIRS has already been translated into a production SaaS platform
- The platform supports assessment, segmentation, personalized guidance, and longitudinal tracking
- This extends the instrument from academic validation into real-world organizational use

### Defense Value

This dissertation does not end at theory. It shows a credible pathway to implementation.

<!--
Gamma:
- Layout: top = AIRS diagnostic logic, bottom = AIRS Enterprise extension.
- Visual: radar chart mockup or score-profile diagnostic card leading to intervention recommendations.
- Table to render:
  Low score | Likely barrier | Organizational response
  PV | weak value communication | ROI framing
  TR | trust deficit | confidence-building and verification
  SI | weak advocacy | peer and leadership endorsement
- Visual cue for AIRS Enterprise: small product/system diagram rather than a marketing screenshot.
-->

---

# Future Research Roadmap

## Next Steps for the AIRS Program

1. Expand AIRS-16 to AIRS-28 with better coverage of dropped constructs
2. Conduct longitudinal validation
3. Test cross-cultural invariance beyond the U.S.
4. Evaluate intervention effectiveness by segment
5. Study appropriate reliance and over-reliance after adoption

<!--
Gamma:
- Layout: 5-step roadmap or staircase.
- Visual: near-term to longer-term research arc.
- Emphasis: AIRS-28, longitudinal validation, and appropriate reliance should be visually dominant.
- Optional caption: the dissertation establishes Phase 0 of a broader research program.
-->

---

# Closing Slide

## Main Conclusion and Q&A

This dissertation shows that AI adoption readiness can be measured validly, interpreted meaningfully, and used diagnostically.

### Final Claim

AIRS contributes a validated instrument, a revised account of AI adoption drivers, and a practical foundation for more effective AI implementation.

<!--
Gamma:
- Layout: clean closing slide with one strong concluding sentence and subdued supporting text.
- Visual: minimalist closing motif; avoid clutter.
- Emphasis: validated instrument + revised theory + practical implementation.
-->

---

# Appendix A1

## Converging 2025 Industry Validation

- Multiple independent industry reports aligned with the AIRS findings during the same period
- Convergent themes included perceived value, readiness heterogeneity, and failure of one-size-fits-all rollout strategies
- These reports do not replace replication, but they support the interpretation of the findings

### Examples

McKinsey, BCG, MIT Media Lab, Georgian, ISG, Gartner, Deloitte, Lucidworks, and Capgemini

<!--
Gamma:
- Layout: logo strip or evidence matrix.
- Table to render:
  Source | AIRS-aligned theme
  McKinsey | value realization gap
  MIT Media Lab | pilots fail to scale
  Gartner / Deloitte / BCG | readiness heterogeneity and implementation difficulty
- Emphasis: external convergence, not formal replication.
-->

---

# Appendix A2

## Current Research on AI Anxiety

- Emerging 2025 research distinguishes multiple forms of AI anxiety
- Anxiety may be anticipatory, existential, or tied to displacement concerns
- These findings support redesigning AI Anxiety items rather than abandoning the construct

### Program Implication

The AIRS-28 expansion should revisit anxiety with better measurement logic.

<!--
Gamma:
- Layout: 3-category framework with a small implication box.
- Visual: taxonomy diagram for anxiety subtypes.
- Emphasis: the construct failed psychometrically in AIRS-16 but remains theoretically important.
-->

---

# Appendix A3

## Appropriate Reliance and Over-Reliance

- Post-adoption quality matters, not only adoption quantity
- CAIR focuses on relying on AI when AI is right
- CSR focuses on relying on oneself when AI is wrong
- The real target is calibrated adoption, not maximal adoption

### Research Question

How can organizations improve adoption without creating dependence, complacency, or skill erosion?

<!--
Gamma:
- Layout: quadrant or 2x2 matrix showing correct AI-reliance and correct self-reliance.
- Visual prompt: calibrated reliance framework, not generic risk imagery.
- Emphasis: this appendix slide should foreshadow the next phase of AIRS research.
-->

---

# Appendix A4

## 2026 Contextual Developments

- Open-source frontier models changed the meaning of cost and value
- Agentic AI raises stronger trust, control, and oversight questions
- Regulatory developments such as the EU AI Act add compliance as a new adoption dimension

### Implication

The AIRS construct space will likely need expansion as the AI environment changes.

<!--
Gamma:
- Layout: 3 environmental drivers as equal cards.
- Visual: ecosystem shift slide with open-source, agentic AI, and regulation.
- Emphasis: AIRS findings remain valid, but the environment is changing fast.
-->

---

# Appendix A5

## AlexBooks Extension: The Life of Alex Finch

- The Life of Alex Finch is a published documentary biography of human-AI collaboration
- Its calibrated confidence material extends the dissertation's concern with verification and human judgment
- It provides a public-facing narrative form for the appropriate-reliance agenda

### Why Include It

It shows how the research program extends beyond measurement into broader questions of human agency and AI partnership.

<!--
Gamma:
- Layout: book cover / narrative extension slide.
- Visual source inspiration: sibling repo AlexBooks biography materials.
- Emphasis: treat this as research-program extension, not as a promotional detour.
- Visual tone: documentary, reflective, not commercial.
-->

---

# Appendix A6

## AIRS Enterprise as Longitudinal Infrastructure

- The platform creates a mechanism for repeated measurement over time
- It supports pre-post intervention comparison
- It can generate normative benchmarks across industries and populations

### Long-Term Value

This creates a practical pathway from dissertation validation to an ongoing research program.

<!--
Gamma:
- Layout: infrastructure diagram showing dissertation -> platform -> longitudinal data -> benchmarks -> future research.
- Visual: feedback loop rather than product screenshot.
- Emphasis: research infrastructure and longitudinal capability.
-->
