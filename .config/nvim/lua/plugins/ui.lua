return {
	{
		"nvim-lualine/lualine.nvim",
		opts = function()
			local gruvbox = require("lualine.themes.gruvbox")
			local bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg")
			gruvbox.normal.c.bg = bg
			gruvbox.insert.c.bg = bg
			gruvbox.visual.c.bg = bg
			gruvbox.replace.c.bg = bg
			gruvbox.command.c.bg = bg
			gruvbox.inactive.c.bg = bg

			return {
				options = {
					icons_enabled = true,
					colored = true,
					theme = gruvbox,
					component_separators = "|",
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = {
						{ "mode", separator = { left = "" }, padding = { left = 1, right = 2 } },
					},
					lualine_b = {
						{
							"filename",
							padding = 2,
							symbols = {
								modified = "+", -- Text to show when the file is modified.
								readonly = "-", -- Text to show when the file is non-modifiable or readonly.
								unnamed = "[No Name]", -- Text to show for unnamed buffers.
								newfile = "[New]", -- Text to show for newly created file before first write
							},
						},
						{ "branch", padding = 2 },
					},
					lualine_c = {},
					lualine_x = { "diagnostics" },
					lualine_y = {
						{ "filetype", padding = 2 },
					},
					lualine_z = {
						{ "progress", separator = { left = "" }, padding = { left = 2 } },
						{ "location", separator = { right = "" }, padding = 0 },
					},
				},
				inactive_sections = {
					lualine_a = { "filename" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { "location" },
				},
				tabline = {},
				extensions = {},
			}
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			char = "┊",
			show_trailing_blankline_indent = false,
		},
	},

	{
		"sindrets/diffview.nvim",
		opts = {},
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{
				"<leader>fe",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		opts = {
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = true,
				use_libuv_file_watcher = true,
			},
			window = {
				position = "left",
				width = 30,
				mappings = {
					["<space>"] = "none",
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				git_status = {
					symbols = {
						added = "✚",
						deleted = "✖",
						modified = "",
						renamed = "",
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
					align = "right",
				},
			},
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
			},
		},
	},

	{
		"rcarriga/nvim-notify",
		lazy = true,
		opts = {
			render = "minimal",
		},
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			cmdline = {
				format = {
					search_down = { kind = "search", pattern = "^/", icon = "🔎 ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = "🔎 ", lang = "regex" },
				},
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				signature = {
					enabled = false,
				},
			},
			views = {
				notify = {
					merge = true,
				},
			},
			presets = {
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
		},
	},
}
