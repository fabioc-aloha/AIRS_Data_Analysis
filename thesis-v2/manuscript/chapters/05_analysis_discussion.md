\clearpage

# Chapter 5: Analysis and Discussion

## 5.1 Introduction

This chapter interpreted the empirical findings presented in Chapter 4, connecting the results to the theoretical framework and existing literature. The analysis proceeded systematically through each major finding, examining its meaning, comparing it with prior research, and exploring implications for both theory and practice. Unexpected findings and study limitations specific to interpretation were also addressed. Comprehensive conclusions, recommendations, and future research directions were presented in Chapter 6.



## 5.2 Interpretation of Findings

### 5.2.1 AIRS Diagnostic Instrument Validation

The study successfully validated an 8-factor, 16-item AI Readiness Scale extending UTAUT2 with AI Trust. The instrument demonstrated excellent psychometric properties across both development (n = 261) and holdout (n = 262) samples, with fit indices exceeding conventional thresholds (CFI = .975, TLI = .960, RMSEA = .065, SRMR = .026). The 8-factor structure was selected over a more parsimonious 7-factor model because AI Trust enabled diagnostic assessment: organizations could identify trust deficits and design targeted confidence-building interventions.

The cross-validation design (rarely employed in scale development research) provided strong evidence for the generalizability of the factor structure. The successful demonstration of configural invariance across academic and professional populations further supported the instrument's utility for diverse workplace contexts, though metric invariance was not fully achieved (mean Δλ = .082, max Δλ = .326).

### 5.2.2 Structural Model Results

Three of seven hypothesized UTAUT2 paths were significant:

- Price Value (β = .505, p < .001): Cost-benefit perception was the dominant driver
- Hedonic Motivation (β = .217, p = .014): Enjoyment significantly predicted adoption
- Social Influence (β = .136, p = .024): Peer influence mattered for AI adoption

The AI Trust extension approached but did not reach significance (β = .106, p = .064). While this fell short of conventional significance, the effect was retained as a diagnostic inclusion rather than a structural claim: detecting β = .106 at 80% power required n > 600, making the sample (N = 523, ~68% power) underpowered for this effect size. AI Trust provided essential diagnostic capability that could not be captured by the other seven constructs, enabling organizations to identify trust-specific barriers and design targeted confidence-building interventions. Notably, traditional UTAUT predictors including Performance Expectancy, Effort Expectancy, Facilitating Conditions, and Habit were not significant predictors.

### 5.2.3 Diagnostic Purpose Framing

The 8-factor AIRS structure was retained in its entirety, including the marginally significant AI Trust construct (β = .106, p = .064), because the instrument served a diagnostic rather than purely predictive purpose. While a more parsimonious model (e.g., excluding non-significant paths) would marginally improve statistical fit, it would sacrifice the diagnostic breadth required for organizational assessment. Practitioners administering AIRS need to identify *which specific readiness dimensions* are deficient in their workforce: trust deficits require different interventions than value perception gaps or social influence deficits. This diagnostic orientation aligned with established psychometric practice in clinical and organizational assessment, where construct coverage reflects theoretical breadth rather than empirical parsimony alone [@clarkwatson1995; @messick1995].

Bootstrap validation (1,000 resamples, R/lavaan) confirmed that only Price Value demonstrated robust significance across both z-test and bootstrap methods. Hedonic Motivation and Social Influence were z-test significant but bootstrap-unstable (CIs including zero), suggesting their structural effects might be sensitive to sample composition. These constructs nonetheless retained diagnostic value: HM demonstrated reversed population effects (Academic β = 0.449 vs. Professional β = −0.301), and SI captured peer influence dynamics relevant to intervention design.

### 5.2.4 Discriminant Validity Considerations

The high inter-factor correlations among PE, HM, and PV (r = .898–.911) represented a measurement challenge characteristic of 2-item-per-factor scales measuring conceptually adjacent constructs [@marsh1998]. Five Fornell-Larcker violations and four HTMT ratios exceeding .85 (PE×PV = .902, PE×HM = .900, HM×PV = .904, HM×TR = .850) indicated that the current 16-item scale did not fully achieve discriminant separation for the PE/HM/PV triad.

