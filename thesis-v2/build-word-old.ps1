<#
.SYNOPSIS
    Build the AIRS thesis from markdown sources to Word (.docx) format.

.DESCRIPTION
    Modern, modular thesis build system for Word output. Combines chapters,
    processes Mermaid diagrams, converts LaTeX front matter to Word-compatible
    format, and generates APA 7-style Word document using pandoc.

.PARAMETER Target
    Build target: 'all' (default), 'draft', 'figures', 'validate', 'clean', 'watch'

.PARAMETER Open
    Open the Word document after successful build.

.PARAMETER Clean
    Shortcut for -Target clean

.PARAMETER ReferenceDoc
    Custom Word template (.docx) for styling. Auto-generates APA 7 template if not specified.

.EXAMPLE
    .\build-word.ps1
    Build the thesis Word document with APA 7 formatting.

.EXAMPLE
    .\build-word.ps1 -Target draft -Open
    Build draft version and open it.

.EXAMPLE
    .\build-word.ps1 -Clean
    Remove all generated files.

.EXAMPLE
    .\build-word.ps1 -ReferenceDoc templates/custom-template.docx
    Build using a custom Word template for styling.
#>

param(
    [ValidateSet('all', 'draft', 'figures', 'validate', 'clean', 'watch')]
    [string]$Target = 'all',
    [switch]$Open,
    [switch]$Clean,
    [string]$ReferenceDoc
)

# Handle -Clean shortcut
if ($Clean) { $Target = 'clean' }

# ============================================================
# CONFIGURATION
# ============================================================
$ErrorActionPreference = 'Stop'
$RootDir = $PSScriptRoot

$Config = @{
    # Directories
    Manuscript   = Join-Path $RootDir 'manuscript'
    ChaptersDir  = Join-Path $RootDir 'manuscript/chapters'
    FrontMatter  = Join-Path $RootDir 'manuscript/front-matter'
    BackMatter   = Join-Path $RootDir 'manuscript/back-matter'
    Assets       = Join-Path $RootDir 'assets'
    Figures      = Join-Path $RootDir 'assets/figures'
    Tables       = Join-Path $RootDir 'assets/tables'
    Templates    = Join-Path $RootDir 'templates'
    References   = Join-Path $RootDir 'references'
    Output       = Join-Path $RootDir 'output'
    
    # Files
    MetaFile     = Join-Path $RootDir 'meta.yaml'
    BibFile      = Join-Path $RootDir 'references/bibliography.bib'
    CslFile      = Join-Path $RootDir 'references/apa-7th-edition.csl'
    OutputDocx   = Join-Path $RootDir 'output/CORREA_AIRS_Dissertation.docx'
    ReferenceDoc = Join-Path $RootDir 'templates/apa7-reference.docx'
    
    # Chapter order
    ChapterFiles = @(
        '01_introduction.md',
        '02_literature_review.md',
        '03_methodology.md',
        '04_results.md',
        '05_analysis_discussion.md',
        '06_conclusions.md'
    )
    
    # Thesis metadata (read from meta.yaml or defaults)
    Title        = "Artificial Intelligence Readiness Scale: Extending UTAUT2 for Enterprise AI Adoption"
    Author       = "Fabio Correa"
    Institution  = "Touro University Worldwide"
    Degree       = "Doctor of Business Administration"
    Year         = "2026"
}

# ============================================================
# HELPERS
# ============================================================
function Write-Step {
    param([string]$Message, [string]$Color = 'Cyan')
    Write-Host "`n[$((Get-Date).ToString('HH:mm:ss'))] $Message" -ForegroundColor $Color
}

function Write-Success {
    param([string]$Message)
    Write-Host "  ✓ $Message" -ForegroundColor Green
}

function Write-Info {
    param([string]$Message)
    Write-Host "  • $Message" -ForegroundColor Gray
}

