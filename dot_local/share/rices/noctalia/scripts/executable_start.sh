#!/bin/bash
# Boot + live-switch path, runs under Hyprland AND Umbriel. Idempotent.

# Desktop shell
pgrep -x noctalia >/dev/null || setsid -f noctalia >/dev/null 2>&1

systemctl --user restart sunshine.service

# Idle daemon: hypridle only exists under Hyprland (it drives hyprctl dpms);
# under Umbriel, Noctalia's built-in idle handles locking/screensleep.
if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    pkill -x hypridle 2>/dev/null || true
    setsid -f hypridle >/dev/null 2>&1
fi

exit 0
