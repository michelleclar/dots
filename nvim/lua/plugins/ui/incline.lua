local M = {}
M.config = function()
	local status_ok, incline = pcall(require, "incline")
	if not status_ok then
		return
	end

	local function truncate(str, max_len)
		assert(str and max_len, "string and max_len must be provided")
		return vim.api.nvim_strwidth(str) > max_len and str:sub(1, max_len) .. "…" or str
	end
	local function render(props)
		local fmt = string.format
		local devicons = require("nvim-web-devicons")
		local bufname = vim.api.nvim_buf_get_name(props.buf)
		if bufname == "" then
			return "[No name]"
		end
		local ret = vim.api.nvim_get_hl_by_name("Directory", true)
		local directory_color = string.format("#%06x", ret["foreground"])
		local parts = vim.split(vim.fn.fnamemodify(bufname, ":."), "/")
		local result = {}
		for idx, part in ipairs(parts) do
			if next(parts, idx) then
				vim.list_extend(result, {
					{ truncate(part, 20) },
					{ fmt(" %s ", ""), guifg = directory_color },
				})
			else
				table.insert(result, { part, gui = "bold", guisp = directory_color })
			end
		end
		local icon, color = devicons.get_icon_color(bufname, nil, { default = true })
		table.insert(result, #result, { icon .. " ", guifg = color })
		return result
	end
	-- local opts = {
	-- 	debounce_threshold = {
	-- 		falling = 50,
	-- 		rising = 10,
	-- 	},
	-- 	hide = {
	-- 		cursorline = false,
	-- 		focused_win = false,
	-- 		only_win = false,
	-- 	},
	-- 	highlight = {
	-- 		groups = {
	-- 			InclineNormal = {
	-- 				default = true,
	-- 				group = "NormalFloat",
	-- 			},
	-- 			InclineNormalNC = {
	-- 				default = true,
	-- 				group = "NormalFloat",
	-- 			},
	-- 		},
	-- 	},
	-- 	ignore = {
	-- 		buftypes = "special",
	-- 		filetypes = {},
	-- 		floating_wins = true,
	-- 		unlisted_buffers = true,
	-- 		wintypes = "special",
	-- 	},
	-- 	render = "basic",
	-- 	window = {
	-- 		margin = {
	-- 			horizontal = 1,
	-- 			vertical = 1,
	-- 		},
	-- 		options = {
	-- 			signcolumn = "no",
	-- 			wrap = false,
	-- 		},
	-- 		padding = 1,
	-- 		padding_char = " ",
	-- 		placement = {
	-- 			horizontal = "right",
	-- 			vertical = "top",
	-- 		},
	-- 		width = "fit",
	-- 		winhighlight = {
	-- 			active = {
	-- 				EndOfBuffer = "None",
	-- 				Normal = "InclineNormal",
	-- 				Search = "None",
	-- 			},
	-- 			inactive = {
	-- 				EndOfBuffer = "None",
	-- 				Normal = "InclineNormalNC",
	-- 				Search = "None",
	-- 			},
	-- 		},
	-- 		zindex = 50,
	-- 	},
	-- }
	local opts = {
		window = {
			zindex = 49,
			winhighlight = {
				inactive = {
					Normal = "Directory",
				},
			},
			width = "fit",
			padding = { left = 2, right = 1 },
			placement = { vertical = "top", horizontal = "right" },
			margin = {
				horizontal = 0,
			},
		},
		hide = {
			cursorline = false,
			focused_win = true,
			only_win = false,
		},
		render = render,
	}
	incline.setup(opts)
end
return M
