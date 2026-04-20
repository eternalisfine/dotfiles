#!/bin/bash

BATTERY_PATH="/sys/class/power_supply/BAT0"
LEVEL=$(cat "$BATTERY_PATH/capacity")
STATUS=$(cat "$BATTERY_PATH/status")

if [ "$STATUS" != "Discharging" ]; then
    exit 0
fi

if [ "$LEVEL" -eq 5 ]; then
    notify-send -u critical "🔋 CRITICAL Battery" "Battery at ${LEVEL}%! Plug in now!" -t 0
elif [ "$LEVEL" -eq 15 ]; then
    notify-send -u critical "🔋 Low Battery" "Battery at ${LEVEL}%" -t 10000
elif [ "$LEVEL" -eq 20 ]; then
    notify-send -u normal "🔋 Battery Low" "Battery at ${LEVEL}%" -t 5000
fi
