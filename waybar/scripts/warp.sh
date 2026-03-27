#!/bin/bash
# Get the status from warp-cli
STATUS=$(warp-cli status | grep "Status update:" | awk '{print $3}')

if [ "$STATUS" = "Connected" ]; then
    # Change the icon/text for connected state
    echo '{"text": " 󰌆 ", "class": "connected", "tooltip": "WARP Connected"}'

elif [ "$STATUS" = "Connecting" ]; then
    # Change the icon/text for connecting state
    echo '{"text": " 󰿂 ", "class": "connecting", "tooltip": "Connecting"}'
else
    # Change the icon/text for disconnected state
    echo '{"text": "  ", "class": "disconnected", "tooltip": "WARP Disconnected"}'
fi

