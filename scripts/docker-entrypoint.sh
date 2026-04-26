#!/bin/sh
set -e

# Capture runtime UID/GID from environment variables, defaulting to 1000
PUID=${USER_UID:-1000}
PGID=${USER_GID:-1000}

# Adjust the node user's UID/GID if they differ from the runtime request
# and fix volume ownership only when a remap is needed
changed=0

if [ "$(id -u node)" -ne "$PUID" ]; then
    echo "Updating node UID to $PUID"
    usermod -o -u "$PUID" node
    changed=1
fi

if [ "$(id -g node)" -ne "$PGID" ]; then
    echo "Updating node GID to $PGID"
    groupmod -o -g "$PGID" node
    usermod -g "$PGID" node
    changed=1
fi

if [ "$changed" = "1" ]; then
    chown -R node:node /paperclip
fi

# Seed Hermes Agent config on first run (HERMES_HOME=/paperclip/.hermes via env)
HERMES_HOME_DIR="${HERMES_HOME:-/paperclip/.hermes}"
HERMES_CONFIG_PATH="$HERMES_HOME_DIR/config.yaml"
HERMES_DEFAULT_CONFIG="/app/docker/hermes-config-default.yaml"
if [ ! -f "$HERMES_CONFIG_PATH" ] && [ -f "$HERMES_DEFAULT_CONFIG" ]; then
    echo "Seeding Hermes config at $HERMES_CONFIG_PATH"
    mkdir -p "$HERMES_HOME_DIR"
    cp "$HERMES_DEFAULT_CONFIG" "$HERMES_CONFIG_PATH"
    chown -R node:node "$HERMES_HOME_DIR"
fi

exec gosu node "$@"
