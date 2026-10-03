#!/usr/bin/env bash
# ─── Catppuccin Mocha (Red) ───────────────────────────────────────────────────
# Single source of truth for all theme colors.
# Every other theme file is derived from these values.

# Accent colors
ACCENT="#e93a46"     # primary red accent
ACCENT2="#f07080"    # softer pink/red accent
ACCENT_HYPR="e93a46" # no # prefix, for hyprland rgba() values

# Base colors
DARK="#242424"     # dark background (network, clipboard, tailscale)
DARK_HYPR="242424" # no # prefix

# Supporting colors
ORANGE="#f38020" # warp accent, battery warning
GREY="#6e6e6e"   # muted/disabled state
WHITE="#ffffff"

# Hyprland border (rgba format, no #)
BORDER_ACTIVE_1="ffffff5f" # first gradient color
BORDER_ACTIVE_2="ff0000aa" # second gradient color (red)
BORDER_INACTIVE="595959aa"

# GTK / Desktop
GTK_THEME="catppuccin-mocha-red-standard+default"
ICON_THEME="Papirus-Dark"
CURSOR_THEME="breeze_cursors"
CURSOR_SIZE="24"

# Wallpaper
WALLPAPER="$HOME/.config/themes/tokyo-ghoul-red/active_wallpaper"
