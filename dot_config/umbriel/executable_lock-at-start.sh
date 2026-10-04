#!/bin/bash
# Boot lock under Umbriel: wait for Noctalia's IPC, then lock.
# If the shell never comes up, terminate the session — SDDM's greeter
# takes over (Relogin=false) instead of leaving an unlocked desktop.
for i in $(seq 1 30); do
    noctalia msg status >/dev/null 2>&1 && exec noctalia msg session lock
    sleep 0.5
done
loginctl terminate-session "$XDG_SESSION_ID"
