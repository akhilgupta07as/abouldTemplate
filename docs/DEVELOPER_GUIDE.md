# Developer Guide — Abould ADA

## Prerequisites

- Flutter SDK (see `pubspec.yaml` environment SDK constraint)
- Android Studio or VS Code with Flutter extension
- Optional: Firebase project, Supabase project for live demos

## Run the app

```bash
flutter pub get
flutter run
```

### Supabase keys (local)

1. Copy `dart_defines/supabase.local.json.example` → `dart_defines/supabase.local.json` (gitignored).
2. Set `SUPABASE_URL` and `SUPABASE_ANON_KEY`.
3. Run with defines file or rely on debug asset loader (see `docs/SUPABASE.md`).

### Firebase

Configure `google-services.json` / `GoogleService-Info.plist` per FlutterFire docs when enabling Firebase modules.

## Project map

- `lib/main.dart` — entry, bootstrap
- `lib/app.dart` — `MaterialApp.router`, locale, theme, lifecycle observer
- `lib/core/` — routing, theme, config, services (compression, location, lifecycle)
- `lib/modules/` — authentication, API, Firebase, Supabase, UI components
- `lib/features/` — dashboard, profile, demos (products, supabase, ui showcase)
- `lib/l10n/` — ARB files (English + Hindi)
- `supabase/migrations/` — SQL for tasks and profiles

## Localization workflow

1. Add key to `lib/l10n/app_en.arb`.
2. Add Hindi translation to `lib/l10n/app_hi.arb`.
3. Run `flutter gen-l10n`.
4. Use `context.l10n.yourKey` in widgets (`l10n_extensions.dart`).

## Profile features

- **Avatar upload:** gallery pick → compress → Firebase Storage (when Firebase enabled).
- **Location panel:** GPS via `geolocator` + permissions (see Android manifest / iOS Info.plist).
- **Lifecycle panel:** shows current `AppLifecycleState` from global observer.

## Quality docs

- [CODING_STANDARDS.md](./CODING_STANDARDS.md)
- [CODE_REVIEW_CHECKLIST.md](./CODE_REVIEW_CHECKLIST.md)
- [PERFORMANCE_REPORT.md](./PERFORMANCE_REPORT.md)
- [TESTING.md](./TESTING.md)

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Supabase “Keys missing” | Provide `supabase.local.json` or dart-defines |
| l10n compile errors | Sync EN/HI ARB keys; run gen-l10n |
| Location denied | Grant permission in OS settings; check manifest/plist |
