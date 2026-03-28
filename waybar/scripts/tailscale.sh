#!/bin/bash

STATUS=$(tailscale status --json | python3 -c "import sys,json; print(json.load(sys.stdin)['BackendState'])")

if [ "$STATUS" = "Running" ]; then
    sudo tailscale down
    notify-send "Tailscale" "Disconnected"
else
    warp-cli connect
    sleep 2
    sudo tailscale up
    notify-send "Tailscale" "Connected"
fi
