vim.keymap.set('n', '<leader>fv', function()
  vim.g.netrw_banner = 0
  vim.g.netrw_liststyle = 3
  vim.g.netrw_hide = 0
  vim.cmd '20Lexplore'
end, { desc = 'Netrw - Left explorer toggle (CC)' })

return {
  {
    'stevearc/oil.nvim',
    enabled = not vim.g.vscode,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local oil = require 'oil'

      oil.setup {
        default_file_explorer = false, -- CC: without this, `netrw` would be completely disabled
        columns = {
          'icon',
          'permission',
          'size',
          'mtime',
        },
        watch_for_changes = true,
        view_options = {
          show_hidden = true,
        },
      }

      local toggle_float = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get()

        oil.setup {
          float = {
            max_width = math.floor(screen_w * 0.75),
            max_height = math.floor(screen_h * 0.75),
          },
        }
        oil.toggle_float()
      end

      local desc = 'Oil - Open parent directory'
      vim.keymap.set('n', '-', toggle_float, { desc = desc })
      vim.keymap.set('n', '<leader>fo', toggle_float, { desc = desc })
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    enabled = not vim.g.vscode,
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      vim.keymap.set('n', '<leader>ff', ':Neotree reveal position=float toggle=true<CR>', { desc = 'Neotree - toggle', silent = true, noremap = true })

      require('neo-tree').setup {
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
          },
        },
      }
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    enabled = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      -- global
      vim.api.nvim_set_keymap('n', '<C-h>', ':NvimTreeToggle<cr>', { silent = true, noremap = true })
      -- vim.api.nvim_set_keymap("n", "<C-g>", ":NvimTreeFindFile<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap(
        'n',
        '<C-g>',
        ":lua if require('nvim-tree.api').tree.is_visible() then require('nvim-tree.api').tree.close() else vim.cmd('NvimTreeFindFile') end<cr>",
        { silent = true, noremap = true }
      )

      local HEIGHT_RATIO = 0.8
      local WIDTH_RATIO = 0.5

      require('nvim-tree').setup {
        view = {
          centralize_selection = true,
          number = true,
          relativenumber = true,
          preserve_window_proportions = true,
          float = {
            enable = true,
            open_win_config = function()
              local screen_w = vim.opt.columns:get()
              local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_w = screen_w * WIDTH_RATIO
              local window_h = screen_h * HEIGHT_RATIO
              local window_w_int = math.floor(window_w)
              local window_h_int = math.floor(window_h)
              local center_x = (screen_w - window_w) / 2
              local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
              return {
                border = 'rounded',
                relative = 'editor',
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,
              }
            end,
          },
          width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
          end,
        },
        renderer = {
          -- highlight_git = true,
          -- highlight_diagnostics = true,
          -- highlight_opened_files = true,
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
        },
      }
    end,
  },
}
