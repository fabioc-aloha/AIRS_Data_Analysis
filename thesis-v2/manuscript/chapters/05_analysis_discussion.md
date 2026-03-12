\clearpage

# Chapter 5: Analysis and Discussion

## 5.1 Introduction

This chapter interprets the empirical findings presented in Chapter 4, connecting the results to the theoretical framework and existing literature. The analysis proceeds systematically through each major finding, examining its meaning, comparing it with prior research, and exploring implications for both theory and practice. Unexpected findings and study limitations specific to interpretation are also addressed. Comprehensive conclusions, recommendations, and future research directions are presented in Chapter 6.



## 5.2 Interpretation of Findings

### 5.2.1 AIRS Diagnostic Instrument Validation

The study successfully validated an 8-factor, 16-item AI Readiness Scale extending UTAUT2 with AI Trust. The instrument demonstrated excellent psychometric properties across both development (n = 261) and holdout (n = 262) samples, with fit indices exceeding conventional thresholds (CFI = .975, TLI = .960, RMSEA = .065, SRMR = .026). The 8-factor structure was selected over a more parsimonious 7-factor model because AI Trust enables diagnostic assessment: organizations can identify trust deficits and design targeted confidence-building interventions.

The cross-validation design (rarely employed in scale development research) provides strong evidence for the generalizability of the factor structure. The successful demonstration of configural invariance across academic and professional populations further supports the instrument's utility for diverse workplace contexts, though metric invariance was not fully achieved (mean Δλ = .082, max Δλ = .326).

### 5.2.2 Structural Model Results

Three of seven hypothesized UTAUT2 paths were significant:

- **Price Value** (β = .505, p < .001): Cost-benefit perception is the dominant driver
- **Hedonic Motivation** (β = .217, p = .014): Enjoyment significantly predicts adoption
- **Social Influence** (β = .136, p = .024): Peer influence matters for AI adoption

The AI Trust extension approached but did not reach significance (β = .106, p = .064). While this falls short of conventional significance, the effect is retained as a diagnostic inclusion rather than a structural claim: detecting β = .106 at 80% power requires n > 600, making the present sample (N = 523, ~68% power) underpowered for this effect size. AI Trust provides essential diagnostic capability that cannot be captured by the other seven constructs, enabling organizations to identify trust-specific barriers and design targeted confidence-building interventions. Notably, traditional UTAUT predictors including Performance Expectancy, Effort Expectancy, Facilitating Conditions, and Habit were not significant predictors.

### 5.2.3 Diagnostic Purpose Framing

The 8-factor AIRS structure was retained in its entirety, including the marginally significant AI Trust construct (β = .106, p = .064), because the instrument serves a diagnostic rather than purely predictive purpose. While a more parsimonious model (e.g., excluding non-significant paths) would marginally improve statistical fit, it would sacrifice the diagnostic breadth required for organizational assessment. Practitioners administering AIRS need to identify *which specific readiness dimensions* are deficient in their workforce — trust deficits require different interventions than value perception gaps or social influence deficits. This diagnostic orientation aligns with established psychometric practice in clinical and organizational assessment, where construct coverage reflects theoretical breadth rather than empirical parsimony alone [@clarkwatson1995; @messick1995].

Bootstrap validation (1,000 resamples, R/lavaan) confirmed that only Price Value demonstrates robust significance across both z-test and bootstrap methods. Hedonic Motivation and Social Influence are z-test significant but bootstrap-unstable (CIs including zero), suggesting their structural effects may be sensitive to sample composition. These constructs nonetheless retain diagnostic value: HM demonstrates reversed population effects (Academic β = 0.449 vs. Professional β = −0.301), and SI captures peer influence dynamics relevant to intervention design.

### 5.2.4 Discriminant Validity Considerations

The high inter-factor correlations among PE, HM, and PV (r = .898–.911) represent a measurement challenge characteristic of 2-item-per-factor scales measuring conceptually adjacent constructs [@marsh1998]. Five Fornell-Larcker violations and four HTMT ratios exceeding .85 (PE×PV = .902, PE×HM = .900, HM×PV = .904, HM×TR = .850) indicate that the current 16-item scale does not fully achieve discriminant separation for the PE/HM/PV triad.

Three findings support retaining separate factors despite this limitation: (a) the constructs serve distinct diagnostic functions enabling targeted intervention design — low PV requires value messaging while low HM requires engagement redesign; (b) they demonstrate differential population sensitivity, with HM showing reversed effects across academic and professional samples (β = 0.449 vs. −0.301, p = .041); and (c) theoretical continuity with UTAUT2 enables cumulative science and meta-analytic integration. The AIRS-28 development roadmap (§6.7.3) addresses this limitation through item pool expansion, which is expected to improve discriminant separation [@dewinter2009].



