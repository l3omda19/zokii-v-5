# Zokii Studio v5

Production-oriented Android GTA tool manager with a server-authoritative 3-day license system and a separate static admin website.

## Repository

- `app/` Android client. `AppConfig.java` is the single public API configuration point.
- `api/` Node.js + Express + PostgreSQL license API.
- `web/` GitHub Pages-compatible public/admin UI. It contains no private secret.
- `app/src/main/assets/rpfengine/` supplied RPF conversion engine assets retained from the uploaded project.

## 1. Database

Create PostgreSQL database and run:

```bash
psql "$DATABASE_URL" -f api/schema.sql
```

## 2. API

```bash
cd api
cp .env.example .env
npm install
npm start
```

Set on the server only:

```text
ADMIN_SECRET=CHANGE_THIS_ON_SERVER
DATABASE_URL=postgres://USER:PASSWORD@HOST:5432/zokii
SESSION_SECRET=CHANGE_THIS_TO_A_LONG_RANDOM_SECRET
CORS_ORIGIN=https://YOUR-USERNAME.github.io
```

Do not put any of these in Android, GitHub Pages, or public JavaScript.

### Endpoints

Public:
- `GET /api/health`
- `POST /api/license/activate` body `{ "code":"ZK-XXXXXXXXXXXX", "device_id":"..." }`
- `POST /api/license/verify` body `{ "code":"...", "device_id":"..." }` or `{ "code_hash":"sha256...", "device_id":"..." }`

Admin (Bearer session token):
- `POST /api/admin/login`
- `GET /api/admin/licenses`
- `POST /api/admin/licenses/create`
- `POST /api/admin/licenses/revoke`
- `POST /api/admin/licenses/delete`
- `POST /api/admin/licenses/extend`
- `POST /api/admin/licenses/reset-device`

The server uses database-backed rate limits for login, activation, and verification.

## 3. Android API URL

Edit exactly one line:

`app/src/main/java/com/zokii/rpf/AppConfig.java`

```java
public static final String LICENSE_API_URL = "https://YOUR-API-DOMAIN.example.com/api";
```

Also set `LICENSE_GET_URL` to the public license page.

The APK stores only a SHA-256 license hash, expiry, device UUID, server timestamp, and last successful verification. The cached license cannot be verified offline after a reboot; online server verification is required again. During the same boot, the configurable offline grace period is limited to six hours by default.

## 4. Android build

The uploaded project was AIDE-oriented and therefore retains a conservative Android Gradle Plugin 3.5.3 / compile SDK 28 setup for compatibility with the original project. The app itself supports Android 5.0+ and runs on Android 13. For a modern CI migration, update AGP/Gradle/compileSdk together rather than changing one value alone.

Open the root project in AIDE/Android Studio and build `app`. The package is `com.zokii.studio.v5`.

## 5. GitHub Pages

Push the repository to GitHub. Enable Pages with **GitHub Actions**. The workflow at `.github/workflows/pages.yml` publishes `web/`.

Before publishing, configure the API origin in `web/admin.js` or add a generated `web/config.js` loaded before it. `web/config.js` is ignored by Git.

## 6. Tool behavior

RPF Studio performs actual RPF7 parsing/extraction/building using the Java engine retained from the uploaded project. Add/replace operations use a real local workspace; the user then builds the workspace into a new RPF7. PC→PS4 uses the supplied structural converter for its supported resource extensions. Unsupported conversion formats are not reported as successful.
