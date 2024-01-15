local M = {}

M.plugins_list = {
	-- LSP
	{
		"folke/neodev.nvim",
		opts = {},
		-- config = function()
		--   require("neodev").setup({})
		--   -- require("plugins.lsp._neodev").config()
		-- end,
		lazy = true,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		dependencies = { "mason-lspconfig.nvim", "nlsp-settings.nvim" },
	},
	{
		"williamboman/mason-lspconfig.nvim",
		cmd = { "LspInstall", "LspUninstall" },
		lazy = true,
		event = "User FileOpened",
		dependencies = "mason.nvim",
	},
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		config = function()
			require("plugins.lsp.mason").config()
			require("plugins.lsp.lspKeymaps").set_lsp_keymap()
			require("plugins.lsp.handlers").setup()
		end,
		build = function()
			pcall(function()
				require("mason-registry").refresh()
			end)
		end,
		event = "User FileOpened",
		lazy = true,
	},
	{ "tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true },
	{
		"nvimtools/none-ls.nvim",
		config = function()
			require("plugins.lsp.null_ls").config()
		end,
		lazy = true,
	},
	{
		"RRethy/vim-illuminate",
		event = "User FileOpened",
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("plugins.lsp.lsp_signature").config()
		end,
		event = { "BufRead", "BufNew" },
	},
}
return M
