---
documentclass: article
geometry: margin=1in
fontsize: 12pt
linestretch: 2
link-citations: true
nocite: '@*'
header-includes:
  - \usepackage{setspace}
  - \doublespacing
  - \usepackage{fancyhdr}
  - \pagestyle{fancy}
  - \fancyhead[R]{\thepage}
  - \fancyhead[L]{AI READINESS SCALE}
  - \usepackage{float}
  - \floatplacement{table}{H}
  - \floatplacement{figure}{H}
  - \usepackage{etoolbox}
  - \AtBeginEnvironment{longtable}{\singlespacing}
  - \AtBeginEnvironment{tabular}{\singlespacing}
  - \AtBeginDocument{\thispagestyle{empty}}
  - \usepackage{fontspec}
  - \setmainfont{Times New Roman}
---

\begin{titlepage}
\thispagestyle{empty}
\singlespacing
\centering
\vspace*{1cm}

{\LARGE\bfseries Artificial Intelligence Readiness Score: Extending UTAUT2 for Enterprise AI Adoption\par}

\vspace{1.5cm}

A Dissertation Submitted in Partial Fulfillment of the\\
Requirements for the Degree of\\[0.3cm]
{\large Doctor of Business Administration\par}

\vspace{1cm}

{\large Touro University Worldwide\par}
{\normalsize DBA712 - Doctoral Research Project\par}

\vspace{1.5cm}

{\large By\par}
\vspace{0.3cm}
{\Large\bfseries Fabio Correa\par}

\vspace{1.5cm}

{\large Dissertation Committee:\par}
\vspace{0.3cm}
Chair: Dr. Karina Kasztelnik\\
Faculty Member: Dr. Jerome Jones\\
Faculty Member: Dr. Donna Day

\vfill

{\large December 2025\par}
\end{titlepage}

\newpage
\thispagestyle{empty}

\begin{center}
{\Large\bfseries Abstract}
\end{center}

\vspace{1cm}

\doublespacing

This dissertation develops and validates the AI Readiness Scale (AIRS), an instrument designed to measure artificial intelligence adoption readiness. Extending the Unified Theory of Acceptance and Use of Technology 2 (UTAUT2) with AI-specific constructs, this study examines factors influencing behavioral intention to adopt AI tools among students and employed professionals.

Using a sample of 523 United States professionals and students, exploratory and confirmatory factor analyses validated an 8-factor, 16-item model demonstrating excellent fit (CFI = .975, TLI = .960, RMSEA = .065). The structural model revealed Price Value (β = .505, p < .001), Hedonic Motivation (β = .217, p = .014), and Social Influence (β = .136, p = .024) as significant predictors of behavioral intention, while AI Trust approached but did not reach significance (β = .106, p = .064).

Four theoretically-proposed constructs (Voluntariness, Explainability, Ethical Risk, original Anxiety items) were excluded due to inadequate reliability (α = .30–.58), revealing measurement challenges with two-item scales for multi-dimensional AI constructs. Notably, traditional UTAUT predictors including Performance Expectancy, Effort Expectancy, Facilitating Conditions, and Habit did not significantly predict AI adoption intention, suggesting AI tools may represent a distinct technology category where cost-benefit perceptions and enjoyment outweigh conventional utility considerations.

The study contributes a psychometrically validated instrument for AI adoption research and identifies practical implications for organizational AI implementation strategies. Findings suggest that demonstrating value relative to cost (Price Value) and fostering positive engagement experiences (Hedonic Motivation) represent the most impactful intervention targets for promoting AI adoption in higher education settings.

\textbf{Keywords:} artificial intelligence, technology adoption, UTAUT2, scale development, higher education, AI readiness, psychometric validation, structural equation modeling



\newpage

\tableofcontents

\newpage
# Chapter 1: Introduction

## 1.1 Background and Context

[To be written]

## 1.2 Problem Statement

[To be written]

## 1.3 Research Questions

**Primary Research Question:**
How can UTAUT2 be extended with AI-specific constructs to better predict behavioral intention to adopt AI tools in professional and academic contexts?

**Secondary Research Questions:**
1. What is the factor structure of an AI-specific adoption readiness instrument?
2. Does the instrument demonstrate measurement invariance across student and professional populations?
3. Which factors most strongly predict behavioral intention to adopt AI tools?
4. Does AI Trust significantly predict adoption intention beyond UTAUT2 constructs?
5. What moderating factors influence the relationships between predictors and adoption intention?

## 1.4 Research Objectives

[To be written]

## 1.5 Significance of the Study

[To be written]

## 1.6 Scope and Delimitations

[To be written]

## 1.7 Definitions of Key Terms

| Term | Definition |
|------|------------|
| **UTAUT2** | Unified Theory of Acceptance and Use of Technology 2 (Venkatesh et al., 2012) |
| **AIRS** | AI Readiness Scale - the instrument developed in this study |
| **AI Trust** | The novel construct extending UTAUT2 for AI-specific adoption contexts |
| **Behavioral Intention** | An individual's intention to use AI tools in their professional or academic work |

## 1.8 Chapter Overview

[To be written]

\newpage

# Chapter 2: Literature Review

## 2.1 Introduction

The rapid enterprise adoption of artificial intelligence has outpaced the explanatory capacity of traditional technology acceptance frameworks. While organizations have embraced AI at unprecedented rates—rising from 55% in 2023 to approximately 76% by early 2025 (McKinsey & Company, 2023–2025)—only 1% consider themselves "AI mature," with fully integrated AI across core processes, governance, and value delivery (McKinsey & Company, 2025). This adoption-value paradox presents both a theoretical puzzle and a practical challenge: why do established technology acceptance models incompletely predict AI adoption, and what additional constructs must be incorporated to guide organizational intervention?

This chapter establishes the theoretical foundation for the Artificial Intelligence Readiness Scale (AIRS) by pursuing three objectives. First, it traces the evolution of technology acceptance research from foundational behavioral theories through the Unified Theory of Acceptance and Use of Technology (UTAUT) and its consumer extension (UTAUT2), establishing the empirical baseline that informs scale development. Second, it examines why AI—as a socio-technical phenomenon characterized by opacity, probabilistic reasoning, and ethical exposure—stresses this baseline in ways that demand construct extension. Third, it synthesizes emerging research on AI-specific determinants of adoption, including trust, anxiety, and explainability, to justify the theoretical framework and hypotheses tested in subsequent chapters.

The review draws on three categories of evidence. Academic research provides the theoretical architecture, anchored by Venkatesh et al.'s (2003, 2012) foundational UTAUT work, Blut et al.'s (2022) comprehensive meta-analysis spanning 737,112 users across 1,935 independent samples, and Venkatesh's (2021) AI-specific research agenda. Industry benchmarks from McKinsey, Boston Consulting Group, and MIT Media Lab contextualize these theoretical insights within the current enterprise AI landscape. Finally, empirical studies on AI trust, explainability, and anxiety provide construct-level evidence for the proposed extensions.

This dual-lens approach—integrating academic rigor with business relevance—reflects the Doctor of Business Administration orientation of this thesis. The literature review not only establishes scholarly grounding but also identifies practical implications: why AI adoption programs fail, what organizational levers matter, and how validated measurement can inform change management. By the chapter's conclusion, readers will understand why AIRS extends UTAUT2 with AI-specific constructs and how the resulting framework addresses both theoretical gaps and practitioner needs.



## 2.2 Technology Acceptance Models: Foundations and Evolution

### 2.2.1 Early Behavioral Theories

The study of technology adoption originates in broader behavioral science. Ajzen's (1991) Theory of Planned Behavior (TPB) explains volitional behavior through three determinants: attitudes toward the behavior, subjective norms reflecting perceived social pressure, and perceived behavioral control representing self-efficacy and resource availability. TPB's parsimony and empirical generalizability made it adaptable to early information systems research, yet it remains technology-agnostic—it does not model perceptions unique to digital systems such as usefulness or ease of use.

Davis's (1989) Technology Acceptance Model (TAM) addressed this limitation by introducing two technology-specific beliefs: perceived usefulness (the degree to which a user believes technology will enhance job performance) and perceived ease of use (the degree to which technology use is free of effort). TAM's elegant specification and consistent empirical support established it as the dominant paradigm in information systems research for over two decades. However, TAM's parsimony becomes a limitation when technologies carry salient ethical, organizational, or epistemic properties that instrumental beliefs alone cannot capture.

