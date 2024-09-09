return {
  'dmmulroy/tsc.nvim',
  enabled = not vim.g.vscode,
  config = function()
    require('tsc').setup {}
  end,
}
