return {
  {
    'ThePrimeagen/harpoon',
    enabled = not vim.g.vscode,
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon.setup {}

      -- local setup_size = function()
      --   local win_width = vim.o.columns
      --   local win_height = vim.o.lines
      --   -- CC: these return the size of the current split window, not the entire window
      --   -- local win_width = vim.api.nvim_win_get_width(0)
      --   -- local win_height = vim.api.nvim_win_get_height(0)
      --   local width = (win_width > 100) and math.floor(win_width / 2) or (win_width - 10)
      --   local height = (win_height > 50) and math.floor(win_height / 2) or (win_height - 10)
      --
      --   harpoon.setup {
      --     menu = {
      --       width = width,
      --       height = height,
      --     },
      --   }
      -- end

      -- -- basic telescope configuration
      -- local conf = require('telescope.config').values
      -- local function toggle_telescope(harpoon_files)
      --   local file_paths = {}
      --   for _, item in ipairs(harpoon_files.items) do
      --     table.insert(file_paths, item.value)
      --   end
      --
      --   require('telescope.pickers')
      --     .new({}, {
      --       prompt_title = 'Harpoon',
      --       finder = require('telescope.finders').new_table {
      --         results = file_paths,
      --       },
      --       previewer = conf.file_previewer {},
      --       sorter = conf.generic_sorter {},
      --     })
      --     :find()
      -- end

      vim.keymap.set('n', '<leader>de', function()
        harpoon:list():add()
      end, { desc = 'Harpoon: add file (CC)' })
      vim.keymap.set('n', '<C-e>', function()
        -- setup_size()

        -- toggle_telescope(harpoon:list())
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon: toggle quick menu' })

      -- vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
      -- vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
      -- vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
      -- vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

      -- require('telescope').load_extension 'harpoon'
    end,
  },
}
