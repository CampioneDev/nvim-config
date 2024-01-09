-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  clangd = {},
  gopls = {},
  -- pyright = {},
  rust_analyzer = nil,
  tsserver = {},
  bashls = {},
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  templ = {},
  cssls = {
    init_options = {
      provideFormatter = false,
    },
  },

  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
}

-- --- @type table<string, fun(client: any, bufnr: number)[]>
-- CC_LSP_SERVERS_ATTACH = {}
-- for server_name, _ in pairs(servers) do
--   CC_LSP_SERVERS_ATTACH[server_name] = {}
-- end

return {
  lsp_servers = servers,
}
