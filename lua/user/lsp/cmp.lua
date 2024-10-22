local CMP = {}

function CMP.setup()
	local cmp = require 'cmp'
	local luasnip = require 'luasnip'
	local neogen = require 'neogen'

	luasnip.config.setup {}
	
	local has_words_before = function()
		-- was vim.api.nvim_buf_get_option
		-- if vim.api.nvim_buf_get_option_value(0, "buftype") == "prompt" then
		if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
			return false
		end
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
	end

	cmp.setup {
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		completion = { completeopt = "menu,menuone,noinsert" },
		mapping = cmp.mapping.preset.insert {
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-f>"] = cmp.mapping.scroll_docs(-4),
			["<C-b>"] = cmp.mapping.scroll_docs(4),
			["<C-y>"] = cmp.mapping.confirm({
				-- documentation says this is important.
				-- I don't know why.
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}),
			["<Tab>"] = vim.schedule_wrap(function(fallback)
				if cmp.visible() and has_words_before() then
					cmp.select_next_item({
						behavior = cmp.SelectBehavior.Select,
					})
				else
					fallback()
				end
			end),
			["<C-j>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif neogen.jumpable() then
					neogen.jump_next()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s", "c" }),
			["<C-k>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				elseif neogen.jumpable(1) then
					neogen.jump_prev()
				else
					fallback()
				end
			end, { "i", "s", "c" }),
		},
		sources = cmp.config.sources({
			{
				name = "nvim_lsp",
				keyword_length = 1,
			},
			{ name = "nvim_lsp_signature_help" },
			{
				name = "nvim_lua",
			},
			{
				name = "luasnip",
				keyword_length = 3,
			},
			{
				name = "copilot",
			},
		}, {
			{
				name = "path",
			},
			{
				name = "buffer",
				keyword_length = 3,
			},
		})
		
	}

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = { {
			name = "buffer",
		} },
	})
	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({ {
			name = "path",
		} }, { {
			name = "cmdline",
		} }),
	})
end

return CMP
