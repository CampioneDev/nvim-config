return {
  {
    'nvim-lualine/lualine.nvim',
    enabled = not vim.g.vscode,
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
      },
    },
  },
}
