# Domain Knowledge: Computational Notebook Refactoring

**Domain**: Data Science & Computational Research Methodology
**Version**: 1.0.0 UNNILIUM
**Created**: November 26, 2025
**Scope**: Systematic approaches to cleaning, refactoring, and generalizing Jupyter/computational notebooks for reusability and maintainability

---

## Overview

Computational notebooks (Jupyter, VS Code notebooks) accumulate technical debt through iterative exploratory analysis. This domain knowledge documents systematic refactoring methodologies to transform study-specific, verbose, redundant notebooks into clean, general-purpose, reusable research tools.

**Context**: Developed from comprehensive analysis of 3077-line qualitative analysis notebook requiring transformation from dissertation-specific artifact to general AIRS research template.

---

## 1. Assessment Phase: Systematic Issue Identification

### 1.1 Complete Notebook Examination
**Protocol**: Before making changes, conduct full structural analysis

**Examination checklist**:
- [ ] Total cell count (code vs markdown)
- [ ] Line count and notebook size
- [ ] Section numbering patterns
- [ ] Figure/table numbering schemes
- [ ] Hardcoded values scan
- [ ] Data flow dependencies
- [ ] Output cell analysis
- [ ] Visualization inventory

**Tool usage**:
- `copilot_getNotebookSummary` - Cell structure, execution status, output types
- `grep_search` - Find hardcoded values, specific text patterns
- `read_file` - Deep dive into specific sections
- `semantic_search` - Find conceptual patterns across notebook

### 1.2 Anti-Pattern Detection

**Common notebook anti-patterns**:

1. **Hardcoded Values**
   - Specific sample sizes (n=250, n=148) instead of dynamic calculation
   - Dates, percentages, study-specific identifiers
   - Non-parameterized thresholds and cutoffs
   - Example-specific variable names

2. **Study-Specific Content**
   - Dissertation defense talking points
   - Committee-specific interpretations
   - Timeline references (dates, validation percentages)
   - Specific result citations in prose

3. **Code Quality Issues**
   - Duplicate code blocks (DRY principle violations)
   - Long procedural code without functions
   - Repeated filtering/analysis patterns
   - Magic numbers without explanation

4. **Documentation Problems**
   - Verbose, redundant interpretation sections
   - Missing purpose statements for sections
   - Poor logical flow between sections
   - Inconsistent section numbering

5. **Visualization Issues**
   - Inconsistent styling across figures
   - Missing or incorrect figure numbering
   - Hardcoded titles with specific study details
   - Non-APA formatting (when required)

### 1.3 Data Flow Validation

**Critical check**: Verify proper integration with upstream notebooks

**Validation protocol**:
```python
# 1. Check expected input files exist
input_files = ['../data/AIRS_clean.csv', '../data/raw_survey.csv']

# 2. Verify required columns present
required_cols = ['PE2', 'EE2', 'SI2', 'FC2', 'HM2', 'PV2',
                 'TR2', 'EX2', 'ER2', 'AX2', 'BI2', 'HB2']

# 3. Confirm construct mapping matches upstream model
# Check that Notebook N uses outputs from Notebook N-1 correctly

# 4. Validate merge logic
# Ensure row-order merge or proper join keys documented
```

---

## 2. Planning Phase: Structured Todo List Creation

### 2.1 Todo List as Project Management

**Principle**: Don't start refactoring without comprehensive plan

**Todo structure template**:
```markdown
1. Examine entire notebook structure (in-progress)
   - Description: Full scan with findings
   - Status: in-progress → completed

2. Identify all issues to fix (not-started)
   - Description: Comprehensive anti-pattern list
   - Status: not-started → completed

3-N. Execution tasks in logical order
   - Verify dependencies first
   - Structure before content
   - Code before documentation
   - Test after all changes
```

### 2.2 Prioritization Framework

**Priority levels**:
1. **CRITICAL**: Data flow validation, execution errors
2. **HIGH**: Section restructuring, major code refactoring
3. **MEDIUM**: Generalization, documentation cleanup
4. **LOW**: Minor formatting, optional enhancements

**Sequence logic**:
- Dependencies before dependents
- Structure before content
- Code before markdown
- Validation after changes

---

## 3. Execution Phase: Refactoring Strategies

### 3.1 Strategic Choice: Incremental vs Clean Rewrite

**Decision factors**:

| Factor | Incremental Fixes | Clean Rewrite |
|--------|------------------|---------------|
| **Scope** | < 20 cells, focused issues | 50+ cells, systemic issues |
| **Anti-patterns** | Isolated problems | Pervasive throughout |
| **User timeline** | Immediate small fixes | Can invest upfront time |
| **Risk tolerance** | Low (preserve working code) | High (confident in logic) |
| **Reusability goal** | Minor improvements | Full template creation |

**Recommendation guideline**:
- **Incremental**: < 30% of notebook needs changes
- **Clean rewrite**: > 50% of notebook needs changes
- **Hybrid**: Fix critical issues incrementally, plan rewrite for later

### 3.2 KISS/DRY Refactoring Patterns

