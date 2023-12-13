--- ### AstroNvim Utilities
--
-- Various utility functions to use within AstroNvim and user configurations.
--
-- This module can be loaded with `local utils = require "astronvim.utils"`
--
-- @module astronvim.utils
-- @copyright 2022
-- @license GNU General Public License v3.0

local M = {}

--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function M.extend_tbl(default, opts)
	opts = opts or {}
	return default and vim.tbl_deep_extend("force", default, opts) or opts
end

--- Insert one or more values into a list like table and maintain that you do not insert non-unique values (THIS MODIFIES `lst`)
---@param lst any[]|nil The list like table that you want to insert into
---@param vals any|any[] Either a list like table of values to be inserted or a single value to be inserted
---@return any[] # The modified list like table
function M.list_insert_unique(lst, vals)
	if not lst then
		lst = {}
	end
	assert(vim.tbl_islist(lst), "Provided table is not a list like table")
	if not vim.tbl_islist(vals) then
		vals = { vals }
	end
	local added = {}
	vim.tbl_map(function(v)
		added[v] = true
	end, lst)
	for _, val in ipairs(vals) do
		if not added[val] then
			table.insert(lst, val)
			added[val] = true
		end
	end
	return lst
end

--- Call function if a condition is met
---@param func function The function to run
---@param condition boolean # Whether to run the function or not
---@return any|nil result # the result of the function running or nil
function M.conditional_func(func, condition, ...)
	-- if the condition is true or no condition is provided, evaluate the function with the rest of the parameters and return the result
	if condition and type(func) == "function" then
		return func(...)
	end
end

--- Get an icon from the AstroNvim internal icons if it is available and return it
---@param kind string The kind of icon in astronvim.icons to retrieve
---@param padding? integer Padding to add to the end of the icon
---@param no_fallback? boolean Whether or not to disable fallback to text icon
---@return string icon
function M.get_icon(kind, padding, no_fallback)
	if not vim.g.icons_enabled and no_fallback then
		return ""
	end
	local icon_pack = vim.g.icons_enabled and "icons" or "text_icons"
	if not M[icon_pack] then
		M.icons = require("plugins.ui.icons.nerd_font")
		M.text_icons = require("plugins.ui.icons.text")
	end
	local icon = M[icon_pack] and M[icon_pack][kind]
	return icon and icon .. string.rep(" ", padding or 0) or ""
end