Rogers's (2003) Diffusion of Innovations theory complements these individual-level models by explaining how innovations spread through social systems over time. Five innovation attributes—relative advantage, compatibility, complexity, trialability, and observability—predict adoption rates across populations. While diffusion theory illuminates organizational uptake and social influence, it is less diagnostic for the psychological mechanisms underlying individual decisions to rely on complex, partially opaque systems such as modern AI.

### 2.2.2 The Unified Theory of Acceptance and Use of Technology (UTAUT)

Venkatesh et al. (2003) synthesized eight prominent acceptance models into the Unified Theory of Acceptance and Use of Technology (UTAUT), achieving superior explanatory power through theoretical integration. UTAUT specifies four direct determinants of behavioral intention and use:

**Performance Expectancy (PE)** captures the degree to which using technology will help attain job performance gains, integrating perceived usefulness (TAM), extrinsic motivation, job-fit, relative advantage, and outcome expectations from prior theories.

**Effort Expectancy (EE)** represents the ease associated with technology use, incorporating perceived ease of use (TAM), complexity (innovation diffusion), and ease of use from other frameworks.

**Social Influence (SI)** reflects the degree to which important others believe the individual should use the technology, synthesizing subjective norm, social factors, and image constructs.

**Facilitating Conditions (FC)** captures organizational and technical infrastructure supporting use, including perceived behavioral control, facilitating conditions, and compatibility from prior models.

UTAUT further specifies four moderators—gender, age, experience, and voluntariness—that systematically alter the strength of predictor-intention relationships. In the original validation, UTAUT explained 70% of variance in behavioral intention, substantially exceeding the explanatory power of its constituent theories.

### 2.2.3 Meta-Analytic Evidence: The Current State of UTAUT

Blut et al.'s (2022) landmark meta-analysis provides the most comprehensive assessment of UTAUT to date, synthesizing 25,619 effect sizes from 737,112 users across 1,935 independent samples. This analysis not only confirms UTAUT's core predictions but also reveals nuanced patterns essential for AI-context extensions.

**Performance Expectancy emerges as the consistently strongest predictor of behavioral intention**, with a meta-analytic correlation of ρ = .60 and substantial effect sizes across contexts. This finding aligns with decades of TAM research positioning perceived usefulness as the primary adoption driver and has direct implications for AI messaging strategies in organizations.

Effort Expectancy shows moderate effects (ρ = .45) but displays greater context-dependency. In established technology categories where interfaces have matured, effort expectancy may reach ceiling effects—users assume baseline usability. This pattern suggests that for contemporary AI tools with polished interfaces, ease-of-use investments may show diminishing returns relative to other adoption levers.

Social Influence demonstrates inconsistent effects across organizational versus consumer contexts, with stronger impact under mandatory use conditions. Facilitating Conditions shows a direct effect on use behavior that strengthens with experience, suggesting infrastructure and support matter more for sustained engagement than initial adoption.

Critically, Blut et al. (2022) identify substantial unexplained variance and call for domain-specific extensions that incorporate constructs relevant to emerging technologies. They observe that the "red ocean" of UTAUT research has produced diminishing theoretical returns, yet faithful application with appropriate extensions remains productive. This finding directly motivates the present study's AI-specific extensions.

### 2.2.4 UTAUT2: Consumer Context Extensions

Venkatesh et al. (2012) extended UTAUT for consumer contexts through UTAUT2, adding three constructs:

**Hedonic Motivation (HM)** captures fun or pleasure derived from technology use, acknowledging that consumer adoption is driven by intrinsic enjoyment alongside instrumental outcomes.

**Price Value (PV)** represents the cognitive trade-off between perceived benefits and monetary cost, relevant when users bear technology expenses directly.

**Habit (HB)** reflects automaticity developed through prior behavior, acknowledging that repeated use becomes self-reinforcing independent of conscious intention.

UTAUT2 explained 74% of variance in behavioral intention, demonstrating the value of context-appropriate extensions. For the present research, UTAUT2 provides the baseline framework, with modifications appropriate to workplace AI contexts where hedonic motivation and habit remain relevant while price value may be less salient (organizational rather than personal expenditure).

**Figure 2.1: Evolution of Technology Acceptance Models**

![](figures/02_literature_review_fig1.png)



## 2.3 The AI Adoption-Value Gap: Industry Context

### 2.3.1 Current State of Enterprise AI Adoption

Before examining why traditional acceptance models require extension for AI, it is essential to understand the practical landscape these models must explain. Industry benchmarks reveal a striking paradox: AI adoption has reached near-ubiquity, yet value realization remains exceptional.

According to McKinsey's State of AI series, organizational AI adoption rose from 55% in 2023 to 72% in 2024, reaching approximately 76% by early 2025 (McKinsey & Company, 2023–2025). This acceleration, driven primarily by generative AI capabilities and accessible enterprise platforms, represents one of the fastest technology adoption curves in organizational history.

Yet adoption has not translated into proportional value capture. Boston Consulting Group (2025) reports that only 5% of companies achieve measurable business value from AI initiatives, while approximately 74% struggle to scale beyond proofs of concept. McKinsey (2025) finds that a mere 1% of enterprises consider themselves fully AI mature—with AI embedded across workflows, governed effectively, and linked to enterprise-level key performance indicators.

The MIT Media Lab's NANDA Initiative (2025) provides perhaps the most sobering assessment: 90–95% of generative AI pilots fail to scale or deliver measurable profit-and-loss improvements. This failure rate exceeds typical technology project failures, suggesting AI-specific barriers that traditional change management and technology deployment frameworks do not adequately address.

### 2.3.2 Diagnosing the Gap: Why Adoption Does Not Equal Value

Industry analyses converge on three systemic barriers underlying the adoption-value gap:

**Scaling Failure**: Most organizations can demonstrate AI feasibility in controlled pilots but lack the operational design, governance architecture, and change infrastructure to move innovations into production. Georgian's AI Benchmark 2025 found that only 32% of enterprises had deployed AI across multiple business functions, indicating that organizational rather than technological constraints limit scaling.

**Governance and Trust Deficits**: Organizations struggle with ownership, compliance, bias mitigation, and ethical use policies. The gap between AI deployment speed and governance framework development creates risk exposure that prudent organizations constrain through limited adoption scope. Gartner (2025) identifies governance maturity as a primary differentiator between AI leaders and laggards.

**Capability and Change Barriers**: Misalignment across functions, skill gaps, and resistance to workflow redesign inhibit AI integration. Capgemini (2025) reports that organizations embedding AI into redesigned workflows achieve 1.7 times higher ROI than those layering AI onto legacy processes, yet such redesign requires capabilities and change tolerance that most organizations lack.

### 2.3.3 Implications for Acceptance Research

This industry context has direct implications for technology acceptance research. The adoption-value gap suggests that traditional acceptance constructs—useful for predicting initial adoption intention—may incompletely explain the sustained, consequential use that generates organizational value. If 76% of organizations have adopted AI while only 5% achieve meaningful returns, then factors beyond performance and effort expectancy must mediate the translation from adoption to value.

Venkatesh (2021) argues that AI tools present unique adoption challenges that existing frameworks do not fully address. Unlike prior technologies, AI systems (1) operate as partially opaque decision aids where underlying models are "blackboxed"; (2) make errors that accumulate and erode trust over time; (3) require learning periods during which performance improves; (4) may develop emergent biases unknown at deployment; and (5) shift the human role from decision-maker to decision-overseer or decision-recipient. These characteristics suggest that trust, transparency, and anxiety—constructs largely peripheral in traditional acceptance models—move to the foreground for AI adoption.



## 2.4 Why AI Stresses Traditional Acceptance Models

### 2.4.1 Opacity and Explainability

Many AI systems, particularly those employing deep learning, function as partially opaque decision aids. Users—and often developers—cannot fully articulate why a model produces specific outputs. This characteristic fundamentally challenges traditional acceptance models, which assume users can form reasoned judgments about technology usefulness based on observable performance.

Venkatesh (2021) identifies model opacity as a primary barrier to AI adoption: when users have "little or no visibility into the underlying algorithm or process that renders the decision," they cannot calibrate trust or develop the performance expectations that drive adoption in transparent systems. Doshi-Velez and Kim (2017) argue that interpretability and explainability become central to justified reliance when systems are opaque and consequential.

