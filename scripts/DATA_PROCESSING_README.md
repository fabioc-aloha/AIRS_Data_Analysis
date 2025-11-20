# AIRS Data Processing Scripts

Modular Python scripts for data preprocessing and quality control.

---

## Python Scripts

### `preprocess_airs_data.py` ⭐
**Primary data preprocessing pipeline**

Converts raw Centiment CSV to clean analysis dataset with quality checks, geolocation, and control variables.

**Usage**:
```bash
python preprocess_airs_data.py
```

**Processing Steps**:
1. Load raw data (skip Centiment metadata)
2. Rename to standardized codes (PE1, BI4, etc.)
3. Duration analysis (speeders/outliers)
4. IP → US state geolocation
5. Attention check filtering
6. Numeric conversion + validation
7. Add control variables (Region, Duration_minutes, Role)
8. Save clean dataset

**Input**: `data/AIRS---AI-Readiness-Scale.csv` (N=221)
**Output**: `data/AIRS_clean.csv` (N=201)

---

### `check_grouping_vars.py`
**H4 moderation feasibility checker**

Verifies sample sizes for multi-group SEM analysis.

**Usage**:
```bash
python check_grouping_vars.py
```

**Output**: Role, Usage groups, minimum n per group

---

## Notebook Integration

Main notebook automatically runs preprocessing if clean data missing:

```python
# Cell 2 checks for clean data
if not Path("../data/AIRS_clean.csv").exists():
    from preprocess_airs_data import AIRSPreprocessor
    preprocessor.run_pipeline()
```

---

## Quality Standards

✅ N=201 valid responses
✅ No missing data
✅ Values 1-5 validated
✅ Region + Duration_minutes + Role available
✅ Privacy protected (no IP addresses saved)

---

See `r-preprocessing/` for legacy R scripts. See `neural-dream.ps1` for Alex system maintenance.
