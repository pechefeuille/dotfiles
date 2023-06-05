return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"haydenmeade/neotest-jest",
			"marilari88/neotest-vitest",
		},
		config = function()
			local neotest = require("neotest")

			vim.keymap.set("n", "<C-p>tt", function()
				neotest.run.run()
			end, { desc = "[T]est nearest" })

			vim.keymap.set("n", "<C-p>tf", function()
				neotest.run.run(vim.fn.expand("%"))
			end, { desc = "[T]est current [F]ile" })

			vim.keymap.set("n", "<C-p>dn", function()
				neotest.run.run({ strategy = "dap" })
			end, { desc = "[D]ebug [T]est nearest" })

			vim.keymap.set("n", "<C-p>dd", function()
				neotest.run.run({ strategy = "dap" })
			end, { desc = "[D]ebug test nearest" })

			vim.keymap.set("n", "<C-p>to", function()
				neotest.output.open({})
			end, { desc = "Open [T]est [O]uput" })

			vim.keymap.set("n", "<C-p>tp", function()
				neotest.output_panel.open()
			end, { desc = "Open [T]est [P]anel" })

			vim.keymap.set("n", "<C-p>ts", function()
				neotest.summary.open()
			end, { desc = "Open [T]est [S]ummary" })

			neotest.setup({
				adapters = {
					require("neotest-jest"),
					require("neotest-vitest"),
				},
			})
		end,
	},
}
