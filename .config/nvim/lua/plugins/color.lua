vim.fn.sign_define("DiagnosticSignError", {
	text = "",
	texthl = "DiagnosticSignError",
})
vim.fn.sign_define("DiagnosticSignWarn", {
	text = "",
	texthl = "DiagnosticSignWarn",
})
vim.fn.sign_define("DiagnosticSignInfo", {
	text = "",
	texthl = "DiagnosticSignInfo",
})
vim.fn.sign_define("DiagnosticSignHint", {
	text = "",
	texthl = "DiagnosticSignHint",
})

return {
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = function()
			vim.cmd([[let g:gruvbox_material_background = 'hard']])
			vim.cmd([[colorscheme gruvbox-material]])

			local bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg")
			vim.cmd("hi FloatBorder guibg=" .. bg)
		end,
	},
}
