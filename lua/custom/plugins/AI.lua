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
    'folke/sidekick.nvim',
    dependencies = {
      'nvim-lualine/lualine.nvim',
    },
    opts = {
      cli = {
        mux = {
          enabled = false,
          backend = 'tmux',
        },
      },
    },
    init = function()
      require('which-key').add {
        { '<leader>a', group = '[A]I' },
      }

      local lualine = require 'lualine'
      local opts = lualine.get_config()
      -- https://github.com/folke/sidekick.nvim?tab=readme-ov-file#-statusline-integration
      table.insert(opts.sections.lualine_c, {
        function()
          return ' '
        end,
        color = function()
          local status = require('sidekick.status').get()
          if status then
            return status.kind == 'Error' and 'DiagnosticError' or status.busy and 'DiagnosticWarn' or 'Special'
          end
        end,
        cond = function()
          local status = require 'sidekick.status'
          return status.get() ~= nil
        end,
      })

      lualine.setup(opts)
    end,
    keys = {
      {
        '<tab>',
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require('sidekick').nes_jump_or_apply() then
            return '<Tab>' -- fallback to normal tab
          end
        end,
        expr = true,
        desc = 'Goto/Apply Next Edit Suggestion',
      },
      {
        '<leader>aa',
        function()
          require('sidekick.cli').toggle()
        end,
        mode = { 'n', 'v' },
        desc = 'Sidekick Toggle CLI',
      },
      {
        '<leader>as',
        function()
          require('sidekick.cli').select()
        end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = 'Sidekick Select CLI',
      },
      {
        '<leader>as',
        function()
          require('sidekick.cli').send { selection = true }
        end,
        mode = { 'v' },
        desc = 'Sidekick Send Visual Selection',
      },
      {
        '<leader>ap',
        function()
          require('sidekick.cli').prompt()
        end,
        mode = { 'n', 'v' },
        desc = 'Sidekick Select Prompt',
      },
      {
        '<c-a>',
        function()
          require('sidekick.cli').focus()
        end,
        mode = { 'n', 'x', 'i', 't' },
        desc = 'Sidekick Switch Focus',
      },
      {
        '<leader>ac',
        function()
          require('sidekick.cli').toggle { name = 'codex', focus = true }
        end,
        desc = 'Sidekick Codex Toggle',
        mode = { 'n', 'v' },
      },
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    enabled = false, -- not vim.g.vscode,
    branch = 'main',
    dependencies = {
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log wrapper
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
