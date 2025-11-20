# Contributing to AIRS Data Analysis Project

Thank you for your interest in the AIRS (Artificial Intelligence Readiness Score) Data Analysis project! This document provides guidelines for contributing to this academic research repository.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Project Overview](#project-overview)
- [Getting Started](#getting-started)
- [Contributing Guidelines](#contributing-guidelines)
- [Development Workflow](#development-workflow)
- [Data Privacy](#data-privacy)
- [Code Standards](#code-standards)
- [Documentation](#documentation)
- [Academic Integrity](#academic-integrity)
- [Contact](#contact)

---

## Code of Conduct

This project adheres to academic integrity standards and the Contributor Covenant Code of Conduct. By participating, you are expected to:

- Respect academic research ethics
- Maintain data privacy and confidentiality
- Provide proper attribution for contributions
- Follow reproducible research practices

Please report unacceptable behavior via GitHub issues or contact the repository owner.

---

## Project Overview

This repository contains a **doctoral research project** examining AI adoption readiness through psychometric validation and structural equation modeling. The study:

- Validates the AIRS survey instrument (28 items, 13 constructs)
- Extends UTAUT2 framework with AI-specific constructs
- Analyzes N=201 survey responses
- Compares competing theoretical models

**Status**: Analysis complete, dissertation in progress

---

## Getting Started

### Prerequisites

#### Required
- **Python 3.12+**: Primary analysis environment
- **Git**: Version control
- **Jupyter Notebook**: Interactive analysis

#### Recommended
- **VS Code**: Editor with Python and Jupyter extensions
- **R 4.0+**: Optional for R-based analyses
- **RStudio**: Optional IDE for R markdown

### Installation

```bash
# Clone repository
git clone https://github.com/fabioc-aloha/AIRS_Data_Analysis.git
cd AIRS_Data_Analysis

# Create virtual environment
python -m venv venv
.\venv\Scripts\Activate.ps1  # Windows PowerShell
source venv/bin/activate      # macOS/Linux

# Install dependencies
pip install -r requirements.txt

# Launch Jupyter
jupyter notebook AIRS_Analysis_Python.ipynb
```

---

## Contributing Guidelines

### Types of Contributions Welcome

#### 1. **Bug Reports**
- Errors in analysis code
- Documentation typos
- Broken links or references
- Statistical calculation issues

#### 2. **Enhancement Suggestions**
- Alternative statistical approaches
- Additional validation analyses
- Visualization improvements
- Documentation clarity

#### 3. **Code Improvements**
- Performance optimization
- Code refactoring for clarity
- Additional comments/documentation
- Reproducibility enhancements

#### 4. **Academic Collaboration**
- Theoretical insights
- Methodological recommendations
- Literature suggestions
- Replication studies

### What NOT to Contribute

❌ **Do NOT submit**:
- Raw survey data (privacy violation)
- Personally identifiable information
- Unauthorized dataset modifications
- Plagiarized content

---

## Development Workflow

### 1. Fork and Branch

```bash
# Fork repository via GitHub UI
git clone https://github.com/YOUR-USERNAME/AIRS_Data_Analysis.git
cd AIRS_Data_Analysis

# Create feature branch
git checkout -b feature/your-feature-name
```

### 2. Make Changes

- Keep changes focused and atomic
- Follow existing code style
- Update documentation as needed
- Add comments explaining complex logic

### 3. Test Thoroughly

```bash
# Test notebook execution
jupyter nbconvert --to notebook --execute AIRS_Analysis_Python.ipynb

# Verify outputs
python -c "import pandas as pd; df = pd.read_csv('data/AIRS_clean.csv'); print(df.shape)"
```

### 4. Commit with Clear Messages

```bash
git add .
git commit -m "feat: Add bootstrap confidence intervals for path coefficients"

# Use conventional commit prefixes:
# feat: New feature
# fix: Bug fix
# docs: Documentation changes
# refactor: Code restructuring
# test: Adding tests
# chore: Maintenance tasks
```

### 5. Submit Pull Request

- Provide clear description of changes
- Reference any related issues
- Explain rationale for modifications
- Include before/after comparisons if applicable

---

## Data Privacy

### CRITICAL: Data Protection

This project handles survey data with privacy considerations:

✅ **DO**:
- Keep data files in `data/` directory (git-ignored)
- Use aggregate statistics in commits
- Anonymize any shared examples
- Follow IRB/ethics protocols

❌ **DO NOT**:
- Commit raw data files to git
- Share personally identifiable information
- Post screenshots with sensitive data
- Distribute data without authorization

### Data Access

Researchers requesting data access must:
1. Contact repository owner via GitHub issue
2. Demonstrate legitimate research purpose
3. Agree to data use terms
4. Acknowledge source in publications

---

## Code Standards

### Python Style Guide

Follow **PEP 8** conventions:

```python
# Good: Clear variable names, proper spacing
efa_loadings = pd.DataFrame(efa.loadings_)
kmo_all, kmo_model = calculate_kmo(df_numeric)

# Bad: Unclear names, poor spacing
x=pd.DataFrame(y.loadings_)
a,b=calculate_kmo(df_numeric)
```

### Jupyter Notebook Guidelines

**Cell Organization**:
1. Markdown cells for section headers
2. Explanatory text before code blocks
3. Code cells with clear purpose
4. Output cells preserved for reproducibility
5. Clear cell execution order

**Best Practices**:
- Restart kernel and run all cells before committing
- Clear unnecessary outputs (except key results)
- Include academic citations in markdown
- Document statistical thresholds with sources

### R Code Style (if applicable)

Follow **tidyverse style guide**:

```r
# Good: Readable pipe chains
airs_data %>%
  filter(complete.cases(.)) %>%
  select(PE1:BI4) %>%
  psych::alpha()

# Bad: Nested functions
psych::alpha(select(filter(airs_data, complete.cases(.)), PE1:BI4))
```

---

## Documentation

### Required Documentation Updates

When modifying analysis:

1. **Update README.md** if:
   - Changing methodology
   - Adding/removing constructs
   - Modifying sample characteristics
   - Updating key findings

2. **Update DATA_DICTIONARY.md** if:
   - Adding/removing variables
   - Changing scales
   - Modifying construct definitions
   - Updating measurement notes

3. **Update Notebook Markdown** if:
   - Changing analysis steps
   - Adding new statistical tests
   - Modifying interpretations
   - Updating references

### Citation Requirements

All statistical methods must cite authoritative sources:

```markdown
**CFI/TLI/RMSEA Thresholds** (Hu & Bentler, 1999):
- CFI ≥ 0.90 indicates acceptable fit
- TLI ≥ 0.90 indicates acceptable fit
- RMSEA ≤ 0.08 indicates acceptable fit
```

### Reference Format

Use APA 7th edition:

```
Venkatesh, V., Thong, J. Y. L., & Xu, X. (2012). Consumer acceptance and use
of information technology: Extending the unified theory of acceptance and use
of technology. *MIS Quarterly, 36*(1), 157-178. https://doi.org/10.2307/41410412
```

---

## Academic Integrity

### Attribution Requirements

Contributors must:

✅ **Provide proper attribution** for:
- Code adapted from other sources
- Statistical methods from literature
- Theoretical frameworks
- Dataset information

✅ **Acknowledge contributions** in:
- Commit messages
- Code comments
- Documentation updates
- Pull request descriptions

### Prohibited Practices

❌ **Academic misconduct**:
- Plagiarism of code or text
- Fabrication of results
- Falsification of data
- Unauthorized data sharing
- Unattributed contributions

### Collaboration Ethics

When collaborating:
- Discuss contribution scope upfront
- Document individual contributions
- Agree on authorship criteria
- Follow academic integrity standards

---

## Pull Request Process

### Before Submitting

- [ ] Code runs without errors
- [ ] Notebook executes cell-by-cell
- [ ] Documentation updated
- [ ] Commit messages are clear
- [ ] No sensitive data included
- [ ] Citations added where needed

### PR Description Template

```markdown
## Description
Brief summary of changes

## Motivation
Why is this change needed?

## Changes Made
- Change 1
- Change 2
- Change 3

## Testing
How were changes validated?

## Documentation
What documentation was updated?

## Related Issues
Fixes #123
```

### Review Process

1. **Automated checks**: Code style, notebook execution
2. **Maintainer review**: Statistical validity, methodology
3. **Revisions**: Address feedback
4. **Approval**: Merge when ready

---

## Testing and Validation

### Statistical Validation

Before submitting analysis changes:

```python
# Verify measurement model fit
assert cfa_results['CFI'] >= 0.90, "CFI below threshold"
assert cfa_results['RMSEA'] <= 0.08, "RMSEA above threshold"

# Check reliability
for construct, alpha in reliability_dict.items():
    assert alpha >= 0.70, f"{construct} alpha below threshold"
```

### Reproducibility Check

```bash
# Full analysis pipeline
jupyter nbconvert --to notebook --execute AIRS_Analysis_Python.ipynb --output test_output.ipynb

# Compare key results
python scripts/validate_results.py
```

---

## Questions?

### Getting Help

- **General questions**: Open a GitHub issue with `question` label
- **Bug reports**: Open issue with `bug` label
- **Feature requests**: Open issue with `enhancement` label
- **Academic collaboration**: Contact repository owner directly

### Response Time

- Issues: Within 1-2 business days
- Pull requests: Within 1 week
- Complex questions: May require additional time

---

## Contact

**Repository Owner**: fabioc-aloha
**Project**: AIRS Data Analysis
**Institution**: [Academic institution if applicable]
**GitHub**: https://github.com/fabioc-aloha/AIRS_Data_Analysis

---

## Acknowledgments

Contributors will be acknowledged in:
- Repository README
- Dissertation acknowledgments section (for substantial contributions)
- Academic publications (per journal guidelines)

Thank you for contributing to reproducible, ethical academic research! 🎓

---

**Last Updated**: November 2025
**Version**: 1.0
