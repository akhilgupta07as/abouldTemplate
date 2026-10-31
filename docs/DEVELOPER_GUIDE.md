# Internal Developer Guide — Abould ADA

This guide provides complete instructions for developers at Abould to initialize, configure, develop, test, and build client applications using the **Application Development Accelerator (ADA)** starter kit. It directly covers the **17 mandatory topics** specified in **Workstream 6: Internal Developer Documentation**.

---

## 1. Project Architecture
The project follows a modular, feature-first clean architecture:
- `lib/core/`: Foundation layer (DI, routing, theme tokens, storage, error boundaries).
- `lib/modules/`: Standalone, plug-and-play feature modules (Authentication, REST API, Firebase, Supabase, UI Components).
- `lib/features/`: Client screens and workflows.
- Detailed architecture and Riverpod selection rationale are documented in [ARCHITECTURE.md](./ARCHITECTURE.md).

---

## 2. How to Initialize a New Flutter Project
To bootstrap a new client application from this starter kit:
1. Clone the repository into your new client project directory:
   ```bash
   git clone <repo-url> client_app
   cd client_app
   ```
2. Rename the package in `pubspec.yaml` (set `name: client_app`).
3. Update bundle identifiers:
   - Android: `android/app/build.gradle.kts` -> update `applicationId`.
   - iOS: Open `ios/Runner.xcodeproj` in Xcode and set Bundle Identifier.
4. Run bootstrap commands:
   ```bash
   flutter pub get
   flutter gen-l10n
   ```

---

## 3. How to Configure Firebase
1. Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
2. Add an Android app and download `google-services.json` into `android/app/`.
3. Add an iOS app and download `GoogleService-Info.plist` into `ios/Runner/`.
4. Enable Firebase services in your environment defines or `AppConfig`:
   ```json
   {
     "USE_FIREBASE": true
   }
   ```
5. Deploy Firestore and Storage security rules:
   ```bash
   firebase deploy --only firestore:rules,storage
   ```
   *(See [FIREBASE_SETUP.md](./FIREBASE_SETUP.md) and [FIREBASE_RULES.md](./FIREBASE_RULES.md) for full instructions).*

---

## 4. How to Configure Supabase
1. Copy the example defines file:
   ```bash
   cp dart_defines/supabase.local.json.example dart_defines/supabase.local.json
   ```
2. Fill in your project keys:
   ```json
   {
     "SUPABASE_URL": "https://xyzcompany.supabase.co",
     "SUPABASE_PUBLISHABLE_KEY": "sb_publishable_xxxx",
     "SUPABASE_ANON_KEY": "anon_key_xxxx"
   }
   ```
3. Run the SQL schema migrations located in `supabase/migrations/` in the Supabase SQL editor.
   *(See [SUPABASE.md](./SUPABASE.md) for table schemas and Row Level Security setup).*

---

## 5. How to Integrate REST APIs
1. Use the centralized HTTP client [`DioApiClient`](../lib/modules/api_integration/services/dio_api_client.dart).
2. Set `API_BASE_URL` in `AppConfig` or `dart_defines/`.
3. For endpoints, create a dedicated data source file in `lib/modules/api_integration/data/`:
   ```dart
   final response = await dioClient.get('/products');
   final list = (response.data['products'] as List)
       .map((json) => ProductModel.fromJson(json))
       .toList();
   ```
4. For multipart uploads:
   ```dart
   await dioClient.uploadFile('/api/upload', filePath: file.path, fieldName: 'file');
   ```

---

## 6. How to Implement Authentication
The authentication module supports multiple interchangeable backends via [`AuthRepositoryRegistry`](../lib/modules/authentication/data/auth_repository_registry.dart):
- Set `authBackend` in `AppConfig` to `AuthBackend.firebase`, `AuthBackend.supabase`, or `AuthBackend.dummyJson`.
- UI pages for Login, Register, Forgot Password, Reset Password, OTP Verification, and Email Verification are ready out of the box in `lib/modules/authentication/presentation/`.

---

