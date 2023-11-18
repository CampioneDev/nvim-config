local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>sW", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "[S]earch [W]ord (CC)" })
