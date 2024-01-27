return {
  {
    'theprimeagen/harpoon',
    config = function()
      local harpoon = require 'harpoon'
      harpoon.setup {
        menu = {
          width = math.max(120, vim.api.nvim_win_get_width(0) / 3),
          height = math.max(40, vim.api.nvim_win_get_height(0) / 3),
        },
      }

      local mark = require 'harpoon.mark'
      local ui = require 'harpoon.ui'

      vim.keymap.set('n', '<leader>de', mark.add_file, { desc = 'Harpoon: add file (CC)' })
      vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu, { desc = 'Harpoon: toggle quick menu' })

      -- vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
      -- vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
      -- vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
      -- vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

      require('telescope').load_extension 'harpoon'
    end,
  },
}
