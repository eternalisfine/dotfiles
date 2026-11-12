-- ~/.config/hypr/hyprland.lua
-- Converted from hyprland.conf, checked against the current wiki (Hyprland 0.57).
-- 0.57 no longer reads .conf files at all, so every file this config pulls in must be Lua.
--
-- Files this config expects (the old .conf versions need converting):
--   ~/.config/themes/current/hyprland.lua  -> returns { active_border_1, active_border_2, inactive_border }
--   ~/.config/hypr/monitors.lua            -> plain hl.monitor(...) calls
--   ~/.config/hypr/mode.lua                -> written by toggle-tabmode.sh

---------------------
---- THEME COLORS ----
---------------------

-- Was: source = ~/.config/themes/current/hyprland.conf  ($active_border_1 etc.)
-- Falls back to Hyprland's default colors if the theme file is missing or broken,
-- so a bad theme file doesn't stop the rest of the config (and autostart) from loading.
local ok, theme = pcall(dofile, os.getenv("HOME") .. "/.config/themes/current/hyprland.lua")
if not ok or type(theme) ~= "table" then
	theme = {
		active_border_1 = "rgba(33ccffee)",
		active_border_2 = "rgba(00ff99ee)",
		inactive_border = "rgba(595959aa)",
	}
end

------------------
---- MONITORS ----
------------------

-- Was: source = ~/.config/hypr/monitors.conf
-- dofile (not require) so the file is re-run on every reload instead of cached.
pcall(dofile, os.getenv("HOME") .. "/.config/hypr/monitors.lua")

-- fallback
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "kitty"
local fileManager = "dolphin"
local menu = "wofi --show drun"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("swaybg -i ~/.config/themes/current/active_wallpaper")
	hl.exec_cmd("brightnessctl")
	hl.exec_cmd("hyprlock")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'catppuccin-mocha-red-standard+default'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'breeze_cursors'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 24")
	hl.exec_cmd("swaync")
	hl.exec_cmd("quickshell")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("wl-paste --watch cliphist store")
	hl.exec_cmd("hypridle")
	-- hl.exec_cmd("kanshi")
	-- hl.exec_cmd("nwg-dock-hyprland -r")
	-- hl.exec_cmd("nwg-dock-hyprland -p bottom -i 32 -mb 6 -d")
end)

-- blur and transparency for the dock
-- hl.layer_rule({ match = { namespace = "nwg-dock" }, blur = true })

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = { top = 5, right = 0, bottom = 0, left = 0 },

		border_size = 1,

		col = {
			active_border = { colors = { theme.active_border_1, theme.active_border_2 }, angle = 90 },
			inactive_border = theme.inactive_border,
		},

		-- Set to true enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		allow_tearing = false,

		layout = "master",
	},

	decoration = {
		rounding = 10,
		rounding_power = 10,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1,
		inactive_opacity = 0.7,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},

		blur = {
			enabled = true,
			size = 4,
			passes = 3,
			vibrancy = 0.1696,
			new_optimizations = true,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Default curves
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default animations
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- "Smart gaps" / "No gaps when only" (uncomment all if you wish to use that)
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ match = { float = false, workspace = "f[1]" },   border_size = 0, rounding = 0 })

-- hl.config({
--     dwindle = {
--         preserve_split = true,
--     },
-- })

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
		key_press_enables_dpms = true,
		mouse_move_enables_dpms = true,
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0.5, -- -1.0 - 1.0, 0 means no modification.

		accel_profile = "flat", -- removing mouse acceleration

		touchpad = {
			natural_scroll = true,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Per-device config
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -1.0,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle

-- Notifications
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("swaync-client -t"))

-- Screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region")) -- region
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window -m active")) -- active window
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output")) -- monitor

-- Btop
hl.bind(
	"CTRL + SHIFT + Escape",
	hl.dsp.exec_cmd("pgrep -x btop && pkill -x btop || " .. terminal .. " --class btop_monitor -e btop")
)

-- Alt-Tab switcher
hl.bind("ALT + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)
hl.bind("ALT + SHIFT + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next({ next = false }))
	hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)

-- Was: source = ~/.config/hypr/mode.conf
-- toggle-tabmode.sh now writes mode.lua. dofile (not require) so it re-runs on every
-- reload; a missing file is fine, it just means tab mode is off.
pcall(dofile, os.getenv("HOME") .. "/.config/hypr/mode.lua")
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-tabmode.sh"))

-- Brightness control
-- (the same keys are bound again below with 5% steps; both fire)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 10%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"))

-- Larp
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("kitty --hold -e fastfetch"))

-- Reload waybar
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("~/.config/waybar/scripts/launch.sh"))

-- Run hyprlock
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Turn screen off (after a 1s delay so the key release doesn't wake it straight away)
hl.bind(mainMod .. " + SHIFT + L", function()
	hl.timer(function()
		hl.dispatch(hl.dsp.dpms({ action = "disable" }))
	end, { timeout = 1000, type = "oneshot" })
end)

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Workspaces 11-20 on mainMod + SHIFT + Q W E R T Y U I O P
local extraKeys = { "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P" }
for i, key in ipairs(extraKeys) do
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.focus({ workspace = 10 + i }))
end

-- Special workspace (scratchpad)
-- NOTE: mainMod + SHIFT + S is also the hyprshot region bind above; both fire.
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Clearing cache
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("kitty --hold -e ~/.local/bin/clear-cache.sh"))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Floating tile for calendar
hl.window_rule({
	name = "gsimplecal",
	match = { class = "^(gsimplecal)$" },

	float = true,
	move = "830 30",
	pin = true,
})

-- Ignore maximize requests from apps.
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Btop: keep it floating and centered
hl.window_rule({
	name = "btop-monitor",
	match = { title = "^(btop_monitor)$" },

	float = true,
	size = "1000 600",
	center = true,
})

-- Common save dialogs and pickers float
hl.window_rule({
	name = "float-dialogs",
	match = { title = "^(Save As|Volume Control|Open File|Open Folder)$" },

	float = true,
})

hl.window_rule({
	name = "center-file-upload",
	match = { title = "^(File Upload)$" },

	center = true,
})

-- Floating + centered: hyprshot, swappy, and common utilities
hl.window_rule({
	name = "float-center-utilities",
	match = { class = "^(hyprshot|swappy|pavucontrol|blueman-manager|nm-connection-editor)$" },

	float = true,
	center = true,
})
