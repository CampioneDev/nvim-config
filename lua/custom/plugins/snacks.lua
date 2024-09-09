return {
  {
    'folke/snacks.nvim',
    enabled = not vim.g.vscode,
    priority = 1000,
    lazy = false,
    opts = {
      bufdelete = { enabled = true },
      notifier = { enabled = true },
      lazygit = { enabled = true },
      terminal = {
        win = {},
      },
    },
    keys = {
      {
        '<leader>dD',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete buffer (CC)',
      },
      {
        '<leader>gl',
        function()
          Snacks.lazygit()
        end,
        desc = '[L]azyGit (CC)',
      },
      {
        '<leader>tt',
        function()
          Snacks.terminal()
        end,
        desc = '[T]oggle [T]erminal',
      },
    },
  },
}
