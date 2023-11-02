print("VSCODE PLUGIN")

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("custom.configs.remap")

-- https://github.com/vscode-neovim/vscode-neovim/wiki/Plugins
vim.keymap.set("x", "gc", ":VSCodeCommentary<CR>", { silent = true })
vim.keymap.set("n", "gc", ":VSCodeCommentary<CR>", { silent = true })
vim.keymap.set("o", "gc", ":VSCodeCommentary<CR>", { silent = true })
vim.keymap.set("n", "gcc", ":VSCodeCommentaryLine<CR>", { silent = true })
