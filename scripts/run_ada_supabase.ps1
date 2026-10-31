# Run tests + launch ADA on a connected device with Supabase defines.
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

Write-Host "== flutter pub get ==" -ForegroundColor Cyan
flutter pub get

Write-Host "`n== flutter test ==" -ForegroundColor Cyan
flutter test

Write-Host "`n== flutter run (Supabase defines) ==" -ForegroundColor Cyan
flutter run --dart-define-from-file=dart_defines/supabase.local.json @args