function Test-Dependency {
    param([string]$Command, [string]$Name)
    $cmd = Get-Command $Command -ErrorAction SilentlyContinue
    if ($cmd) {
        Write-Success "$Name found: $($cmd.Source)"
        return $true
    }
    Write-Host "  ⚠ $Name not found" -ForegroundColor Yellow
    return $false
}

# ============================================================
# REFERENCE DOCUMENT GENERATION
# ============================================================
function New-APA7ReferenceDoc {
    <#
    .SYNOPSIS
        Generate an APA 7th edition reference.docx for pandoc styling.
    #>
    param([string]$OutputPath)
    
    Write-Step "Generating APA 7 reference document..."
    
    # Create a minimal markdown file with all heading levels and styles
    $tempMd = Join-Path $env:TEMP "apa7-sample.md"
    $tempDocx = Join-Path $env:TEMP "apa7-temp.docx"
    
    # Sample content that exercises all styles
    $sampleContent = @"
---
title: "Sample Document"
author: "Author Name"
date: "2026"
---

# Heading 1

Normal body text paragraph. This establishes the body text style with Times New Roman 12pt, double spacing, and first-line indent.

## Heading 2

Another paragraph of body text to ensure consistent formatting throughout the document.

### Heading 3

More body text following a level 3 heading.

#### Heading 4

Body text after level 4 heading.

##### Heading 5

Final body text paragraph.

> Block quote text that should be indented.

- Bullet list item 1
- Bullet list item 2

1. Numbered list item 1
2. Numbered list item 2

| Column 1 | Column 2 |
|----------|----------|
| Cell 1   | Cell 2   |

`Inline code` and **bold** and *italic* text.
"@
    
    Set-Content $tempMd -Value $sampleContent -Encoding UTF8
    
    # Generate initial docx
    & pandoc $tempMd -o $tempDocx --standalone 2>$null
    
    if (-not (Test-Path $tempDocx)) {
        Write-Warning "Could not generate reference document"
        return $false
    }
    
    # Copy to output path - user can customize styles in Word later
    Copy-Item $tempDocx $OutputPath -Force
    
    # Cleanup
    Remove-Item $tempMd -Force -ErrorAction SilentlyContinue
    Remove-Item $tempDocx -Force -ErrorAction SilentlyContinue
    
    Write-Success "Generated: $OutputPath"
    Write-Info "TIP: Open in Word to customize styles (Home > Styles), then save"
    
    return $true
}

# ============================================================
# LATEX TO MARKDOWN PREPROCESSING
# ============================================================
function ConvertFrom-LatexToMarkdown {
    <#
    .SYNOPSIS
        Convert LaTeX commands in front matter to Word-compatible Markdown.
    #>
    param([string]$Content)
    
    # Remove LaTeX page styling commands
    $Content = $Content -replace '\\thispagestyle\{[^}]*\}', ''
    $Content = $Content -replace '\\pagestyle\{[^}]*\}', ''
    $Content = $Content -replace '\\pagenumbering\{[^}]*\}', ''
    
    # Convert \newpage to pagebreak marker
    $Content = $Content -replace '\\newpage', "`n`n---`n`n"
    
    # Convert \section* to markdown heading
    $Content = $Content -replace '\\section\*?\{([^}]*)\}', '# $1'
    $Content = $Content -replace '\\subsection\*?\{([^}]*)\}', '## $1'
    $Content = $Content -replace '\\subsubsection\*?\{([^}]*)\}', '### $1'
    
    # Remove \addcontentsline (Word handles TOC differently)
    $Content = $Content -replace '\\addcontentsline\{[^}]*\}\{[^}]*\}\{[^}]*\}', ''
    
    # Convert spacing environments
    $Content = $Content -replace '\\begin\{singlespace\}', ''
    $Content = $Content -replace '\\end\{singlespace\}', ''
    $Content = $Content -replace '\\begin\{doublespace\}', ''
    $Content = $Content -replace '\\end\{doublespace\}', ''
    
    # Convert \textbf and \textit
    $Content = $Content -replace '\\textbf\{([^}]*)\}', '**$1**'
    $Content = $Content -replace '\\textit\{([^}]*)\}', '*$1*'
    $Content = $Content -replace '\\emph\{([^}]*)\}', '*$1*'
    
    # Convert math notation (simple cases)
    $Content = $Content -replace '\$\\beta\$', 'β'
    $Content = $Content -replace '\$\\alpha\$', 'α'
    $Content = $Content -replace '\$R\^2\$', 'R²'
    $Content = $Content -replace '\$R\^\{2\}\$', 'R²'
    $Content = $Content -replace '\$<\$', '<'
    $Content = $Content -replace '\$>\$', '>'
    
    # Remove \vspace commands
    $Content = $Content -replace '\\vspace\*?\{[^}]*\}', ''
    
    # Convert center environment
    $Content = $Content -replace '\\begin\{center\}', ''
    $Content = $Content -replace '\\end\{center\}', ''
    
    # Remove raw LaTeX that Word can't handle
    $Content = $Content -replace '\\[a-zA-Z]+\{[^}]*\}', ''
    $Content = $Content -replace '\\[a-zA-Z]+', ''
    
    # Clean up excessive whitespace
    $Content = $Content -replace '\r?\n\s*\r?\n\s*\r?\n+', "`n`n"
    
    return $Content.Trim()
}

