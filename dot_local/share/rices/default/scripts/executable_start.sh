#!/bin/bash
systemctl --user list-units --no-legend --plain --state=running \
  | grep -q 'app-Hyprland-ashell.*\.scope' || uwsm app -- ashell --config-path ~/.local/share/rices/default/ashell/config.toml

systemctl --user is-active --quiet swaync || uwsm app -- swaync
