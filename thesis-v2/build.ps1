<#
.SYNOPSIS
    Build the AIRS thesis from markdown sources.

.DESCRIPTION
    Modern, modular thesis build system. Combines chapters, processes
    diagrams, and generates APA-style PDF using pandoc.

.PARAMETER Target
    Build target: 'all' (default), 'draft', 'figures', 'validate', 'clean'

.PARAMETER Open
    Open the PDF after successful build.

.EXAMPLE
    .\build.ps1
    Build the thesis PDF.

.EXAMPLE
    .\build.ps1 -Target draft -Open
    Build draft version and open it.
#>

param(
    [ValidateSet('all', 'draft', 'figures', 'validate', 'clean')]
    [string]$Target = 'all',
    [switch]$Open
)

# ============================================================
# CONFIGURATION
# ============================================================
$ErrorActionPreference = 'Stop'
$RootDir = $PSScriptRoot

$Config = @{
    # Directories
    Manuscript   = Join-Path $RootDir 'manuscript'
    Chapters     = Join-Path $RootDir 'manuscript/chapters'
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
    Template     = Join-Path $RootDir 'templates/apa7-thesis.tex'
    BibFile      = Join-Path $RootDir 'references/bibliography.bib'
    CslFile      = Join-Path $RootDir 'references/apa-7th-edition.csl'
    OutputPdf    = Join-Path $RootDir 'output/AIRS_Dissertation.pdf'
    
    # Chapter order
    Chapters     = @(
        '01_introduction.md',
        '02_literature_review.md',
        '03_methodology.md',
        '04_results.md',
        '05_analysis_discussion.md',
        '06_conclusions.md'
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
    
    $hasXelatex = Test-Dependency 'xelatex' 'XeLaTeX'
    $script:PdfEngine = if ($hasXelatex) { 'xelatex' } else { 'pdflatex' }
    
    $hasMermaid = Test-Dependency 'mmdc' 'Mermaid CLI'
    $script:HasMermaid = $hasMermaid
}

function Build-MermaidDiagrams {
    Write-Step "Processing Mermaid diagrams..."
    
    if (-not $script:HasMermaid) {
        Write-Info "Skipping (mmdc not installed)"
        return
    }
    
    $mmdFiles = Get-ChildItem -Path $Config.Figures -Filter '*.mmd' -ErrorAction SilentlyContinue
    if (-not $mmdFiles) {
        Write-Info "No .mmd files found"
        return
    }
    
    foreach ($mmd in $mmdFiles) {
        $pngFile = $mmd.FullName -replace '\.mmd$', '.png'
        & mmdc -i $mmd.FullName -o $pngFile -b white -s 5
        if (Test-Path $pngFile) {
            Write-Success "Generated: $($mmd.BaseName).png"
        }
    }
}

function Build-Pdf {
    param([bool]$IsDraft = $false)
    
    Write-Step "Building PDF..."
    
    # Ensure output directory exists
    if (-not (Test-Path $Config.Output)) {
        New-Item -ItemType Directory -Path $Config.Output -Force | Out-Null
    }
    
    # Collect source files in order
    $sources = @()
    
    # Front matter
    $frontMatter = Join-Path $Config.FrontMatter '00_title_abstract.md'
    if (Test-Path $frontMatter) {
        $sources += $frontMatter
        Write-Info "Front matter: 00_title_abstract.md"
    }
    
    # Chapters
    foreach ($chapter in $Config.Chapters) {
        $chapterPath = Join-Path $Config.Chapters $chapter
        if (Test-Path $chapterPath) {
            $sources += $chapterPath
            Write-Info "Chapter: $chapter"
        }
    }
    
    # Back matter
    foreach ($backFile in @('references.md', 'appendices.md')) {
        $backPath = Join-Path $Config.BackMatter $backFile
        if (Test-Path $backPath) {
            $sources += $backPath
            Write-Info "Back matter: $backFile"
        }
    }
    
    # Build pandoc arguments
    $pandocArgs = @(
        '--from=markdown+raw_tex+table_captions+implicit_figures+yaml_metadata_block'
        "--pdf-engine=$script:PdfEngine"
        "--metadata-file=$($Config.MetaFile)"
        '--toc'
        '--toc-depth=3'
        '-o', $Config.OutputPdf
    )
    
    # Add bibliography if exists
    if (Test-Path $Config.BibFile) {
        $pandocArgs += @(
            '--citeproc'
            "--bibliography=$($Config.BibFile)"
            "--csl=$($Config.CslFile)"
        )
        Write-Info "Bibliography: enabled with APA 7th"
    }
    
    # Add draft watermark if requested
    if ($IsDraft) {
        $pandocArgs += @('-V', 'draft=true')
        Write-Info "Mode: DRAFT"
    }
    
    # Add source files
    $pandocArgs += $sources
    
    # Execute pandoc
    Write-Step "Running pandoc..." 'Yellow'
    & pandoc @pandocArgs 2>&1 | ForEach-Object {
        if ($_ -notmatch 'Missing character|major issue') {
            Write-Host "  $_" -ForegroundColor DarkGray
        }
    }
    
    if ($LASTEXITCODE -ne 0) {
        throw "Pandoc failed with exit code $LASTEXITCODE"
    }
    
    # Verify output
    if (Test-Path $Config.OutputPdf) {
        $pdf = Get-Item $Config.OutputPdf
        Write-Success "Generated: $($pdf.Name) ($([math]::Round($pdf.Length/1KB)) KB)"
    } else {
        throw "PDF was not created"
    }
}

function Invoke-Validate {
    Write-Step "Validating sources..."
    
    # Check meta.yaml
    if (Test-Path $Config.MetaFile) {
        Write-Success "meta.yaml exists"
    } else {
        throw "meta.yaml not found"
    }
    
    # Check chapters
    foreach ($chapter in $Config.Chapters) {
        $path = Join-Path $Config.Chapters $chapter
        if (Test-Path $path) {
            Write-Success $chapter
        } else {
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
    
    if (Test-Path $Config.Output) {
        Remove-Item -Path $Config.Output -Recurse -Force
        Write-Success "Removed output directory"
    } else {
        Write-Info "Nothing to clean"
    }
}

# ============================================================
# MAIN
# ============================================================
try {
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "  AIRS Thesis Build System v2          " -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    
    switch ($Target) {
        'all' {
            Test-Dependencies
            Build-MermaidDiagrams
            Build-Pdf
        }
        'draft' {
            Test-Dependencies
            Build-MermaidDiagrams
            Build-Pdf -IsDraft $true
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
    }
    
    Write-Host "`n========================================" -ForegroundColor Green
    Write-Host "  Build Complete!                      " -ForegroundColor Green
    Write-Host "========================================`n" -ForegroundColor Green
    
    if ($Open -and (Test-Path $Config.OutputPdf)) {
        Start-Process $Config.OutputPdf
    }
    
} catch {
    Write-Host "`n✗ Build failed: $_" -ForegroundColor Red
    exit 1
}
