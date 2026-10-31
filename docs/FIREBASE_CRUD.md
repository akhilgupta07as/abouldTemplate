# Firestore todos

## Collection: `todo` (flat — no subcollections)

Each document:

| Field | Type | Description |
|-------|------|-------------|
| `userref` | string | Firebase Auth UID |
| `todoname` | string | Todo title |
| `iscompleted` | boolean | Done or not |
| `createdAt` | timestamp | Server time on create |

Example path: `todo/abc123xyz` (not `ada_demo/{uid}/items/...`).

## Rules

See **`firestore.rules`** in the project root. Publish in Firebase Console.

Firestore may ask for a composite index: **`userref` + `createdAt` (desc)** — follow the link in the app error log.

## App

**Dashboard → Firestore todos** — add, edit (tap row or edit icon), complete, swipe to delete.

Requires **Firebase** login (not DummyJSON API).
