# AIRS Data Dictionary
## Artificial Intelligence Readiness Score (AIRS) Survey Data

**Dataset**: AIRS---AI-Readiness-Scale.csv
**Version**: 2.0
**Date**: November 2025
**Sample Size**: N ≈ 509 valid responses (data collection ongoing)
**Survey Platform**: Online survey collection (Centiment panel)

---

## Overview

The AIRS (Artificial Intelligence Readiness Score) survey measures attitudes, perceptions, and behavioral intentions toward AI tool adoption. The instrument extends the UTAUT2 (Unified Theory of Acceptance and Use of Technology 2) framework with AI-specific constructs to predict AI adoption readiness in work and educational settings.

### Theoretical Framework
- **Base Model**: UTAUT2 (Venkatesh et al., 2012)
- **Extensions**: AI-specific constructs (Trust, Explainability, Ethical Risk, Anxiety)
- **Outcome Variable**: Behavioral Intention (AI Adoption Readiness)

### Current Analysis Approach (Three-Model Strategy)
- **Full Sample**: N ≈ 509 — All respondents
- **Academic Subsample**: N ≈ 194 — Full-time + Part-time students
- **Professional Subsample**: N ≈ 274 — Employed (IC, Manager, Executive) + Freelancers
- **Scale Development**: Theory-guided, data-driven EFA → CFA per population
- **Goal**: Minimum viable scale with maximum diagnostic coverage (all 13 constructs if data supports)

### Item Pool
- **Predictor Items**: 24 items across 12 constructs (2 items per construct)
- **Outcome Items**: 4 items (Behavioral Intention)
- **Total Analysis Items**: 28 (excluding attention check)
- **Reverse Coding**: NO reverse-coded items — all items scored as presented

---

## Data Structure

### File Information
- **Original File**: `data/AIRS---AI-Readiness-Scale.csv`
- **Clean File**: `data/AIRS_clean.csv` (preprocessed, attention check filtered)
- **Format**: CSV (Comma-Separated Values)
- **Encoding**: UTF-8
- **Missing Data Code**: NA (blank cells indicate missing)

### Record Structure
- **Header Row 1**: Variable labels (full question text)
- **Header Row 2**: Question type metadata
- **Data Rows**: Individual survey responses (rows 3+)

---

## Variable Categories

### 1. Administrative Variables

| Variable Name | Type | Description | Values |
|--------------|------|-------------|--------|
| `Session.ID` | String | Unique session identifier | GUID format |
| `Publish.ID` | String | Survey publication identifier | GUID format |
| `Collector` | String | Data collection source | "Audience Panel - Collection 1" |
| `Language` | String | Survey language | "English" |
| `Start.Date` | DateTime | Survey start timestamp | MM/DD/YYYY HH:MM:SS |
| `End.Date` | DateTime | Survey completion timestamp | MM/DD/YYYY HH:MM:SS |
| `Status` | String | Completion status | "complete" |
| `Progress` | Integer | Completion percentage | 0-100 |
| `Duration..seconds.` | Integer | Time to complete (seconds) | Numeric |

### 2. Consent & Screening

| Variable Name | Type | Description | Values |
|--------------|------|-------------|--------|
| `Consent` | Integer | Informed consent | 1 = Yes, I agree |
| `Role` | String | Current role/status | See Role coding below |

**Role Coding** (used for population subsetting):

| Value | Label | Population |
|-------|-------|------------|
| `Student (full-time)` | Full-time student | Academic |
| `Student (part-time)` | Part-time student | Academic |
| `Employed (individual contributor)` | IC/Staff | Professional |
| `Employed (manager)` | Manager | Professional |
| `Employed (executive)` | Executive/Director | Professional |
| `Freelancer or self-employed` | Independent | Professional |
| `Not currently employed` | Unemployed | Excluded from subsamples |
| `Other` | Other | Excluded from subsamples |

### 3. Core Measurement Items (Likert Scale)

All items use a **5-point Likert scale**:
- 1 = Strongly Disagree
- 2 = Disagree
- 3 = Neither Agree nor Disagree
- 4 = Agree
- 5 = Strongly Agree

#### 3.1 Performance Expectancy (PE)
*"How much do you agree with these statements about how AI tools help you get things done?"*

| Variable | Item Text | Direction | Provenance |
|----------|-----------|-----------|------------|
| `PE1` | AI tools help me accomplish tasks more quickly | POSITIVE | Direct (UTAUT2) |
| `PE2` | Using AI improves the quality of my work or studies | POSITIVE | Direct (UTAUT2) |

#### 3.2 Effort Expectancy (EE)
*"How much do you agree with these statements about how easy AI tools are to learn and use?"*

