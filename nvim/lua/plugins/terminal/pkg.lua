local M = {}

M.plugins_list = {

	{
		"akinsho/toggleterm.nvim",
		init = function()
			require("plugins.terminal.toggleterm").init()
		end,
		config = function()
			require("plugins.terminal.toggleterm").config()
		end,
		branch = "main",
		cmd = {
			"ToggleTerm",
			"TermExec",
			"ToggleTermToggleAll",
			"ToggleTermSendCurrentLine",
			"ToggleTermSendVisualLines",
			"ToggleTermSendVisualSelection",
		},
		keys = require("plugins.terminal.toggleterm").opts.open_mapping,
		enabled = true,
	},
}
return M
