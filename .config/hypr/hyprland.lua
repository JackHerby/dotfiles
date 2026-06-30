-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
  output = "DP-1",
  mode = "3440x1440@180",
  position = "0x0",
  scale = 1,
})
hl.monitor({
  output = "DP-2",
  mode = "2560x1440@200",
  position = "-1440x0",
  scale = 1,
  transform = 3,
})
hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@60",
  position = "-3360x0",
  scale = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "kitty"
local browser = "brave"
local fileManager = "thunar"
local menu = "rofi -show drun"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("hyprpm reload -n")
  hl.exec_cmd(terminal, { workspace = 1 })
  hl.exec_cmd(browser, { workspace = 2 })
  hl.exec_cmd("steam", { workspace = 3 })
  hl.exec_cmd(terminal .. " -e btop", { workspace = 4 })
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env(
  "PATH",
  os.getenv("HOME")
    .. "/.local/share/fnm/aliases/default/bin:"
    .. os.getenv("HOME")
    .. "/.bun/bin:"
    .. os.getenv("PATH")
)

---------------------
---- PERMISSIONS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 8,

    border_size = 1,

    col = {
      active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },

    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false,

    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing = false,

    layout = "master",
  },

  decoration = {
    rounding = 0,
    rounding_power = 0,

    -- Change transparency of focused and unfocused windows
    active_opacity = 0.98,
    inactive_opacity = 0.95,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = 0xee1a1a1a,
    },

    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
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

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
  dwindle = {
    preserve_split = true, -- You probably want this
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
  master = {
    new_status = "master",
    mfact = 0.66,
    orientation = "right",
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

hl.config({
  layout = {
    single_window_aspect_ratio = { 16, 9 },
  },
})

hl.config({
  cursor = {
    inactive_timeout = 5,
    no_hardware_cursors = true,
    no_warps = true,
  },
})

----------------
----  MISC  ----
----------------

hl.config({
  misc = {
    disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
    font_family = "0xProto Nerd Font",
    force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
  },
})

---------------
---- INPUT ----
---------------

hl.config({
  input = {
    follow_mouse = 2,
    kb_layout = "pl, us",
    kb_model = "pc105",
    kb_options = "caps:swapescape",
    kb_rules = "",
    kb_variant = "",
    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
    touchpad = { natural_scroll = false },
  },
})

hl.gesture({
  action = "workspace",
  direction = "horizontal",
  fingers = 3,
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- See https://wiki.hypr.land/Configuring/Basics/Binds/ for more

-- Launch programs
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + b", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + e", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + i", hl.dsp.exec_cmd("networkmanager_dmenu"))
hl.bind(mainMod .. " + k", hl.dsp.window.close())
hl.bind(mainMod .. " + n", hl.dsp.exec_cmd("neovide"))
hl.bind(mainMod .. " + p", hl.dsp.exec_cmd("pavucontrol"))
hl.bind(mainMod .. " + r", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + print", hl.dsp.exec_cmd('grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png'))
hl.bind(
  mainMod .. " + SHIFT + print",
  hl.dsp.exec_cmd(
    "grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name') ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png"
  )
)

-- Layout actions
hl.bind(mainMod .. " + m", hl.dsp.layout("mfact exact 0.66"))
hl.bind(mainMod .. " + w", hl.dsp.layout("swapwithmaster master"))
hl.bind(mainMod .. " + bracketleft", hl.dsp.layout("swapprev"))
hl.bind(mainMod .. " + bracketright", hl.dsp.layout("swapnext"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))

-- Move window with mainMod + SHIFT + arrow keys
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))

-- Resize active window with mainMod + CTRL + arrow keys
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 8, relative = true }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -8, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 8, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -8, relative = true }))

-- Switch workspaces with mainMod + [1-6]
-- Move active window to a workspace with mainMod + SHIFT + [1-6]
for i = 1, 6 do
  hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + s", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + s", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),
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

-- Misc
hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen({ action = "toggle", mode = "maximized" }))
hl.bind(mainMod .. " + l", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + v", hl.dsp.window.float({ action = "toggle" }))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
hl.workspace_rule({
  workspace = 1,
  default_name = " Dev",
  monitor = "DP-1",
  persistent = true,
})
hl.workspace_rule({
  workspace = 2,
  default_name = "󰖟 Misc",
  monitor = "DP-1",
  persistent = true,
})
hl.workspace_rule({
  workspace = 3,
  default_name = "󰊴 Gaming",
  monitor = "DP-1",
  persistent = true,
})
hl.workspace_rule({
  workspace = 4,
  default_name = " Btop",
  monitor = "DP-1",
  persistent = true,
})
hl.workspace_rule({
  workspace = 5,
  default_name = "󰆡 Portrait",
  monitor = "DP-2",
  persistent = true,
  layout_opts = { orientation = "bottom" },
})
hl.workspace_rule({
  workspace = 6,
  default_name = "󰔂 TV",
  monitor = "HDMI-A-1",
  persistent = true,
})

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
  -- Fix some dragging issues with XWayland
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

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
  name = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move = "20 monitor_h-120",
  float = true,
})

hl.window_rule({
  name = "windowrule-brave",
  match = { class = "^(brave-browser)$" },
  opacity = "1.0 override",
})

hl.window_rule({
  name = "windowrule-firefox",
  match = { initial_title = "^(Mozilla Firefox)$" },
  opacity = "1.0 override",
})

hl.window_rule({
  name = "windowrule-float",
  match = { float = true },
  center = true,
})

hl.window_rule({
  name = "float-apps",
  match = { title = "^(Bluetooth|Volume Control)$" },
  float = true,
})

hl.window_rule({
  name = "steam-workspace",
  match = { class = "^(steam)$" },
  workspace = 3,
  no_initial_focus = true,
})