Three findings supported retaining separate factors despite this limitation: (a) the constructs served distinct diagnostic functions enabling targeted intervention design: low PV required value messaging while low HM required engagement redesign; (b) they demonstrated differential population sensitivity, with HM showing reversed effects across academic and professional samples (β = 0.449 vs. −0.301, p = .041); and (c) theoretical continuity with UTAUT2 enabled cumulative science and meta-analytic integration. The AIRS-28 development roadmap (§6.7.3) addressed this limitation through item pool expansion, which was expected to improve discriminant separation [@dewinter2009].



## 5.3 Comparison with Existing Literature

### 5.3.1 Price Value as Dominant Predictor

Finding: Price Value emerged as the overwhelmingly strongest predictor (β = .505, p < .001), substantially exceeding all other constructs.

Comparison with Prior Research: This finding represented a significant departure from traditional UTAUT research where Performance Expectancy typically dominates. @blut2022's meta-analysis of 737,112 users found Performance Expectancy to be the strongest predictor (ρ = .60) across technology contexts. The reversal observed in this study suggested fundamental differences in how users evaluated AI tools compared to conventional technologies.

Industry Context: This finding gained significance against the adoption-value gap documented in §2.3: despite high adoption rates, few organizations achieved measurable returns. McKinsey's 2025 global survey reinforced this pattern: while 88% of organizations had adopted AI, only 33% were "scaling" AI beyond isolated pilots, with larger companies (48%) significantly outpacing SMBs (29%) in achieving systematic deployment [@mckinseyStateAI2025]. The gap suggested organizations deployed AI without effectively communicating value to end users, precisely the construct captured by Price Value.

Interpretation: In the AI context, users appeared primarily motivated by perceived value relative to cost rather than raw productivity benefits (PE, ns), ease of use (EE, ns), organizational support (FC, ns), or habit (HB, ns). This suggested a hypothesis for future research: AI adoption interventions might be more effective when they prioritize demonstrating clear return on investment rather than focusing solely on capability demonstrations.

Theoretical Implications: The dominance of Price Value over Performance Expectancy suggested AI tools might represent a distinct technology category. Unlike previous technologies where utility perceptions drove adoption, AI adoption appeared more influenced by value propositions, potentially reflecting the freemium pricing models common in AI tools, concerns about ongoing subscription costs, or cost-benefit analyses comparing AI tools to traditional methods.

### 5.3.2 Non-Significant UTAUT2 Paths

Finding: PE, EE, FC, and HB were not significant predictors.

Comparison with Prior Research: The non-significance of Performance Expectancy (β = -.028, p = .791) was particularly noteworthy given its historical dominance in technology acceptance research. @davis1989's TAM established perceived usefulness as the primary adoption driver, and this finding had been replicated across thousands of studies. The present results challenged this assumption for AI contexts.

Industry Context: The non-significance of Effort Expectancy and Facilitating Conditions aligned with industry observations about modern AI implementation. Deloitte's State of Generative AI research identified skill gaps as a persistent barrier to AI integration [@deloitte2024genai], yet users in this study did not cite ease-of-use or organizational support as adoption drivers. This disconnect suggested a maturation in AI tool interfaces: contemporary consumer-facing AI (e.g., ChatGPT, GitHub Copilot) had achieved such usability that effort perceptions no longer differentiated adoption decisions. The barrier had shifted from "Can I use this?" to "Is it worth my investment?"

Interpretation: In the AI context, perceived usefulness might have been a baseline expectation rather than a differentiating factor. Users might have assumed AI tools would enhance productivity, making cost-benefit considerations (Price Value) and enjoyment (Hedonic Motivation) the deciding factors.

Similarly, the non-significance of Effort Expectancy (β = -.008, p = .875) and Facilitating Conditions (β = .059, p = .338) might have reflected the increasingly user-friendly nature of modern AI tools and widespread organizational technology infrastructure. Contemporary AI interfaces have achieved remarkable usability, potentially creating ceiling effects for ease-of-use perceptions.

### 5.3.3 AI Trust Marginality

