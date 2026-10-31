# Code Review Checklist — Abould ADA

Use this list for every PR or significant local change.

## Correctness

- [ ] Feature works on Android (primary target) and does not break iOS build.
- [ ] Edge cases: empty lists, loading, error states, and sign-out/session clear.
- [ ] No regressions in auth flow (API / Firebase / Supabase selectors).

## Localization

- [ ] New UI strings added to `app_en.arb` **and** `app_hi.arb`.
- [ ] Placeholders documented with `@key` metadata where used.
- [ ] Hindi locale verified on at least one affected screen.

## Security & config

- [ ] No API keys, service role keys, or `.env` secrets in source.
- [ ] Supabase/Firebase rules documented or referenced in `docs/`.
- [ ] Permissions (location, notifications, storage) declared only when used.

## Architecture

- [ ] Logic not duplicated; reuses existing repositories/services.
- [ ] Riverpod providers registered in appropriate `di/` files.
- [ ] Routes added to router + `route_names.dart` if new screens.

## UI / UX

- [ ] Uses ADA components and theme (light + dark).
- [ ] Accessible tap targets; loading/disabled states on async actions.
- [ ] Snackbars/dialogs for recoverable errors.

## Performance

- [ ] Lists use builders where lists are long; images compressed before upload.
- [ ] No unnecessary `ref.watch` in hot paths; streams disposed correctly.

## Tests & CI

- [ ] `flutter analyze` clean (or only pre-existing infos).
- [ ] `flutter test` passes; new behavior covered where practical.
- [ ] CI workflow (`.github/workflows/flutter_ci.yml`) would pass.

## Documentation

- [ ] README or `docs/` updated for new modules, env vars, or migrations.
- [ ] Breaking changes called out in PR description.
