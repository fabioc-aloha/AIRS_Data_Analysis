<#
.SYNOPSIS
    Converts standalone Markdown files to PDF with APA 7th edition formatting.

.DESCRIPTION
    This script converts individual Markdown files to PDF using Pandoc and XeLaTeX.
    It applies APA-style formatting (Times New Roman, 12pt, 1" margins).

.PARAMETER File
    Path to a specific .md file to convert. If not provided, converts all standalone documents.

.PARAMETER LineSpacing
    Line spacing multiplier (default: 1.5 for briefs, 2.0 for formal documents).

.EXAMPLE
    .\convert-to-pdf.ps1
    Converts all standalone documents (EXECUTIVE_SUMMARY, PRACTITIONER_BRIEF, THESIS_SUMMARY)

.EXAMPLE
    .\convert-to-pdf.ps1 -File "EXECUTIVE_SUMMARY.md"
    Converts only the specified file

.EXAMPLE
    .\convert-to-pdf.ps1 -File "MyDocument.md" -LineSpacing 2.0
    Converts with double spacing
#>

param(
    [string]$File,
    [double]$LineSpacing = 1.5
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Configuration
$PandocArgs = @(
    "--pdf-engine=xelatex"
    "-V", "geometry:margin=1in"
    "-V", "fontsize=12pt"
    "-V", "mainfont=Times New Roman"
    "-V", "linestretch=$LineSpacing"
)

# Optional: Add bibliography support if references exist
$BibFile = Join-Path $ScriptDir "references\bibliography.bib"
$CslFile = Join-Path $ScriptDir "references\apa-7th-edition.csl"

if ((Test-Path $BibFile) -and (Test-Path $CslFile)) {
    $PandocArgs += @(
        "--citeproc"
        "--bibliography=$BibFile"
        "--csl=$CslFile"
    )
}

# Standalone documents to convert (if no specific file provided)
$StandaloneFiles = @(
    "EXECUTIVE_SUMMARY.md"
    "PRACTITIONER_BRIEF.md"
    "THESIS_SUMMARY.md"
    "PRESENTATION_SLIDES.md"
)

function Convert-MarkdownToPdf {
    param(
        [string]$InputFile,
        [double]$Spacing = 1.5
    )
    
    if (-not (Test-Path $InputFile)) {
        Write-Warning "File not found: $InputFile"
        return $false
    }
    
    $OutputFile = [System.IO.Path]::ChangeExtension($InputFile, ".pdf")
    $FileName = Split-Path -Leaf $InputFile
    
    Write-Host "  Converting: $FileName" -ForegroundColor Cyan
    
    try {
        # Build pandoc command directly
        $HeaderFile = Join-Path $ScriptDir "standalone-header.tex"
        $cmd = "pandoc `"$InputFile`" -o `"$OutputFile`" --pdf-engine=xelatex"
        $cmd += " -V geometry:margin=1in -V fontsize=12pt"
        $cmd += " -V `"mainfont=Times New Roman`""
        
        # Add header for table spacing if it exists
        if (Test-Path $HeaderFile) {
            $cmd += " -H `"$HeaderFile`""
        } else {
            # Fallback to linestretch variable if no header
            $cmd += " -V linestretch=$Spacing"
        }
        
        # Add bibliography if available
        if ((Test-Path $BibFile) -and (Test-Path $CslFile)) {
            $cmd += " --citeproc --bibliography=`"$BibFile`" --csl=`"$CslFile`""
        }
        
        # Execute command
        Invoke-Expression $cmd 2>&1 | Out-Null
        
        if (Test-Path $OutputFile) {
            $Size = [math]::Round((Get-Item $OutputFile).Length / 1KB, 1)
            Write-Host "    ✓ Generated: $(Split-Path -Leaf $OutputFile) ($Size KB)" -ForegroundColor Green
            return $true
        } else {
            Write-Host "    ✗ Failed to generate PDF" -ForegroundColor Red
            return $false
        }
    }
    catch {
        Write-Host "    ✗ Error: $_" -ForegroundColor Red
        return $false
    }
}

# Main execution
Write-Host ""
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "  Markdown to PDF Converter (APA 7)" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""

# Check for Pandoc
if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Pandoc not found. Please install Pandoc first." -ForegroundColor Red
    exit 1
}

Push-Location $ScriptDir

$Success = 0
$Failed = 0

if ($File) {
    # Convert specific file
    $FilePath = if ([System.IO.Path]::IsPathRooted($File)) { $File } else { Join-Path $ScriptDir $File }
    if (Convert-MarkdownToPdf -InputFile $FilePath -Spacing $LineSpacing) {
        $Success++
    } else {
        $Failed++
    }
} else {
    # Convert all standalone files
    Write-Host "Converting standalone documents..." -ForegroundColor White
    Write-Host ""
    
    foreach ($mdFile in $StandaloneFiles) {
        $FilePath = Join-Path $ScriptDir $mdFile
        
        # Use 1.5 line spacing for all standalone documents
        $Spacing = 1.5
        
        if (Convert-MarkdownToPdf -InputFile $FilePath -Spacing $Spacing) {
            $Success++
        } else {
            $Failed++
        }
    }
}

Pop-Location

Write-Host ""
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "  Conversion Complete" -ForegroundColor Yellow
Write-Host "  Success: $Success | Failed: $Failed" -ForegroundColor $(if ($Failed -eq 0) { "Green" } else { "Yellow" })
Write-Host "========================================" -ForegroundColor Yellow
