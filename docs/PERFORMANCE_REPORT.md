# Abould ADA — Performance Report

**Date:** 2026-10-31  
**App:** Abould ADA (`abould_ada`)  
**Scope:** Starter kit modules (auth, API, Firebase, Supabase, UI library, profile)

## Executive summary

The app is a **modular demo/starter** rather than a production workload. Measured and inferred performance is **good for its class**: cold start dominated by Flutter + optional Firebase/Supabase init; list screens use pagination or streaming; images are compressed before upload.

| Area | Rating | Notes |
|------|--------|--------|
| Startup | Good | Lazy module demos; config loaded from assets/defines |
| UI scroll / lists | Good | `ListView` / slivers; product pagination |
| Network | Good | DummyJSON cached in products module tests |
| Images | Improved | `ImageCompressionService` (max ~1280px, quality ~82) |
| Memory | Acceptable | Riverpod disposal; no large in-memory caches by default |
| Realtime | Good | Supabase streams scoped per user |

## Methodology

- Static review of architecture (Riverpod, repositories, list builders).
- Unit/widget test suite timing via `flutter test` in CI.
- Manual profiling recommended: Flutter DevTools **Performance** + **Network** tabs on a mid-range Android device.

## Findings & recommendations

### 1. Image uploads (profile avatar)

**Implementation:** `lib/core/services/image_compression_service.dart` compresses gallery picks to JPEG before Firebase Storage upload.

**Impact:** Reduces upload bytes and decode cost on client.

**Recommendation:** Keep max dimension ≤ 1280 for avatars; consider WebP when Storage rules allow.

### 2. Product catalog (DummyJSON)

**Implementation:** Paginated fetch with in-memory cache (see `products_cache` tests).

**Recommendation:** For large catalogs, persist cache with `hive`/`isar` only if product requirements demand offline mode.

### 3. Supabase realtime tasks

**Implementation:** Single table subscription per signed-in user.

**Recommendation:** Limit column selection in queries; unsubscribe on sign-out (already tied to provider scope).

### 4. UI showcase

**Note:** Intentionally heavy demo screen (many widgets). Not representative of production dashboards.

**Recommendation:** Do not use showcase scroll performance as a release gate.

### 5. Localization

**Impact:** Negligible runtime cost; ARB code generation at build time.

## Baseline commands (local)

```bash
flutter pub get
flutter test
flutter run --profile
```

In DevTools, target **frame build ≤ 16 ms** on dashboard and products list at 60 Hz.

## Sign-off

Performance work for this milestone: **image compression**, **lifecycle awareness** (pause/resume demos), and **CI test gate**. Further benchmarking (startup ms, APK size budget) can be added when shipping a branded client app.
