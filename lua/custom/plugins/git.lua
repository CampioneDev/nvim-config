return {
  {
    'tpope/vim-fugitive',
    enabled = not vim.g.vscode,
    config = function()
      require('which-key').add {
        { '<leader>g', group = 'Git' },
      }

      vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Fugitive' })
    end,
  },
  {
    'tpope/vim-rhubarb',
    enabled = not vim.g.vscode,
  },
  {
    'sindrets/diffview.nvim',
    enabled = not vim.g.vscode,
    keys = {
      {
        '<leader>gd',
        function()
          local lib = require 'diffview.lib'
          local view = lib.get_current_view()
          if view then
            view:close()
          else
            local diffview = require 'diffview'
            diffview.open {}
          end
        end,
        desc = 'Diffview - Toggle',
      },
    },
  },
  {
    'isakbm/gitgraph.nvim',
    enabled = not vim.g.vscode,
    dependencies = {
      'sindrets/diffview.nvim',
    },
    ---@type I.GGConfig
    opts = {
      git_cmd = 'git',
      symbols = {
        merge_commit = 'M',
        commit = '*',
      },
      format = {
        timestamp = '%H:%M:%S %d-%m-%Y',
        fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
      },
      hooks = {
        -- Check diff of a commit
        on_select_commit = function(commit)
          vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
          vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
        end,
        -- Check diff from commit a -> commit b
        on_select_range_commit = function(from, to)
          vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
          vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
        end,
      },
    },
    keys = {
      {
        '<leader>gg',
        function()
          require('gitgraph').draw({}, { all = true, max_count = 5000 })
        end,
        desc = 'GitGraph - Draw',
      },
    },
  },
}
