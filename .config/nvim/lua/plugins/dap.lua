return {
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		opts = {},
	},

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local mason_registry = require("mason-registry")
			local js_debug_adapter = mason_registry.get_package("js-debug-adapter")
			local path = js_debug_adapter:get_install_path()

			vim.keymap.set("n", "<C-p>co", function()
				dap.continue()
			end, { desc = "Debug [Co]ntinue" })
			vim.keymap.set("n", "<C-p>bb", function()
				dap.toggle_breakpoint()
			end, { desc = "Debug [B]reakpoint Toggle" })
			vim.keymap.set("n", "<C-p>so", function()
				dap.step_over()
			end, { desc = "Debug [S]tep [O]ver" })
			vim.keymap.set("n", "<C-p>si", function()
				dap.step_into()
			end, { desc = "Debug [S]tep [I]nto" })
			vim.keymap.set("n", "<C-p>su", function()
				dap.step_out()
			end, { desc = "Debug [S]tep o[U]t" })
			vim.keymap.set("n", "<C-p>or", function()
				dap.repl.open()
			end, { desc = "Debug [O]pen [R]epl" })

			dap.listeners.before.event_terminated["js-debug-adapter"] = function(session)
				if session.parent then
					return
				end

				vim.fn.system(
					"ps -fea | grep node | grep 'dapDebugServer.js "
						.. session.adapter["port"]
						.. "' | grep -v grep | awk '{print $2}' | xargs kill"
				)
			end

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = path .. "/js-debug-adapter",
					args = { "${port}" },
				},
			}

			-- javascript & typescript
			for _, language in ipairs({ "typescript", "javascript" }) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Debug File",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end
		end,
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			ensure_installed = {
				"js",
			},
			automatic_installation = true,
			handlers = {},
		},
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end

			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
