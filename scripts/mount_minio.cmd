@echo off
set RCLONE_EXE=C:\Tools\rclone\rclone.exe

echo Mounting MinIO staging to X: ...
start "" "%RCLONE_EXE%" mount minio-staging:/ X: --vfs-cache-mode full --links

echo Mounting MinIO images to Y: ...
start "" "%RCLONE_EXE%" mount minio-images:/ Y: --vfs-cache-mode full --links

echo Mounting MinIO videos to Z: ...
start "" "%RCLONE_EXE%" mount minio-videos:/ Z: --vfs-cache-mode full --links
