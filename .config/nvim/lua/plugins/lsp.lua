vim.diagnostic.config({
	underline = true,
	virtual_text = true,
	severity_sort = true,
	float = { border = "rounded" },
})

return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = true,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"tsserver",
				"svelte",
			},
		},
	},

	{
		"folke/neodev.nvim",
		lazy = true,
		opts = {
			library = { plugins = { "neotest" }, types = true },
		},
	},

	{
		"jose-elias-alvarez/typescript.nvim",
		lazy = true,
	},

	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = function()
			return {
				lightbulb = {
					enable_in_insert = false,
					virtual_text = false,
				},
				ui = {
					title = true,
					-- single, double, rounded, solid, shadow.
					border = "rounded",
					winblend = 0,
					code_action = "",
				},
			}
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
			"folke/neodev.nvim",
			"glepnir/lspsaga.nvim",
			"jose-elias-alvarez/typescript.nvim",
		},
		config = function()
			local telescope_builtin = require("telescope.builtin")
			require("mason-lspconfig").setup_handlers({
				function(server)
					local on_attach = function(client, bufnr)
						local nmap = function(keys, func, desc)
							vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
						end

						nmap("gh", "<cmd>Lspsaga lsp_finder<cr>", "[G]oto [H]ierarchical finder")
						nmap("gd", "<cmd>Lspsaga peek_definition<cr>", "[G]oto [D]efinition")
						nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
						nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
						nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
						nmap("<leader>rn", "<cmd>Lspsaga rename<cr>", "[R]e[n]ame")
						nmap("<leader>ca", "<cmd>Lspsaga code_action<cr>", "[C]ode [A]ction")
						nmap("<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<cr>", "Show cursor [D]iagnostics")
						nmap("<leader>D", "<cmd>Lspsaga show_line_diagnostics<cr>", "Show line [D]iagnostics")
						nmap("[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Previous [D]iagnostics")
						nmap("]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next [D]iagnostics")
						nmap("<Leader>go", "<cmd>Lspsaga outline<cr>", "[G]oto [O]utline")
						nmap("<Leader>ci", "<cmd>Lspsaga incoming_calls<cr>", "[C]all [I]ncoming")
						nmap("<Leader>co", "<cmd>Lspsaga outgoing_calls<cr>", "[C]all [O]utgoing")

						nmap("<leader>sd", telescope_builtin.lsp_document_symbols, "[S]ymbol in [D]ocument")
						nmap("<leader>sw", telescope_builtin.lsp_dynamic_workspace_symbols, " [S]ymbols in [W]orkspace")

						nmap("K", "<cmd>Lspsaga hover_doc<cr>", "Hover Documentation")
						nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

						if client.name == "tsserver" then
							nmap("<leader>rf", "<cmd>:TypescriptRenameFile<cr>", "[R]ename [F]ile")
						end
					end

					local capabilities =
						require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

					if server == "tsserver" then
						require("typescript").setup({
							server = {
								on_attach = on_attach,
								capabilities = capabilities,
							},
						})
					else
						require("lspconfig")[server].setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end
				end,
			})
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/typescript.nvim",
		},
		opts = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			return {
				sources = {
					formatting.prettier.with({
						extra_filetypes = { "svelte", "toml" },
					}),
					formatting.stylua,
					diagnostics.eslint_d.with({
						condition = function(utils)
							return utils.root_has_file(".eslintrc.js")
						end,
					}),
					require("typescript.extensions.null-ls.code-actions"),
				},
				on_attach = function(current_client, bufnr)
					if current_client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									filter = function(client)
										return client.name == "null-ls"
									end,
									bufnr = bufnr,
								})
							end,
						})
					end
				end,
			}
		end,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		opts = {
			ensure_installed = {
				"prettier", -- ts/js formatter
				"stylua", -- lua formatter
				"eslint_d", -- ts/js linter
			},
			automatic_installation = true,
		},
	},

	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("trouble").setup({})
		end,
	},
}