| Variable | Item Text | Direction | Provenance |
|----------|-----------|-----------|------------|
| `EE1` | Learning to use AI tools is easy for me | POSITIVE | Direct (UTAUT2) |
| `EE2` | Interacting with AI tools is clear and understandable | POSITIVE | Direct (UTAUT2) |

#### 3.3 Social Influence (SI)
*"How much do you agree with these statements about the people around you and their views on using AI?"*

| Variable | Item Text | Direction | Provenance |
|----------|-----------|-----------|------------|
| `SI1` | People whose opinions I value encourage me to use AI tools | POSITIVE | Direct (UTAUT2) |
| `SI2` | Leaders in my organization or school support the use of AI tools | POSITIVE | Direct (UTAUT2) |

#### 3.4 Facilitating Conditions (FC)
*"How much do you agree with these statements about the resources and support you have for using AI?"*

| Variable | Item Text | Direction | Provenance |
|----------|-----------|-----------|------------|
| `FC1` | I have access to training or tutorials for the AI tools I use | POSITIVE | Adapted (UTAUT2) |
| `FC2` | The AI tools I use are compatible with other tools or systems I use | POSITIVE | Adapted (UTAUT2) |

#### 3.5 Hedonic Motivation (HM)
*"How much do you agree with these statements about enjoyment when using AI tools?"*

| Variable | Item Text | Direction | Provenance |
|----------|-----------|-----------|------------|
| `HM1` | Using AI tools is stimulating and engaging | POSITIVE | Adapted (UTAUT2) |
| `HM2` | AI tools make my work or studies more interesting | POSITIVE | Adapted (UTAUT2) |

#### 3.6 Price Value (PV)
*"How much do you agree with these statements about whether using AI is worth your time and effort?"*

| Variable | Item Text | Direction | Provenance |
|----------|-----------|-----------|------------|
| `PV1` | I get more value from AI tools than the effort they require | POSITIVE | Adapted (UTAUT2) - effort substituted for monetary cost |
| `PV2` | Using AI tools is worth the learning curve | POSITIVE | Adapted (UTAUT2) - effort substituted for monetary cost |

#### 3.7 Habit (HB)
*"How much do you agree with these statements about your habits with AI tools?"*

| Variable | Item Text | Direction | Provenance |
|----------|-----------|-----------|------------|
| `HB1` | Using AI tools has become a habit for me | POSITIVE | Direct (UTAUT2) |
| `HB2` | I tend to rely on AI tools by default when I need help with tasks | POSITIVE | Adapted (UTAUT2) |

#### 3.8 Voluntariness (VO)
*"How much do you agree with these statements about your freedom to choose whether or not to use AI tools?"*

| Variable | Item Text | Direction | Provenance |
|----------|-----------|-----------|------------|
| `VO1` | I choose to use AI tools in my work because I find them helpful, not because I am required to | POSITIVE | UTAUT2 extension |
| `VO2` | I could choose not to use AI tools in my work or studies if I preferred | AMBIGUOUS | UTAUT2 extension |

**Notes**:
- Voluntariness is an extension to standard UTAUT2. Consider excluding if strict UTAUT2 replication is needed.
- ⚠️ **Measurement Issue**: VO1 measures intrinsic motivation (autonomous choice), while VO2 measures freedom from coercion (lack of mandatory use). These represent different facets of voluntariness and may not form a unidimensional construct. VO2's relationship with adoption intention is theoretically ambiguous.
- **Recommendation**: Examine inter-item correlation and individual item correlations with outcome variable.

#### 3.9 Trust in AI (TR)
*"How much do you agree with these statements about trusting AI tools?"*

| Variable | Item Text | Direction | Provenance |
|----------|-----------|-----------|------------|
| `TR1` | I trust AI tools to provide reliable information | POSITIVE | Adapted (AI literature - Langer et al., 2023; Siau & Wang, 2018) |
| `TR2` | I trust the AI tools that are available to me | POSITIVE | Adapted (AI literature - Langer et al., 2023) |

#### 3.10 Explainability (EX)
*"How much do you agree with these statements about understanding how AI tools make their recommendations?"*

| Variable | Item Text | Direction | Provenance |
|----------|-----------|-----------|------------|
| `EX1` | I understand how the AI tools I use generate their outputs | POSITIVE | Adapted (AI literature - Doshi-Velez & Kim, 2017) |
| `EX2` | I prefer AI tools that explain their recommendations | POSITIVE | Adapted (AI literature - Guidotti et al., 2018; Shin, 2021) |

#### 3.11 Attention Check (ATT_CHECK)
**⚠️ EXCLUDE FROM ANALYSIS** — Removed during preprocessing

| Variable | Item Text | Expected Response |
|----------|-----------|-------------------|
| `ATT_CHECK` | To show that you are paying attention please select "Disagree" | 2 (Disagree) |

