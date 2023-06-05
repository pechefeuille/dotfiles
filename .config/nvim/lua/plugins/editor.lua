return {
	{
		"leafOfTree/vim-svelte-plugin",
		ft = "svelte",
		config = function()
			vim.cmd([[let g:vim_svelte_plugin_use_typescript = 1]])
		end,
	},

	{
		"leafgarland/typescript-vim",
		ft = "typescript",
	},

	{
		"tpope/vim-fugitive",
		cmd = "Git",
	},

	{
		"delphinus/vim-firestore",
	},

	{
		"windwp/nvim-autopairs",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = function()
			local autopairs = require("nvim-autopairs")
			local cmp = require("cmp")
			autopairs.setup({
				check_ts = true,
				ts_config = {
					lua = { "string" },
					javascript = { "template_string" },
					java = false,
				},
			})
			cmp.event:on("confirm_done", autopairs.on_confirm_done)
		end,
	},

	{
		"folke/which-key.nvim",
		opts = {},
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	{
		"ggandor/leap.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function()
			vim.keymap.set("n", "s", "<Plug>(leap-forward-to)", { desc = "Leap forward to" })
			vim.keymap.set("n", "S", "<Plug>(leap-backward-to)", { desc = "Leap backward to" })
			vim.keymap.set("n", "gs", "<Plug>(leap-from-window)", { desc = "Leap from window" })
		end,
	},

	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gc", mode = { "n", "v" }, desc = "Toggles linewise comment" },
			{ "gb", mode = { "n", "v" }, desc = "Toggles blockwise comment" },
		},
		opts = {
			mappings = {
				basic = true,
				extra = false,
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		keys = {
			{
				"<leader>ff",
				"<cmd>Telescope find_files<CR>",
				desc = "[F]ind [F]iles in Telescope",
			},
			{
				"<leader>fg",
				"<cmd>Telescope live_grep<CR>",
				desc = "[F]ind [G]repped files in Telescope",
			},
			{
				"<space>fb",
				"<cmd>Telescope file_browser<CR>",
				desc = "Open [F]ile [B]rowser in Telescope",
			},
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
						},
					},
				},
				extensions = {
					file_browser = {
						theme = "ivy",
					},
				},
			})
			telescope.load_extension("file_browser")
			telescope.load_extension("fzf")
		end,
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},

	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
}
