local _stylelint_checked = {}

return {
  init_options = {
    -- we're using eslint and stylelint
    provideFormatter = false,
  },
  on_attach = function(client, bufnr)
    local lsp_root_dir = client.config.root_dir
    if not _stylelint_checked[lsp_root_dir] then
      _stylelint_checked[lsp_root_dir] = true

      if
        require('custom.utils.nodejs_tools').package_is_installed 'stylelint'
        and require('custom.configs.stylelint').project_has_stylelint_cfg(lsp_root_dir)
      then
        local conform = require 'conform'

        local f = conform.formatters_by_ft
        ---@diagnostic disable-next-line: param-type-mismatch
        f['css'] = vim.list_extend(f['css'] or {}, { 'stylelint' })
        ---@diagnostic disable-next-line: param-type-mismatch
        f['scss'] = vim.list_extend(f['scss'] or {}, { 'stylelint' })

        ---

        local lint = require 'lint'
        lint.linters_by_ft.css = { 'stylelint' }
        lint.linters_by_ft.scss = { 'stylelint' }

        ---

        vim.notify('Stylelint formatter/linter enabled', vim.log.levels.INFO)
      end
    end
  end,
  settings = {
    css = {
      lint = {
        -- for CSS modules, prevents `unknownProperties` error
        validProperties = { 'composes' },
      },
    },
  },
}
