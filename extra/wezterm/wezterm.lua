local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

local is_windows = package.config:sub(1, 1) == '\\'

config.initial_cols = 132
config.initial_rows = 43
-- config.window_decorations = "RESIZE"
config.window_padding = {
  left = '0cell',
  right = '0cell',
  top = '0cell',
  bottom = '0cell',
}
config.window_background_opacity = 0
config.win32_system_backdrop = 'Mica'

config.tab_bar_at_bottom = true
-- config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.color_scheme = 'Catppuccin Mocha'
config.bold_brightens_ansi_colors = 'BrightAndBold'

config.font_size = 9.0
config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })
config.font_rules = {
  {
    intensity = 'Normal',
    font = wezterm.font {
      family = 'JetBrains Mono',
      weight = 'Medium',
    },
  },
  {
    intensity = 'Bold',
    font = wezterm.font {
      family = 'JetBrains Mono',
      weight = 'ExtraBold',
    },
  },
  {
    italic = true,
    -- intensity = "Half",
    font = wezterm.font {
      family = 'JetBrains Mono',
      -- weight = "Medium",
      style = 'Italic',
    },
  },
}

-- This would affect the fancy tab bar
-- config.window_frame = {
--   font = wezterm.font { family = 'JetBrainsMono Nerd Font', weight = 'Bold' },
--   font_size = 8.0,
--   -- active_titlebar_bg = "#333333",
-- }

if is_windows then
  local cwd_path = os.getenv 'CAMPIONE_PROJECTS_PATH' or os.getenv 'PROFILE'
  config.default_prog = { 'pwsh.exe', '-wd', cwd_path }

  -- CC: emulate tmux in windows
  config.leader = { key = 'b', mods = 'CTRL' }
  config.disable_default_key_bindings = true
  config.keys = {
    -- Send "CTRL-B" to the terminal when pressing CTRL-B, CTRL-B
    { key = 'b', mods = 'LEADER|CTRL', action = act { SendString = '\x02' } },
    {
      key = '%',
      mods = 'LEADER|SHIFT',
      action = act { SplitVertical = { domain = 'CurrentPaneDomain' } },
    },
    {
      key = '"',
      mods = 'LEADER|SHIFT',
      action = act { SplitHorizontal = { domain = 'CurrentPaneDomain' } },
    },
    { key = 'z', mods = 'LEADER', action = 'TogglePaneZoomState' },
    { key = 'c', mods = 'LEADER', action = act { SpawnTab = 'CurrentPaneDomain' } },
    { key = 'h', mods = 'LEADER|CTRL', action = act { ActivatePaneDirection = 'Left' } },
    { key = 'j', mods = 'LEADER|CTRL', action = act { ActivatePaneDirection = 'Down' } },
    { key = 'k', mods = 'LEADER|CTRL', action = act { ActivatePaneDirection = 'Up' } },
    { key = 'l', mods = 'LEADER|CTRL', action = act { ActivatePaneDirection = 'Right' } },
    { key = 'LeftArrow', mods = 'LEADER|ALT', action = act { AdjustPaneSize = { 'Left', 5 } } },
    { key = 'DownArrow', mods = 'LEADER|ALT', action = act { AdjustPaneSize = { 'Down', 5 } } },
    { key = 'UpArrow', mods = 'LEADER|ALT', action = act { AdjustPaneSize = { 'Up', 5 } } },
    { key = 'RightArrow', mods = 'LEADER|ALT', action = act { AdjustPaneSize = { 'Right', 5 } } },
    { key = '1', mods = 'LEADER', action = act { ActivateTab = 0 } },
    { key = '2', mods = 'LEADER', action = act { ActivateTab = 1 } },
    { key = '3', mods = 'LEADER', action = act { ActivateTab = 2 } },
    { key = '4', mods = 'LEADER', action = act { ActivateTab = 3 } },
    { key = '5', mods = 'LEADER', action = act { ActivateTab = 4 } },
    { key = '6', mods = 'LEADER', action = act { ActivateTab = 5 } },
    { key = '7', mods = 'LEADER', action = act { ActivateTab = 6 } },
    { key = '8', mods = 'LEADER', action = act { ActivateTab = 7 } },
    { key = '9', mods = 'LEADER', action = act { ActivateTab = 8 } },
    { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
    { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
    { key = 'b', mods = 'LEADER', action = act.ActivateLastTab },
    { key = 'x', mods = 'LEADER', action = act { CloseCurrentPane = { confirm = true } } },
    -- { key = "&", mods = "LEADER|SHIFT", action = act({ CloseCurrentTab = { confirm = true } }) },

    -- { key = 'u', mods = 'LEADER', action = act.ScrollByPage(-0.5) },
    -- { key = 'd', mods = 'LEADER', action = act.ScrollByPage(0.5) },
    { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },

    -- { key = "n", mods = "SHIFT|CTRL", action = "ToggleFullScreen" },
    -- { key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
    -- { key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
    -- { key = "+", mods = "SHIFT|CTRL", action = "IncreaseFontSize" },
    -- { key = "-", mods = "SHIFT|CTRL", action = "DecreaseFontSize" },
    -- { key = "0", mods = "SHIFT|CTRL", action = "ResetFontSize" },
  }
end

return config
