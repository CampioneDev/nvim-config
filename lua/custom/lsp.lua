-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
local servers = {
  clangd = {},
  gopls = {},
  -- pyright = {},
  rust_analyzer = nil,
  -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  --
  -- Some languages (like typescript) have entire language plugins that can be useful:
  --    https://github.com/pmizio/typescript-tools.nvim
  --
  -- But for many setups, the LSP (`tsserver`) will work just fine
  ts_ls = {
    -- capabilities = {
    --   documentFormatting = false,
    --   rangeFormatting = false,
    --   formatting = false,
    --   textDocument = {
    --     formatting = false,
    --   },
    settings = {
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        },
      },
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        },
      },
    },
  },
  bashls = {},
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  templ = {},
  cssls = {
    init_options = {
      provideFormatter = false,
    },
  },
  jsonls = {
    -- CC: copied from LazyVim: https://www.lazyvim.org/extras/lang/json#nvim-lspconfig
    -- lazy-load schemastore when needed
    on_new_config = function(new_config)
      new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
    end,
    settings = {
      json = {
        format = {
          enable = true,
        },
        validate = { enable = true },
      },
    },
  },
  eslint = {
    -- copied from tsserver on :LspInfo
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  },
  -- CC: added for conform
  -- eslind_d = nil,
  lemminx = {},
  taplo = {},
}

-- --- @type table<string, fun(client: any, bufnr: number)[]>
-- CC_LSP_SERVERS_ATTACH = {}
-- for server_name, _ in pairs(servers) do
--   CC_LSP_SERVERS_ATTACH[server_name] = {}
-- end

local cc_js_filetypes = {
  ['javascript'] = true,
  ['javascriptreact'] = true,
  ['javascript.jsx'] = true,
  ['typescript'] = true,
  ['typescriptreact'] = true,
  ['typescript.tsx'] = true,
}

return {
  lsp_servers = servers,
  custom_format_check = function(bufnr)
    -- CC: since calling eslint_d from conform returns a timeout error lately,
    -- and disabling the formatting capabilities of tsserver doesn't work
    -- anymore, we check the current buffer and use EslintFixAll for all
    -- relevant filetypes
    if cc_js_filetypes[vim.bo[bufnr].filetype] then
      -- CC: this command exists only when eslint is available
      if vim.fn.exists ':EslintFixAll' > 0 then
        vim.cmd 'EslintFixAll'
      else
        return false
      end
      return true
    end
    return false
  end,
}
