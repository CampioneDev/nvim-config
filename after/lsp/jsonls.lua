return {
  -- CC: copied from LazyVim: https://www.lazyvim.org/extras/lang/json#nvim-lspconfig
  -- lazy-load schemastore when needed
  on_new_config = function(new_config)
    new_config.settings.json.schemas = new_config.settings.json.schemas or {}
    vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
  end,
  settings = {
    json = {
      format = {
        -- CC: I'm actually using prettierd via conform.nvim
        enable = true,
      },
      validate = { enable = true },
    },
  },
}
