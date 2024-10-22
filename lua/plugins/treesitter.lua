return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = require("nixCatsUtils").lazyAdd(":TSUpdate"),
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects", pin = true },
			{ "nvim-treesitter/nvim-treesitter-context" },
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{ "windwp/nvim-ts-autotag" },
		},
		event = "BufReadPost",
		-- cmd = {
		-- 	"TSBufDisable",
		-- 	"TSBufEnable",
		-- 	"TSBufToggle",
		-- 	"TSDisable",
		-- 	"TSEnable",
		-- 	"TSToggle",
		-- 	"TSInstall",
		-- 	"TSInstallInfo",
		-- 	"TSInstallSync",
		-- 	"TSModuleInfo",
		-- 	"TSUninstall",
		-- 	"TSUpdate",
		-- 	"TSUpdateSync",
		-- },
		config = function()
			require("nvim-treesitter.install").prefer_git = true
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				autotag = { enable = true, enable_close_on_slash = false },
				highlight = {
					enable = true,
					disable = function(_, bufnr)
						return vim.api.nvim_buf_line_count(bufnr) > 10000
					end,
				},
				incremental_selection = { enable = true },
				indent = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["ak"] = "@block.outer",
							["ik"] = "@block.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["a?"] = "@conditional.outer",
							["i?"] = "@conditional.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]k"] = { query = "@block.outer", desc = "Next block start" },
							["]c"] = { query = "@class.outer", desc = "Next class start" },
							["]f"] = { query = "@function.outer", desc = "Next function start" },
							["]a"] = { query = "@parameter.outer", desc = "Next parameter start" },
						},
						goto_next_end = {
							["]k"] = { query = "@block.outer", desc = "Next block end" },
							["]c"] = { query = "@class.outer", desc = "Next class end" },
							["]f"] = { query = "@function.outer", desc = "Next function end" },
							["]a"] = { query = "@parameter.outer", desc = "Next parameter end" },
						},
						goto_previous_start = {
							["[k"] = { query = "@block.outer", desc = "Previous block start" },
							["[c"] = { query = "@class.outer", desc = "Previous class start" },
							["[f"] = { query = "@function.outer", desc = "Previous function start" },
							["[a"] = { query = "@parameter.outer", desc = "Previous parameter start" },
						},
						goto_previous_end = {
							["[K"] = { query = "@block.outer", desc = "Previous block end" },
							["[C"] = { query = "@class.outer", desc = "Previous class end" },
							["[F"] = { query = "@function.outer", desc = "Previous function end" },
							["[A"] = { query = "@parameter.outer", desc = "Previous parameter end" },
						},
					},
					swap = {
						enable = true,
						swap_next = {
							[">k"] = { query = "@block.outer", desc = "Swap next block" },
							[">f"] = { query = "@function.outer", desc = "Swap next function" },
							[">a"] = { query = "@parameter.inner", desc = "Swap next parameter" },
						},
						swap_previous = {
							["<k"] = { query = "@block.outer", desc = "Swap previous block" },
							["<f"] = { query = "@function.outer", desc = "Swap previous function" },
							["<a"] = { query = "@parameter.inner", desc = "Swap previous parameter" },
						},
					},
				},
				ensure_installed = require("nixCatsUtils").lazyAdd({
					"javascript",
					"typescript",
					"tsx",
					"svelte",
					"php",
					"html",
					"css",
					"json",
					"lua",
					"vim",
					"vimdoc",
					"clojure",
					"go",
				}),
				auto_install = require("nixCatsUtils").lazyAdd(true, false),
			})

			require("ts_context_commentstring").setup({
				enable = true,
				enable_autocmd = false,
			})
		end,
	},
}
