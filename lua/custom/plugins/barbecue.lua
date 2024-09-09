return {
  'utilyre/barbecue.nvim',
  enabled = not vim.g.vscode,
  name = 'barbecue',
  version = '*',
  dependencies = {
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons', -- optional dependency
  },
  opts = {
    -- configurations go here
  },
  config = function()
    require('barbecue').setup()

    local barbecue_ui = require 'barbecue.ui'
    vim.keymap.set('n', '[b', function()
      barbecue_ui.navigate(-1)
    end, { desc = 'Barbecue - navigate -1 (CC)' })
  end,
}
