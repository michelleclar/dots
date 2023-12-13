local M = {}

M.plugins_list = {
	"windwp/nvim-autopairs", -- 自动补全括号
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			-- "octaltree/cmp-look",
			-- "hrsh7th/cmp-calc",
			-- "hrsh7th/cmp-emoji",
			-- "jc-doyle/cmp-pandoc-references",
			-- "kdheepak/cmp-latex-symbols",
			"hrsh7th/cmp-buffer", -- buffer
			"hrsh7th/cmp-path", -- 文件路径
			"hrsh7th/cmp-cmdline", -- cmdline
			"hrsh7th/cmp-nvim-lsp",
			-- "hrsh7th/cmp-nvim-lua", -- lua 提示 vim
		},
	}, -- completion plugin
}
return M
