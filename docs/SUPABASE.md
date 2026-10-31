# Supabase setup (Abould ADA)

This app uses **supabase_flutter** for optional **email/password auth** alongside Firebase and DummyJSON API login.

**Project URL (default in code):** `https://fenywyyvxwebgihuqvyt.supabase.co`

## Security — read this first

| Key | Use in Flutter app? |
|-----|---------------------|
| **Publishable** (`sb_publishable_…`) | Yes — preferred for client apps |
| **Anon** (JWT, `role: anon`) | Yes — alternative to publishable |
| **Service role** (JWT, `role: service_role`) | **Never** — server/backend only. Do not paste into the app, git, or chat. If exposed, **rotate it** in Supabase → Project Settings → API. |

## 1. Supabase dashboard

In **Authentication → Sign In / Providers**:

- Enable **Email**
- **Confirm email**: turn **OFF** for instant sign-up (recommended for this demo). The app skips the verify-email screen when Supabase returns a session.
- **Allow new users to sign up** for registration

## 2. Local run (recommended)

1. Copy `dart_defines/supabase.local.json.example` → `dart_defines/supabase.local.json` (gitignored).
2. Put your **publishable** or **anon** key in that file — not the service role key.
3. Run:

```bash
flutter run --dart-define-from-file=dart_defines/supabase.local.json
```

In **VS Code / Cursor**, use the launch config **“ADA (Supabase local defines)”**.

### Manual dart-define

```bash
flutter run ^
  --dart-define=SUPABASE_URL=https://fenywyyvxwebgihuqvyt.supabase.co ^
  --dart-define=SUPABASE_PUBLISHABLE_KEY=sb_publishable_xxxx
```

You can use `SUPABASE_ANON_KEY` instead of `SUPABASE_PUBLISHABLE_KEY` if you prefer the JWT anon key.

## 3. Database + Realtime (CRUD)

In **SQL Editor**, run the migration:

- `supabase/migrations/001_ada_tasks.sql` — `ada_tasks` with `title` + Realtime  
- `supabase/migrations/002_profiles_and_simplify_tasks.sql` — `profiles` user table + trigger; migrates old `english`/`hindi` columns if present

If Realtime does not update live, open **Database → Publications** (or the table’s Realtime toggle) and ensure `ada_tasks` is enabled.

## 4. In-app flows

- **Login** → **Supabase** → email + password
- **Create account** → **Supabase** → verify email when confirm-email is enabled
- **Dashboard → Supabase** → auth status + **Realtime tasks** (insert/update/delete syncs across devices)

Tasks use a single **title** field (no auto-translation on this screen).

## 5. Code map

| Piece | Path |
|-------|------|
| Init | `lib/modules/supabase/supabase_initializer.dart` |
| Auth repo | `lib/modules/authentication/data/supabase_auth_repository.dart` |
| Tasks CRUD + stream | `lib/modules/supabase/data/supabase_tasks_repository.dart` |
| Providers | `lib/modules/supabase/di/supabase_crud_providers.dart` |
| Demo screen | `lib/features/supabase_demo/presentation/supabase_demo_page.dart` |
