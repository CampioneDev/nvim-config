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

-- enables local configuration files
vim.o.exrc = true
-- ensures these files are safe to execute
vim.o.secure = true

-- -- Get the path to the Mason bin directory
-- local mason_bin_path = vim.fn.stdpath('data') .. '/mason/bin'
--
-- -- Prepend the Mason bin path to the PATH environment variable
-- vim.env.PATH = mason_bin_path .. ':' .. vim.env.PATH

require 'custom.configs.filetypes'
require 'custom.configs.remap'
require 'custom.configs.terminal'

if vim.g.neovide then
  require 'custom.configs.neovide'
end