**Create reusable functions**:
```python
# BEFORE: Repeated t-test code
# ... duplicated 13 times with slight variations ...

# AFTER: Single function
def compare_theme_construct(df, theme_col, construct_col):
    """Compare construct scores between theme presence/absence groups.

    Returns: dict with t_stat, p_value, cohens_d, means
    """
    present = df[df[theme_col] == True][construct_col].dropna()
    absent = df[df[theme_col] == False][construct_col].dropna()

    t_stat, p_val = stats.ttest_ind(present, absent)

    # Cohen's d calculation
    pooled_std = np.sqrt((present.std()**2 + absent.std()**2) / 2)
    cohens_d = (present.mean() - absent.mean()) / pooled_std

    return {
        't_stat': t_stat,
        'p_value': p_val,
        'cohens_d': cohens_d,
        'mean_present': present.mean(),
        'mean_absent': absent.mean(),
        'n_present': len(present),
        'n_absent': len(absent)
    }

# Usage: Loop over theme-construct pairs
for theme, construct in pairs:
    results[theme][construct] = compare_theme_construct(df, theme, construct)
```

**Parameterize configurations**:
```python
# BEFORE: Hardcoded throughout notebook
validation_themes = ['Learning_Education', 'Positive_General', ...]
non_substantive = ['N/A', 'None', 'NA', ...]

# AFTER: Configuration cell at top
CONFIG = {
    'random_seed': 67,
    'validation_themes': ['Learning_Education', 'Positive_General',
                          'Productivity_Efficiency', 'Trust_Accuracy'],
    'non_substantive_patterns': ['N/A', 'None', 'NA', 'n/a',
                                  'nothing', 'no feedback'],
    'construct_mapping': {
        'Trust': 'TR2',
        'Hedonic': 'HM2',
        'Performance': 'PE2',
        # ... etc
    },
    'figure_dpi': 300,
    'figure_style': 'whitegrid'
}
```

### 3.3 Generalization Patterns

**Remove study-specific artifacts**:

| Anti-pattern | Generalization |
|-------------|----------------|
| `n=250 responses` | `n={len(df_feedback)} responses` |
| `96% validation accuracy` | `{accuracy:.1f}% validation accuracy` (calculated) |
| `November 23, 2025 analysis` | Remove entirely or `Analysis date: {date.today()}` |
| `Committee talking point:` | Remove section entirely |
| `"ChatGPT helpful for DMV test"` (specific quote) | `(See sample responses in output)` |

**Dynamic calculation template**:
```python
# Calculate all sample sizes dynamically
n_total = len(df)
n_responses = df['Has_Feedback'].sum()
response_rate = (n_responses / n_total) * 100
n_substantive = len(df_substantive)
substantive_rate = (n_substantive / n_responses) * 100

print(f"Total sample: N={n_total}")
print(f"Responses: n={n_responses} ({response_rate:.1f}%)")
print(f"Substantive: n={n_substantive} ({substantive_rate:.1f}%)")
```

### 3.4 Section Restructuring

**Logical narrative flow template**:

```
1. Setup & Configuration
   - Environment, packages, visualization settings
   - Configuration parameters
   - Directory creation

2. Data Loading & Preparation
   - Load AIRS construct scores
   - Load qualitative feedback
   - Merge datasets
   - Initial quality checks

3. Response Characteristics
   - Response rate analysis
   - Length distributions
   - Demographic breakdowns
   - Sample visualization

4. Substantive Filtering
   - Define non-substantive patterns
   - Apply filtering logic
   - Document exclusions
   - Validate filtered sample

5. Thematic Coding
   - Define theme keywords
   - Apply coding logic
   - Manual validation sample
   - Theme refinement

6. Theme Prevalence Analysis
   - Calculate theme distributions
   - Visualize top themes
   - Sentiment analysis
   - Illustrative quotes

7. Construct Triangulation
   - Map themes to constructs
   - Statistical comparison tests
   - Effect size calculations
   - Convergent validity assessment

8. Emergent Themes
   - Identify unmeasured themes
   - Prevalence analysis
   - Prioritization for scale development

9. Supplementary Analyses
   - Word frequency analysis
   - Alternative coding schemes
   - Robustness checks

10. Summary & Integration
    - Key findings synthesis
    - Methodological notes
    - Limitations
    - Next steps for AIRS research
```

---

## 4. Validation Phase: Quality Assurance

### 4.1 Execution Testing

**Full notebook run protocol**:
1. Restart kernel (clear all variables)
2. Run all cells sequentially
3. Monitor for errors or warnings
4. Verify all outputs generated
5. Check figure files saved correctly

**Common execution errors to check**:
- Undefined variable references
- File path issues (absolute vs relative)
- Missing dependencies
- Data type mismatches after refactoring

### 4.2 Output Validation

**Model tracking documentation requirements**:
- [ ] Sample sizes at each stage clearly reported
- [ ] Statistical test results include: t, p, d, n
- [ ] Effect sizes interpreted (small/medium/large)
- [ ] Tables formatted consistently
- [ ] Figures numbered sequentially
- [ ] All percentages calculated, not hardcoded

### 4.3 Narrative Flow Check

