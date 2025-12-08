# PDF Generation Tools

This project includes two PowerShell scripts for generating PDF documents from Markdown source files.

## Scripts Overview

| Script | Location | Purpose |
|--------|----------|---------|
| `build-thesis.ps1` | `thesis/` | Build complete dissertation PDF with all chapters |
| `convert-to-pdf.ps1` | `thesis/` | Convert standalone documents to individual PDFs |

## Requirements

- **Pandoc** - Document converter ([pandoc.org](https://pandoc.org/installing.html))
- **XeLaTeX** - PDF engine (via MiKTeX or TeX Live)
- **Mermaid CLI** - Diagram rendering (`npm install -g @mermaid-js/mermaid-cli`)

## build-thesis.ps1

Builds the complete dissertation PDF by combining all chapters, processing Mermaid diagrams, and applying academic formatting.

### Usage

```powershell
cd thesis
.\build-thesis.ps1
```

### Features

- Combines all chapter files in sequence
- Processes Mermaid diagrams to high-resolution PNG
- Applies APA 7th edition citation style
- Generates table of contents, list of tables, and list of figures
- Outputs to `DRAFT XX.pdf`

### Output

```
thesis/
└── DRAFT 05.pdf    # Complete dissertation (~100 pages)
```

## convert-to-pdf.ps1

Converts standalone Markdown documents to PDF with APA 7 formatting.

### Usage

```powershell
cd thesis

# Convert all standalone documents
.\convert-to-pdf.ps1

# Convert specific file
.\convert-to-pdf.ps1 -File "THESIS_SUMMARY.md"

# Convert with custom line spacing
.\convert-to-pdf.ps1 -File "MyDocument.md" -LineSpacing 2.0
```

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `-File` | string | (none) | Specific file to convert; if omitted, converts all standalone docs |
| `-LineSpacing` | double | 1.5 | Line spacing multiplier |

### Standalone Documents

By default, converts these files:

| Document | Purpose | Output |
|----------|---------|--------|
| `EXECUTIVE_SUMMARY.md` | Academic executive summary | `EXECUTIVE_SUMMARY.pdf` |
| `PRACTITIONER_BRIEF.md` | Practitioner-oriented summary | `PRACTITIONER_BRIEF.pdf` |
| `THESIS_SUMMARY.md` | 5-page dissertation summary | `THESIS_SUMMARY.pdf` |

### Formatting

- **Font**: Times New Roman, 12pt
- **Margins**: 1 inch all sides
- **Line Spacing**: 1.5 (body text), 1.0 (tables)
- **Citations**: APA 7th edition (if bibliography referenced)

## Adding New Documents

To add a new standalone document to the conversion pipeline:

1. Create the Markdown file in `thesis/`
2. Edit `convert-to-pdf.ps1` and add to the `$StandaloneFiles` array:

```powershell
$StandaloneFiles = @(
    "EXECUTIVE_SUMMARY.md"
    "PRACTITIONER_BRIEF.md"
    "THESIS_SUMMARY.md"
    "YOUR_NEW_DOCUMENT.md"  # Add here
)
```

3. Run `.\convert-to-pdf.ps1`

## Troubleshooting

### "Pandoc not found"

Install Pandoc from [pandoc.org](https://pandoc.org/installing.html) and ensure it's in your PATH.

### "XeLaTeX not found"

Install MiKTeX (Windows) or TeX Live (Linux/Mac):
- Windows: [miktex.org](https://miktex.org/download)
- Mac: `brew install --cask mactex`
- Linux: `sudo apt install texlive-xetex`

### "Times New Roman not found"

Ensure the font is installed on your system. On Linux, install:
```bash
sudo apt install ttf-mscorefonts-installer
```

### MiKTeX Update Warnings

The warnings about MiKTeX updates are informational and don't affect PDF generation. To suppress:
```powershell
miktex-console --admin --update
```

## File Structure

```
thesis/
├── build-thesis.ps1        # Main thesis builder
├── convert-to-pdf.ps1      # Standalone document converter
├── standalone-header.tex   # LaTeX header for table formatting
├── references/
│   ├── bibliography.bib    # BibTeX references
│   └── apa-7th-edition.csl # Citation style
├── EXECUTIVE_SUMMARY.md    # Source
├── EXECUTIVE_SUMMARY.pdf   # Output
├── PRACTITIONER_BRIEF.md   # Source
├── PRACTITIONER_BRIEF.pdf  # Output
├── THESIS_SUMMARY.md       # Source
├── THESIS_SUMMARY.pdf      # Output
└── DRAFT 05.pdf            # Complete thesis
```

## Quick Reference

```powershell
# Build complete thesis
cd thesis
.\build-thesis.ps1

# Convert all standalone documents
.\convert-to-pdf.ps1

# Convert single file
.\convert-to-pdf.ps1 -File "THESIS_SUMMARY.md"
```
