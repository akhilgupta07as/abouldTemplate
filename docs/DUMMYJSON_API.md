# DummyJSON API integration

Base URL: `https://dummyjson.com` (default in `AppConfig`).

## Auth

- **Login:** `POST /auth/login`  
  Body: `{ "username", "password", "expiresInMins": 60 }`
- **Demo user:** `emilys` / `emilyspass` (see [dummyjson.com/users](https://dummyjson.com/users))
- Tokens stored in secure storage; `Authorization: Bearer` added by Dio interceptor.
- **Refresh:** `POST /auth/refresh` with `{ "refreshToken", "expiresInMins" }` — used on app startup when `/auth/me` fails, and automatically on HTTP 401 via `TokenRefreshInterceptor`.

Switch auth backend:

```bash
flutter run --dart-define=AUTH_BACKEND=dummyjson
flutter run --dart-define=AUTH_BACKEND=firebase
```

## HTTP verb modules (Users)

Each verb has its own module under `lib/modules/api_integration/http/`:

| Module | Class | DummyJSON examples |
|--------|--------|-------------------|
| GET | `ApiGetModule` | `GET /users`, `/users/{id}`, `/users/search` |
| POST | `ApiPostModule` | `POST /users/add` |
| PUT | `ApiPutModule` | `PUT /users/{id}` |
| PATCH | `ApiPatchModule` | `PATCH /users/{id}` |
| DELETE | `ApiDeleteModule` | `DELETE /users/{id}` |

`UsersRepository` composes all five. Demo screen: **Dashboard → HTTP verbs** (`/api-http-demo`).

POST/PUT/PATCH/DELETE are **simulated** on DummyJSON (response only, not persisted).

## Products (listing + pagination)

- **List:** `GET /products?limit=10&skip=0`
- **Search:** `GET /products/search?q=phone&limit=10&skip=0`

App route: **Dashboard → API Integration** or **Browse products (API)**.

## Code

- `DioApiClient` — HTTP client
- `DummyJsonAuthRepository` — login/session
- `ProductsRepository` — paginated catalog
