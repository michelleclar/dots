local M = {}

M.plugins_list = {
	{
		"goolord/alpha-nvim",
		config = function()
			require("plugins.ui.alpha").config()
		end,
		event = "VimEnter",
	}, -- 简介
	-- buffer
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("plugins.ui.bufferline").config()
		end,
		--[[ dependencies = { ]]
		--[[ 	"moll/vim-bbye", ]]
		--[[ }, ]]
		event = "User FileOpened",
		enabled = true,
	}, -- buffer分割线

	{
		"LudoPinelli/comment-box.nvim",
		config = function()
			require("plugins.ui.comment-box").config()
		end,
		event = "InsertEnter",
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "User FileOpened",
		cmd = "Gitsigns",
	}, -- 左则git提示
	-- "rebelot/heirline.nvim",
	--code line effect for while

	{
		"lukas-reineke/indent-blankline.nvim",
		name = "new-indent",
		main = "ibl",
		enabled = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
	}, -- 状态栏
	-- "SmiteshP/nvim-navic",

	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	-- "onsails/lspkind-nvim",
	"b0o/incline.nvim", -- 浮动状态拦
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("plugins.ui.colorizer").config()
		end,
		event = "BufReadPre",
	}, -- proview color
	{
		"j-hui/fidget.nvim",
		config = function()
			require("plugins.ui.fidget").config()
		end,
		branch = "legacy",
	}, -- dynamic LSP schedule
	{
		"simrat39/symbols-outline.nvim",
		event = "BufReadPost",
	},
}
-- local heirline = require 'plugins.ui.heirline'
-- table.insert(M.plugins_list,heirline)
return M
