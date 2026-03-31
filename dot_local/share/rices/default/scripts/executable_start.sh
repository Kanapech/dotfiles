#!/bin/bash
pkill -x ironbar || true
pkill -x swaync || true

uwsm app -- ironbar -c ~/.local/share/rices/default/ironbar/config.toml
uwsm app -- swaync
