local wezterm = require('wezterm')

local keybindings = require('keybindings')
local options = require('options')

local actions = wezterm.action
local config = wezterm.config_builder()

-- Fonts
config.font = wezterm.font(options.font_name)
config.font_size = options.font_size;

-- Window Settings
config.initial_rows = 40
config.initial_cols = 120
config.color_scheme = options.theme

-- Performance Settings
config.max_fps = 120
config.animation_fps = 30
config.enable_wayland = false
config.prefer_egl = true
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
config.window_background_opacity = options.opacity
config.enable_scroll_bar = false

config.default_prog = options.shell

-- Cursor
config.cursor_thickness = 1
config.default_cursor_style = 'BlinkingBar'

-- Tab Bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32

-- Keybindings
config.keys = keybindings

-- Mousebindings
config.mouse_bindings = {
    { event = { Down = { streak = 1, button = "Right" } },  mods = "NONE",  action = actions.CopyTo("Clipboard") },
    { event = { Down = { streak = 1, button = "Middle" } }, mods = "NONE",  action = actions.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { event = { Down = { streak = 1, button = "Middle" } }, mods = "SHIFT", action = actions.CloseCurrentPane { confirm = false } }
}

return config