Finding: TR approached but did not reach significance (β = .106, p = .064).

Comparison with Prior Research: Emerging AI adoption research has increasingly emphasized trust as a critical determinant [@glikson2020; @siau2018]. The marginal effect observed here partially supports this theoretical direction while highlighting the need for more sensitive measurement or larger samples.

Industry Context: The marginal significance of AI Trust resonated with industry findings on governance and accountability barriers. Gartner identified governance maturity as a key differentiator, with substantial proportions of AI projects experiencing delays due to governance, compliance, or accountability issues [@gartner2025]. The Georgian AI Benchmark found that only 32% of organizations had achieved cross-functional AI deployment, with trust and governance cited as key inhibitors [@georgian2025]. These industry challenges suggested that trust, while marginally significant at the individual level, might become increasingly central as AI applications matured and governance requirements intensified.

Interpretation: The marginal significance of AI Trust suggested it might become a more important predictor as AI technologies matured and trust concerns became more salient. The current sample may have had insufficient power to detect the effect (β = .106 required n > 600 for 80% power at α = .05), or trust considerations may have been less central for the relatively straightforward AI tools then in use. Future research should examine whether AI Trust becomes more predictive for high-stakes AI applications (e.g., AI-assisted decision-making, autonomous systems).

### 5.3.4 Experience as Moderator

Finding: Professional experience strengthened HM -> BI (β = .136, p = .007).

Comparison with Prior Research: While UTAUT specified experience as a moderator, it conceptualized experience as technology familiarity rather than career development. The present finding integrated career development theory [@super1980] with technology acceptance, suggesting that vocational maturity influenced technology evaluation processes.

Interpretation: The significant moderation effect suggested that experienced professionals placed greater weight on enjoyment when evaluating AI tools. This might reflect that experienced users, having satisfied basic competency needs, prioritized intrinsic satisfaction. Additionally, usage frequency moderated the importance of Performance Expectancy (for new users) versus Price Value (for heavy users).

### 5.3.5 Converging Literature Validation

An important methodological note is warranted regarding the alignment between this study's theoretical framework and the broader 2025 literature. The theoretical framework, including the decision to extend UTAUT2 with AI-specific constructs such as Trust and Anxiety, was specified before fieldwork began in October 2025. During the research design, data collection, and writing phases, a rapidly expanding body of industry research and academic work independently corroborated the study's theoretical positioning and empirical findings.

Industry Validation of the Adoption-Value Gap. When the research framework was designed, the adoption-value gap was an emerging pattern supported primarily by McKinsey's 2023–2024 State of AI reports and early BCG findings. Throughout 2025, this pattern was confirmed by at least eight additional sources:

- McKinsey's 2025 report documented adoption reaching 88% while only 6% of organizations achieved meaningful EBIT impact [@mckinseyStateAI2025]
- BCG quantified that just 5% of companies realize measurable AI returns, with 74% stuck at proof-of-concept [@bcgAIAdoption2025]
- The MIT Media Lab NANDA Initiative estimated 90–95% failure rates for generative AI pilots at scale [@mitMediaLab2025]
- Georgian's AI Benchmark found only 32% cross-functional deployment [@georgian2025]
- ISG, Gartner, Deloitte, Lucidworks, and Capgemini each identified governance deficits, skill gaps, and scaling failures as systemic barriers [@isg2025; @gartner2025; @deloitte2024genai; @lucidworks2025; @capgemini2025]

This converging evidence demonstrated that the adoption-value gap was robust, widespread, and not an artifact of any single report's methodology. The present study's finding that traditional UTAUT2 predictors (Performance Expectancy, Effort Expectancy) failed to reach significance while value-oriented constructs dominated aligned with this industry consensus: organizations had moved past questions of *whether AI works* to questions of *whether AI is worth it*.

Academic Validation of AI-Specific Constructs. The decision to include AI Anxiety as a proposed inhibitor construct was informed by @tao2020's early dimensional work. Two recent publications further strengthened this theoretical basis:

