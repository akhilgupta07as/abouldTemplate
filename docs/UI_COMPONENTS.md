# UI component library

Location: `lib/modules/ui_components/`

## Design system

Tokens: `lib/core/theme/` — `AppDesignSystem` aggregates colors, spacing, radius, shadows, typography.

Projects customize branding via `AppTheme` seed colors, not by editing widget internals.

## Showcase

After sign-in: **Dashboard → UI Components** or route `/ui-showcase`.

Demonstrates buttons, inputs, feedback, states, theme toggle, connectivity, image/file pickers.

## Common services (Workstream 2.6)

| Service | Path |
|---------|------|
| Local / secure storage | `core/storage/` |
| Theme mode persistence | `core/services/theme_mode_controller.dart` |
| Connectivity | `core/services/connectivity_service.dart` |
| Image picker | used in profile + showcase |
| File picker | showcase demo |

Planned: deep links, localization ARB files, image compression wrapper, GPS permissions module.

## Tests

```bash
flutter test test/ui/
```
