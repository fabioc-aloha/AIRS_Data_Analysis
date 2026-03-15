# Thin wrapper: delegate to unified converter script in defence/exports
$convertScript = Join-Path $PSScriptRoot "exports/convert.ps1"
if (-not (Test-Path $convertScript)) {
    Write-Error "Converter script not found: $convertScript"
    exit 1
}
# Forward all args to convert.ps1 (supports -BoardSheet / -All)
powershell -ExecutionPolicy Bypass -File $convertScript @args
