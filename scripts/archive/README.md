# Archived Scripts

This directory contains scripts that have been deprecated and replaced with improved implementations.

## preprocess_airs_data_DEPRECATED.py

**Status**: Deprecated as of November 22, 2025
**Replaced by**: `airs/00_Create_Split_Samples.ipynb` (Sections 1.1-1.2)

### Why Deprecated

The original standalone preprocessing script has been superseded by integrated preprocessing in the Jupyter notebook workflow for several key reasons:

1. **Simplified Workflow**: Preprocessing now happens directly in the analysis notebook, eliminating the need for a separate script execution step
2. **Label Export Support**: New implementation uses Centiment's label export format (text labels) instead of numeric codes, eliminating ~50 lines of error-prone demographic mapping code
3. **Safer Mappings**: Text labels from the survey tool match exactly what respondents saw, reducing risk of mapping errors
4. **Better Documentation**: Inline cells document preprocessing logic with immediate validation output
5. **Fact-Checked**: All mappings verified against actual survey instrument screenshots (Q3, Q37-Q40)
6. **Improved Work_Context Logic**: Fixed edge case where "Not currently employed" was incorrectly matched by substring 'employed'

### Key Improvements in New Implementation

**Label Export Format**:
- Likert responses: "Strongly disagree" through "Strongly agree" (text → numeric 1-5)
- Usage frequency: "Never" through "Daily" (text → numeric 1-5)
- Demographics: Keep as text labels (no mapping required)

**Work Context Detection**:
- Academic-Student: Any role containing 'student'
- Academic-Faculty: Education industry + "Employed -" (space-dash) or "Freelancer"
- Professional: All others (including "Not currently employed")

**Validation Results**:
- N=325 responses processed successfully
- 292 AI adopters, 33 non-adopters
- 180 Professional, 120 Academic-Student, 25 Academic-Faculty
- 0 NaN values in all mapped fields
- All balance tests p > 0.97 (excellent split quality)

### If You Need the Old Script

The original script is preserved here for reference but should not be used for new analyses. The notebook implementation is the authoritative preprocessing pipeline going forward.

**Migration Note**: Any analyses using data processed by the old script should be re-run with the new notebook preprocessing to ensure consistency.
