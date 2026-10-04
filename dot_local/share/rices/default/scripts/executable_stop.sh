#!/bin/bash
# Teardown for live switch. Idempotent. Never kills lockers.

# 1) uwsm-managed instances: stop the units (the clean way — no restart races)
systemctl --user stop 'app-waybar*' 'app-swaync*' 'app-hyprpaper*' 'app-hypridle*' 2>/dev/null || true

# 2) Plain instances: by name
pkill -x waybar   2>/dev/null || true
pkill -x swaync   2>/dev/null || true
pkill -x hyprpaper 2>/dev/null || true
pkill -x hypridle  2>/dev/null || true
pkill -f 'wl-paste --type text --watch'  2>/dev/null || true
pkill -f 'wl-paste --type image --watch' 2>/dev/null || true

# 3) Escalate: whatever ignored SIGTERM gets SIGKILL
sleep 0.5
pkill -KILL -x waybar 2>/dev/null || true
pkill -KILL -x swaync 2>/dev/null || true
pkill -KILL -x hyprpaper 2>/dev/null || true
pkill -KILL -x hypridle 2>/dev/null || true
exit 0
