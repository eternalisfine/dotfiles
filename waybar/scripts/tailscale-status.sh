#!/bin/bash
STATUS=$(tailscale status --json | python3 -c "import sys,json; print(json.load(sys.stdin)['BackendState'])")

if [ "$STATUS" = "Running" ]; then
    echo '{"text": " 󰣫 ", "class": "connected", "tooltip": "Tailscale Connected"}'
elif [ "$STATUS" = "Starting" ]; then
    echo '{"text": " 󱨓 ", "class": "connecting", "tooltip": "Tailscale Connecting"}'
else
    echo '{"text": " 󱏗 ", "class": "disconnected", "tooltip": "Tailscale Disconnected"}'
fi




