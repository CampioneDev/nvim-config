return {
  'catppuccin/nvim',
  enabled = not vim.g.vscode,
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      transparent_background = true, -- catp
      default_integrations = true,
      integrations = {
        cmp = true,
        dropbar = {
          enabled = true,
          color_mode = false,
        },
        -- nvimtree = true,
        noice = true,
        notify = true,
        fidget = true,
        flash = true,
        fzf = true,
        gitgraph = true,
        gitsigns = true,
        harpoon = true,
        indent_blankline = {
          enabled = true,
          -- scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = false,
        },
        mason = false,
        -- neotest = false,
        dap = true,
        dap_ui = true,
        overseer = true,
        snacks = {
          enabled = true,
          -- indent_scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
        },
        telescope = {
          enabled = true,
        },
        lsp_trouble = true,
        dadbod_ui = true,
        illuminate = {
          enabled = true,
          lsp = false,
        },
        which_key = true,
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
