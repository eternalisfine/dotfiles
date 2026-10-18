#!/usr/bin/env bash
# ─── Gojo Theme ──────────────────────────────────────────────────────────────
# Single source of truth for all theme colors.

# Accent colors (Bright white / Smoke grey)
ACCENT="#f4f4f4"     # primary bright white accent
ACCENT2="#9e9e9e"    # soft smoke-grey accent
ACCENT_HYPR="f4f4f4" # no # prefix, for hyprland rgba() values

# Base colors
DARK="#090909"     # dark void background
DARK_HYPR="090909" # no # prefix

# Supporting colors
ORANGE="#f38020" # warp accent, battery warning
GREY="#5e5e5e"   # muted/disabled state
WHITE="#ffffff"

# Hyprland border (rgba format, no #)
BORDER_ACTIVE_1="ffffff80" # translucent white
BORDER_ACTIVE_2="f4f4f4bb" # bright white
BORDER_INACTIVE="262626aa"

# GTK / Desktop
GTK_THEME="catppuccin-mocha-blue-standard+default"
ICON_THEME="Papirus-Dark"
CURSOR_THEME="breeze_cursors"
CURSOR_SIZE="24"

# Wallpaper
WALLPAPER="$HOME/.config/themes/gojo/wallpapers/wallpaper.jpg"
MONITOR="eDP-1"
