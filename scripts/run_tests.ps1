# Abould ADA — Automated Test Runner and Report Generator
param(
  [switch]$Coverage
)

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "  Abould ADA — Automated Test Suite Execution" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

$startTime = Get-Date

if ($Coverage) {
  Write-Host "Running tests with code coverage..." -ForegroundColor Yellow
  flutter test --coverage
} else {
  flutter test
}

$exitCode = $LASTEXITCODE
$duration = (Get-Date) - $startTime

Write-Host "`n--------------------------------------------------" -ForegroundColor Cyan
if ($exitCode -eq 0) {
  Write-Host "  TEST RUN STATUS: PASSED" -ForegroundColor Green
} else {
  Write-Host "  TEST RUN STATUS: FAILED" -ForegroundColor Red
}
Write-Host "  Duration: $($duration.TotalSeconds.ToString("0.00"))s" -ForegroundColor White
Write-Host "--------------------------------------------------" -ForegroundColor Cyan

exit $exitCode
