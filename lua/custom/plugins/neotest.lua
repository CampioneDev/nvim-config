return {
  'nvim-neotest/neotest',
  enabled = not vim.g.vscode,
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'rustaceanvim.neotest',
      },
    }

    require('which-key').add {
      { '<leader>n', group = '[N]eotest' },
    }
    vim.keymap.set('n', '<leader>ns', ':Neotest summary<CR>', { silent = true, desc = '[N]eotest - [s]ummary (CC)' })
  end,
}
