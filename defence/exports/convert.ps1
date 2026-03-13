<#
.SYNOPSIS
    Converts AIRS-Executive-Summary.md to PDF using Pandoc + XeLaTeX.
.DESCRIPTION
    Generates a professionally formatted PDF with proper table handling,
    Calibri fonts, and syntax highlighting.
.EXAMPLE
    .\convert.ps1
#>

$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectDir = Split-Path -Parent $scriptDir
$inputFile = Join-Path $projectDir 'AIRS-Executive-Summary.md'
$outputFile = Join-Path $scriptDir 'AIRS-Executive-Summary.pdf'
$headerFile = Join-Path $scriptDir 'header.tex'

if (-not (Test-Path $inputFile)) {
    Write-Error "Input file not found: $inputFile"
    exit 1
}

if (-not (Test-Path $headerFile)) {
    Write-Error "Header file not found: $headerFile"
    exit 1
}

Write-Host "Converting: $inputFile" -ForegroundColor Cyan
Write-Host "Output:     $outputFile" -ForegroundColor Cyan

pandoc $inputFile `
    -o $outputFile `
    --pdf-engine=xelatex `
    -V geometry:margin=1in `
    -V fontsize=11pt `
    -V mainfont="Calibri" `
    -V monofont="Cascadia Code" `
    --syntax-highlighting=tango `
    -V colorlinks=true `
    -V linkcolor=blue `
    -V urlcolor=blue `
    --standalone `
    -H $headerFile

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nPDF generated successfully: $outputFile" -ForegroundColor Green
}
else {
    Write-Error "Pandoc conversion failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}
