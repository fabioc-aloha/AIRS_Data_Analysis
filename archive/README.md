# Archive Folder

This folder contains historical analysis files that have been superseded by newer versions or are not aligned with the current dissertation methodology.

---

## 📂 Archive Contents

### 1. notebooks_exploratory/ (8 Jupyter notebooks)
**Archived**: November 22, 2025
**Status**: Exploratory phase (N=281, pre-dissertation)
**Contents**: 8 Jupyter notebooks using data-driven optimization, single-sample validation
**Reason**: Not aligned with dissertation's construct-balanced, split-sample approach
**Value**: Methodological insights extracted in `../EXPLORATORY_PHASE_LEARNINGS.md`

**Key Notebooks**:
- `AIRS_Adoption_Analysis_v2.ipynb` - Adoption prediction (AUC=92.2%)
- `AIRS_Short_Form_Validation.ipynb` - Item optimization (5-24 items)
- `AIRS_Item_Level_Analysis.ipynb` - Item-outcome correlations
- `AIRS_Analysis_Python.ipynb` - Preliminary psychometrics (63 cells)
- See `notebooks_exploratory/README.md` for complete inventory

### 2. docs_exploratory/ (15 analysis reports)
**Archived**: November 22, 2025
**Status**: Exploratory documentation (N=201-309 variants)
**Contents**: Analysis reports, methodological justifications, modularization experiments
**Reason**: Mixed samples, multiple outcomes, not dissertation-aligned
**Value**: Documents outcome selection, diagnostic rationale, quality assurance practices

**Key Reports**:
- `DISSERTATION_MODEL_EVALUATION.md` - 1190 lines, AUC=92.2% adoption prediction
- `AIRS_12_ITEM_DIAGNOSTIC_RATIONALE.md` - Theoretical coverage justification
- `ITEM_LEVEL_ANALYSIS_REPORT.md` - 1050 lines, item-level validity
- `OUTCOME_VARIABLE_THEORETICAL_JUSTIFICATION.md` - 610 lines, BI vs. adoption
- See `docs_exploratory/README.md` for complete inventory### 3. 01_EFA_Development_Sample_24item.ipynb
**Original**: `airs/01_EFA_Development_Sample.ipynb`
**Archived**: November 22, 2025
**Reason**: Superseded by construct-balanced 12-item approach
**Description**: Original 24-item EFA attempting 12-factor extraction, replaced with data-driven 12-item, 2-factor solution

### 4. 01_EFA_Construct_Balanced_12_Item_Model_OLD.ipynb
**Original**: `airs/01_EFA_Construct_Balanced_12_Item_Model.ipynb`
**Archived**: November 22, 2025
**Reason**: Superseded by `01_EFA_Construct_Balanced_12_Item.ipynb` (current)
**Description**: Previous version of Phase 1 notebook before finalization

---

## 🔄 Methodological Context

**Timeline**:
- **Pre-October 2025**: Exploratory phase (N=281, data-driven optimization)
- **October 2025**: Transition to dissertation methodology (N=318, construct-balanced)
- **November 2025**: Phase 1 complete, exploratory work archived

**Why Archive?**
- Exploratory notebooks used **single-sample validation** (no holdout)
- Item selection was **data-driven** (correlation-based), not construct-balanced
- Framework was **exploratory** (13 constructs), not fixed (12 constructs)
- Outcomes were **mixed** (adoption + BI), not standardized (BI only)

**What Changed for Dissertation?**
- Split-sample design (Development N=159, Holdout N=159)
- Construct-balanced selection (1 item per 12 constructs)
- Fixed theoretical framework (8 UTAUT2 + 4 AI-specific)
- Standardized outcome (Behavioral Intention only)
- A priori hypotheses (H1-H5) for confirmatory testing

---

## 📊 Current Active Notebooks

**Location**: `../airs/`

**Phase 1 (✅ Complete)**:
- `00_Create_Split_Samples.ipynb` - Stratified split-sample creation
- `01_EFA_Construct_Balanced_12_Item.ipynb` - 12-item scale development (α=0.897, R²=0.811)

**Phases 2-5 (⏳ Pending)**:
- `02_CFA_Measurement_Model.ipynb` - Holdout validation (next)
- `03_Measurement_Invariance.ipynb` - Multi-group testing
- `04_Structural_Model_Hypothesis_Testing.ipynb` - H1-H3
- `05_Mediation_Analysis.ipynb` - H5a-H5c
- `06_Moderation_Analysis.ipynb` - H4a-H4e
- `07_Comprehensive_Results.ipynb` - Integration

---

## 📖 Related Documentation

- **Learnings Synthesis**: `../EXPLORATORY_PHASE_LEARNINGS.md` (methodological insights from archived work)
- **Dissertation Plan**: `../airs/ANALYSIS_PLAN.md` (current roadmap with Phase 1 complete)
- **Consistency Check**: `../airs/CONSISTENCY_CHECK.md` (proposal/plan/code alignment)
- **Main README**: `../README.md` (project overview)

---

## 🎯 Archive Purpose

This archive preserves the exploratory phase work that:
1. Validated 12-item feasibility (96.3% efficiency vs. 24-item)
2. Identified strongest items per construct
3. Tested psychometric procedures
4. Informed dissertation design decisions

**Status**: Historical record enabling methodological transparency, not for dissertation hypothesis testing

---

**Last Updated**: November 22, 2025 (Week 24/32)
**Archive Status**: Complete
**Next Action**: Phase 2 CFA validation on holdout sample
