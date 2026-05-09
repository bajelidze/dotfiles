-- Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		-- add LazyVim and import its plugins
		{
			"LazyVim/LazyVim",
			tag = "v14.15.1",
			import = "lazyvim.plugins",
			opts = { colorscheme = "vscode" },
		},

		{ "akinsho/bufferline.nvim", enabled = false },
		{ "which-key.nvim", enabled = false },
		{ "flash.nvim", enabled = false },
		{ "friendly-snippets", enabled = false },
		{ "lewis6991/gitsigns.nvim", enabled = false },
		{ "folke/neoconf.nvim", enabled = false },
		{ "nvimdev/dashboard-nvim", enabled = false },
		{ "olimorris/codecompanion.nvim", enabled = false },
		{ "folke/tokyonight.nvim", enabled = false },
		{ "rcarriga/nvim-notify", enabled = false },
		{ "nvim-tree/nvim-web-devicons", enabled = false },
		{ "mason.nvim", enabled = false },
		{ "mason-lspconfig.nvim", enabled = false },
		{ "mfussenegger/nvim-dap", enabled = false },
		{ "folke/todo-comments.nvim", enabled = false },
		{ "MagicDuck/grug-far.nvim", enabled = false },
		{ "folke/trouble.nvim", enabled = false },
		{ "folke/noice.nvim", enabled = false },

		{
			"folke/snacks.nvim",
			opts = {
				scroll = { enabled = false },
				explorer = { enabled = false },
				scope = { enabled = false },
				indent = { enabled = false },
				input = { enabled = false },
				picker = { enabled = false },
				dashboard = { enabled = false },
				notifier = { enabled = false },
			},
		},

		--   	{
		--   		"meta.metamate",
		--   		config = function()
		--   			require("meta.metamate").init()
		--   		end,
		--   	},

		-- add Neovim@Meta and import the language service configuration
		{
			dir = "/usr/share/fb-editor-support/nvim",
			name = "meta.nvim",
			import = "meta.lazyvim",
		},
		{ import = "lazyvim.plugins.extras.lsp.none-ls" },

		-- import/override with your plugins in `~/.config/nvim/lua/plugins`
		-- this can overwrite configurations from all of the above
		{ import = "plugins" },
	},
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins
		-- will load during startup. If you know what you're doing, you can set this
		-- to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin
		-- that support versioning, have outdated releases, which may break your
		-- Neovim install.
		version = false, -- always use the latest git commit
		-- try installing the latest stable version for plugins that support semver
		-- version = "*",
		news = false, -- don't show news popup on each launch of nvim
	},
	checker = { enabled = false }, -- don't automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

require("meta.metamate").init({
	completionKeymap = "<Tab>",
})

-- meta.nvim ships LSP configs in both the legacy lspconfig format
-- (lua/lspconfig/configs/<name>.lua) and the new vim.lsp.config() format
-- (lsp/<name>.lua). LazyVim's lspconfig spec uses the legacy path, which
-- works in fbsource (has .buckconfig at the root) but returns nil in
-- configerator (no .buckconfig), so no LSP attaches there. Fall back to
-- vim.lsp.enable() for the new-format config in projects where the legacy
-- path wouldn't have started anything — otherwise we'd get duplicate
-- clients (and duplicated hover output) in fbsource.
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local arc_root = require("meta.util").arc.get_project_root(vim.loop.cwd())
		if not arc_root then
			return
		end
		if vim.fn.empty(vim.fn.glob(arc_root .. "/.buckconfig")) == 0 then
			return
		end
		vim.lsp.enable({
			"fb-pyright-ls@meta",
			"cppls@meta",
			"rust-analyzer@meta",
			"gopls@meta",
			"thriftlsp@meta",
			"buck2@meta",
			"erlang@meta",
			"eslint@meta",
			"prettier@meta",
			"linttool@meta",
			"flow@meta",
		})
	end,
})
