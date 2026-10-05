#!/bin/bash
# Boot + live-switch path, runs under Hyprland AND Umbriel. Idempotent.

# Desktop shell
pgrep -x noctalia >/dev/null || setsid -f noctalia >/dev/null 2>&1

# Idle daemon: hypridle only exists under Hyprland (it drives hyprctl dpms);
# under Umbriel, Noctalia's built-in idle handles locking/screensleep.
if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    pgrep -x hypridle >/dev/null || setsid -f hypridle >/dev/null 2>&1
fi

# Audio
pgrep -x easyeffects >/dev/null || setsid -f easyeffects --hide-window --service-mode >/dev/null 2>&1
exit 0
