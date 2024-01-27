return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    local open = false

    local neotree = require 'neo-tree'
    neotree.setup {
      event_handlers = {
        {
          event = 'neo_tree_window_after_open',
          handler = function(_)
            open = true
          end,
          id = 'cc_neo_tree_window_after_open',
        },
        {
          event = 'neo_tree_window_after_close',
          handler = function(_)
            open = false
          end,
          id = 'cc_neo_tree_window_after_close',
        },
      },
    }
    -- print('neotree', vim.inspect(neotree))

    vim.keymap.set('n', '<C-h>', ':Neotree toggle position=float<cr>',
      { desc = 'Neotree - toggle', silent = true, noremap = true })
    vim.keymap.set('n', '<C-g>', function()
      if open then
        vim.cmd 'Neotree close'
      else
        vim.cmd 'Neotree reveal position=float'
      end
    end, { desc = 'Neotree - toggle', silent = true, noremap = true })
  end,
}
