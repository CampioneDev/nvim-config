local lspconfig_ts_ls_config = {}
local lspconfig_plugin = require('lazy.core.config').plugins['nvim-lspconfig']
-- We load the config file directly from the plugin dir because we want to use
-- its `on_attach` function in addition to ours (and not override it)
if lspconfig_plugin then
  lspconfig_ts_ls_config = dofile(lspconfig_plugin.dir .. '/lsp/ts_ls.lua')
end

local shared_settings = {
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
}

return {
  -- Due to how I currently use my submodules, I don't want `package.json` and
  -- `.git` to be considered root markers at this moment
  root_markers = { 'tsconfig.json', 'jsconfig.json' },
  on_attach = function(client, bufnr)
    if lspconfig_ts_ls_config.on_attach then
      lspconfig_ts_ls_config.on_attach(client, bufnr)
    end
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  settings = {
    javascript = shared_settings,
    typescript = shared_settings,
  },
}
