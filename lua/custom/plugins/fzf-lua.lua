return {
  'ibhagwan/fzf-lua',
  enabled = not vim.g.vscode,
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
  keys = {
    {
      '<leader>fz',
      function()
        local fzf = require 'fzf-lua'
        fzf.builtin()
      end,
      mode = { 'n' },
      desc = 'fzf-lua: builtin',
    },
  },
}
