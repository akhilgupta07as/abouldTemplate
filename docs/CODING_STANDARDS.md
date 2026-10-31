# Abould ADA — Coding Standards

These standards keep the starter kit consistent across client projects.

## Architecture

- **Feature-first layout**: `lib/features/<feature>/` for screens; reusable modules under `lib/modules/`.
- **Core cross-cutting**: routing, theme, DI, localization, and services live in `lib/core/`.
- **State**: Riverpod for app state; prefer `ConsumerWidget` / `ConsumerStatefulWidget`.
- **Navigation**: `go_router` with named routes in `lib/core/routing/route_names.dart`.

## Dart & Flutter style

- Follow [Effective Dart](https://dart.dev/effective-dart) and project `analysis_options.yaml`.
- Prefer `const` constructors where possible.
- Keep widgets small; extract private widgets (`_Foo`) instead of deep nesting.
- No business logic in `build()` — use notifiers, repositories, or services.

## Localization (EN / HI)

- **All user-visible copy** in production screens must use `context.l10n.*` from generated `AppLocalizations`.
- Add strings to `lib/l10n/app_en.arb` and **mirror every key** in `app_hi.arb`.
- Run `flutter gen-l10n` after ARB changes (or rely on `flutter pub get` when `generate: true`).
- Demo-only English in the UI showcase component gallery is acceptable; section titles still use l10n.

## Networking & data

- API models: immutable classes with `fromJson` / `toJson` in module `data/` or `models/`.
- Handle errors at repository boundary; surface user-friendly messages in UI.
- Never commit secrets: use `dart_defines/*.json` (gitignored) or CI secrets.

## Firebase & Supabase

- Gate features with `AppConfig` flags (`useFirebase`, Supabase ready providers).
- Firestore paths and Supabase table names live in dedicated constants files.
- SQL migrations live under `supabase/migrations/` with incremental numbering.

## UI components

- Use ADA design tokens (`AppSpacing`, `AppRadius`, `AppColors`) and shared widgets from `lib/modules/ui_components/`.
- Form fields: `AdaTextField`, `AdaPasswordField`, shared validators in auth module.

## Testing

- Unit tests for models, parsers, and pure services.
- Widget tests for critical ADA widgets and l10n smoke tests.
- Integration test for splash → login path when feasible in CI.

## Git & reviews

- Small, focused commits; link to task or module name in message.
- Use [CODE_REVIEW_CHECKLIST.md](./CODE_REVIEW_CHECKLIST.md) before opening a PR.
