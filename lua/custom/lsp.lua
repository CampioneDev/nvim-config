local M = {}

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
M.lsp_servers = {
  clangd = {},
  gopls = {},
  basedpyright = {},
  rust_analyzer = nil,
  -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  --
  -- Some languages (like typescript) have entire language plugins that can be useful:
  --    https://github.com/pmizio/typescript-tools.nvim
  --
  -- But for many setups, the LSP (`tsserver`) will work just fine
  ts_ls = {},
  bashls = {},
  html = {},
  templ = {},
  cssls = {},
  jsonls = {},
  eslint = {},
  lemminx = {},
  taplo = {},
}

local uv = vim.uv or vim.loop

local mason_root = vim.fs.joinpath(vim.fn.stdpath 'data', 'mason')
local pkgs_dir = vim.fs.joinpath(mason_root, 'packages')

--- if installed, returns the name
function M.mason_installed(name)
  return uv.fs_stat(vim.fs.joinpath(pkgs_dir, name)) and name or nil
end

return M
