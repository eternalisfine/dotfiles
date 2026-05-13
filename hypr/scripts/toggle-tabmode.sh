#!/usr/bin/env bash
# ~/.config/hypr/scripts/toggle-tabmode.sh
# Toggles tab mode on the current workspace only

STATE_FILE="/tmp/hypr_tabmode"
TILED_FILE="/tmp/hypr_tabmode_tiled"
MODE_CONF="$HOME/.config/hypr/mode.conf"
W=1918
H=1053
X=1
Y=26

snap_window() {
  local addr="$1"
  hyprctl dispatch resizewindowpixel "exact $W $H,address:$addr"
  hyprctl dispatch movewindowpixel "exact $X $Y,address:$addr"
}

enter_tab_mode() {
  local ws
  ws=$(hyprctl activeworkspace -j | jq '.id')
  touch "$STATE_FILE"

  # Rules for new windows opened while in tab mode
  cat >"$MODE_CONF" <<EOF
windowrule = float on, match:class .*
windowrule = size $W $H, match:class .*
windowrule = move $X $Y, match:class .*
EOF

  # Save tiled windows on current workspace only
  hyprctl clients -j | jq -r --argjson ws "$ws" \
    '.[] | select(.workspace.id == $ws and .floating == false) | .address' \
    >"$TILED_FILE"

  hyprctl reload
  sleep 0.2

  # Float and snap originally tiled windows
  while read -r addr; do
    hyprctl dispatch togglefloating "address:$addr"
    sleep 0.05
    snap_window "$addr"
  done <"$TILED_FILE"

  # Snap already-floating windows on this workspace
  hyprctl clients -j | jq -r --argjson ws "$ws" \
    '.[] | select(.workspace.id == $ws and .floating == true) | .address' |
    while read -r addr; do
      snap_window "$addr"
    done

  notify-send "Tab Mode" "ON — Super+Shift+Tab to exit" -t 1500
}

exit_tab_mode() {
  # Restore only originally tiled windows on this workspace
  if [[ -f "$TILED_FILE" ]]; then
    while read -r addr; do
      local is_floating
      is_floating=$(hyprctl clients -j | jq -r \
        --arg addr "$addr" \
        '.[] | select(.address == $addr) | .floating')
      if [[ "$is_floating" == "true" ]]; then
        hyprctl dispatch togglefloating "address:$addr"
      fi
    done <"$TILED_FILE"
    rm -f "$TILED_FILE"
  fi

  rm -f "$STATE_FILE"
  true >"$MODE_CONF"
  hyprctl reload

  notify-send "Tiling Mode" "ON" -t 1500
}

resnap() {
  local addr
  addr=$(hyprctl activewindow -j | jq -r '.address')
  snap_window "$addr"
}

case "${1:-toggle}" in
toggle)
  if [[ -f "$STATE_FILE" ]]; then
    exit_tab_mode
  else
    enter_tab_mode
  fi
  ;;
snap)
  resnap
  ;;
esac
