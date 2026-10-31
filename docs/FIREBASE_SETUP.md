# Firebase setup — Abould ADA

Project: **adaProject** (`adaproject-d13b2`)  
Android package: `com.example.ada`

## Configured in this repo

| Service | Location |
|---------|----------|
| Core init | `modules/firebase/firebase_initializer.dart` |
| Auth | `modules/authentication/data/firebase_auth_repository.dart` |
| Firestore | `modules/firebase/services/firestore_service.dart` |
| Storage | `modules/firebase/services/firebase_storage_service.dart` |
| FCM | `modules/firebase/services/firebase_messaging_service.dart` |
| Analytics | `modules/firebase/services/firebase_analytics_service.dart` |
| Crashlytics | `modules/firebase/services/firebase_crashlytics_service.dart` |
| Android config | `android/app/google-services.json` |

Bootstrap: `AppBindings` → `FirebaseInitializer` → `FirebaseBootstrap.configure()`.

## Firebase Console checklist

1. **Authentication → Sign-in method** → enable **Email/Password**.
2. **Firestore Database** → create database (start in test mode, then apply rules in [FIREBASE_RULES.md](FIREBASE_RULES.md)).
3. **Storage** → get started, apply rules from [FIREBASE_RULES.md](FIREBASE_RULES.md).
4. **Cloud Messaging** — enabled by default for the project.
5. **Analytics** — enabled with Google Analytics linking (recommended).
6. **Crashlytics** — open Crashlytics in console once to finish activation.

## Run on Android

```bash
flutter pub get
flutter run
```

## App features using Firebase

- **Dashboard** — reads/writes `users/{uid}/workspace/config` in Firestore, shows FCM token preview.
- **Profile** — camera icon uploads avatar to Storage + saves URL in `users/{uid}/profile`.
- **Login** — logs Analytics `login` event.
- **Firebase CRUD demo** — `ada_demo/{uid}/items` (see [FIREBASE_CRUD.md](FIREBASE_CRUD.md)).

## Tests / CI

```bash
flutter test --dart-define=USE_FIREBASE=false
```

Uses no-op Firebase services + `FakeAuthRepository`.

## iOS (later)

Register iOS app, add `GoogleService-Info.plist`, run `flutterfire configure`.

## Optional next

- Google Sign-In (SHA-1 + OAuth client)
- Remote Config feature flags
- Deep links for password reset / email verification
