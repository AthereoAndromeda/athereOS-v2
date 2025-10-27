local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.color_scheme = "Catppuccin Mocha"
-- config.window_decorations = "INTEGRATED_BUTTONS"
config.enable_wayland = true
config.integrated_title_button_style = "Gnome"

config.window_background_opacity = 0.8

config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}


return config
