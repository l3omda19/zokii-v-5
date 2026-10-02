# Zokii Studio v5 API

Deploy this directory to any Node.js host with PostgreSQL (Render, Railway, Fly.io, VPS, etc.). Do not deploy it as a GitHub Pages static site.

1. Create PostgreSQL and run `schema.sql`.
2. Set `DATABASE_URL`, `ADMIN_SECRET`, `SESSION_SECRET`, and `CORS_ORIGIN` as server environment variables.
3. Run `npm install --omit=dev` then `npm start`, or use the included Dockerfile.
4. Put the HTTPS API base ending in `/api` into Android `AppConfig.LICENSE_API_URL`.

Never commit `.env`, secrets, database passwords, or session secrets.
