return {
  {
    'tpope/vim-obsession',
    -- enabled = false,
    enabled = not vim.g.vscode,
    config = function()
      -- CC:
      -- in Windows we need this fix if we store terminal buffers
      if vim.fn.has 'win32' == 1 then
        -- Attaching this callback to the "SessionWritePost" event doesn't work
        -- with Obsession when closing NeoVim, so we need to use its own event
        --
        -- It's not documented, but easily discoverable looking at the source code
        vim.api.nvim_create_autocmd('User', {
          pattern = 'Obsession',
          callback = require('custom.utils.win_session_file_fix').fix_session_file,
        })
      end
    end,
  },
}
