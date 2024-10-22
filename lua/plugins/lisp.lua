return {
	{
		"gpanders/nvim-parinfer",
		ft = { "clojure", "yuck" },
		init = function()
			vim.g.parinfer_force_balance = true
			vim.g.parinfer_comment_chars = ";;"
		end,
	},
	{
		"elkowar/yuck.vim",
		config = function() end,
	},
}
