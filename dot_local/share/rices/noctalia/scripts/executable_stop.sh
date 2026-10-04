#!/bin/bash
# Idempotent teardown. NEVER kill lockers here (remote-access machine).
pkill -x noctalia 2>/dev/null
pkill -x hypridle 2>/dev/null
exit 0