## 5.3 Comparison with Existing Literature

### 5.3.1 Price Value as Dominant Predictor

**Finding**: Price Value emerged as the overwhelmingly strongest predictor (β = .505, p < .001), substantially exceeding all other constructs.

**Comparison with Prior Research**: This finding represents a significant departure from traditional UTAUT research where Performance Expectancy typically dominates. @blut2022's meta-analysis of 737,112 users found Performance Expectancy to be the strongest predictor (ρ = .60) across technology contexts. The reversal observed in this study suggests fundamental differences in how users evaluate AI tools compared to conventional technologies.

**Industry Context**: This finding gains significance against the adoption-value gap documented in §2.3: despite high adoption rates, few organizations achieve measurable returns. McKinsey's 2025 global survey reinforces this pattern: while 88% of organizations have adopted AI, only 33% are "scaling" AI beyond isolated pilots, with larger companies (48%) significantly outpacing SMBs (29%) in achieving systematic deployment [@mckinseyStateAI2025]. The gap suggests organizations deploy AI without effectively communicating value to end users, precisely the construct captured by Price Value.

**Interpretation**: In the AI context, users appear primarily motivated by **perceived value relative to cost** rather than raw productivity benefits (PE, ns), ease of use (EE, ns), organizational support (FC, ns), or habit (HB, ns). This suggests a hypothesis for future research: AI adoption interventions may be more effective when they prioritize demonstrating clear return on investment rather than focusing solely on capability demonstrations.

**Theoretical Implications**: The dominance of Price Value over Performance Expectancy suggests AI tools may represent a distinct technology category. Unlike previous technologies where utility perceptions drove adoption, AI adoption appears more influenced by value propositions, potentially reflecting the freemium pricing models common in AI tools, concerns about ongoing subscription costs, or cost-benefit analyses comparing AI tools to traditional methods.

### 5.3.2 Non-Significant UTAUT2 Paths

**Finding**: PE, EE, FC, and HB were not significant predictors.

**Comparison with Prior Research**: The non-significance of Performance Expectancy (β = -.028, p = .791) is particularly noteworthy given its historical dominance in technology acceptance research. @davis1989's TAM established perceived usefulness as the primary adoption driver, and this finding has been replicated across thousands of studies. The present results challenge this assumption for AI contexts.

**Industry Context**: The non-significance of Effort Expectancy and Facilitating Conditions aligns with industry observations about modern AI implementation. Deloitte's State of Generative AI research identifies skill gaps as a persistent barrier to AI integration [@deloitte2024genai], yet users in this study did not cite ease-of-use or organizational support as adoption drivers. This disconnect suggests a maturation in AI tool interfaces: contemporary consumer-facing AI (e.g., ChatGPT, GitHub Copilot) has achieved such usability that effort perceptions no longer differentiate adoption decisions. The barrier has shifted from "Can I use this?" to "Is it worth my investment?"

**Interpretation**: In the AI context, perceived usefulness may be a baseline expectation rather than a differentiating factor. Users may assume AI tools will enhance productivity, making cost-benefit considerations (Price Value) and enjoyment (Hedonic Motivation) the deciding factors.

Similarly, the non-significance of Effort Expectancy (β = -.008, p = .875) and Facilitating Conditions (β = .059, p = .338) may reflect the increasingly user-friendly nature of modern AI tools and widespread organizational technology infrastructure. Contemporary AI interfaces have achieved remarkable usability, potentially creating ceiling effects for ease-of-use perceptions.

### 5.3.3 AI Trust Marginality

**Finding**: TR approached but did not reach significance (β = .106, p = .064).

**Comparison with Prior Research**: Emerging AI adoption research has increasingly emphasized trust as a critical determinant [@glikson2020; @siau2018]. The marginal effect observed here partially supports this theoretical direction while highlighting the need for more sensitive measurement or larger samples.

**Industry Context**: The marginal significance of AI Trust resonates with industry findings on governance and accountability barriers. Gartner identifies governance maturity as a key differentiator, with substantial proportions of AI projects experiencing delays due to governance, compliance, or accountability issues [@gartner2025]. The Georgian AI Benchmark found that only 32% of organizations have achieved cross-functional AI deployment, with trust and governance cited as key inhibitors [@georgian2025]. These industry challenges suggest that trust, while marginally significant at the individual level, may become increasingly central as AI applications mature and governance requirements intensify.

