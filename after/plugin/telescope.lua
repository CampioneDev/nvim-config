local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>sW', function()
  builtin.grep_string { search = vim.fn.input 'Grep > ' }
end, { desc = '[S]earch [W]ord (CC)' })

vim.keymap.set('n', '<leader>sp', function()
  builtin.live_grep { glob_pattern = vim.fn.input 'Glob Pattern > ' }
end, { desc = '[S]earch by grep with glob [P]attern (CC)' })

vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps (CC)' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands (CC)' })

vim.keymap.set('n', '<leader>se', function()
  local telescope = require 'telescope'
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local sorters = require 'telescope.sorters'
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  local function list_loaded_telescope_extensions()
    local extensions = {}
    for extension_name, _ in pairs(telescope.extensions) do
      table.insert(extensions, extension_name)
    end

    pickers
      .new({}, {
        prompt_title = 'Loaded Telescope Extensions',
        finder = finders.new_table {
          results = extensions,
        },
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(_, map)
          map('i', '<CR>', function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            -- CC - let's try to run the extension as a command
            pcall(function()
              vim.cmd('Telescope ' .. selection[1])
            end)
          end)
          return true
        end,
      })
      :find()
  end

  list_loaded_telescope_extensions()
end, { desc = '[S]earch Telescope [E]xtensions (CC)' })