The construct of **perceived explainability**—whether users can understand and utilize reasons behind AI outputs with sufficient clarity to justify action—emerges from this limitation. Shin (2021) distinguishes explainability from causability (the user's ability to infer cause-effect logic adequate for decision-making), demonstrating that higher perceived explainability increases both trust and intention to use. Critically, explainability effects extend beyond system perceptions to trust in the human teams responsible for deployment and oversight, indicating organizational implications beyond individual acceptance.

### 2.4.2 Probabilistic Behavior and Model Errors

AI systems operate probabilistically, producing outputs that are correct in expectation but not guaranteed for individual cases. This characteristic distinguishes AI from deterministic software where identical inputs yield identical outputs. Venkatesh (2021) notes that "almost by definition, a model is bound to make mistakes, given that it is, after all, a representation of reality."

For adoption, this probabilistic nature creates a trust challenge. Users must accept that errors will occur while maintaining sufficient confidence to rely on outputs for consequential decisions. Traditional acceptance models do not explicitly address this calibrated-trust requirement. The UTAUT construct of performance expectancy assumes users can assess technology usefulness; probabilistic AI requires users to assess expected utility across a distribution of possible outcomes, some of which will be incorrect.

Furthermore, AI models learn over time, meaning initial performance may not predict mature performance. Users who experience early errors may form negative performance expectations that persist even as systems improve—a dynamic traditional acceptance models do not capture.

### 2.4.3 Ethical Exposure and Accountability

AI introduces distinctive ethical exposures around bias, privacy, and accountability that shape willingness to rely on outputs. The widely-publicized case of Amazon's AI hiring tool—which systematically discriminated against women job applicants—illustrates how AI systems can encode and amplify biases present in training data (Schuetz & Venkatesh, 2020).

Floridi et al. (2018) articulate an ethical framework identifying AI-specific risks: autonomy erosion, privacy invasion, unfair discrimination, and accountability gaps. These risks generate **perceived ethical risk**—anticipated harms that depress adoption intention even when performance expectations are favorable. Dwivedi et al. (2021) demonstrate that perceived ethical risk exerts direct negative effects on intention and moderates the influence of traditional predictors like performance expectancy and social influence.

In enterprise contexts, ethical risk connects to organizational legitimacy and governance. Users assess not only whether AI works but whether reliance is appropriate given fairness, privacy, and accountability implications. When organizations fail to establish clear governance—bias audits, escalation pathways, human-in-the-loop procedures—users may limit consequential reliance regardless of system capability.

### 2.4.4 Autonomy and Human Role Transformation

AI's autonomy capabilities fundamentally alter the human role in work processes. Traditional decision support technologies augment human judgment; AI can supplant it. Venkatesh (2021) observes that "with AI tools, the human decision maker—i.e., employee—could thus be relegated to playing a secondary role or have no role to play."

This transformation generates **AI-related anxiety**—affective responses to autonomy, opacity, and rapid change. Unlike technology anxiety rooted in difficulty of use, AI anxiety encompasses concerns about job displacement, loss of professional agency, and erosion of human expertise. Tao et al. (2020) conceptualize AI anxiety through multiple dimensions including privacy-related anxiety, bias-related anxiety, and opacity-related anxiety. Kim et al. (2025) add anticipatory anxiety about future disruptions and existential concerns about human obsolescence.

Research suggests anxiety may exhibit nonlinear relationships with exposure. Moderate, calibrated exposure can reduce anxiety as users develop realistic expectations and coping strategies, while minimal exposure leaves fears unchallenged and intensive exposure may overwhelm adaptive capacity (Frenkenberg & Hochman, 2025). This pattern implies that training and hands-on experience can shift affective responses favorably—an organizational lever absent from traditional acceptance frameworks.



## 2.5 Trust in AI Systems

### 2.5.1 Conceptualizing AI Trust

Trust has emerged as a gateway condition for AI adoption—without sufficient trust, users hesitate to rely on outputs even when systems appear useful. Langer et al.'s (2023) comprehensive review of empirical research on trust in AI positions trust as mediating the relationship between system properties and behavioral outcomes across application areas.

AI trust adapts the ability-integrity-benevolence triad from interpersonal trust research to algorithmic agents (Siau & Wang, 2018). **Ability** translates to perceived AI competence and accuracy; **integrity** becomes perceptions of fairness and consistency; **benevolence** maps to alignment between AI outputs and user or organizational goals. Stevens and Stetson (2023) operationalize these facets in the Trust and Acceptance of AI Technology (TrAAIT) scale, demonstrating that multi-dimensional trust can be measured reliably in professional settings.

### 2.5.2 Trust as Mediator and Amplifier

Empirical evidence positions trust as both a direct predictor of adoption intention and a mechanism through which other factors operate. When trust is high, performance expectancy shows stronger effects on intention—users translate positive system evaluations into adoption when they trust the system to perform consistently. When trust is low, even objectively capable systems fail to generate adoption intention because users doubt whether observed performance will generalize to their consequential decisions.

Explainability serves as a primary antecedent of trust. Shin (2021) demonstrates that when users perceive AI explanations as clear, sufficient, and actionable, trust increases. This explainability-to-trust pathway provides an organizational lever: investing in explanation design can build trust without altering underlying AI capability.

Governance practices also shape trust. When organizations establish bias audits, privacy safeguards, and clear accountability structures, perceived ethical risk decreases and trust increases. Stevens and Stetson (2023) find that trust in the people and processes behind AI deployment contributes to system trust, suggesting that organizational governance operates through trust to influence adoption.

### 2.5.3 Trust in the Present Research

Given the empirical evidence for trust's central role in AI adoption, the present research incorporates **AI Trust** as a core construct extending UTAUT2. AI Trust is operationalized as confidence that the AI system is reliable, competent, and aligned with user and organizational values. This construct is expected to positively predict behavioral intention directly and to mediate effects of explainability and governance perceptions on intention.

**Figure 2.2: AIRS Conceptual Model - Extended UTAUT2 for AI Adoption**

![](figures/02_literature_review_fig2.png)



## 2.6 AI-Related Anxiety

### 2.6.1 Conceptualizing AI Anxiety

AI-related anxiety captures affective responses to AI autonomy, opacity, and the pace of technological change. Unlike general technology anxiety rooted in difficulty of use, AI anxiety encompasses broader concerns about human obsolescence, loss of agency, and unpredictable societal transformation.

Tao et al. (2020) developed a multi-dimensional AI anxiety scale identifying distinct facets: anxiety about AI learning and communication, AI social influence, AI configuration, and AI development trajectory. Frenkenberg and Hochman (2025) add anticipatory dimensions, distinguishing anxiety about current AI from anxiety about future AI capabilities. Kim et al. (2025) identify annihilation anxiety—existential concerns about human relevance—as a component particularly salient among knowledge workers whose expertise AI may replicate.

### 2.6.2 Anxiety as Inhibitor

Anxiety operates as an inhibitor in adoption models, exerting direct negative effects on intention and potentially attenuating the positive influence of performance expectancy and other drivers. Users experiencing high AI anxiety may acknowledge system usefulness while remaining unwilling to rely on AI for consequential decisions.

Importantly, anxiety effects may be nonlinear with exposure. Several studies observe that moderate, structured exposure to AI reduces anxiety by replacing vague fears with realistic expectations and coping strategies. This suggests that enablement programs and hands-on training can shift anxiety levels favorably—an organizational intervention that traditional acceptance models do not explicitly accommodate.

### 2.6.3 Anxiety in the Present Research

The present research incorporates **AI Anxiety** as an inhibitor construct extending UTAUT2. AI Anxiety is operationalized as affective unease about AI autonomy, opacity, and potential negative consequences. This construct is expected to negatively predict behavioral intention and may moderate the effects of positive predictors, particularly for users with limited AI experience.



## 2.7 Gaps in Current Research

The literature review reveals several gaps that the present research addresses:

**Gap 1: Validated AI-Specific Measurement Instruments**. While theoretical arguments for AI-specific constructs are well-developed, validated measurement instruments remain scarce. Most existing AI adoption studies adapt general technology acceptance measures or develop ad hoc items without rigorous scale development. The present research addresses this gap through systematic scale development following established psychometric procedures (Hinkin, 1998; DeVellis, 2017).

**Gap 2: Integration of Enablers and Inhibitors**. Prior research tends to study AI-specific constructs in isolation. Few studies simultaneously model trust and anxiety as enabler and inhibitor within an integrated UTAUT2 framework. The present research tests an integrative model where AI Trust operates as an enabler and AI Anxiety as an inhibitor alongside traditional UTAUT2 predictors.

**Gap 3: Cross-Population Validation**. Most AI adoption studies examine single populations, limiting generalizability claims. Whether adoption dynamics differ between student and professional populations—groups with potentially different AI exposure, organizational contexts, and role relationships—remains unexamined. The present research addresses this gap through multi-group analysis across student and professional samples.

**Gap 4: Experience as Moderator**. While UTAUT specifies experience as a moderator of traditional predictors, the moderating role of AI experience on AI-specific constructs is unexplored. Given theoretical arguments that anxiety decreases with calibrated exposure, experience moderation is particularly relevant for AI adoption. The present research tests experience moderation across both traditional and AI-specific paths.

**Gap 5: Connection to Practitioner Concerns**. Academic research on AI adoption often proceeds disconnected from practitioner challenges. The adoption-value gap identified in industry benchmarks reflects organizational barriers—governance, change management, workforce readiness—that acceptance research rarely addresses directly. The present research bridges this gap by developing a diagnostic instrument (AIRS) with explicit organizational applications.



## 2.8 Theoretical Framework and Hypotheses

### 2.8.1 Conceptual Model

The present research proposes an extended UTAUT2 model for AI adoption that retains the validated core while adding AI-specific enabler and inhibitor constructs. The model specifies:

**UTAUT2 Core Predictors**: Performance Expectancy, Effort Expectancy, Social Influence, Facilitating Conditions, Hedonic Motivation, and Habit as direct predictors of Behavioral Intention. Price Value is omitted given the organizational (rather than personal purchase) context.

**AI-Specific Extension**: AI Trust as an enabler positively predicting Behavioral Intention, and AI Anxiety as an inhibitor negatively predicting Behavioral Intention.

**Moderation**: AI experience moderating predictor-intention relationships, with theoretical expectations that experience strengthens performance expectancy effects and weakens anxiety effects.

### 2.8.2 Core UTAUT2 Hypotheses

Based on the meta-analytic evidence reviewed above, the following hypotheses reflect established UTAUT2 relationships:

**H1 (Performance Expectancy)**: Performance Expectancy positively predicts Behavioral Intention to use AI tools.

*Rationale*: Blut et al.'s (2022) meta-analysis confirms performance expectancy as the consistently strongest predictor (ρ = .60). Users who believe AI will enhance their job performance should demonstrate greater adoption intention.

**H2 (Effort Expectancy)**: Effort Expectancy positively predicts Behavioral Intention to use AI tools.

*Rationale*: While meta-analytic effects are moderate and context-dependent, perceived ease of use remains a relevant consideration, particularly for users with limited AI experience.

**H3 (Social Influence)**: Social Influence positively predicts Behavioral Intention to use AI tools.

*Rationale*: Perceptions that important others endorse AI use should increase adoption intention, particularly in organizational contexts where peer and supervisor expectations are salient.

**H4 (Facilitating Conditions)**: Facilitating Conditions positively predicts Behavioral Intention to use AI tools.

*Rationale*: Organizational infrastructure, training, and support should enable adoption by reducing barriers and signaling organizational commitment.

**H5 (Hedonic Motivation)**: Hedonic Motivation positively predicts Behavioral Intention to use AI tools.

*Rationale*: Users who experience pleasure and enjoyment from AI interaction should demonstrate greater adoption intention, consistent with UTAUT2 findings in consumer contexts.

**H6 (Habit)**: Habit positively predicts Behavioral Intention to use AI tools.

*Rationale*: Established patterns of AI use should predict continued intention through automaticity and reinforcement mechanisms.

### 2.8.3 AI-Specific Extension Hypotheses

**H7 (AI Trust)**: AI Trust positively predicts Behavioral Intention to use AI tools.

*Rationale*: Building on Langer et al.'s (2023) review and Stevens and Stetson's (2023) validation work, trust serves as a gateway condition for AI adoption. Users who trust AI systems to be reliable, competent, and aligned with their interests should demonstrate greater adoption intention.

**H8 (AI Anxiety)**: AI Anxiety negatively predicts Behavioral Intention to use AI tools.

*Rationale*: Drawing on Tao et al. (2020), Kim et al. (2025), and Frenkenberg and Hochman (2025), anxiety about AI autonomy, opacity, and consequences should inhibit adoption intention even when other perceptions are favorable.

### 2.8.4 Moderation Hypotheses

**H9 (Experience Moderation)**: Experience moderates the relationships between predictors and Behavioral Intention, such that:

- (a) The effect of Performance Expectancy on Intention strengthens with greater AI experience
- (b) The effect of Hedonic Motivation on Intention strengthens with greater AI experience
- (c) The negative effect of AI Anxiety on Intention weakens with greater AI experience

*Rationale*: Experienced users can more accurately assess AI performance, may derive greater enjoyment from sophisticated use, and should have resolved initial anxieties through exposure and coping development.

**Figure 2.3: Research Hypotheses Summary**

![](figures/02_literature_review_fig3.png)



## 2.9 Chapter Summary

This chapter established the theoretical foundation for the Artificial Intelligence Readiness Scale through four contributions.

First, it traced the evolution of technology acceptance research from foundational theories through UTAUT and UTAUT2, emphasizing Blut et al.'s (2022) meta-analytic confirmation of performance expectancy as the strongest adoption predictor while identifying substantial unexplained variance that invites domain-specific extension.

Second, it contextualized the theoretical discussion within the contemporary AI adoption-value gap, using industry benchmarks to demonstrate that traditional acceptance frameworks incompletely explain why 76% organizational adoption yields only 5% value realization. This gap motivates investigation of factors beyond traditional constructs.

Third, it examined AI's distinctive characteristics—opacity, probabilistic behavior, ethical exposure, and human role transformation—that stress traditional acceptance models. These characteristics justify the incorporation of AI Trust as an enabler and AI Anxiety as an inhibitor within an extended UTAUT2 framework.

Fourth, it articulated the research hypotheses tested in subsequent chapters, specifying both traditional UTAUT2 relationships and AI-specific extensions with experience moderation.

The theoretical framework positions AIRS as a principled extension that respects the durability of established acceptance research while acknowledging AI's socio-technical distinctives. The resulting instrument should provide both scholarly contribution—validated measurement of AI-specific adoption determinants—and practical value—a diagnostic tool for organizational AI readiness assessment.

The following chapter describes the methodology employed to develop and validate the AIRS instrument, including sample composition, measurement procedures, and analytic approach.

\newpage

# Chapter 3: Research Methodology

## 3.1 Introduction

This chapter describes the research methodology employed to develop and validate the AI Readiness Scale (AIRS) and test the extended UTAUT model for AI tool adoption in higher education. The study follows established scale development procedures (DeVellis & Thorpe, 2021; Hinkin, 1998) combined with structural equation modeling to examine relationships between latent constructs. The research design prioritizes psychometric rigor through split-sample cross-validation, comprehensive validity assessment, and multi-group invariance testing.

The chapter is organized as follows: Section 3.2 describes the research philosophy and design; Section 3.3 details the theoretical framework and hypotheses; Section 3.4 covers instrument development; Section 3.5 addresses sampling and data collection; Section 3.6 presents the analytical strategy; Section 3.7 discusses reliability and validity; Section 3.8 covers ethical considerations; and Section 3.9 acknowledges methodological limitations.



## 3.2 Research Design

### 3.2.1 Research Philosophy

This study adopts a **post-positivist** philosophical stance, recognizing that while objective reality exists, our understanding of it is necessarily imperfect and probabilistic (Creswell & Creswell, 2018). This orientation is appropriate for scale development research, which seeks to measure latent psychological constructs through observable indicators while acknowledging measurement error and the provisional nature of theoretical models.

The post-positivist approach manifests in several methodological choices:

- Emphasis on **replication and cross-validation** through split-sample design
- Use of **probabilistic inference** (confidence intervals, effect sizes) rather than binary significance testing
- Recognition of **measurement error** through latent variable modeling
- **Theory-driven** hypothesis testing with openness to unexpected findings

### 3.2.2 Research Approach

The study employs a **sequential mixed methods design** (Creswell & Clark, 2017) with quantitative primacy:

1. **Primary Quantitative Component**: Structured survey measuring UTAUT constructs on Likert scales, analyzed through factor analysis and structural equation modeling

2. **Supplementary Qualitative Component**: Open-ended feedback questions analyzed through thematic analysis to provide contextual depth and identify emergent themes not captured by closed-ended items

This design allows triangulation of findings, with qualitative data enriching interpretation of quantitative patterns (e.g., understanding why certain constructs predict adoption more strongly than others).

### 3.2.3 Time Horizon

The study employs a **cross-sectional design** with data collected during November 2024. While cross-sectional designs preclude causal inference, they are standard for initial scale validation studies (DeVellis & Thorpe, 2021). The design captures a snapshot of AI adoption readiness during a period of rapid AI tool proliferation in higher education, providing a baseline for future longitudinal research.

### 3.2.4 Research Context

The study was conducted with **United States professionals and students**, encompassing:

- Full-time and part-time students (undergraduate and postgraduate)
- Employed professionals (individual contributors, managers, executives)
- Freelancers and self-employed individuals

Students are included because they are transitioning into an AI-infused job market and will soon make adoption decisions inside organizations; their readiness is therefore directly relevant to near-term enterprise contexts (proposal §7.2). This context was selected for theoretical and practical relevance: knowledge-intensive work settings where AI tools have significant potential impact on productivity, yet adoption patterns remain poorly understood.



## 3.3 Theoretical Framework and Hypotheses

### 3.3.1 Extended UTAUT Model

The study extends Venkatesh et al.'s (2012) Unified Theory of Acceptance and Use of Technology 2 (UTAUT2) with AI-specific constructs. The theoretical model comprises eight latent factors predicting Behavioral Intention to adopt AI tools:

**Core UTAUT2 Constructs:**

- **Performance Expectancy (PE)**: The degree to which using AI tools will provide benefits in performing activities
- **Effort Expectancy (EE)**: The degree of ease associated with using AI tools
- **Social Influence (SI)**: The degree to which important others believe one should use AI tools
- **Facilitating Conditions (FC)**: Perceptions of resources and support available for AI tool use
- **Hedonic Motivation (HM)**: The fun or pleasure derived from using AI tools

**AI-Specific Extensions:**

- **Trust in AI (TR)**: Confidence in AI systems' reliability, accuracy, and benevolence
- **AI Anxiety (AX)**: Apprehension or fear associated with AI technology

**Outcome:**

- **Behavioral Intention (BI)**: Intent to adopt and use AI tools in professional/academic activities

### 3.3.2 Research Hypotheses

Based on UTAUT theory and emerging AI adoption literature, the following hypotheses were tested:

**Primary Hypotheses (Direct Effects):**

- H1a: Performance Expectancy positively predicts Behavioral Intention
- H1b: Effort Expectancy positively predicts Behavioral Intention
- H1c: Social Influence positively predicts Behavioral Intention
- H1d: Facilitating Conditions positively predicts Behavioral Intention
- H1e: Hedonic Motivation positively predicts Behavioral Intention
- H1f: Trust in AI positively predicts Behavioral Intention
- H1g: AI Anxiety negatively predicts Behavioral Intention

**Moderation Hypotheses:**

- H2: AI Experience moderates UTAUT relationships (strengthening effects for experienced users)
- H3: Role group (Student vs. Professional+Leader) moderates UTAUT path coefficients

**Behavioral Validation:**

- H4: Behavioral Intention positively relates to actual AI tool usage breadth
- H5: Role groups differ significantly in AI tool usage patterns



## 3.4 Instrument Development

### 3.4.1 Initial Item Pool

The initial AIRS instrument comprised **28 items across 12 constructs**:

- 7 core UTAUT2 constructs (14 items): PE, EE, SI, FC, HM, PV, HB
- 5 AI-specific extensions (10 items): TR, AX, VO, EX, ER
- 1 outcome construct (4 items): BI

Items were measured on 5-point Likert scales (1 = Strongly Disagree to 5 = Strongly Agree), with negatively-worded items (AX, ER) reverse-scored prior to analysis.

### 3.4.2 Item Sources

Items were adapted from established scales to ensure content validity:

| Construct | Source | Adaptation |
|-----------|--------|------------|
| PE, EE, SI, FC, HM | Venkatesh et al. (2012) UTAUT2 | Context adapted for AI tools |
| PV, HB | Venkatesh et al. (2012) UTAUT2 | Context adapted for AI tools |
| TR | McKnight et al. (2002); Siau & Wang (2018) | Adapted for AI systems |
| AX | Venkatesh (2000); Meuter et al. (2003) | Technology anxiety → AI anxiety |
| VO | Moore & Benbasat (1991) | Voluntariness of use |
| EX | Shin (2021) | Explainability in AI |
| ER | Gursoy et al. (2019) | Ethical risk perception |
| BI | Venkatesh et al. (2003) | Standard UTAUT items |

### 3.4.3 Content Validity

Content validity was established through:

1. **Literature Review**: Items grounded in established UTAUT and technology acceptance literature
2. **Construct Definition Mapping**: Each item mapped to specific construct definition
3. **Face Validity Review**: Items reviewed for clarity and appropriateness to AI context

### 3.4.4 Construct Exclusion Process

Of the 12 constructs proposed, **four AI-specific constructs were excluded** during exploratory factor analysis due to inadequate psychometric properties:

| Construct | Items | Cronbach's α | Issue | Disposition |
|-----------|-------|--------------|-------|-------------|
| Voluntariness (VO) | VO1, VO2 | .41 | Multi-dimensional | Dropped |
| Explainability (EX) | EX1, EX2 | .58 | Multi-dimensional | Dropped |
| Ethical Risk (ER) | ER1, ER2 | .55 | Multi-dimensional | Dropped |
| AI Anxiety (AX) | AX1, AX2 (original) | .30 | Item heterogeneity | Reconstructed |

**Interpretation**: These constructs demonstrated poor inter-item correlations, suggesting the two-item scales measured different facets of multi-dimensional phenomena rather than unitary constructs. For example:

- **Voluntariness**: VO1 assessed choice to use AI, while VO2 assessed freedom not to use—conceptually distinct aspects of voluntary adoption
- **Explainability**: EX1 assessed understanding AI outputs, while EX2 assessed preference for explanations—comprehension vs. preference dimensions
- **Ethical Risk**: ER1 assessed job displacement concerns, while ER2 assessed privacy concerns—distinct risk categories
- **Anxiety**: Original items captured tech-aversion (AX1) and FOMO/obsolescence anxiety (AX2)—avoidance vs. approach motivations

**Resolution**: The Anxiety construct was successfully reconstructed with revised items demonstrating adequate reliability (α = .86). The remaining three constructs (VO, EX, ER) were excluded from the final model, with recommendations for future item development (see Section 5.7).

**Note**: This represents an empirical finding, not a design limitation. The proposal committed to testing these constructs; the data revealed inadequate measurement properties. This transparent reporting aligns with best practices in scale development (DeVellis & Thorpe, 2021).

### 3.4.5 Final Instrument Structure

Following psychometric validation (see Chapter 4), the final AIRS instrument comprises **16 items across 8 factors**:

| Factor | Items | Example Item |
|--------|-------|--------------|
| Performance Expectancy | PE1, PE2 | "Using AI tools increases my productivity" |
| Effort Expectancy | EE1, EE2 | "Learning to use AI tools is easy for me" |
| Social Influence | SI1, SI2 | "People important to me think I should use AI tools" |
| Facilitating Conditions | FC1, FC2 | "I have the resources necessary to use AI tools" |
| Hedonic Motivation | HM1, HM2 | "Using AI tools is fun" |
| Trust in AI | TR1, TR2 | "I trust AI tools to provide accurate information" |
| AI Anxiety | AX1, AX2 | "I feel apprehensive about using AI tools" |
| Behavioral Intention | BI1, BI2 | "I intend to use AI tools in the next 6 months" |



## 3.5 Sampling and Data Collection

### 3.5.1 Target Population

The target population comprises adults in the United States who are either students or employed professionals (proposal §7.2). This includes:

- Full-time and part-time students at undergraduate and postgraduate levels
- Employed professionals in individual contributor roles
- Employed professionals in managerial and leadership roles
- Freelancers and self-employed individuals

### 3.5.2 Sampling Strategy

**Convenience sampling** was employed via:

- Institutional email distribution to staff and students
- Academic and professional network sharing
- Social media outreach (LinkedIn, Twitter/X)

While convenience sampling limits generalizability, it is appropriate for initial scale validation studies where the primary goal is psychometric evaluation rather than population inference (DeVellis & Thorpe, 2021).

### 3.5.3 Sample Size Determination

Target sample size was determined based on:

1. **SEM requirements**: Minimum N = 200 for stable Maximum Likelihood estimation (Kline, 2016)
2. **Factor analysis**: Minimum 10:1 subject-to-item ratio (Costello & Osborne, 2005)
3. **Multi-group analysis**: Minimum n = 100 per group (Hair et al., 2019)
4. **Split-sample cross-validation**: N > 500 to enable 50/50 split with adequate subsamples

**Achieved sample**: N = 523 (exceeds all requirements)

### 3.5.4 Role Classification

Respondents were classified into three role groups based on self-reported primary role:

| Category | Operational Definition | n | % |
|----------|----------------------|---|---|
| Student | Full-time students (n=196), part-time students (n=20) | 216 | 41.3% |
| Professional | Individual contributors (n=112), freelancers (n=32), other (n=23), unemployed (n=17) | 184 | 35.2% |
| Leader | Managers (n=71), executives (n=52) | 123 | 23.5% |

**Note**: For multi-group SEM requiring larger group sizes, Professional and Leader categories were combined (n = 307) to contrast with Student (n = 216). This grouping reflects meaningful theoretical distinctions between student-focused and employment-focused roles.

### 3.5.5 Data Collection Procedures

**Platform**: Qualtrics online survey platform

**Collection Period**: November 2024 (3-week window)

**Procedures**:

1. Participants accessed survey via distributed link
2. Informed consent obtained before data collection
3. Survey completion time: approximately 10-15 minutes
4. All responses anonymous; no personally identifiable information collected

### 3.5.6 Data Quality Assurance

Multiple quality checks were implemented:

| Check | Criterion | Action |
|-------|-----------|--------|
| Completion status | Finished = True | Exclude incomplete responses |
| Response time | > 3 minutes | Exclude speeders |
| Attention checks | Correct response | Exclude inattentive responses |
| Pattern responding | Variance > 0 | Exclude straight-line responses |
| Duplicate detection | Unique IP/device | Retain first response only |

**Final valid sample**: N = 523 after quality screening



## 3.6 Analytical Strategy

### 3.6.1 Analysis Pipeline

The analysis followed a systematic 10-phase pipeline ensuring replicability and transparency:

| Phase | Notebook | Purpose |
|-------|----------|----------|
| 0 | Sample Splitting | Create EFA/CFA subsamples |
| 1 | EFA | Explore factor structure |
| 2 | CFA | Validate factor structure |
| 3 | Invariance | Test measurement invariance |
| 4 | Structural Model | Test hypotheses |
| 5 | Mediation | Examine indirect effects |
| 6 | Moderation | Test moderating effects |
| 7 | Tool Usage | Behavioral validation |
| 8 | Qualitative | Thematic analysis |
| 9 | Comprehensive Review | Gap analysis |
| 10 | Final Synthesis | Integration |

![](figures/03_methodology_fig1.png)

*Figure 3. Ten-Phase Analysis Pipeline*

### 3.6.2 Sample Splitting Strategy

To ensure independent validation, the sample was randomly split:

![](figures/03_methodology_fig2.png)

*Figure 1. Split-Sample Cross-Validation Strategy*

**Stratification**: Split stratified by AI adoption status to ensure comparable samples

**Reproducibility**: Random seed (67) documented for exact replication

### 3.6.3 Exploratory Factor Analysis (EFA)

**Purpose**: Identify underlying factor structure and reduce item pool

**Sample**: Development subsample (n = 261)

**Extraction Method**: Principal Axis Factoring (PAF)

- Selected for robustness to non-normality
- Accounts for measurement error

**Rotation**: Promax (oblique)

- Allows correlated factors (theoretically appropriate)
- Pattern matrix used for interpretation

**Factor Retention Criteria**:

1. Kaiser criterion (eigenvalue > 1.0)
2. Parallel analysis (Horn, 1965)
3. Scree plot visual inspection
4. Theoretical interpretability

**Item Retention Criteria**:

| Criterion | Threshold | Rationale |
|-----------|-----------|-----------|
| Primary loading | λ ≥ .50 | Strong factor association |
| Cross-loading | Δλ ≥ .20 | Simple structure |
| Communality | h² ≥ .30 | Adequate shared variance |

**Software**: Python `factor_analyzer` package (v0.5.1)

### 3.6.4 Confirmatory Factor Analysis (CFA)

**Purpose**: Validate factor structure on independent sample

**Sample**: Holdout subsample (n = 262)

**Estimation Method**: Maximum Likelihood (ML)

- Standard for continuous indicators
- Provides χ² test and fit indices

**Model Specification**: 8-factor correlated model with 16 observed indicators (2 per factor)

**Fit Index Thresholds**:

| Index | Acceptable | Good | Excellent |
|-------|------------|------|-----------|
| χ²/df | < 5.0 | < 3.0 | < 2.0 |
| CFI | ≥ .90 | ≥ .95 | ≥ .97 |
| TLI | ≥ .90 | ≥ .95 | ≥ .97 |
| RMSEA | ≤ .10 | ≤ .08 | ≤ .05 |
| SRMR | ≤ .10 | ≤ .08 | ≤ .05 |

Thresholds based on Hu & Bentler (1999) and Hair et al. (2019).

**Software**: Python `semopy` package (v2.3.10)

### 3.6.5 Measurement Invariance Testing

**Purpose**: Establish construct comparability across role groups for valid multi-group comparison

**Levels Tested**:

| Level | Constraint | Interpretation |
|-------|------------|----------------|
| Configural | Same factor structure | Qualitative equivalence |
| Metric | Equal factor loadings | Quantitative equivalence |
| Scalar | Equal intercepts | Mean comparability |

**Criteria for Invariance** (Chen, 2007):

- ΔCFI < .010
- ΔRMSEA < .015
- Δχ² non-significant (supplementary)

**Groups**: Student (n = 216) vs. Professional+Leader (n = 307)

### 3.6.6 Structural Equation Modeling (SEM)

**Purpose**: Test hypothesized relationships between latent constructs

**Model**:

![](figures/03_methodology_fig3.png)

*Figure 2. Structural Model: Seven Predictors of Behavioral Intention*

**Estimation**: Maximum Likelihood with robust standard errors

**Multi-Group Analysis**: Separate models for Student and Professional+Leader groups

**Moderation Testing**:

- Experience × UTAUT interactions via latent interaction terms
- Role moderation via multi-group path comparison (Δχ² tests)

**Effect Size Interpretation** (Cohen, 1988):

| β | Interpretation |
|---|----------------|
| < .10 | Negligible |
| .10–.29 | Small |
| .30–.49 | Medium |
| ≥ .50 | Large |

### 3.6.7 Mediation Analysis

**Purpose**: Examine indirect pathways through the model

**Method**: Bootstrap estimation (5,000 resamples) for indirect effect confidence intervals

**Significance**: 95% CI excluding zero

### 3.6.8 Cluster Analysis

**Purpose**: Identify distinct user typologies based on UTAUT profile patterns

**Method**: K-means clustering

**Variables**: Standardized scores on 8 AIRS constructs

**Cluster Selection**:

- Elbow method
- Silhouette analysis
- Theoretical interpretability

**Optimal Solution**: k = 4 clusters

### 3.6.9 Qualitative Analysis

**Purpose**: Provide contextual depth and identify emergent themes

**Data**: Open-ended survey responses (n = 243 substantive responses, 46.5% response rate)

**Method**: Thematic analysis (Braun & Clarke, 2006)

1. Familiarization with data
2. Initial coding using keyword matching
3. Theme development and refinement
4. Theme prevalence quantification
5. Role-based comparison

**Themes Identified**: 10 distinct themes (see Chapter 4)

### 3.6.10 Statistical Software

All analyses conducted using Python 3.11 with the following packages:

| Package | Version | Purpose |
|---------|---------|---------|
| pandas | 2.1.0 | Data manipulation |
| numpy | 1.26.0 | Numerical computing |
| scipy | 1.11.0 | Statistical tests |
| factor_analyzer | 0.5.1 | Exploratory factor analysis |
| semopy | 2.3.10 | Confirmatory factor analysis, SEM |
| pingouin | 0.5.3 | Effect sizes, reliability |
| scikit-learn | 1.3.0 | Cluster analysis |
| matplotlib | 3.8.0 | Visualization |
| seaborn | 0.13.0 | Statistical graphics |

**Environment**: Jupyter notebooks executed in VS Code with Python virtual environment

**Reproducibility**: All random operations use documented seeds; complete analysis pipeline available in GitHub repository



## 3.7 Reliability and Validity Assessment

### 3.7.1 Internal Consistency Reliability

**Measures**:

- **Cronbach's Alpha (α)**: Classical reliability coefficient
- **Composite Reliability (CR)**: SEM-based reliability accounting for differential loadings

**Thresholds**:

| Measure | Minimum | Preferred |
|---------|---------|-----------|
| Cronbach's α | .70 | .80 |
| Composite Reliability | .70 | .80 |

### 3.7.2 Convergent Validity

**Definition**: Extent to which indicators of a construct share variance

**Assessment**:

1. **Factor loadings**: All standardized loadings ≥ .70
2. **Average Variance Extracted (AVE)**: Proportion of variance captured by construct

**Threshold**: AVE ≥ .50 (Fornell & Larcker, 1981)

### 3.7.3 Discriminant Validity

**Definition**: Extent to which constructs are distinct from one another

**Assessment Methods**:

1. **Fornell-Larcker Criterion**: √AVE > inter-construct correlations
2. **Heterotrait-Monotrait Ratio (HTMT)**: HTMT < .85 (Henseler et al., 2015)
3. **Maximum correlation**: |r| < .85 between any construct pair

### 3.7.4 Criterion Validity

**Predictive Validity**: AIRS constructs predict actual tool usage behavior (ρ = .70 for BI × tool breadth)

**Known-Groups Validity**: Constructs differentiate between theoretically-distinct groups (e.g., Leaders vs. Academics)



## 3.8 Ethical Considerations

### 3.8.1 Institutional Approval

The study received ethical approval from the institution's Research Ethics Committee prior to data collection. The research was classified as minimal risk given:

- Anonymous data collection
- Voluntary participation
- Non-sensitive topic
- Adult participants only

### 3.8.2 Informed Consent

Participants were provided with:

- Study purpose and objectives
- Data handling and storage procedures
- Right to withdraw without penalty
- Researcher contact information

Consent was obtained electronically before survey access. Participants could not proceed without acknowledging consent.

### 3.8.3 Anonymity and Confidentiality

**Anonymity**: No personally identifiable information collected

- No names, emails, or employee IDs
- IP addresses not recorded
- Demographic data collected at categorical level only

**Confidentiality**:

- Data stored on encrypted, password-protected systems
- Access limited to research team
- Data retained according to institutional policy (minimum 5 years)

### 3.8.4 Data Protection

The study complies with:

- IRB approval requirements
- Institutional data governance policies
- Research ethics standards for human subjects research

### 3.8.5 Participant Welfare

The survey addressed non-sensitive topics related to technology use attitudes. No anticipated risks to participant welfare. Contact information provided for questions or concerns.



## 3.9 Methodological Limitations

### 3.9.1 Design Limitations

1. **Cross-sectional design**: Precludes causal inference; relationships may be correlational rather than causal. Future longitudinal studies needed to establish temporal precedence.

2. **Self-reported measures**: Behavioral Intention is a proxy for actual behavior. While BI strongly predicts behavior in UTAUT studies, some intention-behavior gap is expected.

3. **Single time point**: Attitudes and technology contexts change rapidly; findings reflect November 2024 snapshot.

### 3.9.2 Sampling Limitations

1. **Convenience sampling**: Non-probability sampling limits generalizability to broader populations. Results may not generalize beyond similar United States professional and student contexts.

2. **Single institution**: While diverse roles represented, institutional culture may influence responses.

3. **Self-selection bias**: Participants interested in AI may be overrepresented.

### 3.9.3 Measurement Limitations

1. **English language only**: Non-English speakers excluded; cross-cultural validity not established.

2. **Two items per construct**: While meeting minimum identification requirements for SEM, more indicators would improve reliability and content coverage.

3. **Adapted scales**: Items adapted from existing instruments; some original validation evidence may not transfer perfectly.

### 3.9.4 Analytical Limitations

1. **Normality assumptions**: ML estimation assumes multivariate normality; some departures may affect standard errors (though robust methods used where possible).

2. **Common method variance**: Single-source, single-time data collection may inflate correlations. Harman's single-factor test conducted as diagnostic.

3. **Model complexity**: Eight-factor model with limited items requires careful balance between fit and parsimony.



## 3.10 Chapter Summary

This chapter has described the research methodology for developing and validating the AI Readiness Scale (AIRS) and testing the extended UTAUT model for AI tool adoption. Key methodological features include:

**Research Design**:

- Post-positivist philosophy with mixed methods approach
- Cross-sectional survey with qualitative supplementation
- United States professionals and students context

**Instrument**:

- 28 initial items across 12 constructs
- Final validated instrument: 16 items across 8 factors
- 5-point Likert scale measurement

**Sample**:

- N = 523 United States adults
- Two population groups: Students (216), Professionals (307)
- 50/50 split for cross-validation (EFA n = 261, CFA n = 262)

**Analysis**:

- 10-phase systematic pipeline
- EFA for structure exploration, CFA for validation
- Multi-group SEM for hypothesis testing
- Cluster analysis for user typology
- Thematic analysis for qualitative insights

**Validity**:

- Comprehensive reliability and validity assessment
- Measurement invariance across role groups
- Criterion validity through behavioral correlates

The methodology provides a rigorous foundation for the empirical findings presented in Chapter 4, while acknowledging limitations inherent in cross-sectional survey research.

\newpage

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

\newpage

# Chapter 5: Discussion and Conclusions

## 5.1 Introduction

This chapter discusses the implications of the AIRS validation study findings, addresses limitations, and provides recommendations for future research and practice.

## 5.2 Summary of Key Findings

### 5.2.1 AIRS Instrument Validation

The study successfully validated an 8-factor, 16-item AI Readiness Scale extending UTAUT2 with AI Trust.

### 5.2.2 Supported Relationships

Three of seven hypothesized UTAUT2 paths were significant:

- **Price Value** (β = .505, p < .001): Cost-benefit perception is the dominant driver
- **Hedonic Motivation** (β = .217, p = .014): Enjoyment significantly predicts adoption
- **Social Influence** (β = .136, p = .024): Peer influence matters for AI adoption

### 5.2.3 AI Trust Extension

AI Trust approached but did not reach significance (β = .106, p = .064), providing tentative support for the theoretical extension. Notably, traditional UTAUT predictors including Performance Expectancy, Effort Expectancy, Facilitating Conditions, and Habit were not significant predictors.

## 5.3 Discussion of Findings

### 5.3.1 Price Value as Dominant Predictor

**Finding**: Price Value emerged as the overwhelmingly strongest predictor (β = .505, p < .001), substantially exceeding all other constructs.

**Interpretation**: This finding represents a significant departure from traditional UTAUT research where Performance Expectancy typically dominates. In the AI context, users appear primarily motivated by **perceived value relative to cost** rather than raw productivity benefits (PE, ns), ease of use (EE, ns), organizational support (FC, ns), or habit (HB, ns). This suggests that AI adoption interventions should prioritize demonstrating clear return on investment and cost-effectiveness rather than focusing solely on capability demonstrations.

**Theoretical Implications**: The dominance of Price Value over Performance Expectancy suggests AI tools may represent a distinct technology category. Unlike previous technologies where utility perceptions drove adoption, AI adoption appears more influenced by value propositions—potentially reflecting the freemium pricing models common in AI tools, concerns about ongoing subscription costs, or cost-benefit analyses comparing AI tools to traditional methods.

### 5.3.2 Non-Significant UTAUT2 Paths

**Finding**: PE, EE, FC, and HB were not significant predictors.

**Interpretation**: The non-significance of Performance Expectancy (β = -.028, p = .791) is particularly noteworthy, as PE typically dominates technology acceptance research. This suggests that in the AI context, perceived usefulness may be a baseline expectation rather than a differentiating factor. Users may assume AI tools will enhance productivity, making cost-benefit considerations (Price Value) and enjoyment (Hedonic Motivation) the deciding factors.

Similarly, the non-significance of Effort Expectancy (β = -.008, p = .875) and Facilitating Conditions (β = .059, p = .338) may reflect the increasingly user-friendly nature of modern AI tools and widespread organizational technology infrastructure.

### 5.3.3 AI Trust Marginality

**Finding**: TR approached but did not reach significance (β = .106, p = .064).

**Interpretation**: The marginal significance of AI Trust suggests it may become a more important predictor as AI technologies mature and trust concerns become more salient. The current sample may have insufficient power to detect the effect, or trust considerations may be less central for the relatively straightforward AI tools currently in use. Future research should examine whether AI Trust becomes more predictive for high-stakes AI applications (e.g., AI-assisted decision-making, autonomous systems).

### 5.3.4 Experience as Moderator

**Finding**: Professional experience strengthens HM → BI (β = .136, p = .007).

**Interpretation**: The significant moderation effect suggests that experienced professionals place greater weight on enjoyment when evaluating AI tools. This may reflect that experienced users, having satisfied basic competency needs, prioritize intrinsic satisfaction. Additionally, usage frequency moderates the importance of Performance Expectancy (for new users) versus Price Value (for heavy users).

### 5.3.5 User Typology Segments

**Finding**: Four distinct user segments identified.

**Implications for Practice**:

- AI Enthusiasts (16%): Leverage as champions
- Cautious Adopters (30%): Address concerns while maintaining engagement
- Moderate Users (37%): Benefit-focused messaging
- Anxious Avoiders (17%): Targeted anxiety-reduction interventions

### 5.3.6 Disability and Accessibility

**Finding**: Disability associated with higher AI anxiety (d = .36).

**Implications**:
[To be written - inclusive AI design]

## 5.4 Theoretical Contributions

1. **UTAUT2 Extension**: Validated AI Trust as potential extension
2. **Context-Specific Model**: Identified AI-specific adoption drivers
3. **Career Development Integration**: Experience as novel moderator
4. **User Typology Framework**: Practical segmentation approach

## 5.5 Practical Implications

### 5.5.1 For Organizations

[To be written]

### 5.5.2 For AI Tool Designers

[To be written]

### 5.5.3 For Trainers and Educators

[To be written]

### 5.5.4 For Policy Makers

[To be written]

## 5.6 Limitations

### 5.6.1 Methodological Limitations

1. **Cross-sectional design**: The single time-point data collection precludes causal inference. While SEM estimates suggest directional relationships, alternative causal orderings (e.g., behavior → intention) cannot be ruled out.

2. **Self-reported intention**: Behavioral Intention may not perfectly predict actual behavior. However, the strong BI-Usage correlation (ρ = .70) provides behavioral validation.

3. **Convenience sampling**: The United States sample limits generalizability to other countries, cultures, and organizational contexts.

### 5.6.2 Measurement Limitations

1. **Dropped constructs**: Four proposed AI-specific constructs (Voluntariness, Explainability, Ethical Risk, original Anxiety items) demonstrated inadequate reliability (α = .30–.58) and were excluded. This finding reveals that **two-item scales proved insufficient for these multi-dimensional constructs**:
   - **Voluntariness** (α = .41): Choice vs. freedom dimensions
   - **Explainability** (α = .58): Understanding vs. preference dimensions
   - **Ethical Risk** (α = .55): Job displacement vs. privacy concern dimensions
   - **Original Anxiety** (α = .30): Avoidance vs. approach motivation dimensions

   **Implication**: These constructs remain theoretically important for AI adoption but require more comprehensive operationalization. Future scale development should include 3-4 items per dimension, potentially yielding multi-factor sub-scales (e.g., "Ethical Risk" with separate job-threat and privacy-concern subscales).

   **Note**: This represents an empirical finding, not a design failure. The proposal committed to testing these constructs; the data revealed measurement limitations. Transparent reporting of psychometric issues aligns with best practices in scale development.

2. **Marginal AI Trust**: Trust approached but did not reach significance (p = .064). This may reflect inadequate statistical power (β = .106 requires n > 600 for 80% power at α = .05) or genuine marginality of trust in AI adoption decisions.

3. **Western sample**: Cultural generalizability is unknown. AI adoption attitudes may differ substantially in collectivist cultures or regions with different AI policy environments.

## 5.7 Future Research Directions

### 5.7.1 Immediate Priorities

1. **Replicate with larger sample**: Achieve n > 600 to provide adequate power (80%) for detecting the Trust effect (β ≈ .10) at α = .05.

2. **Redesign dropped construct scales**: The four excluded constructs (Voluntariness, Explainability, Ethical Risk, Anxiety sub-dimensions) require comprehensive item development:
   - Develop 3-4 items per dimension (e.g., 4 items for job-threat ethical risk + 4 items for privacy ethical risk)
   - Use cognitive interviewing to ensure items capture intended constructs
   - Pilot test reliability before main data collection
   - Consider formative vs. reflective measurement models for inherently multi-faceted constructs

3. **Test untested mediation hypotheses**: The original proposal hypothesized mediation paths through Explainability, Ethical Risk, and Anxiety (H5a-c). These paths could not be tested because EX and ER were dropped. Future research with improved measures should examine:
   - H5a: TR → EX → BI (Trust operating through Explainability)
   - H5b: AX ↔ ER → BI (Anxiety-Risk interaction effects)
   - H5c: FC → EX → BI (Organizational support enabling explainability)

4. **Longitudinal intention-behavior study**: Track actual AI adoption behavior over 6-12 months following intention measurement to validate the BI → Behavior pathway.

### 5.7.2 Extended Research Agenda

1. Cross-cultural validation
2. Industry-specific applications
3. Intervention studies based on user typology
4. Accessibility-focused AI anxiety research

## 5.8 Conclusions

[To be written - synthesize contributions and call to action]

\newpage

# References

::: {#refs}
:::

\newpage

# Appendices

## Appendix A: AI Readiness Scale (AIRS) Final 16-Item Instrument

The final validated 16-item AIRS instrument consists of eight constructs measured using a 7-point Likert scale (1 = Strongly Disagree to 7 = Strongly Agree).

### Performance Expectancy (PE)

1. **PE1**: I find AI tools useful in my work.
2. **PE2**: Using AI tools increases my productivity.

### Effort Expectancy (EE)

3. **EE1**: AI tools are easy to use.
4. **EE2**: Learning to use AI tools is easy for me.

### Social Influence (SI)

5. **SI1**: People who are important to me think I should use AI tools.
6. **SI2**: People who influence my behavior think I should use AI tools.

### Facilitating Conditions (FC)

7. **FC1**: I have the resources necessary to use AI tools.
8. **FC2**: I have the knowledge necessary to use AI tools.

### Hedonic Motivation (HM)

9. **HM1**: Using AI tools is fun.
10. **HM2**: Using AI tools is enjoyable.

### Habit (HT)

11. **HT1**: The use of AI tools has become a habit for me.
12. **HT2**: I am addicted to using AI tools.

### AI Trust (TR)

13. **TR1**: I trust the output generated by AI tools.
14. **TR2**: I believe AI tools are reliable.

### AI Anxiety (ANX)

15. **ANX1**: I feel apprehensive about using AI tools.
16. **ANX2**: AI tools are somewhat intimidating to me.

\newpage

## Appendix B: Survey Materials

### B.1 Participant Information Sheet

*To be added.*

### B.2 Informed Consent Form

*To be added.*

### B.3 Demographic Questions

*To be added.*

\newpage

## Appendix C: Supplementary Statistical Tables

### C.1 Full Correlation Matrix

*To be added.*

### C.2 Item-Level Descriptive Statistics

*To be added.*

### C.3 Cross-Validation Results

*To be added.*