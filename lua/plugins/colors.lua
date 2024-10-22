return {
	-- {
	-- 	"norcalli/nvim-colorizer.lua",
	-- 	opts = { "css", "html", "javascript", "lua", "toml" },
	-- },
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			filetypes = {
				"css",
				"html",
				"javascript",
				"lua",
				"toml",
			},
		},
	},
	{
		"navarasu/onedark.nvim",
		enabled = false,
		config = function()
			local onedark = require("onedark")
			onedark.setup({ style = "dark" })
			onedark.load()
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		enabled = false,
		config = function()
			vim.o.background = "light"
			require("rose-pine").setup({})
			vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("solarized-osaka").setup()
			vim.cmd("colorscheme solarized-osaka")
		end,
	},
}
