#!/bin/bash
pkill -x ironbar || true
pkill -x swaync || true

CONFIG="$HOME/.local/share/rices/default/ironbar/config.toml"

if ! test -f "$CONFIG"; then
    echo "ERROR: inronbar config not found: $CONFIG"
    exit 1
fi

uwsm app -- ironbar -c "$CONFIG"
uwsm app -- swaync
