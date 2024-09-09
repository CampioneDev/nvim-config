-- CC: copied from LazyVim: https://www.lazyvim.org/extras/lang/json#schemastorenvim
return {
  'b0o/SchemaStore.nvim',
  enabled = not vim.g.vscode,
  lazy = true,
  version = false, -- last release is way too old
}