**Interpretation**: The marginal significance of AI Trust suggests it may become a more important predictor as AI technologies mature and trust concerns become more salient. The current sample may have insufficient power to detect the effect (β = .106 requires n > 600 for 80% power at α = .05), or trust considerations may be less central for the relatively straightforward AI tools currently in use. Future research should examine whether AI Trust becomes more predictive for high-stakes AI applications (e.g., AI-assisted decision-making, autonomous systems).

### 5.3.4 Experience as Moderator

**Finding**: Professional experience strengthens HM -> BI (β = .136, p = .007).

**Comparison with Prior Research**: While UTAUT specifies experience as a moderator, it conceptualizes experience as technology familiarity rather than career development. The present finding integrates career development theory [@super1980] with technology acceptance, suggesting that vocational maturity influences technology evaluation processes.

**Interpretation**: The significant moderation effect suggests that experienced professionals place greater weight on enjoyment when evaluating AI tools. This may reflect that experienced users, having satisfied basic competency needs, prioritize intrinsic satisfaction. Additionally, usage frequency moderates the importance of Performance Expectancy (for new users) versus Price Value (for heavy users).

### 5.3.5 Converging Literature Validation

An important methodological note is warranted regarding the alignment between this study's theoretical framework and the broader 2025 literature. The theoretical framework — including the decision to extend UTAUT2 with AI-specific constructs such as Trust and Anxiety — was specified before fieldwork began in October 2025. During the research design, data collection, and writing phases, a rapidly expanding body of industry research and academic work independently corroborated the study's theoretical positioning and empirical findings.

**Industry Validation of the Adoption-Value Gap**. When the research framework was designed, the adoption-value gap was an emerging pattern supported primarily by McKinsey's 2023–2024 State of AI reports and early BCG findings. Throughout 2025, this pattern was confirmed by at least eight additional sources:

- McKinsey's 2025 report documented adoption reaching 88% while only 6% of organizations achieved meaningful EBIT impact [@mckinseyStateAI2025]
- BCG quantified that just 5% of companies realize measurable AI returns, with 74% stuck at proof-of-concept [@bcgAIAdoption2025]
- The MIT Media Lab NANDA Initiative estimated 90–95% failure rates for generative AI pilots at scale [@mitMediaLab2025]
- Georgian's AI Benchmark found only 32% cross-functional deployment [@georgian2025]
- ISG, Gartner, Deloitte, Lucidworks, and Capgemini each identified governance deficits, skill gaps, and scaling failures as systemic barriers [@isg2025; @gartner2025; @deloitte2024genai; @lucidworks2025; @capgemini2025]

This converging evidence demonstrates that the adoption-value gap is robust, widespread, and not an artifact of any single report's methodology. The present study's finding that traditional UTAUT2 predictors (Performance Expectancy, Effort Expectancy) fail to reach significance while value-oriented constructs dominate aligns with this industry consensus: organizations have moved past questions of *whether AI works* to questions of *whether AI is worth it*.

**Academic Validation of AI-Specific Constructs**. The decision to include AI Anxiety as a proposed inhibitor construct was informed by @tao2020's early dimensional work. Two recent publications further strengthened this theoretical basis:

- @kim2025 identified "annihilation anxiety" (existential concerns about human relevance) as a distinct dimension particularly salient among knowledge workers — precisely the population this study sampled
- @frenkenberg2025 distinguished anticipatory anxiety (about future AI capabilities) from present-state anxiety, providing a theoretical explanation for why the two-item AX scale in this study (which conflated avoidance and approach motivations) demonstrated inadequate reliability (α = .301)

These findings validate both the theoretical importance of anxiety as an AI adoption construct and this study's empirical conclusion that more sophisticated, multi-dimensional measurement is required (see §5.6.2).

**Significance**. The convergence between this study's a priori theoretical choices and the 2025 evidence base provides a form of concurrent validation. The framework was not retrofitted to accommodate new findings; rather, the constructs selected for investigation (trust, anxiety, value perception, governance) are precisely those the field has independently identified as central to explaining the adoption-value gap.



## 5.4 Implications for Theory

### 5.4.1 UTAUT2 Extension

The study extends UTAUT2 with AI-specific constructs, demonstrating that traditional technology acceptance frameworks require context-sensitive modification. The dramatic shift in predictor importance, from Performance Expectancy dominance to Price Value dominance, suggests that AI represents a theoretically distinct technology category.

### 5.4.2 Context-Specific Model

The findings support calls for domain-specific UTAUT extensions [@blut2022]. Rather than applying generic technology acceptance models, researchers should develop and validate context-appropriate extensions that capture the unique psychological processes relevant to each technology category.

### 5.4.3 Price Value Dominance

