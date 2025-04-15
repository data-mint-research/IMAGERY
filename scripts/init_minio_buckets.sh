#!/bin/bash

# MinIO Zugangsdaten
USER="minio"
PASS="minio123"

# Nur EIN Alias über den echten API-Port (9000)
mc alias set minio http://localhost:9000 $USER $PASS

# Buckets anlegen (idempotent)
mc mb minio/staging || true
mc mb minio/images  || true
mc mb minio/videos  || true
