return {
	{
		"echasnovski/mini.jump",
		event = "VeryLazy",
		keys = { "f", "F", "t", "T" },
		config = function()
			require("mini.jump").setup()
		end,
	},
	{
		"echasnovski/mini.cursorword",
		event = "VeryLazy",
		config = function()
			require("mini.cursorword").setup()
		end,
	},
	{
		"echasnovski/mini.bufremove",
		event = "VeryLazy",
		opts = {},
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},
}
