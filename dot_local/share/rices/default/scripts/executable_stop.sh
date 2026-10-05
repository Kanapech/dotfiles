#!/bin/bash
# Teardown for live switch. Idempotent. Never kills lockers (remote-access box).
# Deliberately not killed: easyeffects, gnome-keyring, sunshine (shared / lifeline).
# Compositor-agnostic by nature — absent processes are no-ops.

# 1) uwsm-managed instances: stop the units (the clean way — no restart races)
systemctl --user stop 'app-waybar*' 'app-swaync*' 'app-hyprpaper*' 'app-hypridle*' 2>/dev/null || true

# 2) Plain instances: by name/pattern
pkill -x waybar    2>/dev/null || true
pkill -x swaync    2>/dev/null || true
pkill -x hyprpaper 2>/dev/null || true
pkill -x hypridle  2>/dev/null || true
pkill -f 'wl-paste --type text --watch'  2>/dev/null || true
pkill -f 'wl-paste --type image --watch' 2>/dev/null || true

# 3) Bounded wait until ACTUALLY gone — the next rice's pgrep guards must not
#    see a dying process and skip launching (max ~2s, cannot hang)
for i in 1 2 3 4; do
    pgrep -x waybar >/dev/null || pgrep -x swaync >/dev/null \
        || pgrep -x hyprpaper >/dev/null || pgrep -x hypridle >/dev/null || break
    sleep 0.5
done

# 4) Escalate: whatever ignored SIGTERM gets SIGKILL
pkill -KILL -x waybar   2>/dev/null || true
pkill -KILL -x swaync   2>/dev/null || true
pkill -KILL -x hyprpaper 2>/dev/null || true
pkill -KILL -x hypridle  2>/dev/null || true
exit 0
