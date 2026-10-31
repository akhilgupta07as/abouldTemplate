# Localization (English + Hindi)

## App UI strings

- ARB files: `lib/l10n/app_en.arb`, `lib/l10n/app_hi.arb`
- Generated: `flutter gen-l10n` (runs on `flutter pub get` when `generate: true`)
- Access in widgets: `context.l10n.someKey`
- Locale switch: **EN | HI** on the dashboard (`AdaLocaleToggle`), persisted via `StorageKeys.localeCode`

## User-generated / database copy

Firestore todos (collection `todo`) store bilingual fields:

| Field     | Description                          |
|-----------|--------------------------------------|
| `english` | English text                         |
| `hindi`   | Hindi text                           |
| `todoname`| Legacy mirror of English for old UIs |

When the user saves a todo in the **current app language**, `TranslationService` fills the other language using [MyMemory](https://mymemory.translated.net/) (demo-friendly, no API key). Replace `TranslationClient` in `localization_providers.dart` for production (Google Cloud Translation, etc.).

Display at runtime: `todo.localizedTitle(locale.languageCode)`.

## Adding strings

1. Add the key to `app_en.arb` and translate in `app_hi.arb`.
2. Run `flutter pub get` to regenerate `AppLocalizations`.
3. Use `context.l10n.yourKey` in UI code.
