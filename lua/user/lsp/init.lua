local P = {}

function P.setup()
	local lsp_ok, lsp_zero = pcall(require, "lsp-zero")
	if not lsp_ok then
		return nil
	end

	lsp_zero.extend_lspconfig()

	lsp_zero.on_attach(function(client, bufnr)
		-- see :help lsp-zero-keybindings
		-- to learn the available actions
		lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false, exclude = { "K" } })

		local opts = { buffer = bufnr, remap = false }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "<leader>ss", function()
			vim.lsp.buf.document_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>sS", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>ld", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("n", "<leader>la", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>lr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>br", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)

		if client.server_capabilities.documentSymbolProvider then
			require("nvim-navic").attach(client, bufnr)
		end
	end)

	lsp_zero.set_server_config({
		on_init = function(client)
			client.server_capabilities.semanticTokensProvider = nil
		end,
	})

	require("mason").setup({})
	require("mason-lspconfig").setup({
		ensure_installed = {
			"lua_ls",
			"ts_ls",
			"rust_analyzer",
			"gopls",
			"clojure_lsp",
			"jsonls",
			"tailwindcss",
			"svelte",
			"ocamllsp",
			"hls",
		},
		handlers = {
			lsp_zero.default_setup,
			ts_ls = lsp_zero.noop,
			rust_analyzer = function()
				local rust_tools = require("rust-tools")
				rust_tools.setup({
					on_attach = function(_, bufnr)
						vim.keymap.set("n", "<leader>la", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
					end,
				})
			end,
			-- tsserver = function()
			-- 	require("typescript-tools").setup({})
			-- end,
			lua_ls = function()
				local lua_opts = lsp_zero.nvim_lua_ls()
				require("lspconfig").lua_ls.setup(lua_opts)
			end,
		},
	})

	lsp_zero.setup()
end

return P
