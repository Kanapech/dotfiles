#!/bin/bash
# Runs at boot (template hook) and on live rice switch. Idempotent.

# ── Bar + notifications: restart fresh (their config just changed) ──
systemctl --user stop 'app-waybar*' 'app-swaync*' 2>/dev/null || true
pkill -x waybar 2>/dev/null || true
pkill -x swaync 2>/dev/null || true

# Bounded wait until actually gone — the relaunch must not race a dying process
for i in 1 2 3 4; do
    pgrep -x waybar >/dev/null || pgrep -x swaync >/dev/null || break
    sleep 0.5
done
uwsm app -- waybar  2>/dev/null || setsid -f waybar
uwsm app -- swaync  2>/dev/null || setsid -f swaync

# ── Rice daemons — guarded for idempotency (boot + switch both land here).
#    start.sh is their SINGLE owner: execs.lua no longer starts these. ──
if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    pgrep -x hypridle >/dev/null || uwsm app -- hypridle 2>/dev/null || setsid -f hypridle
    pgrep -x hyprpaper   >/dev/null || uwsm app -- hyprpaper 2>/dev/null || setsid -f hyprpaper
fi

# ── Clipboard history watchers ──
pgrep -f 'wl-paste --type text'  >/dev/null || wl-paste --type text  --watch cliphist store >/dev/null 2>&1 &
pgrep -f 'wl-paste --type image' >/dev/null || wl-paste --type image --watch cliphist store >/dev/null 2>&1 &
exit 0
