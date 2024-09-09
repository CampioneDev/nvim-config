return {
  'stevearc/overseer.nvim',
  enabled = not vim.g.vscode,
  opts = {},
  config = function()
    local overseer = require 'overseer'
    overseer.setup {
      strategy = 'toggleterm',
    }

    vim.keymap.set('n', '<leader>ot', overseer.toggle, { desc = 'Overseer - Toggle (CC)' })
    vim.keymap.set('n', '<leader>or', ':OverseerRun<CR>', { desc = 'Overseer - Run (CC)' })
    vim.keymap.set('n', '<leader>oa', ':OverseerTaskAction<CR>', { desc = 'Overseer - Task Action (CC)' })
    -- vim.keymap.set('n', '<leader>oq', ':OverseerQuickAction<CR>', { desc = 'Overseer - Quick Action (CC)' })
  end,
}
