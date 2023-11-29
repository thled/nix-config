local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font 'Cascadia Code'
config.font_size = 14.0

config.color_scheme = 'Tomorrow Night'

config.use_fancy_tab_bar = false

return config
