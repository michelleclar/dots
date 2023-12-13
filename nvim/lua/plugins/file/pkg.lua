local M = {}

M.plugins_list = {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- 文档树图标
		}, -- 文档树
	},

	-- toggleterm 文件检索
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-media-files.nvim", -- 图片等预览
		},
	},
}
return M
