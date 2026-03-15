<#!br/>.SYNOPSIS
    Converts AIRS markdown files (exec summary & board sheet) to PDF using Pandoc + XeLaTeX.
.DESCRIPTION
    Generates professionally formatted PDFs with TOC, sane margins, robust font coverage (Greek/math symbols),
    optional header injection, and support for both the Executive Summary and Board cheat sheet.
.EXAMPLES
    .\convert.ps1                              # Exec summary only
    .\convert.ps1 -BoardSheet                  # Board cheat sheet only
    .\convert.ps1 -All                         # Both exec summary and board sheet
#>

param(
    [string]$InputFile = "AIRS-Executive-Summary.md",
    [string]$OutputFile = "AIRS-Executive-Summary.pdf",
    [switch]$BoardSheet,
    [switch]$All,
    [string]$BoardInputFile = "board-ready-quick-answers.md",
    [string]$BoardOutputFile = "board-ready-quick-answers.pdf",
    [string]$HeaderFile = "header.tex",
    [string]$PdfEngine = "lualatex"  # default to lualatex to avoid dvipdfmx font bugs
)

$ErrorActionPreference = 'Stop'

# Resolve paths once
$Script:ScriptDir = $PSScriptRoot
$Script:ProjectDir = Split-Path -Parent $PSScriptRoot

function Resolve-ProjectPaths {
    param([string]$relativePath)
    return @{
        ScriptDir  = $Script:ScriptDir
        ProjectDir = $Script:ProjectDir
        InputPath  = Join-Path $Script:ProjectDir $relativePath
        HeaderPath = Join-Path $Script:ScriptDir $HeaderFile
    }
}

function Select-Font {
    param([string[]]$Candidates, [string]$fallback)
    foreach ($font in $Candidates) {
        return $font
    }
    return $fallback
}

function Invoke-Pandoc {
    param(
        [string]$InputPath,
        [string]$OutputPath,
        [string]$HeaderPath,
        [string]$Title,
        [string]$Author,
        [string]$PdfEngine
    )

    if (-not (Test-Path $InputPath)) {
        Write-Error "Input file not found: $InputPath"
        exit 1
    }

    # Prefer widely available fonts to reduce missing-glyph warnings
    $mainFontCandidates = @("Arial", "Times New Roman", "Calibri", "Helvetica", "Latin Modern Roman")
    $monoFontCandidates = @("Consolas", "Cascadia Code", "Courier New", "DejaVu Sans Mono")
    $mathFontCandidates = @("Latin Modern Math", "Cambria Math")

    $mainFont = Select-Font -Candidates $mainFontCandidates -fallback "Latin Modern Roman"
    $monoFont = Select-Font -Candidates $monoFontCandidates -fallback "Consolas"
    $mathFont = Select-Font -Candidates $mathFontCandidates -fallback "Latin Modern Math"

    $argsList = @(
        $InputPath,
        "--from", "markdown",
        "--pdf-engine=$PdfEngine",
        "--toc", "--toc-depth=3",
        "-V", "geometry:margin=1in",
        "-V", "fontsize=11pt",
        "-V", "mainfont=$mainFont",
        "-V", "monofont=$monoFont",
        "-V", "mathfont=$mathFont",
        "-V", "colorlinks=true",
        "-V", "linkcolor=blue",
        "-V", "urlcolor=blue",
        "--metadata", "title=$Title",
        "--metadata", "author=$Author",
        "--standalone",
        "-o", $OutputPath
    )

    if (Test-Path $HeaderPath) {
        $argsList += @("-H", $HeaderPath)
    }

    Write-Host "\nConverting:" $InputPath -ForegroundColor Cyan
    Write-Host "Output:   " $OutputPath -ForegroundColor Cyan

    pandoc @argsList
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path $OutputPath)) {
        Write-Warning "Pandoc conversion failed (engine=$PdfEngine, exit=$LASTEXITCODE). Attempting fallback..."
        # Fallback engine
        $fallback = if ($PdfEngine -eq "lualatex") { "xelatex" } else { "lualatex" }
        $argsList = $argsList -replace "--pdf-engine=$PdfEngine", "--pdf-engine=$fallback"
        pandoc @argsList
        if ($LASTEXITCODE -ne 0 -or -not (Test-Path $OutputPath)) {
            Write-Error "Pandoc conversion failed after fallback (engine=$fallback) with exit code $LASTEXITCODE"
            exit $LASTEXITCODE
        }
        else {
            Write-Host "✅ PDF generated with fallback ($fallback): $OutputPath" -ForegroundColor Yellow
        }
    }
    else {
        # Validate non-empty output
        $length = (Get-Item $OutputPath).Length
        if ($length -lt 20480) {
            Write-Warning "PDF generated but is unusually small ($length bytes). Consider reopening with alternate engine (use -PdfEngine xelatex)."
        }
        Write-Host "✅ PDF generated: $OutputPath" -ForegroundColor Green
    }
}

if ($All) { $BoardSheet = $true }

# Exec summary conversion
$paths = Resolve-ProjectPaths -relativePath $InputFile
if (-not (Test-Path $paths.InputPath)) {
    Write-Error "Input file not found: $($paths.InputPath)"
    exit 1
}
$execOut = Join-Path $paths.ScriptDir $OutputFile
Invoke-Pandoc -InputPath $paths.InputPath -OutputPath $execOut -HeaderPath $paths.HeaderPath -Title "Executive Summary" -Author "Fabio Correa" -PdfEngine $PdfEngine

# Board cheat sheet conversion (optional)
if ($BoardSheet) {
    $boardPaths = Resolve-ProjectPaths -relativePath $BoardInputFile
    if (-not (Test-Path $boardPaths.InputPath)) {
        Write-Error "Board input file not found: $($boardPaths.InputPath)"
        exit 1
    }
    $boardOut = Join-Path $boardPaths.ScriptDir $BoardOutputFile
    Invoke-Pandoc -InputPath $boardPaths.InputPath -OutputPath $boardOut -HeaderPath $boardPaths.HeaderPath -Title "Board-Ready Quick Answers" -Author "Fabio Correa" -PdfEngine $PdfEngine
}
