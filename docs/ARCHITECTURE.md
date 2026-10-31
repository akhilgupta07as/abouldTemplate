# Abould ADA — architecture

## Repository layout (phase 1)

```text
abould_ada/
├── lib/
│   ├── main.dart
│   ├── bootstrap.dart
│   ├── app.dart
│   ├── core/
│   │   ├── bindings/
│   │   ├── config/
│   │   ├── constants/
│   │   ├── di/
│   │   ├── errors/
│   │   ├── network/          # shared contracts
│   │   ├── routing/
│   │   ├── storage/
│   │   ├── theme/
│   │   └── utils/
│   ├── modules/
│   │   ├── authentication/
│   │   ├── api_integration/
│   │   ├── firebase/
│   │   ├── supabase/
│   │   ├── ui_components/
│   │   └── notifications/
│   ├── features/             # app screens (demo + client features)
│   │   ├── splash/
│   │   ├── dashboard/
│   │   └── profile/
│   └── testing/              # fakes & test bindings (integration_test too)
├── test/
├── integration_test/
├── docs/
├── assets/
└── pubspec.yaml
```

## Dependency rules

- `features/` → may import `modules/` and `core/`
- `modules/` → may import `core/` only (not other modules unless via interfaces)
- `core/` → must not import `features/` or `modules/`

## Phase 2 (future)

Extract stable modules into `packages/abould_auth`, `abould_api`, `abould_ui`, etc., and move the demo to `apps/demo_app/`.

## Run

```bash
flutter pub get
flutter run
flutter test
```

Package name: `abould_ada` (`import 'package:abould_ada/...'`).