- @kim2025 identified "annihilation anxiety" (existential concerns about human relevance) as a distinct dimension particularly salient among knowledge workers, precisely the population this study sampled
- @frenkenberg2025 distinguished anticipatory anxiety (about future AI capabilities) from present-state anxiety, providing a theoretical explanation for why the two-item AX scale in this study (which conflated avoidance and approach motivations) demonstrated inadequate reliability (α = .301)

These findings validated both the theoretical importance of anxiety as an AI adoption construct and this study's empirical conclusion that more sophisticated, multi-dimensional measurement was required (see §5.6.2).

Significance. The convergence between this study's a priori theoretical choices and the 2025 evidence base provided a form of concurrent validation. The framework was not retrofitted to accommodate new findings; rather, the constructs selected for investigation (trust, anxiety, value perception, governance) were precisely those the field had independently identified as central to explaining the adoption-value gap.



## 5.4 Implications for Theory

### 5.4.1 UTAUT2 Extension

The study extended UTAUT2 with AI-specific constructs, demonstrating that traditional technology acceptance frameworks required context-sensitive modification. The dramatic shift in predictor importance, from Performance Expectancy dominance to Price Value dominance, suggested that AI represented a theoretically distinct technology category.

### 5.4.2 Context-Specific Model

The findings supported calls for domain-specific UTAUT extensions [@blut2022]. Rather than applying generic technology acceptance models, researchers should develop and validate context-appropriate extensions that capture the unique psychological processes relevant to each technology category.

### 5.4.3 Price Value Dominance

The finding that Price Value (β = .505) rather than Performance Expectancy drove AI adoption represented a significant theoretical departure from traditional UTAUT research. This suggested AI tools were evaluated through a value lens ("Is it worth it?") rather than a utility lens ("Will it help me?"). Users might assume AI would be useful but evaluate whether the investment (in time, effort, or cost) was justified.

### 5.4.4 Non-Significance of Traditional Predictors

The non-significance of PE, EE, FC, and HB suggested AI might represent a distinct technology category requiring tailored theoretical frameworks. Unlike previous technologies where utility perceptions drove adoption, AI adoption appeared more influenced by value propositions, potentially reflecting:

- Freemium pricing models common in AI tools created cost-benefit salience
- Maturation of AI interfaces had created ceiling effects for ease-of-use perceptions
- Widespread organizational technology infrastructure made facilitating conditions a baseline expectation

### 5.4.5 Experience-Dependent Mechanisms

The experience moderation of HM (p = .007) suggested that adoption mechanisms differed by user characteristics in ways not previously documented in technology acceptance research. Experienced professionals placed greater weight on enjoyment when evaluating AI tools, possibly reflecting that users who had satisfied basic competency needs prioritized intrinsic satisfaction.

### 5.4.6 Population-Specific Pathways

Differential HM effects across populations (Academic β = 0.449 vs. Professional β = -0.301, p = .041) indicated that adoption interventions might need to be tailored to specific user groups. Academics weighted enjoyment heavily; professionals might have prioritized other factors.

### 5.4.7 Career Development Integration

The significant experience moderation effect introduced career development as a relevant theoretical domain for technology acceptance research. Future models should consider how career stage and professional identity influence technology evaluation and adoption decisions.

### 5.4.8 User Typology Framework

The empirically-derived three-segment typology (k=3, silhouette=0.271) provided a framework for understanding adoption heterogeneity:

- AI Enthusiasts (31%, n=162): High adoption readiness across all constructs (~0.9 SD above mean), high Behavioral Intention (mean BI=4.23)
- Moderate Users (47%, n=246): Near-population-mean scores across all constructs, pragmatic orientation
- AI Skeptics (22%, n=115): Below-average scores across all constructs (~1.2 SD below mean), low Behavioral Intention (mean BI=1.71)

This segmentation approach moved beyond mean-level analysis to acknowledge individual differences in adoption psychology. The three-segment solution captured a clear readiness gradient that explained 65.9% of BI variance (F=503.47, p<.001), confirming the typology identified adoption-relevant heterogeneity. Whether these segments responded differentially to targeted interventions required experimental validation. Figure 5.1 illustrated the distribution and characteristics of the three user segments.

