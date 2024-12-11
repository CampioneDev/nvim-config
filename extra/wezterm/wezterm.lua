local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

-- CC: it doesn't make any sense to me since my monitor is 60 Hz, but...
-- https://www.reddit.com/r/neovim/comments/1gthknw/wezterm_max_fps_240_is_crazy/
config.max_fps = 240

local is_windows = package.config:sub(1, 1) == '\\'

local emulate_tmux = true

config.initial_cols = 132
config.initial_rows = 43
-- config.window_decorations = "RESIZE"
config.window_padding = {
  left = '0cell',
  right = '0cell',
  top = '0cell',
  bottom = '0cell',
}
config.window_background_opacity = is_windows and 0 or 0.975
config.win32_system_backdrop = 'Mica'

config.hide_tab_bar_if_only_one_tab = emulate_tmux == false
config.use_fancy_tab_bar = false

config.color_scheme = 'Catppuccin Mocha'
config.bold_brightens_ansi_colors = 'BrightAndBold'

config.font_size = is_windows and 9.0 or 12.0
config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })

-- CC: this affects the command palette (and the fancy bar if enabled)
config.window_frame = {
  font = config.font,
  --   font_size = 8.0,
  --   active_titlebar_bg = "#333333",
}
config.command_palette_font_size = config.font_size

config.font_rules = {
  {
    intensity = 'Normal',
    font = wezterm.font {
      family = 'JetBrains Mono',
      weight = 'Medium',
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
  {
    intensity = 'Bold',
    font = wezterm.font {
      family = 'JetBrains Mono',
      weight = 'ExtraBold',
    },
  },
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font {
      family = 'JetBrains Mono',
      weight = 'ExtraBold',
      style = 'Italic',
    },
  },
}

if emulate_tmux then
  if is_windows then
    -- local cwd_path = os.getenv 'CAMPIONE_PROJECTS_PATH' or os.getenv 'PROFILE'
    config.default_prog = { 'pwsh.exe', '-NoLogo' } -- , '-wd', cwd_path }
  end

  config.tab_bar_at_bottom = true

  config.leader = { key = 'b', mods = 'CTRL' }
  config.disable_default_key_bindings = true
  config.keys = {
    -- Send "CTRL-B" to the terminal when pressing CTRL-B, CTRL-B
    { key = 'b', mods = 'LEADER|CTRL', action = act { SendString = '\x02' } },
    { key = ':', mods = 'LEADER|SHIFT', action = act.ActivateCommandPalette },
    { key = 'R', mods = 'LEADER|SHIFT', action = act.ReloadConfiguration },
    {
      key = '"',
      mods = 'LEADER|SHIFT',
      action = act { SplitVertical = { domain = 'CurrentPaneDomain' } },
    },
    {
      key = '%',
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
    { key = 'p', mods = 'LEADER|CTRL', action = act.ActivateTabRelative(-1) },
    { key = 'n', mods = 'LEADER|CTRL', action = act.ActivateTabRelative(1) },
    { key = 'b', mods = 'LEADER', action = act.ActivateLastTab },
    { key = 'x', mods = 'LEADER', action = act { CloseCurrentPane = { confirm = true } } },
    -- { key = "&", mods = "LEADER|SHIFT", action = act({ CloseCurrentTab = { confirm = true } }) },

    -- { key = 'u', mods = 'LEADER', action = act.ScrollByPage(-0.5) },
    -- { key = 'd', mods = 'LEADER', action = act.ScrollByPage(0.5) },
    { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },

    -- { key = "n", mods = "SHIFT|CTRL", action = "ToggleFullScreen" },
    { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    -- { key = "+", mods = "SHIFT|CTRL", action = "IncreaseFontSize" },
    -- { key = "-", mods = "SHIFT|CTRL", action = "DecreaseFontSize" },
    -- { key = "0", mods = "SHIFT|CTRL", action = "ResetFontSize" },
  }

  --- smart-splits

  local smart_splits = wezterm.plugin.require 'https://github.com/mrjones2014/smart-splits.nvim'

  smart_splits.apply_to_config(config, {
    -- the default config is here, if you'd like to use the default keys,
    -- you can omit this configuration table parameter and just use
    -- smart_splits.apply_to_config(config)

    -- directional keys to use in order of: left, down, up, right
    direction_keys = { 'h', 'j', 'k', 'l' },
    -- if you want to use separate direction keys for move vs. resize, you
    -- can also do this:
    -- direction_keys = {
    --   move = { 'h', 'j', 'k', 'l' },
    --   resize = { 'LeftArrow', 'DownArrow', 'UpArrow', 'RightArrow' },
    -- },
    -- modifier keys to combine with direction_keys
    modifiers = {
      move = 'CTRL', -- modifier to use for pane movement, e.g. CTRL+h to move left
      resize = 'META', -- modifier to use for pane resize, e.g. META+h to resize to the left
    },
  })

  ---

  local resurrect = wezterm.plugin.require 'https://github.com/MLFlexer/resurrect.wezterm'

  for _, binding in ipairs {
    {
      key = 's',
      mods = 'LEADER|CTRL',
      action = wezterm.action_callback(function(_, _)
        resurrect.save_state(resurrect.workspace_state.get_workspace_state())
      end),
    },
    {
      key = 'r',
      mods = 'LEADER|CTRL',
      action = wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_load(win, pane, function(id, _)
          local type = string.match(id, '^([^/]+)') -- match before '/'
          id = string.match(id, '([^/]+)$') -- match after '/'
          id = string.match(id, '(.+)%..+$') -- remove file extention
          local opts = {
            relative = true,
            restore_text = true,
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
          }
          if type == 'workspace' then
            local state = resurrect.load_state(id, 'workspace')
            resurrect.workspace_state.restore_workspace(state, opts)
          elseif type == 'window' then
            local state = resurrect.load_state(id, 'window')
            resurrect.window_state.restore_window(pane:window(), state, opts)
          elseif type == 'tab' then
            local state = resurrect.load_state(id, 'tab')
            resurrect.tab_state.restore_tab(pane:tab(), state, opts)
          end
        end)
      end),
    },
    {
      key = 'd',
      mods = 'LEADER|CTRL',
      action = wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_load(win, pane, function(id)
          resurrect.delete_state(id)
        end, {
          title = 'Delete State',
          description = 'Select State to Delete and press Enter = accept, Esc = cancel, / = filter',
          fuzzy_description = 'Search State to Delete: ',
          is_fuzzy = true,
        })
      end),
    },
  } do
    table.insert(config.keys, binding)
  end

  local workspace_switcher = wezterm.plugin.require 'https://github.com/MLFlexer/smart_workspace_switcher.wezterm'

  ---@diagnostic disable-next-line: unused-local
  wezterm.on('augment-command-palette', function(window, pane)
    local workspace_state = resurrect.workspace_state
    return {
      {
        brief = 'Window | Workspace: Switch Workspace',
        icon = 'md_briefcase_arrow_up_down',
        action = workspace_switcher.switch_workspace(),
      },
      {
        brief = 'Window | Workspace: Rename Workspace',
        icon = 'md_briefcase_edit',
        action = wezterm.action.PromptInputLine {
          description = 'Enter new name for workspace',
          ---@diagnostic disable-next-line: unused-local
          action = wezterm.action_callback(function(window, pane, line)
            if line then
              wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
              resurrect.save_state(workspace_state.get_workspace_state())
            end
          end),
        },
      },
    }
  end)
end

return config
