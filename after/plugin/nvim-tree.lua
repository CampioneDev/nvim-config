-- global
vim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap("n", "<C-g>", ":NvimTreeFindFile<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"<C-g>",
	":lua if require('nvim-tree.api').tree.is_visible() then require('nvim-tree.api').tree.close() else vim.cmd('NvimTreeFindFile') end<cr>",
	{ silent = true, noremap = true }
)

local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5

require("nvim-tree").setup({
	view = {
		centralize_selection = true,
		number = true,
		relativenumber = true,
		preserve_window_proportions = true,
		float = {
			enable = true,
			open_win_config = function()
				local screen_w = vim.opt.columns:get()
				local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
				local window_w = screen_w * WIDTH_RATIO
				local window_h = screen_h * HEIGHT_RATIO
				local window_w_int = math.floor(window_w)
				local window_h_int = math.floor(window_h)
				local center_x = (screen_w - window_w) / 2
				local center_y = ((vim.opt.lines:get() - window_h) / 2)
					- vim.opt.cmdheight:get()
				return {
					border = "rounded",
					relative = "editor",
					row = center_y,
					col = center_x,
					width = window_w_int,
					height = window_h_int,
				}
			end,
		},
		width = function()
			return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
		end,
	},
	renderer = {
		-- highlight_git = true,
		-- highlight_diagnostics = true,
		-- highlight_opened_files = true,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
})
