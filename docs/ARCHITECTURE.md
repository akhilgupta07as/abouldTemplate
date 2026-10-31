# Abould ADA — Architecture & Design Blueprint

Technical architecture documentation for the Abould Application Development Accelerator (ADA), satisfying **Workstream 1.1: Project Architecture** and **Workstream 6: Developer Documentation**.

---

## 1. Repository Layout & Module Boundaries

The project adopts a **feature-first, modular clean architecture**:

```text
abould_ada/
├── lib/
│   ├── main.dart             # Application entrypoint
│   ├── bootstrap.dart        # Async service initialization & error zone
│   ├── app.dart              # MaterialApp.router, theme & localization wireup
│   ├── core/                 # Cross-cutting foundational layer
│   │   ├── bindings/         # Global dependency injection container
│   │   ├── config/           # Environment & runtime configuration
│   │   ├── constants/        # Storage keys & system constants
│   │   ├── di/               # Riverpod provider definitions
│   │   ├── errors/           # Unified AppException & Failure models
│   │   ├── network/          # Network contracts & error boundaries
│   │   ├── routing/          # GoRouter configuration & route guards
│   │   ├── services/         # Location, lifecycle, compression services
│   │   ├── storage/          # SharedPreferences & FlutterSecureStorage
│   │   ├── theme/            # ADA design tokens (spacing, colors, typography)
│   │   └── utils/            # Structured logging & helpers
│   ├── modules/              # Reusable standalone functional packages
│   │   ├── authentication/   # Multi-provider auth (DummyJSON, Firebase, Supabase)
│   │   ├── api_integration/  # Centralized Dio HTTP client, interceptors, cache
│   │   ├── firebase/         # Firestore CRUD, Storage, Crashlytics, Analytics
│   │   ├── supabase/         # PostgreSQL CRUD, Realtime subscriptions, profiles
│   │   ├── ui_components/    # Standardized 30+ widget library
│   │   └── notifications/    # Push notification handlers & routing
│   ├── features/             # Application presentation screens
│   │   ├── splash/           # Splash & session restore
│   │   ├── dashboard/        # Main landing hub & service status
│   │   ├── profile/          # User profile, GPS & avatar upload
│   │   ├── products/         # Paginated catalog & search
│   │   ├── ui_showcase/      # Interactive component gallery
│   │   ├── api_demo/         # REST API testbench
│   │   └── supabase_demo/    # Realtime task manager
│   ├── l10n/                 # ARB localization definitions (EN + HI)
│   └── testing/              # Fakes, in-memory mocks, and test bindings
├── backend/                  # Reference Node.js & Express.js REST backend
├── test/                     # Automated unit, widget, and workflow tests
├── integration_test/         # On-device integration test suite
└── docs/                     # Engineering specifications & guides
```

### Dependency Rules
1. **`features/`** may import `modules/` and `core/`.
2. **`modules/`** may import `core/` only. Modules must **never** import other modules directly (only via interfaces or core contracts).
3. **`core/`** must **never** import `features/` or `modules/`.

---

## 2. State Management Decision: Riverpod vs. BLoC (Doc Section 2.1)

Per Section 2.1 of the requirements, **Flutter Riverpod** was selected as the internal standard for Abould ADA. Below is the technical justification comparing Riverpod with BLoC:

| Evaluation Dimension | Flutter Riverpod | BLoC / Cubit | ADA Selection Decision |
|---|---|---|---|
| **Compile-Time Safety** | High: Providers are globally declared top-level variables. No `ProviderNotFoundException` or runtime context lookups. | Moderate: Relies on `BuildContext` inheritance tree (`BlocProvider.of(context)`). | **Riverpod**: Prevents runtime widget tree resolution crashes. |
| **Boilerplate & Velocity** | Very Low: A simple state is 3-5 lines (`StateProvider`, `AsyncNotifierProvider`). | High: Requires separate Events, States, Bloc class, and `Equatable` props for every feature. | **Riverpod**: Significantly accelerates client MVP delivery. |
| **Asynchronous Data Handling** | Native `AsyncValue` pattern with built-in `.when(data: ..., loading: ..., error: ...)` | Requires manual state classes (`LoadingState`, `LoadedState`, `ErrorState`). | **Riverpod**: Eliminates repetitive boilerplate for network calls. |
| **Dependency Injection** | Built-in: Providers can read or watch any other provider declaratively (`ref.watch`). | Requires pairing with `get_it` or nested `RepositoryProvider` widgets. | **Riverpod**: Unifies DI and state management in one cohesive pattern. |
| **Testability & Overrides** | Outstanding: Any provider can be overridden in tests via `ProviderScope(overrides: [...])` without complex mocking harnesses. | Requires mocking Blocs with `bloc_test`. | **Riverpod**: Effortless fake injection in unit and integration tests. |

---

## 3. Core Architectural Patterns

- **Repository Pattern**: Abstract domain interfaces (`AuthRepository`, `ProductsRepository`) isolate business logic from network or database details.
- **Fail-Fast Error Handling**: Network errors from Dio, Firebase, or Supabase are mapped at the repository boundary into domain-level `AppException` objects.
- **Declarative Navigation**: `go_router` handles URL path routing, deep linking (`abould://app/*`), and declarative route guards (`redirect:`).
- **Design Tokens**: Strict visual consistency via `AppColors`, `AppSpacing`, `AppRadius`, and `AppTypography`.
