local plugins = {
	-- base
	"folke/which-key.nvim", -- key tip
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"p00f/nvim-ts-rainbow", -- 配合treesitter，不同括号颜色区分
		},
	}, -- 语法高亮

	{
		"gbprod/cutlass.nvim",
		config = function()
			require("cutlass").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				cut_key = "x",
				override_del = nil,
				exclude = {},
				registers = {
					select = "s",
					delete = "d",
					change = "c",
				},
			})
		end,
	},
}
table.insert(plugins, "test")
for k, v in ipairs(plugins) do
	print(k, v)
end
--[[ require('/home/carl/.config/nvim/lua/util/utils').writeFile(nil,plugins) ]]
