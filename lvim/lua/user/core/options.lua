local M = {}
local custom = function()
	lvim.leader = " "
	lvim.colorscheme = "tokyonight-moon" -- set to a custom theme
	lvim.builtin.time_based_themes = true -- set false to use your own configured theme
	lvim.transparent_window = false -- enable/disable transparency
	lvim.debug = false
	vim.lsp.set_log_level("error")
	lvim.log.level = "warn"
	lvim.builtin.noice = { active = false } -- enables noice.nvim and inc-rename.nvim
	lvim.builtin.sidebar = { active = false } -- enable/disable sidebar
	lvim.builtin.harpoon = { active = true } -- use the harpoon plugin
	lvim.builtin.symbols_usage = { active = false } -- enable/disable symbols-usage.nvim
	lvim.builtin.markdown = { active = false } -- enable/disable markdown.nvim
	lvim.builtin.sql_integration = { active = false } -- use sql integration
	lvim.builtin.metals = {
		active = false, -- enable/disable nvim-metals for scala development
		fallbackScalaVersion = "3.2.0-RC3",
		serverVersion = "1.0.1",
		bloopVersion = "1.5.11",
	}
	lvim.builtin.fancy_diff = { active = false } -- enable/disable fancier git diff
	lvim.builtin.legendary = { active = false } -- enable/disable legendary plugin ( ctrl-p command )
	lvim.builtin.file_browser = { active = false } -- enable/disable telescope file browser
	lvim.builtin.mind = { active = false, root_path = "~/.mind" } -- enable/disable mind.nvim
	lvim.builtin.test_runner = { active = true, runner = "neotest" } -- change this to enable/disable ultest or neotest
	lvim.builtin.trouble = { active = false } -- enable/disable trouble.nvim
	lvim.builtin.fancy_wild_menu = { active = false } -- enable/disable cmp-cmdline
	lvim.builtin.sell_your_soul_to_devil = { active = false, prada = false, openai = false } -- if you want microsoft to abuse your soul
	lvim.builtin.go_programming = { active = false } -- gopher.nvim + nvim-dap-go
	lvim.builtin.lastplace = { active = false } -- change to false if you are jumping to future
	lvim.builtin.tabnine = { active = true } -- change to false if you don't like tabnine
	lvim.builtin.web_programming = { active = true, extra = "typescript-tools.nvim" } -- (typescript.nvim or typescript-tools.nvim) + package-info.nvim
	lvim.builtin.bufferline.active = true
	lvim.builtin.neoclip = { active = true, enable_persistent_history = false }
	lvim.builtin.smooth_scroll = "cinnamon"
	lvim.builtin.refactoring = { active = true } -- enable to use refactoring.nvim code_actions
	lvim.builtin.tree_provider = "neo-tree" -- can be "neo-tree" or "nvimtree" or ""
	lvim.builtin.tmux_lualine = true
end

