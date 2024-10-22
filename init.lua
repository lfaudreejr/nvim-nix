-- NOTE: NIXCATS USERS:
-- NOTE: there are also notes added as a tutorial of how to use the nixCats lazy wrapper.
-- you can search for the following string in order to find them:
-- NOTE: nixCats:

-- like this one:
-- NOTE: nixCats: this just gives nixCats global command a default value
-- so that it doesnt throw an error if you didnt install via nix.
-- usage of both this setup and the nixCats command is optional,
-- but it is very useful for passing info from nix to lua so you will likely use it at least once.
require("nixCatsUtils").setup({
	non_nix_value = true,
})

require("config.options")
require("config.keybinds")
require("config.autocmds")

local pluginList = nil
local nixLazyPath = nil
if require("nixCatsUtils").isNixCats then
	local allPlugins = require("nixCats").pawsible.allPlugins
	-- it is called pluginList because we only need to pass in the names
	-- this list literally just tells lazy.nvim not to download the plugins in the list.
	pluginList = require("nixCatsUtils.lazyCat").mergePluginTables(allPlugins.start, allPlugins.opt)

	-- it wasnt detecting that these were already added
	-- because the names are slightly different from the url.
	-- when that happens, add them to the list, then also specify the new name in the lazySpec
	-- pluginList[ [[Comment.nvim]] ] = ""
	pluginList[ [[LuaSnip]] ] = ""
	-- alternatively you can do it all in the plugins spec instead of modifying this list.
	-- just set the name and then add `dev = require('nixCatsUtils').lazyAdd(false, true)` to the spec

	-- HINT: to view the names of all plugins downloaded via nix, use the `:NixCats pawsible` command.

	-- we also want to pass in lazy.nvim's path
	-- so that the wrapper can add it to the runtime path
	-- as the normal lazy installation instructions dictate
	nixLazyPath = allPlugins.start[ [[lazy.nvim]] ]
end
-- NOTE: nixCats: You might want to move the lazy-lock.json file
local function getlockfilepath()
	if require("nixCatsUtils").isNixCats and type(require("nixCats").settings.unwrappedCfgPath) == "string" then
		return require("nixCats").settings.unwrappedCfgPath .. "/lazy-lock.json"
	else
		return vim.fn.stdpath("config") .. "/lazy-lock.json"
	end
end
local lazyOptions = {
	lockfile = getlockfilepath(),
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
}
-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
-- NOTE: nixCats: this the lazy wrapper.
require("nixCatsUtils.lazyCat").setup(pluginList, nixLazyPath, {
	{ import = "plugins" },
}, lazyOptions)
