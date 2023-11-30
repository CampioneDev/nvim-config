--rvim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>`>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>`<gv=gv", { silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste without yanking (CC)" })

vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank to clipboard (CC)" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank to clipboard (CC)" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank to clipboard (CC)" })

vim.keymap.set("n", "<leader>df", function()
	vim.lsp.buf.format()
end, { desc = "LSP: [D]ocument [F]ormat (CC)" })
