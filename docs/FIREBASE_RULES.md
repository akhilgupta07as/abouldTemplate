# Firebase security rules (development)

Project: **adaproject-d13b2**. Tighten before production.

Files in repo root: **`firestore.rules`**, **`storage.rules`**.

---

## Firestore

Firebase Console → **Firestore Database → Rules** → paste → **Publish**:

```text
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /ada_config/{document=**} {
      allow read, write: if request.auth != null;
    }
    match /users/{userId}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /todo/{todoId} {
      allow read, update, delete: if request.auth != null
        && resource.data.userref == request.auth.uid;
      allow create: if request.auth != null
        && request.resource.data.userref == request.auth.uid;
    }
  }
}
```

| Path | Used for |
|------|----------|
| `users/{uid}/workspace/config` | Dashboard workspace message |
| `users/{uid}/profile` | Profile / avatar URL |
| `todo/{id}` | Todos (`userref`, `todoname`, `iscompleted`, `createdAt`) |
| `ada_config/*` | Legacy (optional) |

**Index:** If todos fail to load, create composite index **`todo`**: `userref` Asc + `createdAt` Desc (use link in app/log).

---

## Storage

Firebase Console → **Storage → Rules** → paste → **Publish**:

```text
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /users/{userId}/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

Profile avatars: `users/{uid}/avatars/...`

---

## Other services

- **Cloud Messaging** — no rules; enable in console.
- **Analytics / Crashlytics** — enable under **Build** in console.

---

## App requirements

- Sign in with **Firebase** (not DummyJSON API) for Firestore/Storage.
- **Authentication → Sign-in method → Email/Password** enabled.
