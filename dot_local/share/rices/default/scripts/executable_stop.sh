#!/bin/bash
# Teardown. systemd stops are synchronous and an explicit stop never
# triggers Restart= → no waits, no escalation loops.
# Never kills lockers (remote-access box).
# Deliberately untouched: easyeffects, gnome-keyring, sunshine (shared/lifeline).

systemctl --user stop \
    waybar.service swaync.service \
    'app-*waybar*' 'app-*swaync*' 'app-*hyprpaper*' 'app-*hypridle*' \
    2>/dev/null || true

# Strays not living in a unit (TERM is enough for these)
pkill -x waybar swaync hyprpaper hypridle 2>/dev/null || true
pkill -f 'wl-paste --type .* --watch' 2>/dev/null || true
exit 0
