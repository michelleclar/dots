local M = {}
local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end
local step = {
	ensure_installed = {
		"vim",
		"vimdoc",
		"lua",
		"markdown",
		"bash",
		"python",
		"java",
		"json",
		"javascript",
		"c",
		"cpp",
	}, -- put the language you want in this array
	-- ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css" } },
	-- 不同括号颜色区分
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
	-- 启用增量选择模块
	incremental_selection = {

		enable = true,
		keymaps = {

			init_selection = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<BS>",
			scope_incremental = "<TAB>",
		},
	},
}
treesitter.setup(step)
local status, ts_context_commentstring = pcall(require, "ts_context_commentstring")
if not status then
	return
end

ts_context_commentstring.setup({
	enable_autocmd = false,

	enable = true,
	--[[ languages = { ]]
	--[[   typescript = '// %s', ]]
	--[[ }, ]]
})