M.config = function()
	custom()
	local disabled_plugins = {
		"2html_plugin",
		"getscript",
		"getscriptPlugin",
		"gzip",
		"logipat",
		-- "netrw",
		-- "netrwPlugin",
		-- "netrwSettings",
		-- "netrwFileHandlers",
		"matchit",
		"tar",
		"tarPlugin",
		"rrhelper",
		"spellfile_plugin",
		"vimball",
		"vimballPlugin",
		"zip",
		"zipPlugin",
	}
	for _, plugin in pairs(disabled_plugins) do
		vim.g["loaded_" .. plugin] = 1
	end
	vim.g.ultest_summary_width = 30
	vim.g.ultest_deprecation_notice = 0
	vim.opt.completeopt = { "menu", "menuone", "noselect" }
	vim.opt.relativenumber = true
	vim.opt.diffopt = {
		"internal",
		"filler",
		"closeoff",
		"hiddenoff",
		"algorithm:minimal",
	}
	vim.g.toggle_theme_icon = "   "
	vim.opt.backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim"
	vim.opt.ttyfast = true
	vim.opt.wrap = true
	vim.opt.termguicolors = true
	vim.opt.updatetime = 100
	vim.opt.timeoutlen = 250
	vim.opt.redrawtime = 1500
	vim.opt.ttimeoutlen = 10
	vim.opt.wrapscan = true -- Searches wrap around the end of the file
	vim.o.secure = true -- Disable autocmd etc for project local vimrc files.
	vim.o.exrc = false -- Allow project local vimrc files example .nvimrc see :h exrc
	vim.o.sessionoptions = "buffers,curdir,folds,globals,help,tabpages,winpos,winsize"
	vim.wo.foldmethod = "expr"
	vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
	vim.wo.foldlevel = 4
	vim.wo.foldnestmax = 3
	vim.wo.foldminlines = 1
	vim.o.foldtext = "v:lua.HighlightedFoldtext()"
	vim.opt.guifont = "FiraCode Nerd Font:h13"
	vim.opt.cmdheight = 1
	vim.g.root_lsp_ignore = { "copilot" }
	vim.g.dashboard_enable_session = 0
	vim.g.dashboard_disable_statusline = 1
	vim.opt.pumblend = 10
	vim.opt.joinspaces = false
	vim.opt.list = true
	vim.opt.confirm = true -- make vim prompt me to save before doing destructive things
	vim.opt.autowriteall = true -- automatically :write before running commands and changing files
	vim.opt.clipboard = "unnamedplus"
	vim.opt.fillchars = {
		fold = " ",
		eob = " ", -- suppress ~ at EndOfBuffer
		diff = "╱", -- alternatives = ⣿ ░ ─
		msgsep = "‾",
		foldopen = "▾",
		foldsep = "│",
		foldclose = "▸",
		horiz = "━",
		horizup = "┻",
		horizdown = "┳",
		vert = "┃",
		vertleft = "┫",
		vertright = "┣",
		verthoriz = "╋",
	}
	vim.opt.wildignore = {
		"*.aux,*.out,*.toc",
		"*.o,*.obj,*.dll,*.jar,*.pyc,__pycache__,*.rbc,*.class",
		-- media
		"*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp",
		"*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm",
		"*.eot,*.otf,*.ttf,*.woff",
		"*.doc,*.pdf",
		-- archives
		"*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz",
		-- temp/system
		"*.*~,*~ ",
		"*.swp,.lock,.DS_Store,._*,tags.lock",
		-- version control
		".git,.svn",
		--rust
		"Cargo.lock,Cargo.Bazel.lock",
	}
	vim.opt.shortmess = {
		t = true, -- truncate file messages at start
		A = true, -- ignore annoying swap file messages
		o = true, -- file-read message overwrites previous
		O = true, -- file-read message overwrites previous
		T = true, -- truncate non-file messages in middle
		f = true, -- (file x of x) instead of just (x of x
		F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
		s = true,
		c = true,
		W = true, -- Don't show [w] or written when writing
	}
	vim.opt.formatoptions = {
		["1"] = true,
		["2"] = true, -- Use indent from 2nd line of a paragraph
		q = true, -- continue comments with gq"
		c = true, -- Auto-wrap comments using textwidth
		r = true, -- Continue comments when pressing Enter
		n = true, -- Recognize numbered lists
		t = false, -- autowrap lines using text width value
		j = true, -- remove a comment leader when joining lines.
		-- Only break if the line was not longer than 'textwidth' when the insert
		-- started and only at a white character that has been entered during the
		-- current insert command.
		l = true,
		v = true,
	}
	vim.opt.listchars = {
		eol = nil,
		tab = "│ ",
		extends = "›", -- Alternatives: … »
		precedes = "‹", -- Alternatives: … «
		trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
	}
	vim.o.qftf = "{info -> v:lua._G.qftf(info)}"

	-- Cursorline highlighting control
	--  Only have it on in the active buffer
	vim.opt.cursorline = true -- Highlight the current line
	local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
	vim.api.nvim_create_autocmd("WinLeave", {
		group = group,
		callback = function()
			vim.opt_local.cursorline = false
		end,
	})
	vim.api.nvim_create_autocmd("WinEnter", {
		group = group,
		callback = function()
			if vim.bo.filetype ~= "alpha" then
				vim.opt_local.cursorline = true
			end
		end,
	})

	vim.filetype.add({
		extension = {
			fnl = "fennel",
			wiki = "markdown",
		},
		filename = {
			["go.sum"] = "gosum",
			["go.mod"] = "gomod",
		},
		pattern = {
			["*.tml"] = "gohtmltmpl",
			["%.env.*"] = "sh",
		},
	})
	vim.g.editorconfig = true

	if vim.g.neovide then
		vim.g.neovide_cursor_animation_length = 0.01
		vim.g.neovide_cursor_trail_length = 0.05
		vim.g.neovide_cursor_antialiasing = true
		vim.g.neovide_remember_window_size = true
		vim.cmd([[set guifont=FiraCode\ Nerd\ Font,mini-file-icons]])
	end

	if vim.g.nvui then
		-- Configure nvui here
		vim.cmd([[NvuiCmdFontFamily FiraCode Nerd Font]])
		vim.cmd([[set linespace=1]])
		vim.cmd([[set guifont=FiraCode\ Nerd\ Font:h14]])
		vim.cmd([[NvuiPopupMenuDefaultIconFg white]])
		vim.cmd([[NvuiCmdBg #1e2125]])
		vim.cmd([[NvuiCmdFg #abb2bf]])
		vim.cmd([[NvuiCmdBigFontScaleFactor 1.0]])
		vim.cmd([[NvuiCmdPadding 10]])
		vim.cmd([[NvuiCmdCenterXPos 0.5]])
		vim.cmd([[NvuiCmdTopPos 0.0]])
		vim.cmd([[NvuiCmdFontSize 20.0]])
		vim.cmd([[NvuiCmdBorderWidth 5]])
		vim.cmd([[NvuiPopupMenuIconFg variable #56b6c2]])
		vim.cmd([[NvuiPopupMenuIconFg function #c678dd]])
		vim.cmd([[NvuiPopupMenuIconFg method #c678dd]])
		vim.cmd([[NvuiPopupMenuIconFg field #d19a66]])
		vim.cmd([[NvuiPopupMenuIconFg property #d19a66]])
		vim.cmd([[NvuiPopupMenuIconFg module white]])
		vim.cmd([[NvuiPopupMenuIconFg struct #e5c07b]])
		vim.cmd([[NvuiCaretExtendTop 15]])
		vim.cmd([[NvuiCaretExtendBottom 8]])
		vim.cmd([[NvuiTitlebarFontSize 12]])
		vim.cmd([[NvuiTitlebarFontFamily Arial]])
		vim.cmd([[NvuiCursorAnimationDuration 0.1]])
		-- vim.cmd [[NvuiToggleFrameless]]
		vim.cmd([[NvuiOpacity 0.99]])
	end
end

-- credit: https://github.com/nyngwang/NeoZoom.lua
function M.maximize_current_split()
	local cur_win = vim.api.nvim_get_current_win()
	vim.api.nvim_set_var("non_float_total", 0)
	vim.cmd("windo if &buftype != 'nofile' | let g:non_float_total += 1 | endif")
	vim.api.nvim_set_current_win(cur_win or 0)
	if vim.api.nvim_get_var("non_float_total") == 1 then
		if vim.fn.tabpagenr("$") == 1 then
			return
		end
		vim.cmd("tabclose")
	else
		local last_cursor = vim.api.nvim_win_get_cursor(0)
		vim.cmd("tabedit %:p")
		vim.api.nvim_win_set_cursor(0, last_cursor)
	end
end

function _G.qftf(info)
	local fn = vim.fn
	local items
	local ret = {}
	if info.quickfix == 1 then
		items = fn.getqflist({ id = info.id, items = 0 }).items
	else
		items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
	end
	local limit = 25
	local fname_fmt1, fname_fmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
	local valid_fmt, invalid_fmt = "%s |%5d:%-3d|%s %s", "%s"
	for i = info.start_idx, info.end_idx do
		local e = items[i]
		local fname = ""
		local str
		if e.valid == 1 then
			if e.bufnr > 0 then
				fname = vim.api.nvim_buf_get_name(e.bufnr)
				if fname == "" then
					fname = "[No Name]"
				else
					fname = fname:gsub("^" .. vim.env.HOME, "~")
				end
				if fn.strwidth(fname) <= limit then
					fname = fname_fmt1:format(fname)
				else
					fname = fname_fmt2:format(fname:sub(1 - limit, -1))
				end
			end
			local lnum = e.lnum > 99999 and "inf" or e.lnum
			local col = e.col > 999 and "inf" or e.col
			local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
			str = valid_fmt:format(fname, lnum, col, qtype, e.text)
		else
			str = invalid_fmt:format(e.text)
		end
		table.insert(ret, str)
	end
	return ret
end

return M
