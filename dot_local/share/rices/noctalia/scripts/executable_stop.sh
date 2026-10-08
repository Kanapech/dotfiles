#!/bin/bash
# Idempotent teardown. NEVER kill lockers here (remote-access machine).
pkill -x noctalia 2>/dev/null
pkill -x hypridle 2>/dev/null
i=0; while { pgrep -x noctalia >/dev/null || pgrep -x hypridle >/dev/null; } && [ $i -lt 6 ]; do
    sleep 0.5; i=$((i+1))
done
pkill -KILL -x noctalia 2>/dev/null
pkill -KILL -x hypridle 2>/dev/null
exit 0
