local null_ls_config = function()
  local null_ls = require 'null-ls'
  null_ls.setup {
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.diagnostics.eslint_d,
      -- null_ls.builtins.formatting.isort,
      -- null_ls.builtins.formatting.rustfmt,
      -- null_ls.builtins.formatting.clang_format,
      -- null_ls.builtins.formatting.goimports,
      -- null_ls.builtins.formatting.gofmt,
      -- null_ls.builtins.formatting.sqlformat,
    },
  }
end

return {
  {
    'nvimtools/none-ls.nvim',
    -- config = null_ls_config,
  },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
    config = function()
      null_ls_config()
      require('mason').setup()
      require('mason-null-ls').setup {
        automatic_installation = true,
        handlers = {},
      }
    end,
  },
}