**Story coherence assessment**:
- Does each section have clear purpose?
- Are transitions between sections logical?
- Is technical jargon explained when introduced?
- Are visualizations integrated into narrative?
- Is interpretation concise and evidence-based?

---

## 5. Best Practices Summary

### 5.1 Code Quality Principles

**KISS (Keep It Simple, Stupid)**:
- One concept per cell
- Short functions (< 30 lines)
- Clear variable names
- Minimal nesting depth

**DRY (Don't Repeat Yourself)**:
- Functions for repeated operations
- Configuration parameters
- Reusable data transformation patterns

**General-Purpose Design**:
- No hardcoded study-specific values
- Dynamic sample size calculations
- Parameterized thresholds
- Dataset-agnostic logic

### 5.2 Documentation Excellence

**Markdown cell structure**:
```markdown
## N. Section Title

**Purpose**: One-sentence description of what this section does

**Method**: Brief methodological note if applicable

**Interpretation**: Concise findings (2-4 sentences maximum)
```

**Code cell documentation**:
```python
# Clear section header comment
# Describe WHAT this code does (not HOW - code shows that)

# Step 1: Load data
df = pd.read_csv('file.csv')

# Step 2: Process
result = process_function(df)

# Step 3: Visualize
plot_function(result)

print(f"✓ Analysis complete: {len(result)} items processed")
```

### 5.3 Visualization Standards

**APA-style publication requirements**:
```python
# Set at notebook top
plt.rcParams['figure.dpi'] = 300
plt.rcParams['savefig.dpi'] = 300
plt.rcParams['font.family'] = 'DejaVu Sans'
plt.rcParams['font.size'] = 10

# For each figure
fig, ax = plt.subplots(figsize=(12, 6))
ax.set_xlabel('Variable', fontsize=11, fontweight='bold')
ax.set_ylabel('Frequency', fontsize=11, fontweight='bold')
ax.set_title('Descriptive Title', fontsize=12, fontweight='bold', pad=15)

# Save with consistent naming
plt.savefig(f'../results/plots/{notebook_num}_descriptive_name.png',
            bbox_inches='tight', dpi=300)
plt.show()

print(f"✓ Figure {fig_num} saved: descriptive_name.png")
```

---

## 6. Common Pitfalls & Solutions

### 6.1 Scope Creep

**Problem**: Starting to refactor without clear stopping point
**Solution**: Define "done" criteria in todo list before starting

### 6.2 Breaking Working Code

**Problem**: Aggressive refactoring introduces bugs
**Solution**: Test after each major change; keep original notebook backup

### 6.3 Over-Generalization

**Problem**: Removing so much context notebook becomes unclear
**Solution**: Keep methodological guidance; remove only study-specific results

### 6.4 Incomplete Testing

**Problem**: Not running full notebook after changes
**Solution**: ALWAYS restart kernel and run all cells before committing

---

## 7. Workflow Integration

### 7.1 Git Workflow

```bash
# Before starting
git checkout -b notebook-cleanup-08
git add airs/08_Qualitative_Feedback_Analysis.ipynb
git commit -m "checkpoint: Before refactoring Notebook 08"

# After each major change
git add airs/08_Qualitative_Feedback_Analysis.ipynb
git commit -m "refactor: Remove hardcoded values from Notebook 08"

# After completion
git checkout main
git merge notebook-cleanup-08
git push
```

### 7.2 Session Management

**For large refactoring projects**:
1. Session 1: Assessment and planning (todo list creation)
2. Session 2: Critical fixes and data flow validation
3. Session 3: Code refactoring (DRY/KISS)
4. Session 4: Documentation cleanup
5. Session 5: Validation and testing

**Progress tracking**: Update todo list after each session

---

## Embedded Synapse Network

- [DK-DOCUMENTATION-EXCELLENCE-v1.1.0.md] (0.95, applies-to, bidirectional) - "Documentation principles apply to computational notebooks"
- [DK-JUPYTER-PSYCHOMETRIC-WORKFLOWS-v1.0.0.md] (0.92, shares-patterns, analogical) - "Psychometric workflow notebooks benefit from refactoring methodology"
- [meditation-session-2025-11-27-efa-cherry-pick-workflow.prompt.md] (0.91, extends, forward) - "Decision point architecture extends refactoring with researcher judgment pauses"
- [alex-core.instructions.md] (0.89, utilizes, forward) - "Meta-cognitive analysis applied to notebook quality assessment"
- [bootstrap-learning.instructions.md] (0.87, consolidates, forward) - "Notebook refactoring domain learned through systematic analysis"
- [DK-PYTHON-STATISTICAL-ANALYSIS-v1.0.0.md] (0.85, enhances, bidirectional) - "Statistical analysis code quality improved through refactoring"

---

**Domain mastery achieved**: Systematic notebook refactoring methodology
**Application context**: AIRS qualitative analysis cleanup (Notebook 08, 3077 lines)
**Key insight**: Large-scale refactoring requires strategic planning before execution
**Reusability**: Template applicable to any computational notebook cleanup project
**Extension**: Decision point architecture pattern for researcher-guided analysis workflows (Nov 27, 2025)
