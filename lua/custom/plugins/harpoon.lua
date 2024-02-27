return {
  {
    'theprimeagen/harpoon',
    config = function()
      local harpoon = require 'harpoon'
      local mark = require 'harpoon.mark'
      local ui = require 'harpoon.ui'

      local setup_size = function()
        local win_width = vim.api.nvim_win_get_width(0)
        local win_height = vim.api.nvim_win_get_height(0)
        local width = (win_width > 100) and math.floor(win_width / 2) or (win_width - 10)
        local height = (win_height > 50) and math.floor(win_height / 2) or (win_height - 10)

        harpoon.setup {
          menu = {
            width = width,
            height = height,
          },
        }
      end

      vim.keymap.set('n', '<leader>de', mark.add_file, { desc = 'Harpoon: add file (CC)' })
      vim.keymap.set('n', '<C-e>', function()
        setup_size()
        ui.toggle_quick_menu()
      end, { desc = 'Harpoon: toggle quick menu' })

      -- vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
      -- vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
      -- vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
      -- vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

      require('telescope').load_extension 'harpoon'
    end,
  },
}
