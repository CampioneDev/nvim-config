return {
  'akinsho/bufferline.nvim',
  enabled = not vim.g.vscode,
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local catppuccin_highlights = require('catppuccin.special.bufferline').get_theme {
      -- custom = {
      --   all = {
      --     separator = {
      --       fg = 'NONE',
      --       bg = 'NONE',
      --     },
      --   },
      -- },
    }

    -- print(vim.inspect(catppuccin_highlights()))

    local bufferline = require 'bufferline'
    bufferline.setup {
      options = {
        always_show_bufferline = false,
        auto_toggle_bufferline = true,
        mode = 'tabs',
        numbers = 'ordinal',
        show_close_icon = false,
        show_buffer_close_icons = false,
        diagnostics = 'nvim_lsp',
        style_preset = bufferline.style_preset.no_italic,
        -- separator_style = 'slanted',
      },
      highlights = catppuccin_highlights,
    }
  end,
}