# ============================================================
# BUILD FUNCTIONS
# ============================================================
function Test-Dependencies {
    Write-Step "Checking dependencies..."
    
    $hasPandoc = Test-Dependency 'pandoc' 'Pandoc'
    if (-not $hasPandoc) {
        throw "Pandoc is required. Install from https://pandoc.org"
    }
    
    $hasMermaid = Test-Dependency 'mmdc' 'Mermaid CLI'
    $script:HasMermaid = $hasMermaid
}

function Build-MermaidDiagrams {
    Write-Step "Processing Mermaid diagrams..."
    
    if (-not $script:HasMermaid) {
        Write-Info "Skipping (mmdc not installed)"
        return
    }
    
    # Create build directory for processed files
    $script:BuildDir = Join-Path $Config.Output 'build'
    $mermaidDir = Join-Path $script:BuildDir 'mermaid'
    
    # Clean and recreate build directory
    if (Test-Path $script:BuildDir) { Remove-Item $script:BuildDir -Recurse -Force }
    Copy-Item $Config.Manuscript $script:BuildDir -Recurse
    
    if (-not (Test-Path $mermaidDir)) {
        New-Item -ItemType Directory -Path $mermaidDir -Force | Out-Null
    }
    
    # Find all markdown files with mermaid blocks in build copy
    $mdFiles = Get-ChildItem -Path $script:BuildDir -Filter '*.md' -Recurse
    $diagramCount = 0
    
    foreach ($mdFile in $mdFiles) {
        $content = Get-Content $mdFile.FullName -Raw -Encoding UTF8
        
        # Match mermaid code blocks
        $pattern = '(?s)```mermaid\r?\n(.*?)```'
        $regexMatches = [regex]::Matches($content, $pattern)
        
        if ($regexMatches.Count -eq 0) { continue }
        
        $fileIndex = 0
        foreach ($match in $regexMatches) {
            $mermaidCode = $match.Groups[1].Value
            $diagramName = "$($mdFile.BaseName)_diagram_$fileIndex"
            $mmdFile = Join-Path $mermaidDir "$diagramName.mmd"
            $pngFile = Join-Path $mermaidDir "$diagramName.png"
            
            # Write mermaid code to temp file
            Set-Content $mmdFile -Value $mermaidCode -NoNewline -Encoding UTF8
            
            # Render to PNG at high resolution for crisp output
            & mmdc -i $mmdFile -o $pngFile -b white -s 3 -w 1200 2>$null
            
            if (Test-Path $pngFile) {
                # Use relative path for Word compatibility
                $relativePath = $pngFile -replace '\\', '/'
                
                # Replace mermaid block with centered image reference
                # Word handles PNG images well - use width attribute for sizing
                $imageRef = "`n`n![Diagram]($relativePath){ width=100% }`n`n"
                $content = $content.Replace($match.Value, $imageRef)
                Write-Success "Rendered: $diagramName.png"
                $diagramCount++
            }
            $fileIndex++
        }
        
        # Write modified content to build copy only
        Set-Content $mdFile.FullName -Value $content -NoNewline -Encoding UTF8
    }
    
    if ($diagramCount -eq 0) {
        Write-Info "No mermaid blocks found"
        $script:BuildDir = $null  # Use original sources
    }
    else {
        Write-Info "Rendered $diagramCount diagrams"
    }
}