--- Get a icon spinner table if it is available in the AstroNvim icons. Icons in format `kind1`,`kind2`, `kind3`, ...
---@param kind string The kind of icon to check for sequential entries of
---@return string[]|nil spinners # A collected table of spinning icons in sequential order or nil if none exist
function M.get_spinner(kind, ...)
	local spinner = {}
	repeat
		local icon = M.get_icon(("%s%d"):format(kind, #spinner + 1), ...)
		if icon ~= "" then
			table.insert(spinner, icon)
		end
	until not icon or icon == ""
	if #spinner > 0 then
		return spinner
	end
end

--- Get highlight properties for a given highlight name
---@param name string The highlight group name
---@param fallback? table The fallback highlight properties
---@return table properties # the highlight group properties
function M.get_hlgroup(name, fallback)
	if vim.fn.hlexists(name) == 1 then
		local hl
		if vim.api.nvim_get_hl then -- check for new neovim 0.9 API
			hl = vim.api.nvim_get_hl(0, { name = name, link = false })
			if not hl.fg then
				hl.fg = "NONE"
			end
			if not hl.bg then
				hl.bg = "NONE"
			end
		else
			hl = vim.api.nvim_get_hl_by_name(name, vim.o.termguicolors)
			if not hl.foreground then
				hl.foreground = "NONE"
			end
			if not hl.background then
				hl.background = "NONE"
			end
			hl.fg, hl.bg = hl.foreground, hl.background
			hl.ctermfg, hl.ctermbg = hl.fg, hl.bg
			hl.sp = hl.special
		end
		return hl
	end
	return fallback or {}
end

--- Serve a notification with a title of AstroNvim
---@param msg string The notification body
---@param type? number The type of the notification (:help vim.log.levels)
---@param opts? table The nvim-notify options to use (:help notify-options)
function M.notify(msg, type, opts)
	vim.schedule(function()
		vim.notify(msg, type, M.extend_tbl({ title = "AstroNvim" }, opts))
	end)
end

--- Trigger an AstroNvim user event
---@param event string The event name to be appended to Astro
---@param delay? boolean Whether or not to delay the event asynchronously (Default: true)
function M.event(event, delay)
	local emit_event = function()
		vim.api.nvim_exec_autocmds("User", { pattern = "Astro" .. event, modeline = false })
	end
	if delay == false then
		emit_event()
	else
		vim.schedule(emit_event)
	end
end

--- Open a URL under the cursor with the current operating system
---@param path string The path of the file to open with the system opener
function M.system_open(path)
	-- TODO: REMOVE WHEN DROPPING NEOVIM <0.10
	if vim.ui.open then
		return vim.ui.open(path)
	end
	local cmd
	if vim.fn.has("win32") == 1 and vim.fn.executable("explorer") == 1 then
		cmd = { "cmd.exe", "/K", "explorer" }
	elseif vim.fn.has("unix") == 1 and vim.fn.executable("xdg-open") == 1 then
		cmd = { "xdg-open" }
	elseif (vim.fn.has("mac") == 1 or vim.fn.has("unix") == 1) and vim.fn.executable("open") == 1 then
		cmd = { "open" }
	end
	if not cmd then
		M.notify("Available system opening tool not found!", vim.log.levels.ERROR)
	end
	vim.fn.jobstart(vim.fn.extend(cmd, { path or vim.fn.expand("<cfile>") }), { detach = true })
end

--- Create a button entity to use with the alpha dashboard
---@param sc string The keybinding string to convert to a button
---@param txt string The explanation text of what the keybinding does
---@return table # A button entity table for an alpha configuration
function M.alpha_button(sc, txt)
	-- replace <leader> in shortcut text with LDR for nicer printing
	local sc_ = sc:gsub("%s", ""):gsub("LDR", "<Leader>")
	-- if the leader is set, replace the text with the actual leader key for nicer printing
	if vim.g.mapleader then
		sc = sc:gsub("LDR", vim.g.mapleader == " " and "SPC" or vim.g.mapleader)
	end
	-- return the button entity to display the correct text and send the correct keybinding on press
	return {
		type = "button",
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
			vim.api.nvim_feedkeys(key, "normal", false)
		end,
		opts = {
			position = "center",
			text = txt,
			shortcut = sc,
			cursor = -2,
			width = 36,
			align_shortcut = "right",
			hl = "DashboardCenter",
			hl_shortcut = "DashboardShortcut",
		},
	}
end

--- Check if a plugin is defined in lazy. Useful with lazy loading when a plugin is not necessarily loaded yet
---@param plugin string The plugin to search for
---@return boolean available # Whether the plugin is available
function M.is_available(plugin)
	local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
	return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

--- Resolve the options table for a given plugin with lazy
---@param plugin string The plugin to search for
---@return table opts # The plugin options
function M.plugin_opts(plugin)
	local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
	local lazy_plugin_avail, lazy_plugin = pcall(require, "lazy.core.plugin")
	local opts = {}
	if lazy_config_avail and lazy_plugin_avail then
		local spec = lazy_config.spec.plugins[plugin]
		if spec then
			opts = lazy_plugin.values(spec, "opts")
		end
	end
	return opts
end

--- A helper function to wrap a module function to require a plugin before running
---@param plugin string The plugin to call `require("lazy").load` with
---@param module table The system module where the functions live (e.g. `vim.ui`)
---@param func_names string|string[] The functions to wrap in the given module (e.g. `{ "ui", "select }`)
function M.load_plugin_with_func(plugin, module, func_names)
	if type(func_names) == "string" then
		func_names = { func_names }
	end
	for _, func in ipairs(func_names) do
		local old_func = module[func]
		module[func] = function(...)
			module[func] = old_func
			require("lazy").load({ plugins = { plugin } })
			module[func](...)
		end
	end
end

--- regex used for matching a valid URL/URI string
M.url_matcher =
	"\\v\\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)%([&:#*@~%_\\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)[&:#*@~%_\\-=?!+/0-9a-z]+|:\\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\\([&:#*@~%_\\-=?!+;/.0-9a-z]*\\)|\\[[&:#*@~%_\\-=?!+;/.0-9a-z]*\\]|\\{%([&:#*@~%_\\-=?!+;/.0-9a-z]*|\\{[&:#*@~%_\\-=?!+;/.0-9a-z]*})\\})+"

--- Delete the syntax matching rules for URLs/URIs if set
function M.delete_url_match()
	for _, match in ipairs(vim.fn.getmatches()) do
		if match.group == "HighlightURL" then
			vim.fn.matchdelete(match.id)
		end
	end
end

--- Add syntax matching rules for highlighting URLs/URIs
function M.set_url_match()
	M.delete_url_match()
	if vim.g.highlighturl_enabled then
		vim.fn.matchadd("HighlightURL", M.url_matcher, 15)
	end
end

--- Run a shell command and capture the output and if the command succeeded or failed
---@param cmd string|string[] The terminal command to execute
---@param show_error? boolean Whether or not to show an unsuccessful command as an error to the user
---@return string|nil # The result of a successfully executed command or nil
function M.cmd(cmd, show_error)
	if type(cmd) == "string" then
		cmd = { cmd }
	end
	if vim.fn.has("win32") == 1 then
		cmd = vim.list_extend({ "cmd.exe", "/C" }, cmd)
	end
	local result = vim.fn.system(cmd)
	local success = vim.api.nvim_get_vvar("shell_error") == 0
	if not success and (show_error == nil or show_error) then
		vim.api.nvim_err_writeln(
			("Error running command %s\nError message:\n%s"):format(table.concat(cmd, " "), result)
		)
	end
	return success and result:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "") or nil
end

function M.writeFile(fileName, content)
	if fileName == nil then
		fileName = "/home/carl/.config/nvim/test/lua.log"
	end
	local f = assert(io.open(fileName, "a+"))
	f:write(content)
	f:close()
end

return M
