# Zokii Studio v5 Web

Static frontend for GitHub Pages. It contains no ADMIN_SECRET. The admin password is sent only over HTTPS to `/api/admin/login`; the server validates it against the server environment secret and returns a short-lived signed session token.

Before deployment, set `window.ZOKII_API_URL` in a small `config.js` loaded before `admin.js`, or replace the example value in `admin.js`. Never commit credentials.
