# Abould ADA — Reference Node.js & Express.js Backend

Reference implementation for **Workstream 3: Backend and API Integration Framework** of the Abould ADA specification.

This server provides production-pattern REST endpoints with authentication, token refresh, input validation, multipart file upload, and standardized JSON envelopes.

---

## Features

- **Standardized Responses**:
  - Success envelope: `{ "success": true, "data": ... }`
  - Error envelope: `{ "success": false, "error": { "code": "...", "message": "..." } }`
- **Authentication**: JWT token issuance and refresh token rotation (`/api/auth/*`).
- **Data & Pagination**: Filtering, search, limit, and skip parameters (`/api/products`).
- **File Upload**: Multipart form-data with size limits and disk storage (`/api/upload`).
- **Error Handling**: Centralized 404 and 500 middleware.

---

## Quick Start

```bash
cd backend
npm install
npm start
```

The server starts by default on `http://localhost:3000`.

---

## Endpoints

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| `GET` | `/health` | No | Service health and timestamp |
| `POST` | `/api/auth/register` | No | Register new user; returns JWT + refresh token |
| `POST` | `/api/auth/login` | No | Authenticate user; returns JWT + refresh token |
| `POST` | `/api/auth/refresh-token` | No | Exchange valid refresh token for a new JWT |
| `GET` | `/api/products` | No | Paginated product listing (`?limit=10&skip=0&q=phone`) |
| `GET` | `/api/products/:id` | No | Get single product by id |
| `POST` | `/api/products` | **Bearer JWT** | Create product |
| `POST` | `/api/upload` | **Bearer JWT** | Upload file (multipart field name `file`) |

---

## Connecting from Flutter

Set `apiBaseUrl` in `dart_defines/*.json` or `AppConfig`:

```json
{
  "API_BASE_URL": "http://10.0.2.2:3000"
}
```
*(Use `10.0.2.2` for Android emulator or your local machine IP for physical devices).*
