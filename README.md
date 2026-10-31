# Abould ADA — Internal Application Development Accelerator

> **Production-Ready Flutter & Backend Accelerator Framework for Abould Engineering**  
> Accelerating mobile application delivery, standardizing enterprise architecture, and ensuring rigorous automated testing across all client projects.

---

## 1. Project Overview & Quick Start

### Prerequisites
- **Flutter SDK**: `>= 3.11.4` (Channel: `stable`)
- **Dart SDK**: `^3.11.4`
- **Node.js**: `>= 18.x` (for reference backend and Newman API testing)
- Android Studio / VS Code with Flutter extension

### Getting Started in 3 Steps
```bash
# 1. Clone repository and install dependencies
git clone <repository-url>
cd abouldTemplate
flutter pub get

# 2. Setup local development defines (Supabase & Firebase)
cp dart_defines/supabase.local.json.example dart_defines/supabase.local.json

# 3. Generate localizations and launch app
flutter gen-l10n
flutter run
```

---

## 2. Codebase Map — "Which File & Folder Contains What?"

Below is the comprehensive index of the entire repository. Use this table and layout to immediately locate any component, service, model, or screen.

```text
abould_ada/
├── android/                  # Android native project configuration & manifest
├── assets/                   # Static application assets, fonts & icons
├── backend/                  # Reference Node.js & Express.js REST API backend
├── dart_defines/             # Environment runtime variables & API credentials
├── docs/                     # Technical specifications & developer documentation
├── integration_test/         # On-device hardware & simulator E2E integration tests
├── ios/                      # iOS native project configuration & Info.plist
├── lib/                      # Core Flutter application source code
│   ├── app.dart              # Root MaterialApp, theme, routing & locale wireup
│   ├── bootstrap.dart        # Async services initialization & error zones
│   ├── main.dart             # Application main entrypoint
│   ├── core/                 # Shared foundational architecture (cross-cutting)
│   ├── features/             # Feature screens & client presentations
│   ├── l10n/                 # Localization ARB files (English + Hindi)
│   ├── modules/              # Reusable standalone modules
│   └── testing/              # Fakes, in-memory mocks & test bindings
├── scripts/                  # Automated test runners & build automation scripts
├── supabase/                 # PostgreSQL migrations & database schemas
└── test/                     # Comprehensive automated unit & widget test suites
```

### Detailed File Guide

#### 📂 `lib/core/` — Foundations & Shared Infrastructure
| Path | Description |
|---|---|
| [`lib/core/bindings/app_bindings.dart`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/core/bindings/app_bindings.dart) | Dependency Injection bootstrap container; registers singletons & storage overrides. |
| [`lib/core/config/app_config.dart`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/core/config/app_config.dart) | Immutable runtime environment configuration (`apiBaseUrl`, `authBackend`, `useFirebase`). |
| [`lib/core/constants/app_constants.dart`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/core/constants/app_constants.dart) | Global timing constants, network timeouts, and pagination default sizes. |
| [`lib/core/constants/storage_keys.dart`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/core/constants/storage_keys.dart) | Persistent key names for secure storage and SharedPreferences. |
| [`lib/core/di/providers.dart`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/core/di/providers.dart) | Core Riverpod providers (storage, config, logger, network connectivity). |
| [`lib/core/errors/app_exception.dart`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/core/errors/app_exception.dart) | Standardized domain exception classes and unified error types. |
| [`lib/core/routing/app_router.dart`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/core/routing/app_router.dart) | `go_router` routing table, auth guards, deep linking, and redirects. |
| [`lib/core/routing/route_names.dart`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/core/routing/route_names.dart) | Type-safe route path and name constants. |
| [`lib/core/services/app_lifecycle_service.dart`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/core/services/app_lifecycle_service.dart) | Global app lifecycle state tracker (resumed, paused, inactive, detached). |
| [`lib/core/services/connectivity_service.dart`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/core/services/connectivity_service.dart) | Real-time network connectivity monitor (`WiFi`, `Cellular`, `Offline`). |
| [`lib/core/services/image_compression_service.dart`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/core/services/image_compression_service.dart) | Native client-side image compression before remote upload. |
| [`lib/core/services/location_service.dart`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/core/services/location_service.dart) | GPS position queries and runtime permission handling (`geolocator`). |
| [`lib/core/storage/secure_storage_service.dart`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/core/storage/secure_storage_service.dart) | Hardware-backed secure keychain / keystore token storage. |
| [`lib/core/theme/`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/core/theme) | Design tokens: `app_colors.dart`, `app_spacing.dart`, `app_radius.dart`, `app_typography.dart`, and `app_theme.dart`. |

