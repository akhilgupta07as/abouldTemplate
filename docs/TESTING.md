# Automated Testing Framework — Abould ADA

This document details the complete automated testing architecture for the Abould Application Development Accelerator (ADA), meeting all criteria specified in **Workstream 4: Automated Testing Framework**.

---

## 1. Quick Start

Run the entire automated test suite locally:

```bash
# 1. Fetch dependencies & generate localization files
flutter pub get
flutter gen-l10n

# 2. Run static analysis
flutter analyze

# 3. Execute all unit, widget, and workflow tests
flutter test

# 4. Generate code coverage
flutter test --coverage
```

### Running the Test Runner Script
```bash
# On Linux / macOS / Git Bash
./scripts/run_tests.sh

# On Windows PowerShell
.\scripts\run_tests.ps1 -Coverage
```

---

## 2. Test Suite Architecture

| Test Level | Directory | Scope & Purpose | Target Coverage |
|---|---|---|---|
| **Unit Tests** | `test/api/`, `test/modules/`, `test/localization/`, `test/core/` | Business logic, JSON serialization, auth repositories, validators, Dio error mappers, image compression | > 85% |
| **Widget Tests** | `test/ui/` | Reusable UI library: buttons, text inputs, dropdowns, cards, badges, dialogs, bottom sheets, navigation bars, shimmer | 100% of ADA components |
| **Workflow Tests** | `test/integration/app_workflows_test.dart` | Headless execution of all 13 mandatory application scenarios | 13 of 13 scenarios |
| **On-Device Integration** | `integration_test/app_test.dart` | Hardware/simulator end-to-end execution on Android & iOS | Critical smoke paths |
| **API Automated Tests** | `docs/postman/` | Automated Newman / Postman collections testing live/mock REST endpoints | Positive, negative & SLA |

---

## 3. Mandatory Integration Scenarios (Doc Section 5.3)

The starter kit implements and validates all 13 mandatory application workflows in `test/integration/app_workflows_test.dart` and `integration_test/app_test.dart`:

1. **User Registration**: Form input validation, repository creation, token emission.
2. **User Login**: Valid credential verification, session token storage.
3. **Invalid Credentials**: Error state propagation, user feedback message.
4. **Forgot Password**: Password reset email trigger.
5. **Logout**: Session termination, secure token clearance, redirect.
6. **Profile Update**: Display name and avatar state changes.
7. **Image Upload**: Compression pipeline integration and upload trigger.
8. **API Data Loading**: Paginated remote fetch and deserialization.
9. **Form Submission**: Input validation and optimistic state dispatch.
10. **Screen Navigation**: Deep-linking and GoRouter stack transitions.
11. **Session Expiration**: Unauthorized token rejection and guard redirect.
12. **Internet Disconnection**: Offline mode handling via `ConnectivityService`.
13. **App Lifecycle Behavior**: Background pause and foreground resume observer.

---

## 4. API Testing with Postman & Newman (Doc Section 5.4)

The Postman collection is located at `docs/postman/DummyJSON.postman_collection.json`.

### Scenarios Covered
- **Positive Tests**: Successful authentication, paginated product retrieval, query search.
- **Negative & Error Tests**: Missing parameters (400), invalid credentials (401), missing routes (404), expired tokens (401/403).
- **Performance SLA**: Response duration assertion (`pm.expect(responseTime).to.be.below(2000)`).
- **Multipart Upload**: File upload verification (`/api/upload`).

### Automated CLI Execution via Newman
Install Newman globally and run the collection with reporting:

```bash
npm install -g newman newman-reporter-htmlextra

# Run test collection
newman run docs/postman/DummyJSON.postman_collection.json \
  -e docs/postman/DummyJSON.postman_environment.json \
  --reporters cli,htmlextra \
  --reporter-htmlextra-export test_reports/api_test_report.html
```

---

## 5. Tool Evaluation & Selection Rationale (Doc Section 5.8)

In accordance with Section 5.8 of the technical assignment, candidate testing tools were evaluated:

| Tool | Evaluation Summary | Selection Decision | Rationale |
|---|---|---|---|
| **Flutter Test (`flutter_test`)** | Official Flutter unit and widget testing harness. Fast, headless, built-in assertion framework. | **Selected (Core)** | Standard across the Flutter ecosystem. Zero external overhead, instant feedback in local dev and CI. |
| **Flutter Integration Test (`integration_test`)** | Official package for driving tests on real Android/iOS devices or emulators. | **Selected (Core)** | Standardized driver for on-device regression testing and performance benchmarking. |
| **Patrol** | Third-party framework by LeanCode providing native dialog automation (location, camera permissions). | **Evaluated (Optional Add-on)** | Excellent for projects with heavy native OS dialogs. Kept optional to avoid locking client projects into extra native Gradle dependencies unless required. |
| **Postman / Newman** | Industry standard API testing and automation CLI. | **Selected (Core)** | Allows QA teams and developers to share and execute identical collections locally and in CI/CD pipelines. |
| **Firebase Test Lab** | Cloud-hosted test grid for physical Android and iOS devices. | **Evaluated (Enterprise Tier)** | Recommended for pre-release client sign-off. Not required for day-to-day starter kit development to minimize cloud costs. |
| **BrowserStack** | Commercial cloud testing matrix across thousands of real mobile devices. | **Evaluated (Enterprise Tier)** | High subscription cost. Recommended only when client project SLA explicitly mandates testing across 50+ legacy device models. |
| **GitHub Actions** | Built-in cloud CI/CD runner. | **Selected (Core)** | Seamless integration, matrix builds, automated test gates on every pull request. |

---

## 6. Automated Test Reports & CI/CD Pipeline (Doc Section 5.9)

### Local Test Report Generation
```bash
# Output machine-readable JSON report
flutter test --reporter json > test_reports/report.json

# Output human-readable expanded terminal report
flutter test --reporter expanded
```

### GitHub Actions CI
The CI workflow at `.github/workflows/flutter_ci.yml` automatically:
1. Provisions Flutter stable environment with dependency caching.
2. Generates localization classes from ARB files.
3. Enforces static code quality with `flutter analyze`.
4. Executes the full suite of unit, widget, and workflow tests on every PR.
