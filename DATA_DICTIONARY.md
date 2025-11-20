# AIRS Data Dictionary
## Artificial Intelligence Readiness Score (AIRS) Survey Data

**Dataset**: AIRS---AI-Readiness-Scale.csv
**Version**: 1.0
**Date**: November 2025
**Sample Size**: N = 201 responses (205 total, 4 excluded for attention check failure)
**Survey Platform**: Online survey collection

---

## Overview

The AIRS (Artificial Intelligence Readiness Score) survey measures attitudes, perceptions, and behavioral intentions toward AI tool adoption. The instrument extends the UTAUT2 (Unified Theory of Acceptance and Use of Technology 2) framework with AI-specific constructs to predict AI adoption readiness in work and educational settings.

### Theoretical Framework
- **Base Model**: UTAUT2 (Venkatesh et al., 2012)
- **Extensions**: AI-specific constructs (Trust, Explainability, Ethical Risk, Anxiety)
- **Outcome Variable**: Behavioral Intention (AI Adoption Readiness)

### Scale Development History
- **Initial Item Pool**: 49 items (documented in AIRS Survey Instrument v5.md, Appendix C)
- **Item 40 Removed**: "Organizations manage AI risks responsibly (R)" - This reverse-coded item from the Perceived Ethical Risk construct was removed during EFA/CFA validation
- **Final Instrument**: 28 items across 13 constructs (documented in AIRS Survey Instrument v5.md, Appendix A)
- **Reverse Coding**: NO reverse-coded items in final instrument - all items scored as presented

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
| `IP` | String | Respondent IP address | IP address format |

### 2. Consent & Screening

| Variable Name | Original Column | Type | Description | Values |
|--------------|-----------------|------|-------------|--------|
| `Consent` | Column 12 | Integer | Informed consent | 1 = Yes, I agree |
| `Status` | Column 13 | Integer | Current role/status | 3 = Student, 4 = Working professional |

### 3. Core Measurement Items (Likert Scale)

All items use a **5-point Likert scale**:
- 1 = Strongly Disagree
- 2 = Disagree
- 3 = Neither Agree nor Disagree
- 4 = Agree
- 5 = Strongly Agree

#### 3.1 Performance Expectancy (PE)
*"How much do you agree with these statements about how AI tools help you get things done?"*

| Variable | Original Column | Item Text |
|----------|-----------------|-----------|
| `PE1` | 14 | AI tools help me accomplish tasks more quickly |
| `PE2` | 15 | Using AI improves the quality of my work or studies |

#### 3.2 Effort Expectancy (EE)
*"How much do you agree with these statements about how easy AI tools are to learn and use?"*

| Variable | Original Column | Item Text |
|----------|-----------------|-----------|
| `EE1` | 16 | Learning to use AI tools is easy for me |
| `EE2` | 17 | Interacting with AI tools is clear and understandable |

#### 3.3 Social Influence (SI)
*"How much do you agree with these statements about the people around you and their views on using AI?"*

| Variable | Original Column | Item Text |
|----------|-----------------|-----------|
| `SI1` | 18 | People whose opinions I value encourage me to use AI tools |
| `SI2` | 19 | Leaders in my organization or school support the use of AI tools |

#### 3.4 Facilitating Conditions (FC)
*"How much do you agree with these statements about the resources and support you have for using AI?"*

| Variable | Original Column | Item Text |
|----------|-----------------|-----------|
| `FC1` | 20 | I have access to training or tutorials for the AI tools I use |
| `FC2` | 21 | The AI tools I use are compatible with other tools or systems I use |

#### 3.5 Hedonic Motivation (HM)
*"How much do you agree with these statements about enjoyment when using AI tools?"*

| Variable | Original Column | Item Text |
|----------|-----------------|-----------|
| `HM1` | 22 | Using AI tools is stimulating and engaging |
| `HM2` | 23 | AI tools make my work or studies more interesting |

#### 3.6 Price Value (PV)
*"How much do you agree with these statements about whether using AI is worth your time and effort?"*

| Variable | Original Column | Item Text |
|----------|-----------------|-----------|
| `PV1` | 24 | I get more value from AI tools than the effort they require |
| `PV2` | 25 | Using AI tools is worth the learning curve |

#### 3.7 Habit (HB)
*"How much do you agree with these statements about your habits with AI tools?"*

| Variable | Original Column | Item Text |
|----------|-----------------|-----------|
| `HB1` | 26 | Using AI tools has become a habit for me |
| `HB2` | 27 | I tend to rely on AI tools by default when I need help with tasks |

#### 3.8 Voluntariness (VO)
*"How much do you agree with these statements about your freedom to choose whether or not to use AI tools?"*

