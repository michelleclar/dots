return {
	"rebelot/heirline.nvim",
	opts = function()
		-- local status = require("plugins.ui.lineUtil")
		local component = require("plugins.ui.lineUtil.component")

		return {
			statusline = { -- statusline
				hl = { fg = "fg", bg = "bg" },
				component.mode({ mode_text = { padding = { left = 1, right = 1 } } }), -- add the mode text
				component.git_branch(),
				component.file_info({ filetype = {}, filename = false, file_modified = false }),
				component.git_diff(),
				component.diagnostics(),
				component.fill(),
				component.cmd_info(),
				component.fill(),
				component.lsp(),
				component.treesitter(),
				component.nav(),
				-- remove the 2nd mode indicator on the right
			},
		}
	end,
	config = require("plugins.ui.lineUtil.temp"),
}
