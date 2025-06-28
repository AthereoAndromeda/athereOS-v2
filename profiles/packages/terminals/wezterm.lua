local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.color_scheme = "Catppuccin Mocha"
config.window_decorations = "INTEGRATED_BUTTONS"
config.enable_wayland = true
config.integrated_title_button_style = "Gnome"

return config
