return {
  {
    'Exafunction/codeium.vim',
    enabled = false,
    event = 'BufEnter',
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-J>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true })

      -- vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      -- vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      -- vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end,
  },
  {
    'github/copilot.vim',
    enabled = false,
    config = function()
      -- vim.g.copilot_assume_mapped = true
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {
        disable_keymaps = true,
      }
      -- CC: for some reason, setting `nil` to a keymap in the setup doesn't
      -- work. Let's do it manually.
      local completion_preview = require 'supermaven-nvim.completion_preview'
      vim.keymap.set('i', '<C-J>', completion_preview.on_accept_suggestion, { noremap = true, silent = true })
    end,
  },
}
