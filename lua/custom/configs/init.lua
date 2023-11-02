vim.wo.relativenumber = true

vim.opt.guicursor = ""

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.termguicolors = true

-- -- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.opt.scrolloff = 8

vim.o.updatetime = 50

require("custom.configs.theme")
require("custom.configs.remap")
require("custom.configs.rust-tools")
