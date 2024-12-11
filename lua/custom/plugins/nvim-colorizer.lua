return {
  {
    'NvChad/nvim-colorizer.lua',
    enabled = not vim.g.vscode,
    config = function()
      require('colorizer').setup {
        user_default_options = {
          names = false,
          RGB = true,
          RRGGBB = true,
          RRGGBBAA = true,
          css_fn = true,
        },
      }
    end,
  },
}