The finding that Price Value (β = .505) rather than Performance Expectancy drives AI adoption represents a significant theoretical departure from traditional UTAUT research. This suggests AI tools are evaluated through a value lens ("Is it worth it?") rather than a utility lens ("Will it help me?"). Users may assume AI will be useful but evaluate whether the investment—in time, effort, or cost—is justified.

### 5.4.4 Non-Significance of Traditional Predictors

The non-significance of PE, EE, FC, and HB suggests AI may represent a distinct technology category requiring tailored theoretical frameworks. Unlike previous technologies where utility perceptions drove adoption, AI adoption appears more influenced by value propositions, potentially reflecting:

- **Freemium pricing models** common in AI tools create cost-benefit salience
- **Maturation of AI interfaces** has created ceiling effects for ease-of-use perceptions
- **Widespread organizational technology infrastructure** makes facilitating conditions a baseline expectation

### 5.4.5 Experience-Dependent Mechanisms

The experience moderation of HM (p = .007) suggests that adoption mechanisms differ by user characteristics in ways not previously documented in technology acceptance research. Experienced professionals place greater weight on enjoyment when evaluating AI tools, possibly reflecting that users who have satisfied basic competency needs prioritize intrinsic satisfaction.

### 5.4.6 Population-Specific Pathways

Differential HM effects across populations (Academic β = 0.449 vs. Professional β = -0.301, p = .041) indicate that adoption interventions may need to be tailored to specific user groups. Academics weight enjoyment heavily; professionals may prioritize other factors.

### 5.4.7 Career Development Integration

The significant experience moderation effect introduces career development as a relevant theoretical domain for technology acceptance research. Future models should consider how career stage and professional identity influence technology evaluation and adoption decisions.

### 5.4.8 User Typology Framework

The empirically-derived three-segment typology (k=3, silhouette=0.271) provides a framework for understanding adoption heterogeneity:

- **AI Enthusiasts (31%, n=162)**: High adoption readiness across all constructs (~0.9 SD above mean), high Behavioral Intention (mean BI=4.23)
- **Moderate Users (47%, n=246)**: Near-population-mean scores across all constructs, pragmatic orientation
- **AI Skeptics (22%, n=115)**: Below-average scores across all constructs (~1.2 SD below mean), low Behavioral Intention (mean BI=1.71)

This segmentation approach moves beyond mean-level analysis to acknowledge individual differences in adoption psychology. The three-segment solution captures a clear readiness gradient that explains 65.9% of BI variance (F=503.47, p<.001), confirming the typology identifies adoption-relevant heterogeneity. Whether these segments respond differentially to targeted interventions requires experimental validation. Figure 5.1 illustrates the distribution and characteristics of the three user segments.

