return {
  'zbirenbaum/neodim',
  enabled = not vim.g.vscode,
  event = 'LspAttach',
  config = function()
    local color = vim.api.nvim_get_hl(0, { name = 'LineNr' })
    local blend_color = string.format('#%06x', color.fg or 0)

    require('neodim').setup {
      alpha = 0.166,
      blend_color = blend_color,
      hide = {
        underline = true,
        virtual_text = true,
        signs = true,
      },
      regex = {
        rust = {
          'inactive-code',
        },
      },
      priority = 128,
      disable = {},
    }
  end,
}
