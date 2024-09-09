local config_post = function()
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
end

-- --- @param pid integer
-- local function windows_get_executable_path(pid)
--   local Job = require 'plenary.job'
--
--   local result = {}
--   Job:new({
--     command = 'powershell',
--     args = { '-Command', string.format('(Get-Process -Id %d).Path', pid) },
--     on_stdout = function(_, line)
--       table.insert(result, line)
--     end,
--   }):sync()
--
--   local full_path = result[1]
--
--   if full_path ~= nil then
--     return vim.trim(full_path)
--   else
--     return nil
--   end
-- end

--- @param cb fun(proc: {pid: integer, name: string})
local open_process_picker = function(cb)
  -- local telescope = require 'telescope'
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local sorters = require 'telescope.sorters'
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  local daputils = require 'dap.utils'

  local function list()
    local processes = daputils.get_processes()

    local formatted = {}
    for _, process in ipairs(processes) do
      table.insert(formatted, string.format('%d: %s', process.pid, process.name))
    end

    pickers
      .new({}, {
        prompt_title = 'Running processes',
        finder = finders.new_table {
          results = formatted,
        },
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(_, map)
          map('i', '<CR>', function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            pcall(function()
              local process = processes[selection.index]
              -- if vim.fn.has 'win32' == 1 then
              --   process.name = windows_get_executable_path(process.pid) or process.name
              -- end
              cb(process)
            end)
          end)
          return true
        end,
      })
      :find()
  end

  list()
end

local function flash(prompt_bufnr)
  require('flash').jump {
    pattern = '^',
    label = { after = { 0, 0 } },
    search = {
      mode = 'search',
      exclude = {
        function(win)
          return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'TelescopeResults'
        end,
      },
    },
    action = function(match)
      local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
      picker:set_selection(match.pos[1] - 1)
    end,
  }
end

return {
  setup = {
    defaults = {
      -- sorting_strategy = 'ascending',
      path_display = { 'smart' },
      dynamic_preview_title = true,
      mappings = {
        n = { s = flash },
        i = { ['<c-s>'] = flash },
      },
    },
  },
  config_post = config_post,
  open_process_picker = open_process_picker,
}
