return {
  {
    'folke/edgy.nvim',
    enabled = false,
    -- enabled = not vim.g.vscode,
    event = 'VeryLazy',
    init = function()
      -- views can only be fully collapsed with the global statusline
      vim.opt.laststatus = 3
      -- Default splitting will cause your main splits to jump when opening an edgebar.
      -- To prevent this, set `splitkeep` to either `screen` or `topline`.
      vim.opt.splitkeep = 'screen'
    end,
    opts = {},
  },
}
