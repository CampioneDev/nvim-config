local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>sW", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "[S]earch [W]ord (CC)" })

vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps (CC)' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands (CC)' })
vim.keymap.set('n', '<leader>st', require('telescope.builtin').builtin, { desc = '[S]how [T]elescope pickers (CC)' })