**Data Quality**: 4 respondents (2.0%) failed this check and were removed.

#### 3.12 Perceived Ethical Risk (ER)
*"How much do you agree with these statements about possible risks of AI?"*

| Variable | Item Text | Direction | Provenance |
|----------|-----------|-----------|------------|
| `ER1` | I worry that AI tools could replace jobs in my field | NEGATIVE | Adapted (AI literature - Floridi et al., 2018) |
| `ER2` | I am concerned about privacy risks when using AI tools | NEGATIVE | Adapted (AI ethics literature) |

**Notes**:
- ⚠️ **Negatively Valenced Construct**: Items measure worry and concern (negative attitudes). Higher scores indicate more ethical concerns about AI.
- **Expected Relationship**: Should predict **lower** behavioral intention (BI). More concern/worry → Less adoption readiness.
- **Scoring**: Items are NOT reverse-coded. Higher scores genuinely reflect higher perceived risk.
- **Scale Development**: Initial item pool included Item 40 "Organizations manage AI risks responsibly (R)" which was reverse-coded, but this item was REMOVED during EFA/CFA validation. Final 2-item ER scale uses only ER1 and ER2 with no reverse coding.
- **Analysis Consideration**: Path coefficients ER → BI should be negative if construct functions as expected barrier to adoption.

#### 3.13 AI Anxiety (AX)
*"How much do you agree with these statements about feeling uneasy or anxious about AI?"*

| Variable | Item Text | Direction | Provenance |
|----------|-----------|-----------|------------|
| `AX1` | I feel uneasy about the increasing use of AI | NEGATIVE | Adapted (AI literature - Bendel, 2021) |
| `AX2` | I worry that I may be left behind if I do not keep up with AI | POSITIVE | Adapted (AI literature - obsolescence anxiety) |

**Notes**:
- ⚠️⚠️ **CRITICAL Measurement Issue**: AX1 and AX2 measure **opposite types of anxiety**:
  - **AX1**: Tech-averse anxiety (discomfort with AI itself) → Expected to predict **LOWER** BI (barrier)
  - **AX2**: FOMO anxiety (fear of falling behind without AI) → Expected to predict **HIGHER** BI (motivator)
- **Construct Validity Concern**: Items may not measure a unidimensional construct. AX1 and AX2 have opposing theoretical relationships with adoption intention.
- **Scoring**: Items are NOT reverse-coded. Both measure "worry," but about different things.
- **Analysis Considerations**:
  - Expect lower inter-item correlation between AX1 and AX2
  - Cronbach's alpha may be lower than other constructs
  - Path coefficients may be non-significant or show unexpected signs
  - Consider analyzing items separately or removing construct from final model
- **Recommendation**: This internal inconsistency may contribute to poor model fit when AX is included.

#### 3.14 Behavioral Intention - AI Adoption Readiness (BI) [OUTCOME VARIABLE]
*"How much do you agree with these statements about your readiness to use AI?"*

| Variable | Item Text | Direction | Provenance |
|----------|-----------|-----------|------------|
| `BI1` | I am ready to use more AI tools in my work or studies | POSITIVE | Direct (UTAUT2) |
| `BI2` | I would recommend AI tools to others | POSITIVE | Direct (UTAUT2) |
| `BI3` | I see AI as an important part of my future | POSITIVE | Adapted (UTAUT2) |
| `BI4` | I plan to increase my use of AI tools in the next six months | POSITIVE | Direct (UTAUT2) |

**Note**: Standard UTAUT2 uses 2-3 items for BI. This survey uses 4 items for enhanced reliability.

---

### 4. Usage Frequency Variables

*"How often do you use the following AI tools?"*

**Scale**:
- 1 = Never
- 2 = Rarely (less than once a month)
- 3 = Sometimes (monthly)
- 4 = Often (weekly)
- 5 = Very often (daily)

| Variable | AI Tool |
|----------|--------|
| `Usage_MSCopilot` | Microsoft 365 Copilot or Microsoft Copilot |
| `Usage_ChatGPT` | ChatGPT |
| `Usage_Gemini` | Google Gemini |
| `Usage_Other` | Other AI tools (e.g., Claude, Perplexity, Grok) |

---

### 5. Demographic Variables

| Variable | Question | Response Options |
|----------|----------|------------------|
| `Role` | What is your current status? | See Role coding below |
| `Education` | What is your highest level of education completed? | 1=High school, 2=Some college, 3=Associate's, 4=Bachelor's, 5=Master's, 6=Doctoral |
| `Industry` | Which industry or field best describes your primary area of work or study? | Text/categorical |
| `Experience` | How many years of work or study experience do you have in your field? | 1=<1 year, 2=1-3, 3=4-6, 4=7-10, 5=>10 years |
| `Disability` | Do you identify as a person with a disability? | 1=Yes, 2=No, 3=Prefer not to say |
| `Feedback` | Do you have any other feedback about your experiences with AI tools? | Open-text response |

