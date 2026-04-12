#!/bin/bash
pkill -x --wait waybar || true
pkill -x --wait swaync || true

uwsm app -- waybar
uwsm app -- swaync
