-- additional filetypes
vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("CC_force_HTML_no_django", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.html",
	command = "set filetype=html",
	group = "CC_force_HTML_no_django"
})
