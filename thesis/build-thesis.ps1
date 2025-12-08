<#
.SYNOPSIS
    Builds the AIRS thesis PDF from markdown chapters.

.DESCRIPTION
    This script combines the title page, abstract, and all chapter markdown files
    into a single document and converts it to a properly formatted APA-style PDF.

.PARAMETER OutputName
    The name of the output PDF file (without extension). Default: "DRAFT 00"

.PARAMETER OpenAfterBuild
    If specified, opens the PDF after successful generation.

.EXAMPLE
    .\build-thesis.ps1
    Builds "DRAFT 00.pdf" in the thesis directory.

.EXAMPLE
    .\build-thesis.ps1 -OutputName "DRAFT 01" -OpenAfterBuild
    Builds "DRAFT 01.pdf" and opens it.
#>

param(
    [string]$OutputName = "DRAFT 00",
    [switch]$OpenAfterBuild
)

# Configuration
$ThesisDir = $PSScriptRoot
$ChaptersDir = Join-Path $ThesisDir "chapters"
$ReferencesDir = Join-Path $ThesisDir "references"
$FiguresDir = Join-Path $ThesisDir "figures"
$OutputPdf = Join-Path $ThesisDir "$OutputName.pdf"
$TempMarkdown = Join-Path $ThesisDir "_combined_thesis.md"
$TitleAbstractFile = Join-Path $ThesisDir "00_title_abstract.md"
$BibFile = Join-Path $ReferencesDir "bibliography.bib"
$CslFile = Join-Path $ReferencesDir "apa-7th-edition.csl"

