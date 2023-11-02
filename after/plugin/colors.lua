if vim.g.vscode then
	return
end

require('catppuccin').setup({
	-- disable_background = true -- rosepine
	transparent_background = true -- catp
})

function ColorMyPencils(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
