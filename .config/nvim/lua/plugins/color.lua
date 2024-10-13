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
		"f4z3r/gruvbox-material.nvim",
		name = "gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[let g:gruvbox_material_background = 'hard']])
			vim.cmd([[colorscheme gruvbox-material]])

			local bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg")
			vim.cmd("hi FloatBorder guibg=" .. bg)
		end,
	},

	{
		"f-person/auto-dark-mode.nvim",
		opts = {
			update_interval = 1000,
			set_dark_mode = function()
				vim.api.nvim_set_option_value("background", "dark", {})
				vim.cmd("colorscheme gruvbox-material")
			end,
			set_light_mode = function()
				vim.api.nvim_set_option_value("background", "light", {})
				vim.cmd("colorscheme gruvbox-material")
			end,
		},
	},
}
