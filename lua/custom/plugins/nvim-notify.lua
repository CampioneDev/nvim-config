return {
  'rcarriga/nvim-notify',
  enabled = false,
  -- enabled = not vim.g.vscode,
  config = function()
    require('notify').setup {
      background_colour = '#FF0000',
    }
  end,
}
