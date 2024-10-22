return {
	"xiyaowong/transparent.nvim",
	enabled = true,
	opts = {
		groups = { -- table: default groups
			"Normal",
			"NormalNC",
			"Comment",
			"Constant",
			"Special",
			"Identifier",
			"Statement",
			"PreProc",
			"Type",
			"Underlined",
			"Todo",
			"String",
			"Function",
			"Conditional",
			"Repeat",
			"Operator",
			"Structure",
			"LineNr",
			"NonText",
			"SignColumn",
			"CursorLineNr",
			"EndOfBuffer",
		},
		extra_groups = {}, -- table: additional groups that should be cleared
		exclude_groups = {
			"NormalFloat",
		}, -- table: groups you don't want to clear
	},
}
