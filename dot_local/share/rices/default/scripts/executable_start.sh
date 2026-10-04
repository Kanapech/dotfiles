#!/bin/bash
# Runs at boot (template hook) and on live rice switch.

# Bar + notifications — restart fresh (their config just changed)
systemctl --user stop 'app-waybar*' 'app-swaync*' 2>/dev/null || true
pkill -x waybar 2>/dev/null || true
pkill -x swaync 2>/dev/null || true
uwsm app -- waybar
uwsm app -- swaync

# Rice daemons — guarded (at boot, execs.lua already started them)
pgrep -x hypridle  >/dev/null || uwsm app -- hypridle
pgrep -x hyprpaper >/dev/null || uwsm app -- hyprpaper

# Clipboard history watchers
pgrep -f 'wl-paste --type text'  >/dev/null || wl-paste --type text  --watch cliphist store >/dev/null 2>&1 &
pgrep -f 'wl-paste --type image' >/dev/null || wl-paste --type image --watch cliphist store >/dev/null 2>&1 &
exit 0
