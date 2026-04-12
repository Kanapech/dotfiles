#!/usr/bin/env bash

# Battery
enable_battery=false
battery_charging=false

for battery in /sys/class/power_supply/*BAT*; do
  if [[ -f "$battery/uevent" ]]; then
    enable_battery=true
    if [[ $(cat /sys/class/power_supply/*/status | head -1) == "Charging" ]]; then
      battery_charging=true
    fi
    break
  fi
done

if [[ $enable_battery == true ]]; then
  if [[ $battery_charging == true ]]; then
    echo -n "(+) "
  fi
  echo -n "$(cat /sys/class/power_supply/*/capacity | head -1)%"
  if [[ $battery_charging == false ]]; then
    echo -n " remaining"
  fi
  echo -n "  |  "
fi

# Network
iface=$(ip route get 1.1.1.1 2>/dev/null | awk '{print $5; exit}')
if [[ -n "$iface" ]]; then
  echo -n "  $(ip -4 addr show "$iface" | awk '/inet/{print $2}' | cut -d/ -f1)"
else
  echo -n "  No network"
fi

echo ''
