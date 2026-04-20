<#
.SYNOPSIS
    Build the AIRS thesis from markdown sources to Word (.docx) format.

.DESCRIPTION
    Modern thesis build system for Word output. Uses Word-native markdown files
    for front matter, processes Mermaid diagrams, and generates APA 7-style
    Word document using pandoc with a custom reference document.

.PARAMETER Target
    Build target: 'all' (default), 'draft', 'validate', 'clean'

.PARAMETER Open
    Open the Word document after successful build.

.PARAMETER Clean
    Shortcut for -Target clean

.EXAMPLE
    .\build-word.ps1
    Build the thesis Word document with APA 7 formatting.

.EXAMPLE
    .\build-word.ps1 -Open
    Build and open the document.

.EXAMPLE
    .\build-word.ps1 -Clean
    Remove all generated files.
#>

param(
    [ValidateSet('all', 'draft', 'validate', 'clean')]
    [string]$Target = 'all',
    [switch]$Open,
    [switch]$Clean
)

if ($Clean) { $Target = 'clean' }

# ============================================================
# CONFIGURATION
# ============================================================
$ErrorActionPreference = 'Stop'
$RootDir = $PSScriptRoot

$Config = @{
    # Directories
    Manuscript      = Join-Path $RootDir 'manuscript'
    ChaptersDir     = Join-Path $RootDir 'manuscript/chapters'
    FrontMatterWord = Join-Path $RootDir 'manuscript/front-matter-word'
    BackMatter      = Join-Path $RootDir 'manuscript/back-matter'
    Templates       = Join-Path $RootDir 'templates'
    References      = Join-Path $RootDir 'references'
    Output          = Join-Path $RootDir 'output'
    
    # Files
    BibFile      = Join-Path $RootDir 'references/bibliography.bib'
    CslFile      = Join-Path $RootDir 'references/apa-7th-edition.csl'
    OutputDocx   = Join-Path $RootDir 'output/CORREA_AIRS_Dissertation.docx'
    ReferenceDoc = Join-Path $RootDir 'templates/reference.docx'
    
    # Chapter order
    ChapterFiles = @(
        '01_introduction.md',
        '02_literature_review.md',
        '03_methodology.md',
        '04_results.md',
        '05_analysis_discussion.md',
        '06_conclusions.md'
    )
    
    # Front matter order (Word-native versions)
    # Standard dissertation order: title, copyright, abstract, dedication, acknowledgments, data availability
    FrontMatterFiles = @(
        '00_title.md',
        '02_copyright.md',
        '03_abstract.md',
        '05_dedication.md',
        '04_acknowledgments.md',
        '06_data_availability.md'
    )
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

function Write-Warning {
    param([string]$Message)
    Write-Host "  ⚠ $Message" -ForegroundColor Yellow
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
# BUILD FUNCTIONS
# ============================================================
function Test-Dependencies {
    Write-Step "Checking dependencies..."
    
    $hasPandoc = Test-Dependency 'pandoc' 'Pandoc'
    if (-not $hasPandoc) {
        throw "Pandoc is required. Install from https://pandoc.org"
    }
    
    $script:HasMermaid = Test-Dependency 'mmdc' 'Mermaid CLI'
    $script:HasPython = Test-Dependency 'python' 'Python'
}

function Build-ReferenceDoc {
    <#
    .SYNOPSIS
        Generate or regenerate the APA 7 reference document using Python.
    #>
    
    if (Test-Path $Config.ReferenceDoc) {
        Write-Info "Using existing reference document"
        return $true
    }
    
    Write-Step "Generating APA 7 reference document..."
    
    $pythonScript = Join-Path $RootDir 'scripts/create_apa7_reference.py'
    
    if (-not (Test-Path $pythonScript)) {
        Write-Warning "Reference doc script not found: $pythonScript"
        Write-Info "Will use pandoc defaults (manual formatting required)"
        return $false
    }
    
    if (-not $script:HasPython) {
        Write-Warning "Python not found - cannot generate reference document"
        return $false
    }
    
    # Check for python-docx
    $hasDocx = python -c "import docx" 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Info "Installing python-docx..."
        pip install python-docx --quiet
    }
    
    # Run the script
    & python $pythonScript
    
    if (Test-Path $Config.ReferenceDoc) {
        Write-Success "Reference document created"
        return $true
    }
    
    return $false
}

function Build-MermaidDiagrams {
    Write-Step "Processing Mermaid diagrams..."
    
    if (-not $script:HasMermaid) {
        Write-Info "Skipping Mermaid (mmdc not installed)"
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
    
    # Find markdown files with mermaid blocks
    $mdFiles = Get-ChildItem -Path (Join-Path $script:BuildDir 'chapters') -Filter '*.md' -Recurse
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
            
            # Render to PNG (high resolution for print)
            & mmdc -i $mmdFile -o $pngFile -b white -s 3 -w 1200 2>$null
            
            if (Test-Path $pngFile) {
                # Replace mermaid block with image reference
                $absolutePath = (Resolve-Path $pngFile).Path -replace '\\', '/'
                $imageRef = "`n`n![$diagramName]($absolutePath)`n`n"
                $content = $content.Replace($match.Value, $imageRef)
                Write-Success "Rendered: $diagramName.png"
                $diagramCount++
            }
            $fileIndex++
        }
        
        # Write modified content
        Set-Content $mdFile.FullName -Value $content -NoNewline -Encoding UTF8
    }
    
    if ($diagramCount -eq 0) {
        Write-Info "No mermaid blocks found"
        $script:BuildDir = $null
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
    
    # Determine source directories (use build dir if mermaid processed)
    $chaptersDir = if ($script:BuildDir) { Join-Path $script:BuildDir 'chapters' } else { $Config.ChaptersDir }
    $backMatterDir = if ($script:BuildDir) { Join-Path $script:BuildDir 'back-matter' } else { $Config.BackMatter }
    
    # ============================================================
    # COLLECT SOURCE FILES IN ORDER
    # ============================================================
    $sources = @()
    
    # 1. Front matter (Word-native markdown versions)
    Write-Info "Adding front matter..."
    foreach ($fm in $Config.FrontMatterFiles) {
        $fmPath = Join-Path $Config.FrontMatterWord $fm
        if (Test-Path $fmPath) {
            $sources += $fmPath
            Write-Success "Front: $fm"
        }
        else {
            Write-Warning "Missing: $fm"
        }
    }
    
    # 2. Chapters
    Write-Info "Adding chapters..."
    foreach ($chapter in $Config.ChapterFiles) {
        $chapterPath = Join-Path $chaptersDir $chapter
        if (Test-Path $chapterPath) {
            $sources += $chapterPath
            Write-Success "Chapter: $chapter"
        }
        else {
            Write-Warning "Missing: $chapter"
        }
    }
    
    # 3. Back matter
    Write-Info "Adding back matter..."
    foreach ($backFile in @('references.md', 'appendices.md')) {
        $backPath = Join-Path $backMatterDir $backFile
        if (Test-Path $backPath) {
            $sources += $backPath
            Write-Success "Back: $backFile"
        }
    }
    
    # ============================================================
    # BUILD PANDOC ARGUMENTS
    # ============================================================
    $pandocArgs = @(
        '--from=markdown+fenced_divs+bracketed_spans+yaml_metadata_block+implicit_figures+table_captions+raw_html'
        '--to=docx'
        '--toc'
        '--toc-depth=3'
        '-o', $Config.OutputDocx
    )
    
    # Add reference document if available
    if (Test-Path $Config.ReferenceDoc) {
        $pandocArgs += @('--reference-doc', $Config.ReferenceDoc)
        Write-Info "Using APA 7 reference document"
    }
    else {
        Write-Warning "No reference document - output will need manual formatting"
    }
    
    # Add bibliography if exists
    if (Test-Path $Config.BibFile) {
        $pandocArgs += @(
            '--citeproc'
            "--bibliography=$($Config.BibFile)"
            "--csl=$($Config.CslFile)"
        )
        Write-Info "Bibliography: APA 7th edition"
    }
    
    # Draft mode
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
        if ($_ -and $_ -notmatch 'deprecated|Unknown|warning') {
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
        
        # Show status based on reference document usage
        Write-Host ""
        if (Test-Path $Config.ReferenceDoc) {
            Write-Host "  ┌──────────────────────────────────────────────────────┐" -ForegroundColor Green
            Write-Host "  │  APA 7 STYLING APPLIED                               │" -ForegroundColor Green
            Write-Host "  │                                                      │" -ForegroundColor Green
            Write-Host "  │  • Times New Roman 12pt                              │" -ForegroundColor White
            Write-Host "  │  • Double line spacing                               │" -ForegroundColor White
            Write-Host "  │  • 0.5"" first-line paragraph indent                 │" -ForegroundColor White
            Write-Host "  │  • 1"" margins on all sides                          │" -ForegroundColor White
            Write-Host "  │  • APA 7 heading hierarchy (5 levels)                │" -ForegroundColor White
            Write-Host "  │                                                      │" -ForegroundColor Green
            Write-Host "  │  FINAL CHECKS IN WORD:                               │" -ForegroundColor Yellow
            Write-Host "  │  • Add running head: AI READINESS SCALE              │" -ForegroundColor Gray
            Write-Host "  │  • Insert page numbers (bottom center)               │" -ForegroundColor Gray
            Write-Host "  │  • Verify title page vertical spacing                │" -ForegroundColor Gray
            Write-Host "  │  • Check table/figure formatting                     │" -ForegroundColor Gray
            Write-Host "  └──────────────────────────────────────────────────────┘" -ForegroundColor Green
        }
        else {
            Write-Host "  ┌──────────────────────────────────────────────────────┐" -ForegroundColor Yellow
            Write-Host "  │  MANUAL APA 7 FORMATTING REQUIRED                    │" -ForegroundColor Yellow
            Write-Host "  │                                                      │" -ForegroundColor Yellow
            Write-Host "  │  1. Select All (Ctrl+A)                              │" -ForegroundColor White
            Write-Host "  │  2. Font: Times New Roman, 12pt                      │" -ForegroundColor White
            Write-Host "  │  3. Paragraph > Line Spacing: Double                 │" -ForegroundColor White
            Write-Host "  │  4. Paragraph > Special: First line 0.5""            │" -ForegroundColor White
            Write-Host "  │  5. Layout > Margins: 1"" all sides                  │" -ForegroundColor White
            Write-Host "  │                                                      │" -ForegroundColor Yellow
            Write-Host "  │  To auto-generate reference doc:                     │" -ForegroundColor Gray
            Write-Host "  │    python scripts/create_apa7_reference.py           │" -ForegroundColor Gray
            Write-Host "  └──────────────────────────────────────────────────────┘" -ForegroundColor Yellow
        }
    }
    else {
        throw "Word document was not created"
    }
}

function Invoke-Validate {
    Write-Step "Validating sources..."
    
    # Check Word-specific front matter
    Write-Info "Checking Word front matter..."
    $hasFrontMatter = $true
    foreach ($fm in $Config.FrontMatterFiles) {
        $fmPath = Join-Path $Config.FrontMatterWord $fm
        if (Test-Path $fmPath) {
            Write-Success $fm
        }
        else {
            Write-Warning "Missing: $fm"
            $hasFrontMatter = $false
        }
    }
    
    if (-not $hasFrontMatter) {
        Write-Host ""
        Write-Host "  Word-native front matter files should be in:" -ForegroundColor Yellow
        Write-Host "    manuscript/front-matter-word/" -ForegroundColor Cyan
        Write-Host ""
    }
    
    # Check chapters
    Write-Info "Checking chapters..."
    foreach ($chapter in $Config.ChapterFiles) {
        $path = Join-Path $Config.ChaptersDir $chapter
        if (Test-Path $path) {
            Write-Success $chapter
        }
        else {
            Write-Warning "Missing: $chapter"
        }
    }
    
    # Check bibliography
    if (Test-Path $Config.BibFile) {
        $refs = (Get-Content $Config.BibFile -Raw) -split '@' | Where-Object { $_ -match '^\w+\{' }
        Write-Success "bibliography.bib ($($refs.Count) references)"
    }
    
    # Check reference document
    if (Test-Path $Config.ReferenceDoc) {
        Write-Success "Reference document exists"
    }
    else {
        Write-Warning "No reference document - run: python scripts/create_apa7_reference.py"
    }
}

function Invoke-Clean {
    Write-Step "Cleaning output..."
    
    # Remove Word output file
    if (Test-Path $Config.OutputDocx) {
        Remove-Item -Path $Config.OutputDocx -Force
        Write-Success "Removed Word document"
    }
    
    # Remove build directory
    $buildDir = Join-Path $Config.Output 'build'
    if (Test-Path $buildDir) {
        Remove-Item -Path $buildDir -Recurse -Force
        Write-Success "Removed build directory"
    }
    
    if (-not (Test-Path $Config.OutputDocx) -and -not (Test-Path $buildDir)) {
        Write-Info "Nothing to clean"
    }
}

# ============================================================
# MAIN
# ============================================================
Write-Host "`n$('-' * 40)" -ForegroundColor DarkGray
Write-Host "  AIRS Thesis Build System (Word)      " -ForegroundColor White
Write-Host "$('-' * 40)" -ForegroundColor DarkGray

switch ($Target) {
    'clean' {
        Invoke-Clean
    }
    'validate' {
        Test-Dependencies
        Invoke-Validate
    }
    'draft' {
        Test-Dependencies
        Build-ReferenceDoc
        Build-MermaidDiagrams
        Build-Word -IsDraft $true
    }
    default {
        Test-Dependencies
        Build-ReferenceDoc
        Build-MermaidDiagrams
        Build-Word
    }
}

Write-Host "`n$('-' * 40)" -ForegroundColor DarkGray
Write-Host "  Build Complete!                      " -ForegroundColor Green
Write-Host "$('-' * 40)" -ForegroundColor DarkGray

# Open the document if requested
if ($Open -and (Test-Path $Config.OutputDocx)) {
    Write-Info "Opening document..."
    Start-Process $Config.OutputDocx
}
