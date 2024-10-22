return {
	"folke/which-key.nvim",
	event = "VimEnter",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		local wk = require("which-key")

		wk.setup({})

		wk.add({
			{ "<leader>e", "<cmd>Neotree reveal<CR>", desc = "Neotree" },
			{ "<leader>b", group = "Buffer" },
			{ "<leader>c", group = "Code" },
			{ "<leader>d", group = "Document" },
			{ "<leader>f", group = "Find" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>t", group = "Toggle" },
			{ "<leader>r", group = "Rename" },
			{ "<leader>w", group = "Workspace" },
			-- { "<leader>p", function() require("lazy").home() end, desc = "Manager" },
			{ "<leader>w", "<cmd>w<CR>", desc = "Save" },
			{ "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
			-- { "<leader>b", group = "Buffer" },
			{
				"<leader>bc",
				function()
					require("user.utils").close_buffer_with_confirmation()
				end,
				desc = "Close",
			},
			{
				"<leader>bd",
				function()
					require("mini.bufremove").delete(0, false)
				end,
				desc = "Delete",
			},
			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete (force)",
			},
			-- { "<leader>br", desc = "Rename" },
			{
				"<leader>ff",
				"<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<CR>",
				desc = "Find File",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep({})
				end,
				desc = "Live Grep",
			},
			{
				"<leader>fw",
				function()
					require("telescope.builtin").grep_string({})
				end,
				desc = "Find Word",
			},
			{
				"<leader><leader>",
				function()
					require("telescope.builtin").buffers({})
				end,
				desc = "Search Buffers",
			},
			-- { "<leader>l", group = "LSP" },
			-- { "<leader>la", desc = "LSP" },
		})
	end,
}
