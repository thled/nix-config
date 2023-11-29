local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then config = wezterm.config_builder() end

config.font = wezterm.font 'Cascadia Code'
config.font_size = 14.0

config.color_scheme = 'Tomorrow Night'
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.scrollback_lines = 10000

config.keys = {
  {
    key = 's',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },
}

return config
