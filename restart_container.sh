#!/bin/bash

set -e

# Đường dẫn docker
DOCKER=/usr/bin/docker

# Container ID hoặc tên
CONTAINER="4b7"

echo "======================================"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Restart Docker Container"
echo "User      : $(whoami)"
echo "Docker    : $($DOCKER --version)"
echo "Container : $CONTAINER"
echo "======================================"

# Kiểm tra docker
if ! $DOCKER info >/dev/null 2>&1; then
    echo "ERROR: Cannot connect to Docker daemon."
    exit 1
fi

# Kiểm tra container
if ! $DOCKER inspect "$CONTAINER" >/dev/null; then
    echo "ERROR: Container '$CONTAINER' does not exist."
    exit 1
fi

# Lấy log path
LOG_PATH=$($DOCKER inspect --format='{{.LogPath}}' "$CONTAINER")

echo "Log path: $LOG_PATH"

# Xóa log
if [ -f "$LOG_PATH" ]; then
    truncate -s 0 "$LOG_PATH"
    echo "✓ Docker log cleared."
else
    echo "WARNING: Log file not found."
fi

# Restart container
echo "Restarting container..."
$DOCKER restart "$CONTAINER"

echo "✓ Container restarted successfully."
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Completed."