![Three-segment user typology derived from cluster analysis. Segment sizes represent proportions of the sample, with distinct profiles across adoption readiness constructs. *Source: Compiled by Author*](figures/fig_user_typology.png){#fig:user-typology}

Source: Compiled by Author



## 5.5 Implications for Practice

The findings offered insights for organizations navigating AI adoption challenges. As documented in §2.3, the gap between adoption and value realization represented a critical business challenge. While this study validated a measurement instrument rather than testing interventions, the empirical findings suggested several evidence-informed directions.

Important Scope Note: The AIRS diagnostic instrument validated in this study provided a psychometrically sound measure of AI adoption readiness constructs. The 8-factor structure enabled identification of specific adoption barriers (e.g., trust deficits, inadequate perceived value, low social influence) that could inform intervention design. The practical applications suggested below were hypotheses derived from the empirical findings. Future experimental research is needed to validate intervention effectiveness. The author's research roadmap included developing formal AIRS Score algorithms, diagnostic protocols, and intervention frameworks as subsequent research phases.

### 5.5.1 For Organizations

Lead with Value, Not Capabilities: The dominance of Price Value (β = .505) over Performance Expectancy (ns) suggested a potential shift in how organizations might approach AI implementation communications. Rather than emphasizing AI capabilities and productivity promises, the findings suggested that demonstrating return on investment and cost-effectiveness might be more influential. Capgemini's research supported this direction, finding that organizations redesigning workflows around AI, rather than simply adding AI to existing processes, achieved substantially higher returns [@capgemini2025].

Consider Adoption Heterogeneity: The three-segment typology (§4.6) suggested that user populations varied systematically in their AI readiness profiles, with each segment potentially responding to different intervention approaches.

Leadership Engagement: Leaders in this study demonstrated the highest AI tool usage (d = 0.74–1.14). McKinsey's research confirmed that organizations where senior leadership took ownership of AI initiatives were three times more likely to achieve value from their investments [@mckinseyStateAI2025]. Visible leadership engagement might amplify adoption efforts.

### 5.5.2 For AI Tool Designers

Pricing strategy might significantly influence adoption, potentially more so than feature development. The dominance of Price Value suggested that pricing models (freemium tiers, transparent costs, usage-based billing) warranted careful attention. The significant Hedonic Motivation effect (β = .217) also suggested value in investing in enjoyable user experiences.

### 5.5.3 For Trainers and Educators

The AI Skeptics segment (22%), characterized by below-average scores across all adoption readiness constructs, suggested that training programs might benefit from addressing resistance barriers alongside technical skills. The disability-anxiety association (d = .36) highlighted the importance of accessibility-centered training design, addressing both physical accessibility (screen readers, motor-accessible interfaces) and neurodivergent considerations (predictable interactions, reduced cognitive load). These findings warranted experimental validation of targeted approaches in AI training contexts.

### 5.5.4 For Policy Makers

The validated AIRS diagnostic instrument provided a foundation for future organizational AI readiness assessment research. The 8-factor structure enabled identification of population-level adoption barriers that could inform workforce development policy. The differential anxiety findings (disability association d = .36) highlighted equity considerations in AI adoption policy that warranted further investigation.

### 5.5.5 Understanding the Adoption-Value Gap

The findings illuminated mechanisms that might have contributed to the adoption-value gap documented in §2.3:

1. Value Communication Misalignment: Organizations might have led with capability demonstrations when users actually evaluated cost-benefit ratios. Future research should test whether value-focused messaging improves outcomes.

2. Heterogeneous Readiness: One-size-fits-all approaches might have failed because user populations varied systematically. The three-segment typology provided a framework for intervention research.

3. Neglected Affective Barriers: The AI Skeptics segment and marginal Trust effect suggested psychological barriers might have been underaddressed.

4. Context-Inappropriate Frameworks: The shift from Performance Expectancy to Price Value dominance demonstrated why context-specific instruments were valuable.



## 5.6 Unexpected Findings

### 5.6.1 Performance Expectancy Non-Significance

The non-significance of Performance Expectancy was unexpected given its historical dominance in technology acceptance research. This finding suggested that AI adoption operated through different psychological mechanisms than conventional technology adoption, potentially because productivity benefits were now assumed rather than evaluated.

### 5.6.2 Dropped Constructs

Four proposed AI-specific constructs demonstrated inadequate reliability and were excluded from formal hypothesis testing:

```{=latex}
\begin{table}[H]
\centering
\caption{Constructs Excluded During Validation}
\begin{tabular}{@{}lc>{\raggedright\arraybackslash}p{0.30\textwidth}>{\raggedright\arraybackslash}p{0.28\textwidth}@{}}
\toprule
\textbf{Construct} & \textbf{Cronbach's $\alpha$} & \textbf{Issue Identified} & \textbf{Future Recommendation} \\
\midrule
Voluntariness (VO) & .406 & Choice vs. freedom dimensions conflated & Revise operationalization \\
Explainability (EX) & .582 & Understanding vs. preference dimensions conflated & Develop AI-specific items \\
Ethical Risk (ER) & .546 & Job displacement vs. privacy dimensions conflated & Context-specific measurement \\
AI Anxiety (AX) & .301 & Avoidance vs. approach motivations conflated & Validated anxiety scale adaptation \\
\bottomrule
\end{tabular}

\vspace{0.5em}
\footnotesize Source: Compiled by Author
\end{table}
```

Interpretation: Two-item scales proved insufficient for these multi-dimensional constructs. This represented an empirical finding about measurement complexity rather than theoretical invalidity. These constructs remained theoretically important for AI adoption and warranted revised measurement approaches in future research.

Future Development Recommendations:
- For AI Anxiety specifically, future scales should distinguish between technology avoidance anxiety and fear-of-missing-out (FOMO) or obsolescence anxiety, as these represent conceptually distinct motivational orientations
- Each excluded construct requires 3-4 items per sub-dimension to adequately capture its multi-faceted nature
- Context-specific item development may be necessary for constructs like Ethical Risk, which may manifest differently across professional domains

### 5.6.3 Disability and Accessibility

Finding: Disability status was associated with higher AI-related anxiety responses (d = .36), based on exploratory analysis of original AX items prior to exclusion.

Interpretation: This unexpected finding highlighted accessibility considerations in AI adoption. The disability measure encompassed both physical disabilities (vision, mobility) and neurodivergence (ADHD, autism, dyslexia), so the specific mechanisms driving the anxiety association remain unclear. Possible explanations include: (a) concerns about AI accessibility for users with sensory or motor impairments, (b) neurodivergent users experiencing heightened cognitive load from unpredictable AI outputs, (c) fears of job displacement affecting workers who already face employment barriers, or (d) past negative experiences with technology designed without accessibility in mind. Future research should disaggregate by disability type to identify specific intervention targets. Inclusive AI design and training approaches are warranted.



## 5.7 Study Limitations Affecting Interpretation

Several limitations should be considered when interpreting these findings:

### 5.7.1 Methodological Limitations

1. Cross-sectional design: The single time-point data collection precluded causal inference. While SEM estimates suggested directional relationships, alternative causal orderings (e.g., behavior -> intention) could not be ruled out.

2. Self-reported intention: Behavioral Intention may not perfectly predict actual behavior. However, the strong BI-Usage correlation (ρ = .69) provided behavioral validation.

3. Panel sampling: While Centiment's topic-blinded recruitment mitigated self-selection bias, the United States panel sample limited generalizability to other countries, cultures, and organizational contexts.

### 5.7.2 Measurement Limitations

1. Dropped constructs: The exclusion of four proposed constructs limited the comprehensiveness of the theoretical extension. The originally proposed mediation hypotheses involving Explainability and Ethical Risk could not be tested because these constructs were excluded during EFA due to inadequate reliability.

2. Marginal AI Trust: Trust approached but did not reach significance (p = .064). This may have reflected inadequate statistical power (β = .106 requires n > 600 for 80% power at α = .05) or genuine marginality of trust in current AI adoption decisions.

3. Western sample: Cultural generalizability was unknown. AI adoption attitudes might differ substantially in collectivist cultures or regions with different AI policy environments.
