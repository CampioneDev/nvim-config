local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set('n', 'grA', function()
  vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
  -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr, desc = 'Rust: code [A]ction' })
