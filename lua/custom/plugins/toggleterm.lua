return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {}

    vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', { silent = true, desc = 'Toggle Terminal (CC)' })
  end,
}
