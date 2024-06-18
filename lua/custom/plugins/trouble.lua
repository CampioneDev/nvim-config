return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    require('which-key').add {
      { '<leader>x', group = 'Trouble' },
      { '<leader>x_', hidden = true },
    }

    vim.keymap.set('n', '<leader>xx', function()
      require('trouble').toggle()
    end, { desc = 'Trouble: Toggle' })
    vim.keymap.set('n', '<leader>xw', function()
      require('trouble').toggle 'workspace_diagnostics'
    end, { desc = 'Trouble: Toggle Workspace Diagnostics' })
    vim.keymap.set('n', '<leader>xd', function()
      require('trouble').toggle 'document_diagnostics'
    end, { desc = 'Trouble: Toggle Document Diagnostics' })
    vim.keymap.set('n', '<leader>xq', function()
      require('trouble').toggle 'quickfix'
    end, { desc = 'Trouble: Toggle Quickfix' })
    vim.keymap.set('n', '<leader>xl', function()
      require('trouble').toggle 'loclist'
    end, { desc = 'Trouble: Toggle Loclist' })
    vim.keymap.set('n', 'gR', function()
      require('trouble').toggle 'lsp_references'
    end, { desc = 'Trouble: Toggle LSP References' })
  end,
}
