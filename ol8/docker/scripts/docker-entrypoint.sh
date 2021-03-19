#!/bin/sh

# Abort on any error (including if wait-for-it fails).
set -e

# Wait for the backend to be up, if we know where it is.
if [ -n "$WAIT_FOR_HOST" ]; then
  ${ORACLE_BASE}/wait-for-it.sh "${WAIT_FOR_HOST}:${WAIT_FOR_PORT}"
fi

# Run the main container command.
exec "$@"