function Build-Word {
    param([bool]$IsDraft = $false)
    
    Write-Step "Building Word document..."
    
    # Ensure output directory exists
    if (-not (Test-Path $Config.Output)) {
        New-Item -ItemType Directory -Path $Config.Output -Force | Out-Null
    }
    
    # Create build directory for preprocessed files
    $buildDir = Join-Path $Config.Output 'build-word'
    if (Test-Path $buildDir) { Remove-Item $buildDir -Recurse -Force }
    New-Item -ItemType Directory -Path $buildDir -Force | Out-Null
    
    # Use mermaid build directory if it exists, otherwise use originals
    $sourceManuscript = if ($script:BuildDir) { $script:BuildDir } else { $Config.Manuscript }
    $chaptersDir = Join-Path $sourceManuscript 'chapters'
    $backMatterDir = Join-Path $sourceManuscript 'back-matter'
    $frontMatterDir = Join-Path $sourceManuscript 'front-matter'
    
    # ============================================================
    # GENERATE TITLE PAGE (Word-compatible Markdown)
    # ============================================================
    Write-Info "Generating title page..."
    $titlePage = @"
---
title: "$($Config.Title)"
author: "$($Config.Author)"
date: "$($Config.Year)"
---

::: {custom-style="Title"}
**$($Config.Title.Split(':')[0]):**

**$($Config.Title.Split(':')[1].Trim())**
:::

\ 

\ 

A Dissertation

Presented to the Faculty of

$($Config.Institution)

\ 

In Partial Fulfillment

of the Requirements for the Degree

$($Config.Degree)

\ 

\ 

by

$($Config.Author)

$($Config.Year)

\newpage

"@
    $titlePagePath = Join-Path $buildDir "00_title.md"
    Set-Content $titlePagePath -Value $titlePage -Encoding UTF8
    
    # ============================================================
    # PREPROCESS FRONT MATTER (Convert LaTeX to Markdown)
    # ============================================================
    Write-Info "Preprocessing front matter..."
    
    $frontMatterFiles = @(
        @{ Source = '02_copyright.md'; Target = '02_copyright.md' },
        @{ Source = '03_abstract.md'; Target = '03_abstract.md' },
        @{ Source = '04_acknowledgments.md'; Target = '04_acknowledgments.md' },
        @{ Source = '05_dedication.md'; Target = '05_dedication.md' },
        @{ Source = '06_data_availability.md'; Target = '06_data_availability.md' }
    )
    
    foreach ($fm in $frontMatterFiles) {
        $sourcePath = Join-Path $frontMatterDir $fm.Source
        $targetPath = Join-Path $buildDir $fm.Target
        
        if (Test-Path $sourcePath) {
            $content = Get-Content $sourcePath -Raw -Encoding UTF8
            $converted = ConvertFrom-LatexToMarkdown -Content $content
            # Ensure page break after each front matter section
            if ($converted -notmatch '---\s*$') {
                $converted += "`n`n---`n"
            }
            Set-Content $targetPath -Value $converted -Encoding UTF8
            Write-Success "Preprocessed: $($fm.Source)"
        }
    }
    
    # ============================================================
    # COLLECT SOURCE FILES IN ORDER
    # ============================================================
    $sources = @()
    
    # 1. Title page (generated)
    $sources += $titlePagePath
    
    # 2. Front matter (preprocessed)
    foreach ($fm in $frontMatterFiles) {
        $fmPath = Join-Path $buildDir $fm.Target
        if (Test-Path $fmPath) {
            $sources += $fmPath
        }
    }
    
    # 3. Chapters (preprocess LaTeX if needed)
    foreach ($chapter in $Config.ChapterFiles) {
        $chapterPath = Join-Path $chaptersDir $chapter
        if (Test-Path $chapterPath) {
            # Copy and preprocess chapter
            $content = Get-Content $chapterPath -Raw -Encoding UTF8
            $targetPath = Join-Path $buildDir $chapter
            
            # Light preprocessing for chapters (they may have some LaTeX)
            $content = $content -replace '\\newpage', "`n`n---`n`n"
            $content = $content -replace '\$\\beta\$', 'β'
            $content = $content -replace '\$\\alpha\$', 'α'
            $content = $content -replace '\$R\^2\$', 'R²'
            $content = $content -replace '\$R\^\{2\}\$', 'R²'
            $content = $content -replace '\$p\$', '*p*'
            $content = $content -replace '\$n\$', '*n*'
            $content = $content -replace '\$N\$', '*N*'
            
            Set-Content $targetPath -Value $content -Encoding UTF8
            $sources += $targetPath
            Write-Info "Chapter: $chapter"
        }
    }
    
    # 4. Back matter
    foreach ($backFile in @('references.md', 'appendices.md')) {
        $backPath = Join-Path $backMatterDir $backFile
        if (Test-Path $backPath) {
            $content = Get-Content $backPath -Raw -Encoding UTF8
            $targetPath = Join-Path $buildDir $backFile
            Set-Content $targetPath -Value $content -Encoding UTF8
            $sources += $targetPath
            Write-Info "Back matter: $backFile"
        }
    }
    
    # ============================================================
    # GENERATE OR USE REFERENCE DOCUMENT
    # ============================================================
    $refDoc = $null
    
    if ($ReferenceDoc -and (Test-Path $ReferenceDoc)) {
        $refDoc = $ReferenceDoc
        Write-Info "Using custom reference document: $ReferenceDoc"
    }
    elseif (Test-Path $Config.ReferenceDoc) {
        $refDoc = $Config.ReferenceDoc
        Write-Info "Using existing APA 7 reference document"
    }
    elseif (Test-Path (Join-Path $Config.Templates 'reference.docx')) {
        $refDoc = Join-Path $Config.Templates 'reference.docx'
        Write-Info "Using templates/reference.docx"
    }
    else {
        # Generate a basic reference document
        Write-Info "No reference document found - using pandoc defaults"
        Write-Info "TIP: Create templates/reference.docx with APA 7 styles for better formatting"
    }
    
    # ============================================================
    # BUILD PANDOC ARGUMENTS
    # ============================================================
    $pandocArgs = @(
        '--from=markdown+implicit_figures+table_captions+yaml_metadata_block+raw_html'
        '--to=docx'
        '--toc'
        '--toc-depth=3'
        # Metadata for title block
        '-M', "title=$($Config.Title)"
        '-M', "author=$($Config.Author)"
        '-M', "date=$($Config.Year)"
        # Output file
        '-o', $Config.OutputDocx
    )
    
    # Add reference document if available
    if ($refDoc) {
        $pandocArgs += @('--reference-doc', $refDoc)
    }
    
    # Add bibliography if exists
    if (Test-Path $Config.BibFile) {
        $pandocArgs += @(
            '--citeproc'
            "--bibliography=$($Config.BibFile)"
            "--csl=$($Config.CslFile)"
        )
        Write-Info "Bibliography: enabled with APA 7th"
    }
    
    # Add draft metadata if requested
    if ($IsDraft) {
        $pandocArgs += @('-M', 'draft=true')
        Write-Info "Mode: DRAFT"
    }
    
    # Add source files
    $pandocArgs += $sources
    
    # ============================================================
    # EXECUTE PANDOC
    # ============================================================
    Write-Step "Running pandoc..." 'Yellow'
    Write-Host "  Sources: $($sources.Count) files" -ForegroundColor DarkGray
    
    & pandoc @pandocArgs 2>&1 | ForEach-Object {
        if ($_ -notmatch 'deprecated|Unknown') {
            Write-Host "  $_" -ForegroundColor DarkGray
        }
    }
    
    if ($LASTEXITCODE -ne 0) {
        throw "Pandoc failed with exit code $LASTEXITCODE"
    }
    
    # ============================================================
    # VERIFY OUTPUT
    # ============================================================
    if (Test-Path $Config.OutputDocx) {
        $docx = Get-Item $Config.OutputDocx
        Write-Success "Generated: $($docx.Name) ($([math]::Round($docx.Length/1KB)) KB)"
        
        # Provide formatting guidance based on whether reference doc was used
        Write-Host ""
        if ($refDoc) {
            Write-Host "  ┌─────────────────────────────────────────────────────────┐" -ForegroundColor Green
            Write-Host "  │  APA 7 STYLING APPLIED via reference document           │" -ForegroundColor Green
            Write-Host "  │                                                         │" -ForegroundColor Green
            Write-Host "  │  • Times New Roman 12pt                                 │" -ForegroundColor White
            Write-Host "  │  • Double line spacing                                  │" -ForegroundColor White
            Write-Host "  │  • 0.5"" first-line indent                              │" -ForegroundColor White
            Write-Host "  │  • 1"" margins                                           │" -ForegroundColor White
            Write-Host "  │  • APA 7 heading hierarchy                              │" -ForegroundColor White
            Write-Host "  │                                                         │" -ForegroundColor Green
            Write-Host "  │  Final checks: Page numbers, running head, title page   │" -ForegroundColor Gray
            Write-Host "  └─────────────────────────────────────────────────────────┘" -ForegroundColor Green
        }
        else {
            Write-Host "  ┌─────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
            Write-Host "  │  APA 7 FORMATTING - Complete these steps in Word:       │" -ForegroundColor Cyan
            Write-Host "  │                                                         │" -ForegroundColor Cyan
            Write-Host "  │  1. Select All (Ctrl+A)                                 │" -ForegroundColor White
            Write-Host "  │  2. Font: Times New Roman, 12pt                         │" -ForegroundColor White
            Write-Host "  │  3. Paragraph > Line Spacing: Double                    │" -ForegroundColor White
            Write-Host "  │  4. Paragraph > Special: First line 0.5""               │" -ForegroundColor White
            Write-Host "  │  5. Layout > Margins: 1"" all sides                      │" -ForegroundColor White
            Write-Host "  │                                                         │" -ForegroundColor Cyan
            Write-Host "  │  For automated styling, run:                            │" -ForegroundColor Gray
            Write-Host "  │    python scripts/create_apa7_reference.py              │" -ForegroundColor Gray
            Write-Host "  └─────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
        }
    }
    else {
        throw "Word document was not created"
    }
}