| Variable | Original Column | Item Text |
|----------|-----------------|-----------||
| `VO1` | 28 | I choose to use AI tools in my work because I find them helpful, not because I am required to |
| `VO2` | 29 | I could choose not to use AI tools in my work or studies if I preferred |

**Notes**:
- Voluntariness is an extension to standard UTAUT2. Consider excluding if strict UTAUT2 replication is needed.
- ⚠️ **Measurement Issue**: VO1 measures intrinsic motivation (autonomous choice), while VO2 measures freedom from coercion (lack of mandatory use). These represent different facets of voluntariness and may not form a unidimensional construct. VO2's relationship with adoption intention is theoretically ambiguous.
- **Recommendation**: Examine inter-item correlation and individual item correlations with outcome variable.

#### 3.9 Trust in AI (TR)
*"How much do you agree with these statements about trusting AI tools?"*

| Variable | Original Column | Item Text |
|----------|-----------------|-----------|
| `TR1` | 30 | I trust AI tools to provide reliable information |
| `TR2` | 31 | I trust the AI tools that are available to me |

#### 3.10 Explainability (EX)
*"How much do you agree with these statements about understanding how AI tools make their recommendations?"*

| Variable | Original Column | Item Text |
|----------|-----------------|-----------|
| `EX1` | 32 | I understand how the AI tools I use generate their outputs |
| `EX2` | 33 | I prefer AI tools that explain their recommendations |

#### 3.11 Attention Check (ATT_CHECK)
**⚠️ EXCLUDE FROM ANALYSIS**

| Variable | Original Column | Item Text | Expected Response |
|----------|-----------------|-----------|-------------------|
| `ATT_CHECK` | 34 | To show that you are paying attention please select "Disagree" | 2 (Disagree) |

**Data Quality**: 4 respondents (2.0%) failed this check and were removed.

#### 3.12 Perceived Ethical Risk (ER)
*"How much do you agree with these statements about possible risks of AI?"*

| Variable | Original Column | Item Text |
|----------|-----------------|-----------||
| `ER1` | 35 | I worry that AI tools could replace jobs in my field |
| `ER2` | 36 | I am concerned about privacy risks when using AI tools |

**Notes**:
- ⚠️ **Negatively Valenced Construct**: Items measure worry and concern (negative attitudes). Higher scores indicate more ethical concerns about AI.
- **Expected Relationship**: Should predict **lower** behavioral intention (BI). More concern/worry → Less adoption readiness.
- **Scoring**: Items are NOT reverse-coded. Higher scores genuinely reflect higher perceived risk.
- **Scale Development**: Initial item pool included Item 40 "Organizations manage AI risks responsibly (R)" which was reverse-coded, but this item was REMOVED during EFA/CFA validation. Final 2-item ER scale uses only ER1 and ER2 with no reverse coding.
- **Analysis Consideration**: Path coefficients ER → BI should be negative if construct functions as expected barrier to adoption.

#### 3.13 AI Anxiety (AX)
*"How much do you agree with these statements about feeling uneasy or anxious about AI?"*

| Variable | Original Column | Item Text |
|----------|-----------------|-----------||
| `AX1` | 37 | I feel uneasy about the increasing use of AI |
| `AX2` | 38 | I worry that I may be left behind if I do not keep up with AI |

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

| Variable | Original Column | Item Text |
|----------|-----------------|-----------|
| `BI1` | 39 | I am ready to use more AI tools in my work or studies |
| `BI2` | 40 | I would recommend AI tools to others |
| `BI3` | 41 | I see AI as an important part of my future |
| `BI4` | 42 | I plan to increase my use of AI tools in the next six months |

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

| Variable | Original Column | AI Tool |
|----------|-----------------|---------|
| `Usage_MSCopilot` | 43 | Microsoft 365 Copilot or Microsoft Copilot |
| `Usage_ChatGPT` | 44 | ChatGPT |
| `Usage_Gemini` | 45 | Google Gemini |
| `Usage_Other` | 46 | Other AI tools (e.g., Claude, Perplexity, Grok) |

---

### 5. Demographic Variables

| Variable | Original Column | Question | Response Options |
|----------|-----------------|----------|------------------|
| `Education` | 47 | What is your highest level of education completed? | 1=High school, 2=Some college, 3=Associate's, 4=Bachelor's, 5=Master's, 6=Doctoral |
| `Industry` | 48 | Which industry or field best describes your primary area of work or study? | Text/categorical |
| `Experience` | 49 | How many years of work or study experience do you have in your field? | 1=<1 year, 2=1-3, 3=4-6, 4=7-10, 5=>10 years |
| `Disability` | 50 | Do you identify as a person with a disability? | 1=Yes, 2=No, 3=Prefer not to say |
| `Feedback` | 51 | Do you have any other feedback about your experiences with AI tools? | Open-text response |

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
