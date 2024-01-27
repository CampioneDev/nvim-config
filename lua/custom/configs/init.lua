vim.opt.relativenumber = true

vim.opt.guicursor = ''

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.termguicolors = true

-- -- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.opt.scrolloff = 8
vim.opt.winminwidth = 15
vim.opt.winheight = 5
vim.opt.winminheight = 5

vim.opt.updatetime = 50

-- -- Get the path to the Mason bin directory
-- local mason_bin_path = vim.fn.stdpath('data') .. '/mason/bin'
--
-- -- Prepend the Mason bin path to the PATH environment variable
-- vim.env.PATH = mason_bin_path .. ':' .. vim.env.PATH

require 'custom.configs.filetypes'
require 'custom.configs.remap'
