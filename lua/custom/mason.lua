local M = {}

M.mason_packages = {
  'lua_ls',
  'stylua',
  'clangd',
  'gopls',
  'basedpyright',
  'rust_analyzer',
  'ts_ls',
  'bashls',
  'html',
  'cssls',
  'cssmodules_ls',
  'jsonls',
  'eslint',
  'lemminx',
  'taplo',
}

local uv = vim.uv or vim.loop

local mason_root = vim.fs.joinpath(vim.fn.stdpath 'data', 'mason')
local pkgs_dir = vim.fs.joinpath(mason_root, 'packages')

--- if installed, returns the name
function M.mason_installed(name)
  return uv.fs_stat(vim.fs.joinpath(pkgs_dir, name)) and name or nil
end

return M
