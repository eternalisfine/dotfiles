#!/usr/bin/env bash
# ~/.config/hypr/scripts/toggle-tabmode.sh
# Toggles tab mode on the current workspace only
#
# Updated for the Lua config (Hyprland 0.57):
#  - hyprctl dispatch now takes Lua expressions (hl.dsp.*)
#  - the new-window rules are written to mode.lua instead of mode.conf

STATE_FILE="/tmp/hypr_tabmode"
TILED_FILE="/tmp/hypr_tabmode_tiled"
MODE_LUA="$HOME/.config/hypr/mode.lua"
W=1918
H=1053
X=1
Y=26

snap_window() {
  local addr="$1"
  hyprctl dispatch "hl.dsp.window.resize({ x = $W, y = $H, window = 'address:$addr' })"
  hyprctl dispatch "hl.dsp.window.move({ x = $X, y = $Y, window = 'address:$addr' })"
}

toggle_float() {
  local addr="$1"
  hyprctl dispatch "hl.dsp.window.float({ action = 'toggle', window = 'address:$addr' })"
}

enter_tab_mode() {
  local ws
  ws=$(hyprctl activeworkspace -j | jq '.id')
  touch "$STATE_FILE"

  # Rules for new windows opened while in tab mode
  cat >"$MODE_LUA" <<EOF
hl.window_rule({
    name  = "tabmode",
    match = { class = ".*" },

    float = true,
    size  = "$W $H",
    move  = "$X $Y",
})
EOF

  # Save tiled windows on current workspace only
  hyprctl clients -j | jq -r --argjson ws "$ws" \
    '.[] | select(.workspace.id == $ws and .floating == false) | .address' \
    >"$TILED_FILE"

  hyprctl reload
  sleep 0.2

  # Float and snap originally tiled windows
  while read -r addr; do
    toggle_float "$addr"
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
        toggle_float "$addr"
      fi
    done <"$TILED_FILE"
    rm -f "$TILED_FILE"
  fi

  rm -f "$STATE_FILE"
  true >"$MODE_LUA"
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
