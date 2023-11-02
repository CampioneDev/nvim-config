if vim.g.vscode then
	return
end

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
