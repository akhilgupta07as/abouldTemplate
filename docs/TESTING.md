# Testing Guide — Abould ADA

## Quick start

```bash
flutter pub get
flutter gen-l10n
flutter analyze
flutter test
```

Integration tests (device/emulator required):

```bash
flutter test integration_test/app_test.dart
```

## Test layout

| Path | Purpose |
|------|---------|
| `test/api/` | JSON models, pagination, product cache |
| `test/localization/` | Bilingual text helpers, translation service |
| `test/supabase/` | Task model parsing |
| `test/ui/` | ADA button widgets |
| `test/core/` | App bindings, lifecycle, compression edge cases |
| `integration_test/` | End-to-end smoke (splash → login) |

## Writing tests

- Prefer **unit tests** for parsers and services with no Flutter binding.
- Use `flutter_test` + `ProviderContainer` for Riverpod notifiers.
- Widget tests: pump `MaterialApp` with `localizationsDelegates` when asserting l10n strings.

## CI

GitHub Actions workflow `.github/workflows/flutter_ci.yml` runs analyze + test on push/PR.

## Supabase / Firebase in tests

- Default unit tests **do not** hit live backends.
- Use fakes/mocks at repository level when adding auth or CRUD tests.

## Coverage goals (starter kit)

- Models and pure services: high coverage.
- Demo pages: smoke/widget tests only where regressions are likely (buttons, l10n keys).
