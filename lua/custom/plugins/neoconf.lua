return {
  {
    'folke/neoconf.nvim',
    enabled = not vim.g.vscode,
    lazy = false,
    priority = 1000,
    config = function()
      require('neoconf').setup {}
    end,
  },
}
