cat /sys/class/leds/input*capslock/brightness 2>/dev/null | grep -q ^1$ && echo CAPS LOCK || echo ""
