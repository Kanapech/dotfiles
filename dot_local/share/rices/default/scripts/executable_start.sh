#!/bin/bash
pkill -x ironbar || true
pkill -x swaync || true

CONFIG="$HOME/.local/share/rices/default/ironbar/config.toml"
THEME="$HOME/.local/share/rices/default/ironbar/style.css"

if ! test -f "$CONFIG"; then
    echo "ERROR: inronbar config not found: $CONFIG"
    exit 1
fi

if ! test -f "$THEME"; then
    echo "ERROR: inronbar theme not found: $THEME"
    exit 1
fi

uwsm app -- ironbar -c "$CONFIG"
uwsm app -- swaync
