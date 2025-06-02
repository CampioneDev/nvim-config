return {
  {
    'mbbill/undotree',
    enabled = not vim.g.vscode,
    config = function()
      vim.keymap.set('n', '<leader>u', function()
        vim.cmd.UndotreeToggle()
        vim.cmd.UndotreeFocus()
      end, { desc = 'Undotree toggle and focus' })
    end,
  },
}
