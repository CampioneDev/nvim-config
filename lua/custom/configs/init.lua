-- vim.opt.guicursor = ''

-- CC: already in init.lua
-- vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- CC: already in init.lua
-- vim.opt.splitbelow = true
-- vim.opt.splitright = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.termguicolors = true

-- -- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- already in init.lua
-- vim.opt.scrolloff = 8
vim.opt.winminwidth = 15
vim.opt.winheight = 5
vim.opt.winminheight = 5

vim.opt.updatetime = 50

-- -- Get the path to the Mason bin directory
-- local mason_bin_path = vim.fn.stdpath('data') .. '/mason/bin'
--
-- -- Prepend the Mason bin path to the PATH environment variable
-- vim.env.PATH = mason_bin_path .. ':' .. vim.env.PATH

if vim.fn.has 'win32' == 1 then
  -- https://github.com/akinsho/toggleterm.nvim/wiki/Tips-and-Tricks#using-toggleterm-with-powershell
  local powershell_options = {
    shell = vim.fn.executable 'pwsh' == 1 and 'pwsh' or 'powershell',
    shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
    shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait',
    shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
    shellquote = '',
    shellxquote = '',
  }

  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end
end

require 'custom.configs.filetypes'
require 'custom.configs.remap'
