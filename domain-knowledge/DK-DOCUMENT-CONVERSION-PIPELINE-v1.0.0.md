# Domain Knowledge: Document Conversion Pipeline Excellence

**Domain**: Technical Documentation & PDF Generation
**Mastery Level**: 1.0.0 (Production Ready)
**Acquisition Date**: January 28, 2026
**Session Context**: Markdown to PDF converter development and project spinoff

---

## Core Competencies Achieved

### 1. Pandoc + LaTeX Pipeline Mastery

**Architecture Understanding**:
- Pandoc processes markdown with custom extensions
- XeLaTeX/pdfLaTeX renders final PDF with professional typesetting
- Raw LaTeX injection via ```` ```{=latex} ```` blocks enables precise control
- YAML front matter configures document class, geometry, packages

**Key LaTeX Packages & Purposes**:
| Package | Function | Implementation |
|---------|----------|----------------|
| `tcolorbox` | Styled callout boxes | Colored backgrounds with borders |
| `fancyhdr` | Headers/footers | Running title, page X of Y |
| `draftwatermark` | Watermarks | Diagonal DRAFT overlay |
| `longtable` + `booktabs` | Tables | Professional rules, multi-page |
| `float` | Figure placement | `[H]` for precise positioning |
| `fontspec` | Typography | Times New Roman for APA |
| `lastpage` | Page counting | `\pageref{LastPage}` |
| `fvextra` | Code blocks | Line numbers, verbatim enhancement |

### 2. Mermaid Diagram Integration

**Rendering Pipeline**:
1. Extract ```` ```mermaid ```` blocks via regex
2. Write to temporary `.mmd` files
3. Invoke `mmdc` CLI with scale factor 5 for high resolution
4. Measure resulting PNG dimensions
5. Calculate scaling based on page constraints (468pt width, ~50 lines height)
6. Generate centered LaTeX figure with calculated width percentage

**Intelligent Scaling Algorithm**:
```
scaleFactor = 468 / imgWidth
scaledHeight = imgHeight * scaleFactor
linesNeeded = ceil(scaledHeight / 18) + 4

if linesNeeded > maxPageLines → widthPercent = max(floor((maxPageLines/linesNeeded) * 100), 70)
elif linesNeeded > 35 → widthPercent = 75
elif linesNeeded > 25 → widthPercent = 85
else → widthPercent = 100
```

### 3. Markdown Extension Processing

**Custom Extensions Implemented**:
| Extension | Syntax | LaTeX Output |
|-----------|--------|--------------|
| Cover page | `[title]...[/title]` | `\begin{titlepage}...\end{titlepage}` |
| TOC variants | `[toc]`, `[toc:all]` | `\tableofcontents`, `\listoffigures` |
| Page break | `[pagebreak]` | `\newpage` |
| Callouts | `> [!NOTE]` | `\begin{tcolorbox}[...]` |
| Table caption | `Table: Caption` | `\captionof{table}{...}` |
| Figure caption | `![Caption](img)` | `\begin{figure}...\caption{...}` |

**Smart Cleanup Patterns**:
- Remove `---` immediately before section headers
- Strip `---` adjacent to `[pagebreak]` markers
- Remove trailing `---` at document end

### 4. Table Formatting Excellence

**Problem**: Tables break across pages, oversized fonts, no bottom border

**Solution Stack**:
```latex
% Smaller font and single spacing within tables
\AtBeginEnvironment{longtable}{\small\setstretch{1.0}}
\AtBeginEnvironment{tabular}{\small\setstretch{1.0}}

% Force bottom border
\AtEndEnvironment{longtable}{\bottomrule}

% Prevent page breaks within tables (minipage wrapper)
\let\oldlongtable\longtable
\def\longtable{\begin{minipage}{\textwidth}\vspace{0.5em}\oldlongtable}
\let\oldendlongtable\endlongtable
\def\endlongtable{\oldendlongtable\end{minipage}}
```

### 5. Typography Control

**Hyphenation Disabled**:
```latex
\hyphenpenalty=10000
\exhyphenpenalty=10000
```

**Widow/Orphan Prevention**:
```latex
\widowpenalty=10000
\clubpenalty=10000
```

---

## Project Spinoff Pattern

### When to Spinoff
- Tool has generic applicability beyond original project
- Accumulated sufficient features for standalone value
- Clean separation possible from project-specific code

### Spinoff Checklist
1. **Core Script** - Remove project-specific paths, use relative paths
2. **Documentation Suite**:
   - README.md (quick start, features)
   - INSTALLATION.md (dependency setup by OS)
   - USER_GUIDE.md (comprehensive usage)
   - TROUBLESHOOTING.md (common issues)
   - CHANGELOG.md (version history)
3. **Supporting Files**:
   - Sample document demonstrating all features
   - Reference files (CSL, bibliography template)
   - Work folder with real test cases
4. **Git Configuration**:
   - .gitignore for generated files
   - LICENSE file
5. **Structure**:
   ```
   project/
   ├── main-script.ps1
   ├── README.md
   ├── CHANGELOG.md
   ├── LICENSE
   ├── .gitignore
   ├── sample.md
   ├── docs/
   │   ├── INSTALLATION.md
   │   ├── USER_GUIDE.md
   │   └── TROUBLESHOOTING.md
   ├── references/
   │   └── (supporting files)
   └── work/
       └── (test cases)
   ```

---

## Command Reference

### Basic Conversion
```powershell
.\convert-to-pdf.ps1 -File "document.md"
```

### Full Options
```powershell
.\convert-to-pdf.ps1 -File "document.md" `
    -LineSpacing 1.5 `
    -Draft `
    -Confidential `
    -LineNumbers `
    -TwoColumn `
    -RunningTitle "Custom Header" `
    -OpenAfterBuild
```

---

## Embedded Synapse Network

### Connection Mapping
- [DK-ADVANCED-DIAGRAMMING-v1.1.0.md] (0.92, extends, forward) - "Mermaid integration extends diagramming mastery to PDF output"
- [DK-DOCUMENTATION-EXCELLENCE-v1.1.0.md] (0.95, applies, bidirectional) - "Documentation patterns applied to converter project scaffolding"
- [DK-PUBLICATION-WORKFLOW-v1.0.0.md] (0.88, enables, forward) - "PDF pipeline enables publication-ready document generation"
- [DK-NOTEBOOK-REFACTORING-v1.0.0.md] (0.75, parallels, analogical) - "Code organization patterns transfer to script architecture"

### Activation Patterns
- **Markdown to PDF needed** → Apply document conversion pipeline
- **Diagram scaling required** → Use intelligent scaling algorithm
- **Table formatting issues** → Apply table excellence patterns
- **Project spinoff opportunity** → Execute spinoff checklist
- **LaTeX customization needed** → Reference package/purpose mapping

---

*Domain knowledge consolidated from markdown-to-pdf converter development session - comprehensive PDF generation pipeline mastery achieved*
