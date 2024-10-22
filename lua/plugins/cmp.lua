return {
	{
		-- Autocompletion
		-- "hrsh7th/nvim-cmp",
		"yioneko/nvim-cmp",
		event = { "InsertEnter" },
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			-- Snippet Engine & its associated nvim-cmp source
		      {
			'L3MON4D3/LuaSnip',
			-- NOTE: nixCats: nix downloads it with a different file name.
			-- tell lazy about that.
			name = 'luasnip',
			build = require('nixCatsUtils').lazyAdd((function()
			  -- Build Step is needed for regex support in snippets.
			  -- This step is not supported in many windows environments.
			  -- Remove the below condition to re-enable on windows.
			  if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
			    return
			  end
			  return 'make install_jsregexp'
			end)()),
			dependencies = {
			  -- `friendly-snippets` contains a variety of premade snippets.
			  --    See the README about individual language/framework/plugin snippets:
			  --    https://github.com/rafamadriz/friendly-snippets
			  {
			    'rafamadriz/friendly-snippets',
			    config = function()
			      require('luasnip.loaders.from_vscode').lazy_load()
			    end,
			  },
			},
		      },
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
      			require("user.lsp.cmp").setup()
		end,
	},	
}
