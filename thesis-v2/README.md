# AIRS Thesis v2 - Modern Build System

A clean, modular thesis build system for the AI Readiness Scale dissertation.

## Structure

```
thesis-v2/
├── manuscript/              # Source content
│   ├── front-matter/        # Title page, abstract
│   ├── chapters/            # 01-06 chapter files
│   └── back-matter/         # References, appendices
├── assets/                  # Visual resources
│   ├── figures/             # PNG figures, Mermaid sources
│   └── tables/              # Markdown tables
├── templates/               # LaTeX templates
│   └── apa7-thesis.tex      # APA 7th dissertation template
├── references/              # Bibliography
│   ├── bibliography.bib     # BibTeX references
│   └── apa-7th-edition.csl  # Citation style
├── output/                  # Generated files (gitignored)
├── meta.yaml                # Thesis metadata configuration
├── build.ps1                # Windows build script
├── Makefile                 # Unix/macOS build
└── README.md                # This file
```

## Quick Start

### Prerequisites

- **Pandoc** 2.19+ ([install](https://pandoc.org/installing.html))
- **XeLaTeX** (via [TeX Live](https://www.tug.org/texlive/) or [MiKTeX](https://miktex.org/))
- **Mermaid CLI** (optional, for diagrams): `npm install -g @mermaid-js/mermaid-cli`

### Build

**Windows (PowerShell):**
```powershell
.\build.ps1              # Build thesis PDF
.\build.ps1 -Open        # Build and open
.\build.ps1 -Target draft -Open  # Draft with watermark
.\build.ps1 -Target validate     # Check sources
.\build.ps1 -Target clean        # Remove output
```

**Unix/macOS:**
```bash
make                    # Build thesis PDF
make draft              # Draft with watermark
make validate           # Check sources
make clean              # Remove output
make help               # Show all targets
```

## Configuration

Edit `meta.yaml` to update:
- Title, author, institution
- Committee members
- Dates
- Output filename
- Formatting options

## Key Improvements over v1

| Aspect | v1 | v2 |
|--------|----|----|
| Script size | 597 lines | ~200 lines |
| Configuration | Hardcoded in script | External `meta.yaml` |
| Template | Embedded in script | Separate `.tex` file |
| Cross-platform | Windows only | Windows + Unix |
| Modularity | Monolithic | Separate functions |
| Build targets | Single | Multiple (all, draft, figures, validate, clean) |

## Output

Generated PDF is saved to `output/AIRS_Dissertation.pdf`.

## Customization

### Adding chapters
1. Create `.md` file in `manuscript/chapters/`
2. Add filename to `meta.yaml` under `chapters:`
3. Rebuild

### Modifying template
Edit `templates/apa7-thesis.tex` for LaTeX customization.

### Adding figures
Place in `assets/figures/`. For Mermaid diagrams, create `.mmd` files and run `build.ps1 -Target figures`.

---

**Version**: 2.0  
**Last Updated**: February 2026