---

## Construct Summary

| Construct Code | Construct Name | # Items | Type | Theoretical Source |
|----------------|----------------|---------|------|-------------------|
| PE | Performance Expectancy | 2 | Predictor | UTAUT2 |
| EE | Effort Expectancy | 2 | Predictor | UTAUT2 |
| SI | Social Influence | 2 | Predictor | UTAUT2 |
| FC | Facilitating Conditions | 2 | Predictor | UTAUT2 |
| HM | Hedonic Motivation | 2 | Predictor | UTAUT2 |
| PV | Price Value | 2 | Predictor | UTAUT2 |
| HB | Habit | 2 | Predictor | UTAUT2 |
| VO | Voluntariness | 2 | Predictor | Extension |
| TR | Trust | 2 | Predictor | AI-specific |
| EX | Explainability | 2 | Predictor | AI-specific |
| ER | Ethical Risk | 2 | Predictor | AI-specific |
| AX | Anxiety | 2 | Predictor | AI-specific |
| BI | Behavioral Intention | 4 | **Outcome** | UTAUT2 |

**Total Analysis Items**: 28 (excluding attention check)
**UTAUT2 Constructs**: 7 (PE, EE, SI, FC, HM, PV, HB)
**AI-Specific Extensions**: 4 (TR, EX, ER, AX)
**Additional**: 1 (VO - Voluntariness)

---

## Data Quality Notes

### Sample Characteristics
- **Total Responses**: 205
- **Valid Responses**: 201 (after attention check)
- **Completion Rate**: 100% (all records complete)
- **Missing Data**: Minimal (<1% on any item)

### Attention Check Results
- **Location**: Item 34 (embedded in Explainability section)
- **Expected Response**: 2 (Disagree)
- **Failure Rate**: 2.0% (4 respondents)
- **Action**: Failed responses excluded from analysis

### Data Transformations
1. **Variable Renaming**: Long descriptive names → Short codes (PE1, EE2, etc.)
2. **Numeric Conversion**: All Likert items converted to numeric (1-5)
3. **Filtering**: Attention check failures removed
4. **Output**: Clean dataset saved as `data/AIRS_clean.csv`

---

## Usage Guidelines

### For Analysis
1. **Use**: `data/AIRS_clean.csv` (preprocessed)
2. **Sample Size**: N = 201 for all analyses
3. **Missing Data**: Listwise deletion if needed (minimal impact)
4. **Attention Check**: Already filtered in clean dataset

### For Psychometric Validation
- **Recommended Split**: 50/50 for EFA/CFA cross-validation (n=100/101)
- **Alternative**: 60/40 split (n=120/81) for larger CFA sample
- **Construct Assessment**: All constructs have ≥2 items (minimum for identification)

### For SEM Analysis
- **Predictors**: 12 constructs (or 11 if VO excluded)
- **Outcome**: BI (4 items - higher reliability than 2-item version)
- **Sample Size**: N=201 adequate for moderate complexity models (10-15 parameters per construct)
- **Recommended**: Use MLR estimator for Likert data robustness

---

## Variable Naming Convention

### Pattern
`[CONSTRUCT][ITEM_NUMBER]`

**Examples**:
- `PE1` = Performance Expectancy, Item 1
- `TR2` = Trust, Item 2
- `BI4` = Behavioral Intention, Item 4

### Special Cases
- `ATT_CHECK` = Attention check item (exclude from analysis)
- `Usage_[Tool]` = Usage frequency for specific AI tool
- Demographic variables use full descriptive names

---

## References

**Survey Instrument**:
- AIRS Survey Instrument v5.md - Complete survey documentation with research questions, hypotheses, final 28-item instrument (Appendix A), and initial 49-item pool with literature mapping (Appendix C)

**Theoretical Framework**:
- Venkatesh, V., Thong, J. Y., & Xu, X. (2012). Consumer acceptance and use of information technology: Extending the unified theory of acceptance and use of technology. *MIS Quarterly, 36*(1), 157-178.

**AI-Specific Extensions**:
- Shin, D. (2021). The effects of explainability and causability on perception, trust, and acceptance. *International Journal of Human-Computer Studies, 146*, 102551.
- Langer, M., et al. (2023). The role of algorithm aversion, anthropomorphism, and trust. *Computers in Human Behavior, 139*, 107503.

---

## Contact & Version History

**Version 1.0** - November 2025
- Initial data dictionary creation
- 201 valid responses
- 28 analysis items across 12 constructs

---

**End of Data Dictionary**
