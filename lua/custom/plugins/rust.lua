-- ---@type RustaceanOpts
-- local rustacean_opts = {
--   ---@type RustaceanToolsOpts
--   tools = {
--     -- ...
--   },
--   ---@type RustaceanLspClientOpts
--   server = {
--     cmd = function()
--       -- local mason_registry = require 'mason-registry'
--       --
--       -- -- local package = mason_registry.get_package 'rust-analyzer'
--       -- local install_dir = package:get_install_path()
--       -- find out where the binary is in the install dir, and append it to the install dir
--       -- local ra_bin = install_dir .. '/' .. 'rust-analyzer.exe' -- this may need tweaking
--       local ra_bin = vim.fn.stdpath 'data' .. '/mason/rust-analyzer'
--       print('Rust Analyzer binary:', ra_bin)
--       return { ra_bin } -- you can add additional args like `'--logfile', '/path/to/logfile'` to the list
--     end,
--
--     -- on_attach = function(_, bufnr)
--     --   print 'Rust Analyzer is ready!'
--     --   -- Set keybindings, etc. here.
--     --   vim.keymap.set('n', 'K', function()
--     --     vim.cmd.RustLsp { 'hover', 'actions' }
--     --   end, { silent = true, buffer = bufnr, desc = 'Rust: Hover Actions' })
--     --
--     --   vim.keymap.set('n', '<leader>ca', function()
--     --     vim.cmd.RustLsp 'codeAction'
--     --   end, { silent = true, buffer = bufnr, desc = 'Rust: [C]ode [A]ction' })
--     -- end,
--     -- settings = {
--     --   -- rust-analyzer language server configuration
--     --   ['rust-analyzer'] = {
--     --     -- cargo = {
--     --     --   allFeatures = true,
--     --     --   loadOutDirsFromCheck = true,
--     --     --   runBuildScripts = true,
--     --     -- },
--     --     -- checkOnSave = {
--     --     --   allFeatures = true,
--     --     --   command = 'clippy',
--     --     --   extraArgs = { '--no-deps' },
--     --     -- },
--     --     -- procMacro = {
--     --     --   enable = true,
--     --     --   ignored = {
--     --     --     ['async-trait'] = { 'async_trait' },
--     --     --     ['napi-derive'] = { 'napi' },
--     --     --     ['async-recursion'] = { 'async_recursion' },
--     --     --   },
--     --     -- },
--     --   },
--     -- },
--     -- ---@type RustaceanDapOpts
--     -- dap = {
--     --   autoload_configurations = false,
--     --   adapter = false,
--     --   configuration = false,
--     --   load_rust_types = false,
--     --   auto_generate_source_map = false,
--     --   add_dynamic_library_paths = false,
--     --   run_custom_build_command = false,
--     -- },
--   },
-- }

return {
  -- {
  --   'rust-lang/rust.vim',
  --   -- ft = "rust",
  --   -- init = function()
  --   --   vim.g.rustfmt_autosave = 1
  --   -- end
  -- },
  {
    'simrat39/rust-tools.nvim',
    -- enabled = false,
    -- ft = "rust"
    config = function()
      local rt = require 'rust-tools'

      rt.setup {
        server = {
          on_attach = function(_, bufnr)
            -- print('Rust Analyzer is ready!' .. vim.inspect(_))
            -- CC_GLOBAL_LSP_ON_ATTACH(_, bufnr)
            -- Hover actions
            vim.keymap.del('n', 'K', { buffer = bufnr })
            vim.keymap.set('n', 'K', rt.hover_actions.hover_actions, { buffer = bufnr, desc = 'Rust: Hover Actions' })
            -- Code action groups
            vim.keymap.del('n', '<leader>ca', { buffer = bufnr })
            vim.keymap.set('n', '<leader>ca', rt.code_action_group.code_action_group, { buffer = bufnr, desc = 'Rust: [C]ode [A]ction Groups' })
            vim.keymap.set('n', '<leader>cA', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[C]ode [A]ction' })
          end,
        },
      }

      --   vim.api.nvim_create_autocmd('LspAttach', {
      --     callback = function(args)
      --       print 'LSP attached.'
      --       -- local bufnr = args.buf
      --       local client = vim.lsp.get_client_by_id(args.data.client_id)
      --       if client.name == 'rust_analyzer' then
      --         print 'Rust Analyzer is ready!'
      --       end
      --     end,
      --   })
      --
      --   vim.api.nvim_create_autocmd('LspDetach', {
      --     callback = function(args)
      --       print 'LSP detached.'
      --       local client = vim.lsp.get_client_by_id(args.data.client_id)
      --       if client.name == 'rust_analyzer' then
      --         print 'Rust Analyzer is detached!'
      --       end
      --     end,
      --   })
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    -- event = 'VeryLazy',
    enabled = false,
    init = function()
      -- Configure rustaceanvim here
      -- vim.g.rustaceanvim = rustacean_opts
      -- print('RustaceanVim is ready!' .. vim.inspect(vim.g.rustaceanvim))
    end,
  },
}
