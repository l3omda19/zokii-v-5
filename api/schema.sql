CREATE TABLE IF NOT EXISTS licenses (
 id BIGSERIAL PRIMARY KEY,
 code TEXT NOT NULL UNIQUE,
 code_hash CHAR(64) NOT NULL UNIQUE,
 status TEXT NOT NULL DEFAULT 'unused' CHECK(status IN ('unused','active','expired','revoked')),
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
 activated_at TIMESTAMPTZ,
 expires_at TIMESTAMPTZ,
 device_id TEXT,
 updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS licenses_status_idx ON licenses(status);
CREATE INDEX IF NOT EXISTS licenses_device_idx ON licenses(device_id);
CREATE TABLE IF NOT EXISTS rate_limits (
 key TEXT PRIMARY KEY,
 window_start TIMESTAMPTZ NOT NULL,
 count INTEGER NOT NULL DEFAULT 0
);
