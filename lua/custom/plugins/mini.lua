return {
  {
    'echasnovski/mini.nvim',
    enabled = false,
    -- enabled = not vim.g.vscode,
    config = function()
      require('mini.sessions').setup {
        autowrite = true,

        hooks = {
          -- Before successful action
          pre = { read = nil, write = nil, delete = nil },
          -- After successful action
          post = {
            read = nil,
            write = vim.fn.has 'win32' == 1 and function()
              require('custom.utils.win_session_file_fix').fix_session_file()
            end or nil,
            delete = nil,
          },
        },
      }
    end,
  },
}