![Three-segment user typology derived from cluster analysis. Segment sizes represent proportions of the sample, with distinct profiles across adoption readiness constructs. *Source: Compiled by Author*](figures/fig_user_typology.png){#fig:user-typology}

Source: Compiled by Author



## 5.5 Implications for Practice

The findings offer insights for organizations navigating AI adoption challenges. As documented in §2.3, the gap between adoption and value realization represents a critical business challenge. While this study validates a measurement instrument rather than testing interventions, the empirical findings suggest several evidence-informed directions.

**Important Scope Note**: The AIRS diagnostic instrument validated in this study provides a psychometrically sound measure of AI adoption readiness constructs. The 8-factor structure enables identification of specific adoption barriers (e.g., trust deficits, inadequate perceived value, low social influence) that can inform intervention design. The practical applications suggested below are hypotheses derived from the empirical findings. Future experimental research is needed to validate intervention effectiveness. The author's research roadmap includes developing formal AIRS Score algorithms, diagnostic protocols, and intervention frameworks as subsequent research phases.

### 5.5.1 For Organizations

**Lead with Value, Not Capabilities**: The dominance of Price Value (β = .505) over Performance Expectancy (ns) suggests a potential shift in how organizations might approach AI implementation communications. Rather than emphasizing AI capabilities and productivity promises, the findings suggest that demonstrating return on investment and cost-effectiveness may be more influential. Capgemini's research supports this direction, finding that organizations redesigning workflows around AI, rather than simply adding AI to existing processes, achieve substantially higher returns [@capgemini2025].

**Consider Adoption Heterogeneity**: The three-segment typology (§4.6) suggests that user populations vary systematically in their AI readiness profiles, with each segment potentially responding to different intervention approaches.

**Leadership Engagement**: Leaders in this study demonstrated the highest AI tool usage (d = 0.74–1.14). McKinsey's research confirms that organizations where senior leadership takes ownership of AI initiatives are three times more likely to achieve value from their investments [@mckinseyStateAI2025]. Visible leadership engagement may amplify adoption efforts.

### 5.5.2 For AI Tool Designers

Pricing strategy may significantly influence adoption, potentially more so than feature development. The dominance of Price Value suggests that pricing models (freemium tiers, transparent costs, usage-based billing) warrant careful attention. The significant Hedonic Motivation effect (β = .217) also suggests value in investing in enjoyable user experiences.

### 5.5.3 For Trainers and Educators

The AI Skeptics segment (22%) — characterized by below-average scores across all adoption readiness constructs — suggests that training programs may benefit from addressing resistance barriers alongside technical skills. The disability-anxiety association (d = .36) highlights the importance of accessibility-centered training design. These findings warrant experimental validation of targeted approaches in AI training contexts.

### 5.5.4 For Policy Makers

The validated AIRS diagnostic instrument provides a foundation for future organizational AI readiness assessment research. The 8-factor structure enables identification of population-level adoption barriers that can inform workforce development policy. The differential anxiety findings (disability association d = .36) highlight equity considerations in AI adoption policy that warrant further investigation.

### 5.5.5 Understanding the Adoption-Value Gap

The findings illuminate mechanisms that may contribute to the adoption-value gap documented in §2.3:

1. **Value Communication Misalignment**: Organizations may lead with capability demonstrations when users actually evaluate cost-benefit ratios. Future research should test whether value-focused messaging improves outcomes.

2. **Heterogeneous Readiness**: One-size-fits-all approaches may fail because user populations vary systematically. The three-segment typology provides a framework for intervention research.

3. **Neglected Affective Barriers**: The AI Skeptics segment and marginal Trust effect suggest psychological barriers may be underaddressed.

4. **Context-Inappropriate Frameworks**: The shift from Performance Expectancy to Price Value dominance demonstrates why context-specific instruments are valuable.



## 5.6 Unexpected Findings

### 5.6.1 Performance Expectancy Non-Significance

The non-significance of Performance Expectancy was unexpected given its historical dominance in technology acceptance research. This finding suggests that AI adoption operates through different psychological mechanisms than conventional technology adoption, potentially because productivity benefits are now assumed rather than evaluated.

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

**Interpretation**: Two-item scales proved insufficient for these multi-dimensional constructs. This represents an empirical finding about measurement complexity rather than theoretical invalidity. These constructs remain theoretically important for AI adoption and warrant revised measurement approaches in future research.

**Future Development Recommendations**:
- For AI Anxiety specifically, future scales should distinguish between technology avoidance anxiety and fear-of-missing-out (FOMO) or obsolescence anxiety, as these represent conceptually distinct motivational orientations
- Each excluded construct requires 3-4 items per sub-dimension to adequately capture its multi-faceted nature
- Context-specific item development may be necessary for constructs like Ethical Risk, which may manifest differently across professional domains

### 5.6.3 Disability and Accessibility

**Finding**: Disability associated with higher AI-related anxiety responses (d = .36), based on exploratory analysis of original AX items prior to exclusion.

**Interpretation**: This unexpected finding highlights accessibility considerations in AI adoption. Users with disabilities may experience heightened anxiety about AI technologies, potentially due to concerns about accessibility, job displacement, or past negative experiences with technology. Inclusive AI design and training approaches are warranted.



## 5.7 Study Limitations Affecting Interpretation

Several limitations should be considered when interpreting these findings:

### 5.7.1 Methodological Limitations

1. **Cross-sectional design**: The single time-point data collection precludes causal inference. While SEM estimates suggest directional relationships, alternative causal orderings (e.g., behavior -> intention) cannot be ruled out.

2. **Self-reported intention**: Behavioral Intention may not perfectly predict actual behavior. However, the strong BI-Usage correlation (ρ = .69) provides behavioral validation.

3. **Panel sampling**: While Centiment's topic-blinded recruitment mitigates self-selection bias, the United States panel sample limits generalizability to other countries, cultures, and organizational contexts.

### 5.7.2 Measurement Limitations

1. **Dropped constructs**: The exclusion of four proposed constructs limits the comprehensiveness of the theoretical extension. The originally proposed mediation hypotheses involving Explainability and Ethical Risk could not be tested because these constructs were excluded during EFA due to inadequate reliability.

2. **Marginal AI Trust**: Trust approached but did not reach significance (p = .064). This may reflect inadequate statistical power (β = .106 requires n > 600 for 80% power at α = .05) or genuine marginality of trust in current AI adoption decisions.

3. **Western sample**: Cultural generalizability is unknown. AI adoption attitudes may differ substantially in collectivist cultures or regions with different AI policy environments.
