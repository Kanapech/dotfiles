#!/bin/bash
systemctl --user list-units --no-legend --plain --state=running \
  | awk '/app-Hyprland-ashell.*\.scope/{print $1}' \
  | xargs -r systemctl --user stop

systemctl --user stop swaync || true
