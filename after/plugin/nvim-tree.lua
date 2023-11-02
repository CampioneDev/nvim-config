if vim.g.vscode then
	return
end

-- global
vim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", { silent = true, noremap = true })

require("nvim-tree").setup()
