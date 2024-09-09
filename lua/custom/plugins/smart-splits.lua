return {
  'mrjones2014/smart-splits.nvim',
  enabled = not vim.g.vscode,
  lazy = false,
  dependencies = {
    {
      'kwkarlwang/bufresize.nvim',
      config = function()
        require('bufresize').setup()
      end,
    },
  },
  config = function()
    require('smart-splits').setup {
      at_edge = 'stop',
      resize_mode = {
        hooks = {
          on_leave = require('bufresize').resize,
        },
      },
    }

    require('legendary').setup {
      extensions = {
        smart_splits = {
          directions = { 'h', 'j', 'k', 'l' },
          mods = {
            -- for moving cursor between windows
            move = '<C>',
            -- for resizing windows
            resize = '<M>',
            -- for swapping window buffers
            swap = {
              -- this will create the mapping like
              -- <leader><C-h>
              -- <leader><C-j>
              -- <leader><C-k>
              -- <leader><C-l>
              mod = '<C>',
              prefix = '<leader>',
            },
          },
        },
      },
    }
  end,
}
