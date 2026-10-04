#!/usr/bin/env bash
# ─── Garou Theme ─────────────────────────────────────────────────────────────
# Single source of truth for all theme colors.

# Accent colors (Silver / Ink grey)
ACCENT="#b8b8b8"     # primary silver accent
ACCENT2="#e6e6e6"    # soft paper-white accent
ACCENT_HYPR="b8b8b8" # no # prefix, for hyprland rgba() values

# Base colors
DARK="#0e0e0f"     # dark ink background
DARK_HYPR="0e0e0f" # no # prefix

# Supporting colors
ORANGE="#f38020" # warp accent, battery warning
GREY="#6a6a6a"   # muted/disabled state
WHITE="#ffffff"

# Hyprland border (rgba format, no #)
BORDER_ACTIVE_1="ffffff80" # translucent paper white
BORDER_ACTIVE_2="b8b8b8bb" # silver
BORDER_INACTIVE="2a2a2aaa"

# GTK / Desktop
GTK_THEME="catppuccin-mocha-blue-standard+default"
ICON_THEME="Papirus-Dark"
CURSOR_THEME="breeze_cursors"
CURSOR_SIZE="24"

# Wallpaper
WALLPAPER="$HOME/.config/themes/garou/wallpapers/wallpaper.jpg"
MONITOR="eDP-1"
