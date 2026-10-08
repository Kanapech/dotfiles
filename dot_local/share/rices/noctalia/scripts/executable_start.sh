#!/bin/bash
# Boot + live-switch path, runs under Hyprland AND Umbriel. Idempotent.

# ── Desktop shell: stop any instance fully, then start fresh ──
pkill -x noctalia 2>/dev/null
i=0; while pgrep -x noctalia >/dev/null && [ $i -lt 6 ]; do sleep 0.5; i=$((i+1)); done
pkill -KILL -x noctalia 2>/dev/null
setsid -f noctalia >/dev/null 2>&1

# ── Deterministic readiness: the shell answers IPC (implies tray is up) ──
i=0
while [ $i -lt 30 ]; do
    noctalia msg status >/dev/null 2>&1 && break
    i=$((i+1)); sleep 0.5
done

systemctl --user restart sunshine.service

# ── Idle daemon: Hyprland-only (its listeners drive hyprctl dpms);
#    under Umbriel, Noctalia's built-in idle owns locking/screensleep. ──
if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    pkill -x hypridle 2>/dev/null
    setsid -f hypridle >/dev/null 2>&1
fi

exit 0
