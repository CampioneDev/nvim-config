return {
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
    enabled = not vim.g.vscode,
    -- CC: not needed now, but this is how it's done
    -- config = function()
    --   local _ = require 'rustaceanvim'
    --   -- ---@type rustaceanvim.lsp.ClientOpts
    --   -- local server_opts = {
    --   --   -- cmd = { 'rust-analyzer' },
    --   --   settings = {
    --   --     ['rust-analyzer'] = {
    --   --       diagnostics = {
    --   --         disabled = { 'inactive-code' },
    --   --       },
    --   --       cargo = {},
    --   --     },
    --   --   },
    --   -- }
    --
    --   local default_config = require 'rustaceanvim.config.internal'
    --
    --   ---@type rustaceanvim.dap.Opts
    --   local dap_opts = {
    --     configuration = function()
    --       local config = default_config.dap.configuration()
    --       print('Rustaceanvim: DAP configuration' .. vim.inspect(config))
    --       return config
    --     end,
    --   }
    --
    --   vim.g.rustaceanvim = {
    --     -- server = server_opts,
    --     dap = dap_opts,
    --   }
    -- end,
  },
  {
    'saecki/crates.nvim',
    enabled = not vim.g.vscode,
    config = function()
      local crates = require 'crates'
      crates.setup {
        autoload = false,
        popup = {
          autofocus = true,
        },
        on_attach = function(_)
          print 'Crates.nvim: on_attach'
        end,
      }

      require('lualine').setup {
        sections = { lualine_x = { 'overseer' } },
      }

      --------

      local crates_first_run = true

      vim.api.nvim_create_augroup('CargoMappings', { clear = true })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'toml',
        callback = function()
          if vim.fn.expand '%:t' == 'Cargo.toml' then
            vim.keymap.set('n', '<leader>crt', function()
              if crates_first_run then
                vim.keymap.set('n', '<leader>crp', function()
                  crates.show_popup()
                end, { desc = 'Crates.nvim: show popup (CC)', buffer = true })

                vim.keymap.set('n', '<leader>crf', function()
                  crates.show_features_popup()
                end, { desc = 'Crates.nvim: show features popup (CC)', buffer = true })

                vim.keymap.set('n', '<leader>crd', function()
                  crates.show_dependencies_popup()
                end, { desc = 'Crates.nvim: show dependencies popup (CC)', buffer = true })

                vim.keymap.set('n', '<leader>crr', function()
                  crates.reload()
                end, { desc = 'Crates.nvim: reload (CC)', buffer = true })

                crates_first_run = false

                crates.show()
              else
                crates.toggle()
              end
            end, { desc = 'Crates.nvim: toggle (CC)', buffer = true })

            local which_key = require 'which-key'
            which_key.add {
              { '<leader>cr', group = 'Crates.nvim (CC)' },
            }
          end
        end,
        group = 'CargoMappings',
      })
    end,
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