---

#### 📂 `lib/modules/` — Standalone Reusable Modules
| Module | Path | Description |
|---|---|---|
| **Authentication** | [`lib/modules/authentication/`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/modules/authentication) | Multi-provider auth architecture supporting Firebase Auth, Supabase Auth, REST Auth (DummyJSON), and offline Fake auth. Includes Login, Register, Forgot Password, Reset Password, and OTP UI screens. |
| **API Integration** | [`lib/modules/api_integration/`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/modules/api_integration) | Centralized `DioApiClient` with auth token injection, automatic token refresh interceptor, logging interceptor, multipart file upload, and file download. |
| **Firebase** | [`lib/modules/firebase/`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/modules/firebase) | Firebase Auth, Cloud Firestore CRUD, Firebase Storage upload, Crashlytics, Analytics, and Cloud Messaging (FCM). |
| **Supabase** | [`lib/modules/supabase/`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/modules/supabase) | Supabase Auth, PostgreSQL CRUD repositories, real-time table streams, and user profiles. |
| **UI Components** | [`lib/modules/ui_components/`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/modules/ui_components) | Complete library of 30+ reusable widgets: Buttons, Inputs, Navigation, Display, Feedback, and Media. |
| **Notifications** | [`lib/modules/notifications/`](file:///d:/Akhil_Code/Apps/abouldTemplate/lib/modules/notifications) | Push notification routing and background message entrypoint. |

---

#### 📂 `lib/features/` — Screens & Workflows
| Feature | Route | Description |
|---|---|---|
| **Splash** | `/splash` | Initial startup screen; auto-restores user session or directs to `/login`. |
| **Dashboard** | `/dashboard` | Central application hub; displays active services, auth status, theme toggle, and module navigation. |
| **Profile** | `/profile` | User avatar upload (camera/gallery pick -> auto-compress -> Firebase Storage), GPS location widget, and lifecycle panel. |
| **Products** | `/products` | Remote REST data list with live search, pagination (limit/skip), caching, and rating indicators. |
| **UI Showcase** | `/ui-showcase` | Interactive living design gallery demonstrating every implemented ADA component. |
| **API Demo** | `/api-demo` | Interactive HTTP tester for GET, POST, PUT, PATCH, and DELETE requests. |
| **Firebase CRUD** | `/firebase-crud` | Firestore document creation, editing, deleting, and live stream updates. |
| **Supabase Demo**| `/supabase-demo` | Supabase real-time collaborative task list and profile manager. |

---

#### 📂 `backend/` — Reference Node.js & Express.js REST API
| Path | Description |
|---|---|
| [`backend/package.json`](file:///d:/Akhil_Code/Apps/abouldTemplate/backend/package.json) | Node.js project manifest (`express`, `jsonwebtoken`, `multer`, `cors`). |
| [`backend/src/server.js`](file:///d:/Akhil_Code/Apps/abouldTemplate/backend/src/server.js) | Express app entrypoint, CORS configuration, healthcheck, and error middlewares. |
| [`backend/src/routes/auth.routes.js`](file:///d:/Akhil_Code/Apps/abouldTemplate/backend/src/routes/auth.routes.js) | Endpoints for `/register`, `/login`, and `/refresh-token` with JWT issuance. |
| [`backend/src/routes/product.routes.js`](file:///d:/Akhil_Code/Apps/abouldTemplate/backend/src/routes/product.routes.js) | Paginated product listing, search queries, and protected item creation. |
| [`backend/src/routes/upload.routes.js`](file:///d:/Akhil_Code/Apps/abouldTemplate/backend/src/routes/upload.routes.js) | Multipart file upload endpoint storing files in `backend/uploads/`. |

---

#### 📂 `test/` & `integration_test/` — Automated Testing Suite
| Path | Scope & Description |
|---|---|
| [`test/modules/auth/`](file:///d:/Akhil_Code/Apps/abouldTemplate/test/modules/auth) | Unit tests for auth repositories, user entity equality, and form validators. |
| [`test/modules/api/`](file:///d:/Akhil_Code/Apps/abouldTemplate/test/modules/api) | Unit tests for Dio error mapping, network status codes, and exceptions. |
| [`test/ui/`](file:///d:/Akhil_Code/Apps/abouldTemplate/test/ui) | Automated widget tests for buttons, input fields, dropdowns, cards, badges, and feedback dialogs. |
| [`test/integration/app_workflows_test.dart`](file:///d:/Akhil_Code/Apps/abouldTemplate/test/integration/app_workflows_test.dart) | Headless integration test suite covering **all 13 mandatory application scenarios**. |
| [`integration_test/app_test.dart`](file:///d:/Akhil_Code/Apps/abouldTemplate/integration_test/app_test.dart) | Real-device/simulator E2E integration test suite for Android & iOS. |
| [`docs/postman/`](file:///d:/Akhil_Code/Apps/abouldTemplate/docs/postman) | Reusable Postman collection with test scripts (`pm.test`) for positive, negative, and latency tests. |

---

## 3. How to Run Tests

### Run all Unit, Widget, and Workflow Tests
```bash
flutter test
```

### Run Automated Test Runner Script
```bash
# PowerShell
.\scripts\run_tests.ps1 -Coverage

# Bash
./scripts/run_tests.sh
```

### Run Automated API Tests (Newman CLI)
```bash
npm install -g newman newman-reporter-htmlextra
newman run docs/postman/DummyJSON.postman_collection.json \
  -e docs/postman/DummyJSON.postman_environment.json \
  --reporters cli,htmlextra \
  --reporter-htmlextra-export test_reports/api_test_report.html
```

---

## 4. Building for Production

### Android Release
```bash
# Build release APK
flutter build apk --release

# Build Google Play App Bundle (AAB)
flutter build appbundle --release
```

### iOS Release
```bash
flutter build ipa --release
```

---

## 5. Technical Documentation Directory

For in-depth guides and architectural blueprints, refer to:
- 📘 [ARCHITECTURE.md](docs/ARCHITECTURE.md) — System layout, dependency rules & Riverpod selection rationale.
- 📘 [DEVELOPER_GUIDE.md](docs/DEVELOPER_GUIDE.md) — Complete 17-topic onboarding & development guide.
- 📘 [TESTING.md](docs/TESTING.md) — Automated testing matrix, tool evaluation & reporting instructions.
- 📘 [CODING_STANDARDS.md](docs/CODING_STANDARDS.md) — Code style, linting rules & localization requirements.
- 📘 [CODE_REVIEW_CHECKLIST.md](docs/CODE_REVIEW_CHECKLIST.md) — Pre-PR review checklist.
- 📘 [PERFORMANCE_REPORT.md](docs/PERFORMANCE_REPORT.md) — Benchmark findings, compression stats & optimization tips.
- 📘 [FIREBASE_SETUP.md](docs/FIREBASE_SETUP.md) & [FIREBASE_RULES.md](docs/FIREBASE_RULES.md) — Firebase configuration & security rules.
- 📘 [SUPABASE.md](docs/SUPABASE.md) — Supabase database configuration & migrations.
