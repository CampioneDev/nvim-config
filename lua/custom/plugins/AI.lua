return {
  {
    'github/copilot.vim',
    enabled = not vim.g.vscode,
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
    'CopilotC-Nvim/CopilotChat.nvim',
    enabled = not vim.g.vscode,
    branch = 'main',
    dependencies = {
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    build = vim.fn.has 'win32' == 0 and 'make tiktoken' or nil, -- Only on MacOS or Linux
    opts = {
      -- debug = true, -- Enable debugging
    },
    config = function()
      local chat = require 'CopilotChat'
      chat.setup {}
      vim.keymap.set('n', '<leader>tc', function()
        chat.toggle()
      end, { desc = '[T]oggle Copilot [C]hat (CC)', noremap = true, silent = true })
    end,
  },
  {
    'supermaven-inc/supermaven-nvim',
    enabled = false,
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
}