## 7. How to Use Reusable UI Components
All ADA components use the centralized design tokens defined in `lib/core/theme/`:
```dart
import 'package:abould_ada/modules/ui_components/ui_components.dart';

// Buttons
AdaPrimaryButton(label: 'Submit', onPressed: () => submit());
AdaLoadingButton(label: 'Save', isLoading: state.isLoading, onPressed: save);

// Form Fields
AdaTextField(label: 'Username', controller: userCtrl);
AdaPasswordField(label: 'Password', controller: passCtrl);

// Feedback
AdaDialogs.confirm(context, title: 'Confirm', message: 'Proceed?');
AdaSnackbar.show(context, 'Changes saved successfully.');
```
*(Browse the live component catalog by running the app and tapping **UI Components** on the Dashboard).*

---

## 8. How to Configure Environments
Environments (`development`, `staging`, `production`) are configured using compile-time Dart defines:
```bash
# Run Development
flutter run --dart-define=ENVIRONMENT=development --dart-define=API_BASE_URL=https://dev-api.client.com

# Run Production
flutter run --release --dart-define=ENVIRONMENT=production --dart-define=API_BASE_URL=https://api.client.com
```

---

## 9. How to Run Unit Tests
```bash
flutter test test/api/ test/modules/ test/core/
```

---

## 10. How to Run Widget Tests
```bash
flutter test test/ui/
```

---

## 11. How to Run Integration Tests
```bash
# Headless CI Workflow integration tests (no device required)
flutter test test/integration/app_workflows_test.dart

# On-device integration tests (physical phone or emulator required)
flutter test integration_test/app_test.dart
```

---

## 12. How to Execute API Test Collections
Run the automated Postman test collection via the Newman CLI:
```bash
npm install -g newman newman-reporter-htmlextra

newman run docs/postman/DummyJSON.postman_collection.json \
  -e docs/postman/DummyJSON.postman_environment.json \
  --reporters cli,htmlextra \
  --reporter-htmlextra-export test_reports/api_report.html
```

---

## 13. How to Generate Test Reports
```bash
# Machine-readable JSON output
flutter test --reporter json > test_reports/test_report.json

# HTML Coverage Report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
# Open coverage/html/index.html in your browser
```

---

## 14. How to Debug Common Issues
| Issue | Cause | Solution |
|---|---|---|
| `No file or variants found for asset: dart_defines/supabase.local.json` | Asset defined in `pubspec.yaml` missing locally. | Run `cp dart_defines/supabase.local.json.example dart_defines/supabase.local.json`. |
| `context.l10n throws null pointer` | Widget pumped without localizations delegate. | Include `AppLocalizations.localizationsDelegates` in test widget harness. |
| `Location permission denied` | Missing OS manifest entry or runtime permission. | Check `AndroidManifest.xml` / `Info.plist` and call `LocationService.requestPermission()`. |
| `DioException 401 Unauthorized` | Expired access token or invalid secret. | Check `TokenRefreshInterceptor` and secure storage token entries. |

---

## 15. How to Generate Android APK & AAB
```bash
# 1. Generate release APK
flutter build apk --release

# 2. Generate Google Play App Bundle (AAB)
flutter build appbundle --release
```
Artifacts are generated in `build/app/outputs/flutter-apk/` and `build/app/outputs/bundle/release/`.

---

## 16. How to Prepare Production Builds
1. Create an upload keystore:
   ```bash
   keytool -genkey -v -keystore android/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```
2. Reference the keystore in `android/key.properties` (gitignored):
   ```properties
   storePassword=your_store_password
   keyPassword=your_key_password
   keyAlias=upload
   storeFile=../upload-keystore.jks
   ```
3. Enable R8 code shrinking and obfuscation in `android/app/build.gradle.kts`.

---

## 17. How to Configure CI/CD Pipelines
The starter kit includes a production GitHub Actions CI pipeline at `.github/workflows/flutter_ci.yml`.

### Configuring GitHub Secrets
Add the following under **Repository Settings -> Secrets and variables -> Actions**:
- `FIREBASE_SERVICE_ACCOUNT`: Base64 encoded GCP service account key.
- `ANDROID_KEYSTORE_BASE64`: Base64 encoded release keystore.
- `KEYSTORE_PASSWORD`, `KEY_ALIAS`, `KEY_PASSWORD`: Signing credentials.
