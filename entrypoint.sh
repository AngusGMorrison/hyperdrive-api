#!/bin/bash
set -e

# Remove any pre-existing server.pid for rails
rm -f /app/tmp/pids/server.pid

# Exec the container's CMD process
exec "$@"