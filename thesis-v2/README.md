<!-- markdownlint-disable MD033 MD041 -->
<div align="center">

# 📄 AIRS Thesis v2

**APA 7th Edition Compliant Build System**

[![Pandoc](https://img.shields.io/badge/Pandoc-2.19+-1e3a8a?style=flat-square&logo=markdown&logoColor=white)](https://pandoc.org/)
[![XeLaTeX](https://img.shields.io/badge/XeLaTeX-MiKTeX-3b82f6?style=flat-square&logo=latex&logoColor=white)](https://miktex.org/)
[![Mermaid](https://img.shields.io/badge/Mermaid-CLI-06b6d4?style=flat-square&logo=mermaid&logoColor=white)](https://mermaid.js.org/)
[![APA 7](https://img.shields.io/badge/Style-APA%207th-f59e0b?style=flat-square)](https://apastyle.apa.org/)

*Modern Pandoc/XeLaTeX build system for the AI Readiness Scale dissertation*

</div>
<!-- markdownlint-enable MD033 MD041 -->

---

## ✨ Features

| Feature | Description |
|:--------|:------------|
| 📑 **APA 7 Formatting** | Running headers, figure/table captions, double spacing, 1" margins |
| 📖 **Smart Pagination** | Section breaks, widow/orphan control, list grouping |
| 📊 **Mermaid Diagrams** | Auto-extraction and rendering from markdown code blocks |
| 📝 **Modular Front Matter** | Separate files for title, approval, abstract, etc. |
| 🔢 **Page Numbering** | Roman numerals (front matter) → Arabic (chapters) |
| 👁️ **Watch Mode** | Auto-rebuild on file changes |

---

## 📁 Structure

```
thesis-v2/
├── manuscript/
│   ├── front-matter/        # 00_title.md through 06_toc_setup.md
│   ├── chapters/            # 01-06 chapter files
│   └── back-matter/         # references.md, appendices.md
├── figures/                 # PNG figures from notebooks
├── references/
│   ├── bibliography.bib     # 93 BibTeX references
│   └── apa-7th-edition.csl  # Citation style
├── output/                  # Generated PDF + rendered diagrams
├── meta.yaml                # Thesis metadata
└── build.ps1                # PowerShell build script
```

---

## 🚀 Quick Start

### Prerequisites

| Tool | Version | Install |
|:-----|:--------|:--------|
| Pandoc | 2.19+ | [pandoc.org](https://pandoc.org/installing.html) |
| XeLaTeX | Latest | [MiKTeX](https://miktex.org/) or [TeX Live](https://www.tug.org/texlive/) |
| Mermaid CLI | Latest | `npm install -g @mermaid-js/mermaid-cli` |

### Build Commands

```powershell
.\build.ps1                    # Build thesis PDF
.\build.ps1 -Open              # Build and open PDF
.\build.ps1 -Target draft      # Draft with watermark
.\build.ps1 -Target watch      # Auto-rebuild on changes
.\build.ps1 -Target validate   # Check sources
.\build.ps1 -Target clean      # Remove output
```

---

## 📋 APA 7 Compliance

| Element | Implementation |
|:--------|:---------------|
| **Running header** | Short title (left), page number (right) |
| **Figure captions** | **Figure X.** *Title in italics* (below) |
| **Table captions** | **Table X.** *Title in italics* (above) |
| **Font** | Times New Roman, 12pt |
| **Spacing** | Double (single in abstract and tables) |
| **Margins** | 1 inch all sides |
| **Page numbers** | Roman (i hidden, ii-vi shown, vii+ TOC), Arabic (1+ body) |

---

## 📤 Output

| File | Description |
|:-----|:------------|
| `output/AIRS_Dissertation.pdf` | ~170 pages, 2.2 MB |
| `output/mermaid/*.png` | 6 rendered diagrams |

---

<div align="center">

**v2.1** · February 21, 2026

</div>