function Invoke-Validate {
    Write-Step "Validating sources..."
    
    # Check meta.yaml
    if (Test-Path $Config.MetaFile) {
        Write-Success "meta.yaml exists"
    }
    else {
        throw "meta.yaml not found"
    }
    
    # Check chapters
    foreach ($chapter in $Config.ChapterFiles) {
        $path = Join-Path $Config.ChaptersDir $chapter
        if (Test-Path $path) {
            Write-Success $chapter
        }
        else {
            Write-Host "  ⚠ Missing: $chapter" -ForegroundColor Yellow
        }
    }
    
    # Check bibliography
    if (Test-Path $Config.BibFile) {
        $refs = (Get-Content $Config.BibFile -Raw) -split '@' | Where-Object { $_ -match '^\w+\{' }
        Write-Success "bibliography.bib ($($refs.Count) references)"
    }
}

function Invoke-Clean {
    Write-Step "Cleaning output..."
    
    # Remove Word output file
    if (Test-Path $Config.OutputDocx) {
        Remove-Item -Path $Config.OutputDocx -Force
        Write-Success "Removed Word document"
    }
    
    # Remove build directory (mermaid)
    $buildDir = Join-Path $Config.Output 'build'
    if (Test-Path $buildDir) {
        Remove-Item -Path $buildDir -Recurse -Force
        Write-Success "Removed mermaid build directory"
    }
    
    # Remove Word build directory (preprocessed files)
    $buildWordDir = Join-Path $Config.Output 'build-word'
    if (Test-Path $buildWordDir) {
        Remove-Item -Path $buildWordDir -Recurse -Force
        Write-Success "Removed Word build directory"
    }
    
    if (-not (Test-Path $Config.OutputDocx) -and -not (Test-Path $buildDir) -and -not (Test-Path $buildWordDir)) {
        Write-Info "Nothing to clean"
    }
}

