return {
  'akinsho/toggleterm.nvim',
  enabled = false,
  -- enabled = not vim.g.vscode,
  version = '*',
  config = function()
    require('toggleterm').setup {}

    vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', { silent = true, desc = '[T]oggle [T]erminal (CC)' })
  end,
}
