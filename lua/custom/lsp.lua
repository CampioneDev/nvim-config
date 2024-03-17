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
  tsserver = {
    capabilities = {
      -- CC: leaves formatting to eslint, avoids double formatting
      documentFormatting = false,
      rangeFormatting = false,
      formatting = false,
      textDocument = {
        formatting = false,
      },
      -- documentFormattingProvider = false,
      -- rangeFormattingProvider = false,
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
  jsonls = {},
  eslint = {
    -- copied from tsserver on :LspInfo
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  },
  -- CC: added for conform
  eslind_d = nil,
  lemminx = {},
  taplo = {},
}

-- --- @type table<string, fun(client: any, bufnr: number)[]>
-- CC_LSP_SERVERS_ATTACH = {}
-- for server_name, _ in pairs(servers) do
--   CC_LSP_SERVERS_ATTACH[server_name] = {}
-- end

return {
  lsp_servers = servers,
}
