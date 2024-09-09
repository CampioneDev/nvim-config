return {
  'catppuccin/nvim',
  enabled = not vim.g.vscode,
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      -- disable_background = true -- rosepine
      transparent_background = true, -- catp
      integrations = {
        gitsigns = true,
        -- nvimtree = true,
        treesitter = true,
        barbecue = {
          dim_dirname = true, -- directory name is dimmed by default
          bold_basename = true,
          dim_context = false,
          alt_background = false,
        },
        noice = false,
        fidget = false,
        harpoon = false,
        indent_blankline = {
          enabled = true,
          -- scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = false,
        },
        mason = false,
        cmp = true,
        neotest = false,
        dap = true,
        dap_ui = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
            ok = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
            ok = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
        telescope = {
          enabled = true,
        },
        trouble = false,
        dadbod_ui = false,
        illuminate = {
          enabled = true,
          lsp = false,
        },
        which_key = false,
      },
    }

    function ColorMyPencils(color)
      color = color or 'catppuccin'
      vim.cmd.colorscheme(color)

      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end

    ColorMyPencils()
  end,
}
