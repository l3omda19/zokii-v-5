# Zokii Studio v5 API

All timestamps returned to Android are server milliseconds (`server_time`) and expiration is server-controlled.

## Activate
`POST /api/license/activate`

```json
{"code":"ZK-XXXXXXXXXXXX","device_id":"stable-installation-uuid"}
```

Success:
```json
{"valid":true,"expires_at":1791192000000,"server_time":1790931600000}
```

## Verify
The first verification may use the code; subsequent Android checks use the SHA-256 code hash:

```json
{"code_hash":"64-char-sha256","device_id":"..."}
```

## Admin login
`POST /api/admin/login`

```json
{"password":"server-secret"}
```

The response contains a short-lived signed bearer token. The secret itself is never returned or stored in the browser.

## Admin license actions
All require `Authorization: Bearer <token>`.

- `GET /api/admin/licenses`
- `POST /api/admin/licenses/create`
- `POST /api/admin/licenses/revoke` `{ "code":"..." }`
- `POST /api/admin/licenses/delete` `{ "code":"..." }`
- `POST /api/admin/licenses/extend` `{ "code":"...", "days":3 }`
- `POST /api/admin/licenses/reset-device` `{ "code":"..." }`
