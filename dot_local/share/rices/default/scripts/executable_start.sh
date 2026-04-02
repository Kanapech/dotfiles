#!/bin/bash
pkill -x --wait ironbar || true
pkill -x --wait swaync || true

uwsm app -- ironbar
uwsm app -- swaync
