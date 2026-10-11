#!/usr/bin/env bash
# ─── Green Pond Theme ────────────────────────────────────────────────────────
# Single source of truth for all theme colors.

# Accent colors (Algae green / Leaf light)
ACCENT="#74c10f"     # primary pond green accent
ACCENT2="#aee36b"    # soft leaf-light accent
ACCENT_HYPR="74c10f" # no # prefix, for hyprland rgba() values

# Base colors
DARK="#0c1109"     # dark forest background
DARK_HYPR="0c1109" # no # prefix

# Supporting colors
ORANGE="#f38020" # warp accent, battery warning
GREY="#5f6b50"   # muted/disabled state
WHITE="#ffffff"

# Hyprland border (rgba format, no #)
BORDER_ACTIVE_1="ffffff80" # translucent sky white
BORDER_ACTIVE_2="74c10fbb" # pond green
BORDER_INACTIVE="253613aa"

# GTK / Desktop
GTK_THEME="catppuccin-mocha-blue-standard+default"
ICON_THEME="Papirus-Dark"
CURSOR_THEME="breeze_cursors"
CURSOR_SIZE="24"

# Wallpaper
WALLPAPER="$HOME/.config/themes/green-pond/wallpapers/wallpaper.jpg"
MONITOR="eDP-1"