# Chapter files in order
$ChapterFiles = @(
    "01_introduction.md",
    "02_literature_review.md",
    "03_methodology.md",
    "04_results.md",
    "05_discussion.md"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  AIRS Thesis PDF Builder" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check for pandoc
Write-Host "[1/6] Checking dependencies..." -ForegroundColor Yellow
$pandocPath = Get-Command pandoc -ErrorAction SilentlyContinue
if (-not $pandocPath) {
    Write-Error "Pandoc is not installed or not in PATH. Please install pandoc."
    exit 1
}
Write-Host "  - Pandoc found: $($pandocPath.Source)" -ForegroundColor Green

# Check for xelatex
$xelatexPath = Get-Command xelatex -ErrorAction SilentlyContinue
if (-not $xelatexPath) {
    Write-Warning "XeLaTeX not found. Attempting to use pdflatex instead."
    $pdfEngine = "pdflatex"
} else {
    Write-Host "  - XeLaTeX found: $($xelatexPath.Source)" -ForegroundColor Green
    $pdfEngine = "xelatex"
}

# Check for mermaid-cli (optional)
$mmdcPath = Get-Command mmdc -ErrorAction SilentlyContinue
if ($mmdcPath) {
    Write-Host "  - Mermaid CLI found: $($mmdcPath.Source)" -ForegroundColor Green
    $hasMermaid = $true
} else {
    Write-Host "  - Mermaid CLI not found (diagrams will be skipped)" -ForegroundColor DarkYellow
    $hasMermaid = $false
}

# Check for bibliography file
if (Test-Path $BibFile) {
    Write-Host "  - Bibliography found: $BibFile" -ForegroundColor Green
    $hasBibliography = $true
} else {
    Write-Host "  - Bibliography not found (references will not be rendered)" -ForegroundColor DarkYellow
    $hasBibliography = $false
}

# Download APA 7th CSL if needed
if ($hasBibliography -and -not (Test-Path $CslFile)) {
    Write-Host "  - Downloading APA 7th Edition CSL..." -ForegroundColor Gray
    try {
        $cslUrl = "https://raw.githubusercontent.com/citation-style-language/styles/master/apa.csl"
        Invoke-WebRequest -Uri $cslUrl -OutFile $CslFile -UseBasicParsing
        Write-Host "  - APA CSL downloaded: $CslFile" -ForegroundColor Green
    } catch {
        Write-Warning "Failed to download APA CSL. References may not be formatted correctly."
        $hasBibliography = $false
    }
} elseif ($hasBibliography) {
    Write-Host "  - APA CSL found: $CslFile" -ForegroundColor Green
}

# Process Mermaid diagrams
Write-Host "[2/6] Processing Mermaid diagrams..." -ForegroundColor Yellow

# Create figures directory if needed
if (-not (Test-Path $FiguresDir)) {
    New-Item -ItemType Directory -Path $FiguresDir -Force | Out-Null
}

$diagramCount = 0
if ($hasMermaid) {
    # Find all markdown files and extract mermaid blocks
    $allMdFiles = Get-ChildItem -Path $ChaptersDir -Filter "*.md" -File
    
    foreach ($mdFile in $allMdFiles) {
        $content = Get-Content $mdFile.FullName -Raw -Encoding UTF8
        $chapterName = [System.IO.Path]::GetFileNameWithoutExtension($mdFile.Name)
        
        # Find all mermaid code blocks
        $mermaidPattern = '(?s)```mermaid\r?\n(.+?)```'
        $matches = [regex]::Matches($content, $mermaidPattern)
        
        $figureIndex = 1
        foreach ($match in $matches) {
            $mermaidCode = $match.Groups[1].Value
            $figureFileName = "${chapterName}_fig${figureIndex}"
            $mmdFile = Join-Path $FiguresDir "${figureFileName}.mmd"
            $pngFile = Join-Path $FiguresDir "${figureFileName}.png"
            
            # Write mermaid code to temp file
            [System.IO.File]::WriteAllText($mmdFile, $mermaidCode, [System.Text.UTF8Encoding]::new($false))
            
            # Render to high-resolution PNG (scale 5 = ~4000px width for crisp print quality)
            $mmdcArgs = @("-i", $mmdFile, "-o", $pngFile, "-b", "white", "-s", "5")
            $mmdcOutput = & mmdc @mmdcArgs 2>&1
            
            if (Test-Path $pngFile) {
                Write-Host "  - Generated: ${figureFileName}.png (high-res)" -ForegroundColor Gray
                $diagramCount++
            } else {
                Write-Warning "Failed to generate: ${figureFileName}.png"
            }
            
            # Clean up temp mmd file
            Remove-Item $mmdFile -Force -ErrorAction SilentlyContinue
            
            $figureIndex++
        }
    }
    
    if ($diagramCount -eq 0) {
        Write-Host "  - No Mermaid diagrams found" -ForegroundColor Gray
    } else {
        Write-Host "  - Generated $diagramCount diagram(s)" -ForegroundColor Green
    }
} else {
    Write-Host "  - Skipping (mmdc not installed)" -ForegroundColor Gray
}

# Build YAML front matter
Write-Host "[3/6] Building front matter..." -ForegroundColor Yellow

# Read and parse 00_title_abstract.md
if (-not (Test-Path $TitleAbstractFile)) {
    Write-Error "Title/abstract file not found: $TitleAbstractFile"
    exit 1
}

$titleAbstractContent = Get-Content $TitleAbstractFile -Raw -Encoding UTF8

# Parse YAML front matter from the file (initialize empty - must come from source)
$Metadata = @{
    Title = $null
    Author = $null
    Institution = $null
    Program = $null
    Chair = $null
    CommitteeMember1 = $null
    CommitteeMember2 = $null
    Date = $null
    RunningHeader = $null
}

if ($titleAbstractContent -match '(?s)^---(.+?)---') {
    $yamlBlock = $Matches[1]
    if ($yamlBlock -match 'title:\s*"?([^"\n]+)"?') { $Metadata.Title = $Matches[1].Trim() }
    if ($yamlBlock -match 'author:\s*"?([^"\n]+)"?') { $Metadata.Author = $Matches[1].Trim() }
    if ($yamlBlock -match 'institution:\s*"?([^"\n]+)"?') { $Metadata.Institution = $Matches[1].Trim() }
    if ($yamlBlock -match 'program:\s*"?([^"\n]+)"?') { $Metadata.Program = $Matches[1].Trim() }
    if ($yamlBlock -match 'chair:\s*"?([^"\n]+)"?') { $Metadata.Chair = $Matches[1].Trim() }
    if ($yamlBlock -match 'committee1:\s*"?([^"\n]+)"?') { $Metadata.CommitteeMember1 = $Matches[1].Trim() }
    if ($yamlBlock -match 'committee2:\s*"?([^"\n]+)"?') { $Metadata.CommitteeMember2 = $Matches[1].Trim() }
    if ($yamlBlock -match 'date:\s*"?([^"\n]+)"?') { $Metadata.Date = $Matches[1].Trim() }
    if ($yamlBlock -match 'running-header:\s*"?([^"\n]+)"?') { $Metadata.RunningHeader = $Matches[1].Trim() }
} else {
    Write-Error "No YAML front matter found in $TitleAbstractFile. Required metadata is missing."
    exit 1
}

# Validate required fields
$requiredFields = @('Title', 'Author')
foreach ($field in $requiredFields) {
    if (-not $Metadata.$field) {
        Write-Error "Required field '$field' is missing from $TitleAbstractFile"
        exit 1
    }
}

# Set default running header from title if not specified
if (-not $Metadata.RunningHeader) {
    # Create abbreviated running header from title (first significant words, max ~30 chars)
    $words = $Metadata.Title -split '\s+' | Where-Object { $_ -notin @('a', 'an', 'the', 'for', 'and', 'of', 'in', 'to') }
    $Metadata.RunningHeader = ($words[0..2] -join ' ').ToUpper()
}

# Extract abstract content (everything after YAML and ## Abstract header)
$abstractContent = ""
if ($titleAbstractContent -match '(?s)## Abstract\s*(.+)$') {
    $abstractContent = $Matches[1].Trim()
    # Remove any trailing \newpage commands
    $abstractContent = $abstractContent -replace '\\newpage\s*$', ''
    # Convert markdown bold **text** to LaTeX \textbf{text}
    $abstractContent = $abstractContent -replace '\*\*([^*]+)\*\*', '\textbf{$1}'
    # Note: Unicode characters (Greek letters, etc.) are preserved - XeLaTeX handles them natively
}

Write-Host "  - Title: $($Metadata.Title)" -ForegroundColor Gray
Write-Host "  - Author: $($Metadata.Author)" -ForegroundColor Gray

$YamlFrontMatter = @"
---
documentclass: article
geometry: margin=1in
fontsize: 12pt
linestretch: 2
link-citations: true
nocite: '@*'
header-includes:
  - \usepackage{setspace}
  - \doublespacing
  - \usepackage{fancyhdr}
  - \pagestyle{fancy}
  - \fancyhead[R]{\thepage}
  - \fancyhead[L]{$($Metadata.RunningHeader)}
  - \usepackage{float}
  - \floatplacement{table}{H}
  - \floatplacement{figure}{H}
  - \usepackage{etoolbox}
  - \AtBeginEnvironment{longtable}{\singlespacing}
  - \AtBeginEnvironment{tabular}{\singlespacing}
  - \AtBeginDocument{\thispagestyle{empty}}
  - \usepackage{fontspec}
  - \setmainfont{Times New Roman}
---

\begin{titlepage}
\thispagestyle{empty}
\singlespacing
\centering
\vspace*{1cm}

{\LARGE\bfseries $($Metadata.Title)\par}

\vspace{1.5cm}

A Dissertation Submitted in Partial Fulfillment of the\\
Requirements for the Degree of\\[0.3cm]
{\large Doctor of Business Administration\par}

\vspace{1cm}

{\large $($Metadata.Institution)\par}
{\normalsize $($Metadata.Program)\par}

\vspace{1.5cm}

{\large By\par}
\vspace{0.3cm}
{\Large\bfseries $($Metadata.Author)\par}

\vspace{1.5cm}

{\large Dissertation Committee:\par}
\vspace{0.3cm}
Chair: $($Metadata.Chair)\\
Faculty Member: $($Metadata.CommitteeMember1)\\
Faculty Member: $($Metadata.CommitteeMember2)

\vfill

{\large $($Metadata.Date)\par}
\end{titlepage}

\newpage
\thispagestyle{empty}

\begin{center}
{\Large\bfseries Abstract}
\end{center}

\vspace{1cm}

\doublespacing

$abstractContent

\newpage

\tableofcontents

\newpage

"@

# Combine chapters
Write-Host "[4/6] Combining chapters..." -ForegroundColor Yellow

$CombinedContent = $YamlFrontMatter

foreach ($chapter in $ChapterFiles) {
    $chapterPath = Join-Path $ChaptersDir $chapter
    if (Test-Path $chapterPath) {
        Write-Host "  - Adding: $chapter" -ForegroundColor Gray
        $chapterContent = Get-Content $chapterPath -Raw -Encoding UTF8
        $chapterName = [System.IO.Path]::GetFileNameWithoutExtension($chapter)
        
        # Remove any YAML front matter from individual chapters
        if ($chapterContent -match "^---[\s\S]*?---\s*") {
            $chapterContent = $chapterContent -replace "^---[\s\S]*?---\s*", ""
        }
        
        # Replace mermaid code blocks with image references
        if ($hasMermaid) {
            $mermaidRegex = [regex]::new('(?s)```mermaid\r?\n.+?```')
            $mermaidMatches = $mermaidRegex.Matches($chapterContent)
            # Process matches in reverse order to preserve indices
            for ($i = $mermaidMatches.Count - 1; $i -ge 0; $i--) {
                $match = $mermaidMatches[$i]
                $figureIndex = $i + 1
                $figureFileName = "${chapterName}_fig${figureIndex}"
                $pngPath = "figures/${figureFileName}.png"
                $imgRef = "![]($pngPath)"
                $chapterContent = $chapterContent.Remove($match.Index, $match.Length).Insert($match.Index, $imgRef)
            }
        }
        
        # Trim trailing whitespace
        $chapterContent = $chapterContent.TrimEnd()
        
        # Note: Unicode characters (Greek letters, emojis, etc.) are preserved - XeLaTeX handles them natively
        
        $CombinedContent += $chapterContent + "`n`n\newpage`n`n"
    } else {
        Write-Warning "Chapter not found: $chapterPath"
    }
}

# Add references section
$ReferencesFile = Join-Path $ThesisDir "references.md"
if (Test-Path $ReferencesFile) {
    Write-Host "  - Adding: references.md" -ForegroundColor Gray
    $referencesContent = Get-Content $ReferencesFile -Raw -Encoding UTF8
    # Remove any YAML front matter
    if ($referencesContent -match "^---[\s\S]*?---\s*") {
        $referencesContent = $referencesContent -replace "^---[\s\S]*?---\s*", ""
    }
    $referencesContent = $referencesContent.TrimEnd()
    $CombinedContent += $referencesContent + "`n`n\newpage`n`n"
} else {
    $CombinedContent += @"
# References

*References to be added.*

\newpage

"@
}

# Add appendices section
$AppendicesFile = Join-Path $ThesisDir "appendices.md"
if (Test-Path $AppendicesFile) {
    Write-Host "  - Adding: appendices.md" -ForegroundColor Gray
    $appendicesContent = Get-Content $AppendicesFile -Raw -Encoding UTF8
    # Remove any YAML front matter
    if ($appendicesContent -match "^---[\s\S]*?---\s*") {
        $appendicesContent = $appendicesContent -replace "^---[\s\S]*?---\s*", ""
    }
    $appendicesContent = $appendicesContent.TrimEnd()
    # Note: Unicode characters are preserved - XeLaTeX handles them natively
    $CombinedContent += $appendicesContent
} else {
    $CombinedContent += @"
# Appendices

## Appendix A: AI Readiness Scale (AIRS) Final 16-Item Instrument

*Instrument items to be added.*

## Appendix B: Survey Materials

*Survey materials to be added.*

## Appendix C: Supplementary Statistical Tables

*Supplementary tables to be added.*

"@
}

# Write combined file
[System.IO.File]::WriteAllText($TempMarkdown, $CombinedContent, [System.Text.UTF8Encoding]::new($false))
Write-Host "  - Combined file: $TempMarkdown" -ForegroundColor Green

# Generate PDF
Write-Host "[5/6] Generating PDF with $pdfEngine..." -ForegroundColor Yellow

$pandocArgs = @(
    $TempMarkdown,
    "-o", $OutputPdf,
    "--pdf-engine=$pdfEngine",
    "-f", "markdown+raw_tex"
)

# Add bibliography support if available
if ($hasBibliography) {
    $pandocArgs += @(
        "--citeproc",
        "--bibliography=$BibFile",
        "--csl=$CslFile"
    )
    Write-Host "  - Bibliography enabled with APA 7th style" -ForegroundColor Gray
}

# Add font specification for XeLaTeX (use system fonts)
if ($pdfEngine -eq "xelatex") {
    # Use default Latin Modern fonts instead of Times New Roman to avoid font issues
    # Uncomment the next line if Times New Roman is needed and fonts are properly configured
    # $pandocArgs += @("-V", 'mainfont=Times New Roman')
}

try {
    $output = & pandoc @pandocArgs 2>&1
    
    # Filter out informational warnings
    $errors = $output | Where-Object { $_ -notmatch "major issue" -and $_ -notmatch "Missing character" }
    
    if ($LASTEXITCODE -ne 0 -and $errors) {
        Write-Error "PDF generation failed: $errors"
        exit 1
    }
} catch {
    Write-Error "Failed to run pandoc: $_"
    exit 1
}

# Verify output
if (Test-Path $OutputPdf) {
    $pdfInfo = Get-Item $OutputPdf
    Write-Host "  - Generated: $($pdfInfo.Name) ($([math]::Round($pdfInfo.Length/1KB, 1)) KB)" -ForegroundColor Green
} else {
    Write-Error "PDF was not created"
    exit 1
}

# Cleanup (disabled for troubleshooting)
Write-Host "[6/6] Keeping temp file for troubleshooting..." -ForegroundColor Yellow
# if (Test-Path $TempMarkdown) {
#     Remove-Item $TempMarkdown -Force
#     Write-Host "  - Removed temporary file" -ForegroundColor Gray
# }
Write-Host "  - Temp file kept: $TempMarkdown" -ForegroundColor Gray

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Build Complete!" -ForegroundColor Green
Write-Host "  Output: $OutputPdf" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

# Open PDF if requested
if ($OpenAfterBuild) {
    Write-Host ""
    Write-Host "Opening PDF..." -ForegroundColor Cyan
    Start-Process $OutputPdf
}
