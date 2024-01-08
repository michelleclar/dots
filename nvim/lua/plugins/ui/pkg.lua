local M = {}

M.plugins_list = {
	"goolord/alpha-nvim", -- 简介
	-- buffer
	{
		"akinsho/bufferline.nvim",
		--[[ dependencies = { ]]
		--[[ 	"moll/vim-bbye", ]]
		--[[ }, ]]
	}, -- buffer分割线

	-- "moll/vim-bbye",
	"LudoPinelli/comment-box.nvim",
	"lewis6991/gitsigns.nvim", -- 左则git提示
	-- "rebelot/heirline.nvim",
	"lukas-reineke/indent-blankline.nvim", --code line effect for while
	"nvim-lualine/lualine.nvim", -- 状态栏
	-- "SmiteshP/nvim-navic",

	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	"onsails/lspkind-nvim",
	"b0o/incline.nvim", -- 浮动状态拦
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPre",
	}, -- proview color
}
-- local heirline = require 'plugins.ui.heirline'
-- table.insert(M.plugins_list,heirline)
return M
