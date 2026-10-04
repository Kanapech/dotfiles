#!/bin/bash
# Idempotent — runs at boot (execs.lua also fires) and on live rice switch.
pgrep -x hypridle    >/dev/null || hypridle &
pgrep -x noctalia    >/dev/null || setsid -f noctalia >/dev/null 2>&1
pgrep -x easyeffects >/dev/null || easyeffects --hide-window --service-mode &
exit 0
