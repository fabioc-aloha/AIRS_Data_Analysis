# Semantic Metadata Integration

## Overview

Starting from Notebook 00 (Create Split Samples), **item semantic metadata** is now systematically maintained throughout the entire analysis pipeline. This ensures theoretical consistency and interpretability across EFA, CFA, and structural modeling phases.

## Metadata Structure

Each of the 24 survey items includes:

| Field | Description | Example |
|-------|-------------|---------|
| `item_code` | Variable name | `"PE1"` |
| `construct` | Full construct name | `"Performance Expectancy"` |
| `construct_abbr` | Construct abbreviation | `"PE"` |
| `hypothesis` | Research hypothesis | `"H1"` or `"H2"` |
| `question_text` | Full survey question | `"AI tools help me accomplish tasks more quickly."` |
| `direction` | Item directionality | `"POSITIVE"` or `"NEGATIVE"` |
| `expected_BI_relationship` | Expected relationship with Behavioral Intention | `"Higher scores → Higher adoption"` |
| `theoretical_note` | Brief conceptual description | `"Perceived productivity gain"` |
| `provenance` | Literature source | `"Direct (UTAUT)"` or `"Adapted (AI literature)"` |

## Directionality Classification

### Positive Items (21/24 = 87.5%)
Items where **higher scores predict higher AI adoption**:
- All Performance Expectancy (PE1, PE2)
- All Effort Expectancy (EE1, EE2)
- All Social Influence (SI1, SI2)
- All Facilitating Conditions (FC1, FC2)
- All Hedonic Motivation (HM1, HM2)
- All Price Value (PV1, PV2)
- All Habit (HB1, HB2)
- All Voluntariness (VO1, VO2)
- All Trust in AI (TR1, TR2)
- All Explainability (EX1, EX2)
- **AX2: FOMO Anxiety** (approach motivation / catch-up behavior)

### Negative Items (3/24 = 12.5%)
Items where **higher scores predict lower AI adoption**:
- **ER1**: Job replacement worry (avoidance motivation)
- **ER2**: Privacy concerns (ethical risk perception)
- **AX1**: Tech-averse anxiety (discomfort with AI proliferation)

## Special Case: FOMO Anxiety (AX2)

**Item**: "I worry that I may be left behind if I do not keep up with AI"

**Classification**: **POSITIVE** (despite being an anxiety measure)

**Rationale**: FOMO anxiety represents **approach motivation** (catch-up behavior), NOT avoidance. People who worry about falling behind actively adopt AI to stay current. This is distinct from:
- **AX1** (tech-averse anxiety): Discomfort with AI itself → Avoidance
- **ER1** (job threat anxiety): External threat perception → Avoidance

**Theoretical Foundation**: Standard motivational psychology—fear of missing out naturally drives engagement behavior to close the perceived gap.

## Pipeline Integration

### Notebook 00: Create Split Samples
- **Creates** `airs_item_semantic_metadata.json` with all 24 items
- **Creates** `airs_24item_complete.json` - comprehensive export bundling data + semantic metadata
- **Location**: `data/airs_item_semantic_metadata.json` (metadata only)
- **Location**: `data/airs_24item_complete.json` (complete package for Notebook 01)
- **Purpose**: Single source of truth for item semantics + complete export for EFA

### Notebook 01: EFA (Exploratory Factor Analysis)
- **Loads** semantic metadata at initialization
- **Exports** 16-item selection with embedded semantic metadata
- **Location**: `data/airs_16item_selection.json` (includes `semantic_metadata` field)
- **Purpose**: Maintain semantic properties for selected items

### Notebook 02: CFA (Confirmatory Factor Analysis)
- **Loads** semantic metadata from centralized source
- **Uses** metadata for semantic content analysis
- **Displays**: Item directionality table with expected BI relationships
- **Purpose**: Validate that factor loadings align with theoretical expectations

### Future Notebooks (03-08)
- **Will load** semantic metadata from either:
  - Full metadata: `airs_item_semantic_metadata.json` (all 24 items)
  - Selected subset: `airs_16item_selection.json` → `semantic_metadata` field (16 items)
- **Applications**:
  - Measurement invariance interpretation
  - Structural model coefficient interpretation
  - Mediation/moderation analysis
  - Qualitative feedback alignment

## Benefits

1. **Theoretical Consistency**: Same item interpretations across all analyses
2. **Reproducibility**: Centralized metadata prevents inconsistencies
3. **Transparency**: Clear documentation of item properties and expected relationships
4. **Efficiency**: No need to redefine item content in each notebook
5. **Quality Control**: Easy to verify that empirical results align with theory

## Example Usage

### Load Full Metadata (All 24 Items)
```python
import json
from pathlib import Path

metadata_path = Path('../data/airs_item_semantic_metadata.json')
with open(metadata_path, 'r', encoding='utf-8') as f:
    item_metadata = json.load(f)

# Access specific item
pe1_meta = item_metadata['PE1']
print(pe1_meta['question_text'])  # "AI tools help me accomplish tasks more quickly."
print(pe1_meta['direction'])      # "POSITIVE"
```

### Load Selected Items Only (16 Items from EFA)
```python
import json
from pathlib import Path

selection_path = Path('../data/airs_16item_selection.json')
with open(selection_path, 'r', encoding='utf-8') as f:
    selection_data = json.load(f)

# Access semantic metadata for selected items
semantic_meta = selection_data['semantic_metadata']
hb2_meta = semantic_meta['HB2']
print(hb2_meta['theoretical_note'])  # "Default reliance behavior"
```

### Create Directionality Summary
```python
positive_items = [item for item, meta in item_metadata.items() if meta['direction'] == 'POSITIVE']
negative_items = [item for item, meta in item_metadata.items() if meta['direction'] == 'NEGATIVE']

print(f"Positive items (pro-adoption): {len(positive_items)}")
print(f"Negative items (anti-adoption): {len(negative_items)}")
```

## Validation Checklist

When analyzing results, verify:

✅ **Positive items** have factor loadings in expected direction (positive on pro-adoption factors)
✅ **Negative items** have either:
   - Negative loadings on pro-adoption factors (correct)
   - Positive loadings on barrier/risk factors (correct)
   - Weak/inconsistent loadings → Consider as standalone predictors

✅ **AX2 (FOMO)** should behave like positive items (approach motivation)
✅ **ER1/AX1** should behave like barriers (avoidance motivation)

## References

- **Survey Instrument**: `docs/AIRS Survey Instrument v5.md`
- **Data Dictionary**: `docs/DATA_DICTIONARY.md`
- **Metadata File**: `data/airs_item_semantic_metadata.json`
- **16-Item Selection**: `data/airs_16item_selection.json`

---

**Created**: November 25, 2025
**Version**: 1.0
**Status**: ✅ Integrated across Notebooks 00, 01, 02
