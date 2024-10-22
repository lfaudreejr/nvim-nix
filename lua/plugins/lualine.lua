return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", opt = true },
	},
	config = function()
		local lualine = require("lualine")

		local config = {
			sections = {
				lualine_a = { "mode" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "filetype" },
				lualine_z = { "location" },
			},
		}

		table.insert(config.sections.lualine_x, 1, {
			-- Lsp server name .
			function()
				local buf_clients = vim.lsp.get_clients()
				if next(buf_clients) == nil then
					return "No Active Lsp"
				end
				local buf_client_names = {}
				for _, client in pairs(buf_clients) do
					if client.name ~= "null-ls" then
						table.insert(buf_client_names, client.name)
					end
				end
				return table.concat(buf_client_names, ", ")
			end,

			icon = " LSP:",
			color = { fg = "#ffffff" },
		})
		-- Now don't forget to initialize lualine
		lualine.setup(config)
	end,
}
