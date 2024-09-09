-- CC: most of telescope stuff is still in `init.lua` but I'll put here any
-- other telescope-related stuff
return {
  {
    'nvim-telescope/telescope-dap.nvim',
    enabled = not vim.g.vscode,
    config = function()
      require('telescope').load_extension 'dap'
    end,
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-telescope/telescope.nvim', 'nvim-treesitter/nvim-treesitter' },
  },
}