function Invoke-Watch {
    Write-Step "Watching for changes (Ctrl+C to stop)..."
    
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = $Config.Manuscript
    $watcher.Filter = "*.md"
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true
    
    $action = {
        $path = $Event.SourceEventArgs.FullPath
        $name = $Event.SourceEventArgs.Name
        Write-Host "`n  Changed: $name" -ForegroundColor Yellow
        
        # Small delay to let file system settle
        Start-Sleep -Milliseconds 500
        
        # Rebuild
        try {
            Build-MermaidDiagrams
            Build-Word
        }
        catch {
            Write-Host "  Build error: $_" -ForegroundColor Red
        }
    }
    
    Register-ObjectEvent $watcher "Changed" -Action $action | Out-Null
    Register-ObjectEvent $watcher "Created" -Action $action | Out-Null
    
    Write-Info "Watching $($Config.Manuscript) for .md changes..."
    Write-Info "Press Ctrl+C to stop"
    
    # Initial build
    Test-Dependencies
    Build-MermaidDiagrams
    Build-Word
    
    # Keep running
    try {
        while ($true) { Start-Sleep -Seconds 1 }
    }
    finally {
        Get-EventSubscriber | Unregister-Event
        $watcher.Dispose()
    }
}

# ============================================================
# MAIN
# ============================================================
try {
    Write-Host "`n----------------------------------------" -ForegroundColor Cyan
    Write-Host "  AIRS Thesis Build System (Word)      " -ForegroundColor Cyan
    Write-Host "----------------------------------------" -ForegroundColor Cyan
    
    switch ($Target) {
        'all' {
            Test-Dependencies
            Build-MermaidDiagrams
            Build-Word
        }
        'draft' {
            Test-Dependencies
            Build-MermaidDiagrams
            Build-Word -IsDraft $true
        }
        'figures' {
            Test-Dependencies
            Build-MermaidDiagrams
        }
        'validate' {
            Invoke-Validate
        }
        'clean' {
            Invoke-Clean
        }
        'watch' {
            Invoke-Watch
        }
    }
    
    Write-Host "`n----------------------------------------" -ForegroundColor Green
    Write-Host "  Build Complete!                      " -ForegroundColor Green
    Write-Host "----------------------------------------`n" -ForegroundColor Green
    
    if ($Open -and (Test-Path $Config.OutputDocx)) {
        Start-Process $Config.OutputDocx
    }
    
}
catch {
    Write-Host "`n✗ Build failed: $_" -ForegroundColor Red
    exit 1
}
