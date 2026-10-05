#!/bin/bash
# Runs once at boot and once per live switch (single-owner rule).
# Restart semantics: stop, then start — no pgrep guards, no sleeps.

# ── Bar + notifications: always fresh (config may have changed) ──
systemctl --user stop waybar.service swaync.service \
                   'app-*waybar*' 'app-*swaync*' 2>/dev/null || true
pkill -x waybar swaync 2>/dev/null || true
uwsm app -- waybar
uwsm app -- swaync

# ── Remote access: wait for the tray host ON THE BUS (deterministic),
#    then restart so the SNI icon registers ──
gdbus wait --session --timeout 5 org.kde.StatusNotifierWatcher 2>/dev/null || true
systemctl --user restart sunshine.service

# ── Wallpaper ──
pkill -x hyprpaper 2>/dev/null || true
uwsm app -- hyprpaper

# ── Idle daemon (Hyprland-only: its listeners drive hyprctl) ──
if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    pkill -x hypridle 2>/dev/null || true
    uwsm app -- hypridle
fi

# ── Clipboard history ──
pkill -f 'wl-paste --type .* --watch' 2>/dev/null || true
wl-paste --type text  --watch cliphist store >/dev/null 2>&1 &
wl-paste --type image --watch cliphist store >/dev/null 2>&1 &
exit 0
