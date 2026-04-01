#!/bin/bash
pkill -x --wait ashell || true
pkill -x --wait swaync || true

CONFIG="$HOME/.local/share/rices/default-ashell/ashell/config.toml"

if ! test -f "$CONFIG"; then
    echo "ERROR: ashell config not found: $CONFIG"
    exit 1
fi
 uwsm app -- ashell --config-path "$CONFIG"
 uwsm app -- swaync
