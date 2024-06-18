local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>sW', function()
  builtin.grep_string { search = vim.fn.input 'Grep > ' }
end, { desc = '[S]earch [W]ord (CC)' })

vim.keymap.set('n', '<leader>sp', function()
  builtin.live_grep { glob_pattern = vim.fn.input 'Glob Pattern > ' }
end, { desc = '[S]earch by grep with glob [P]attern (CC)' })

local find_files_with_glob = function(opts)
  local make_entry = require 'telescope.make_entry'
  local finders = require 'telescope.finders'
  local pickers = require 'telescope.pickers'
  local conf = require('telescope.config').values
  local sorters = require 'telescope.sorters'

  opts = opts or {}
  opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)

  local live_grepper = finders.new_job(function(prompt)
    if not prompt or prompt == '' then
      return nil
    end

    return {
      'rg',
      '--color=never',
      -- CC: using `sort` makes `rg` single-threaded according to `man`.
      -- in the future we could sort in a sorter but it's ok for now
      '--sort=path',
      '--smart-case',
      '--files',
      '--glob',
      prompt,
    }
  end, opts.entry_maker, opts.max_results, opts.cwd)

  -- https://github.com/nvim-telescope/telescope.nvim
  -- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md
  pickers
    .new(opts, {
      prompt_title = 'Find Files with Glob Pattern',
      finder = live_grepper,
      previewer = conf.file_previewer(opts),
      sorter = sorters.empty(),
    })
    :find()
end

vim.keymap.set('n', '<leader>sF', find_files_with_glob, { desc = '[S]earch [F]iles with glob pattern (CC)' })

vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps (CC)' })

-- vim.keymap.set('n', '<leader>se', function()
--   local telescope = require 'telescope'
--   local pickers = require 'telescope.pickers'
--   local finders = require 'telescope.finders'
--   local sorters = require 'telescope.sorters'
--   local actions = require 'telescope.actions'
--   local action_state = require 'telescope.actions.state'
--
--   local function list_loaded_telescope_extensions()
--     local extensions = {}
--     for extension_name, _ in pairs(telescope.extensions) do
--       table.insert(extensions, extension_name)
--     end
--
--     pickers
--       .new({}, {
--         prompt_title = 'Loaded Telescope Extensions',
--         finder = finders.new_table {
--           results = extensions,
--         },
--         sorter = sorters.get_generic_fuzzy_sorter(),
--         attach_mappings = function(_, map)
--           map('i', '<CR>', function(prompt_bufnr)
--             local selection = action_state.get_selected_entry()
--             actions.close(prompt_bufnr)
--             -- CC - let's try to run the extension as a command
--             pcall(function()
--               vim.cmd('Telescope ' .. selection[1])
--             end)
--           end)
--           return true
--         end,
--       })
--       :find()
--   end
--
--   list_loaded_telescope_extensions()
-- end, { desc = '[S]earch Telescope [E]xtensions (CC)' })
