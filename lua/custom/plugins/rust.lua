return {
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  -- {
  --   'simrat39/rust-tools.nvim',
  --   enabled = false,
  --   -- ft = "rust"
  --   config = function()
  --     local rt = require 'rust-tools'
  --
  --     rt.setup {
  --       server = {
  --         on_attach = function(_, bufnr)
  --           -- print('Rust Analyzer is ready!' .. vim.inspect(_))
  --           -- CC_GLOBAL_LSP_ON_ATTACH(_, bufnr)
  --           -- Hover actions
  --           vim.keymap.del('n', 'K', { buffer = bufnr })
  --           vim.keymap.set('n', 'K', rt.hover_actions.hover_actions, { buffer = bufnr, desc = 'Rust: Hover Actions' })
  --           -- Code action groups
  --           vim.keymap.del('n', '<leader>ca', { buffer = bufnr })
  --           vim.keymap.set('n', '<leader>ca', rt.code_action_group.code_action_group, { buffer = bufnr, desc = 'Rust: [C]ode [A]ction Groups' })
  --           vim.keymap.set('n', '<leader>cA', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[C]ode [A]ction' })
  --         end,
  --       },
  --     }
  --   end,
  -- },
}
