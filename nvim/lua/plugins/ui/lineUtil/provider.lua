--- ### AstroNvim Status Providers
--
-- Statusline related provider functions for building statusline components
--
-- This module can be loaded with `local provider = require "astronvim.utils.status.provider"`
--
-- @module astronvim.utils.status.provider
-- @copyright 2023
-- @license GNU General Public License v3.0

local M = {}

local status_utils = require("plugins.ui.lineUtil.utils")

local utils = require("util")
local extend_tbl = utils.extend_tbl
local get_icon = utils.get_icon

function M.filename(opts)
	opts = extend_tbl({
		fallback = "Untitled",
		fname = function(nr)
			return vim.api.nvim_buf_get_name(nr)
		end,
		modify = ":t",
	}, opts)
	return function(self)
		local path = opts.fname(self and self.bufnr or 0)
		local filename = vim.fn.fnamemodify(path, opts.modify)
		return status_utils.stylize((path == "" and opts.fallback or filename), opts)
	end
end

function M.str(opts)
	opts = extend_tbl({ str = " " }, opts)
	return status_utils.stylize(opts.str, opts)
end

function M.unique_path(opts)
	opts = extend_tbl({
		buf_name = function(bufnr)
			return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
		end,
		bufnr = 0,
		max_length = 16,
	}, opts)
	local function path_parts(bufnr)
		local parts = {}
		for match in (vim.api.nvim_buf_get_name(bufnr) .. "/"):gmatch("(.-)" .. "/") do
			table.insert(parts, match)
		end
		return parts
	end
	return function(self)
		opts.bufnr = self and self.bufnr or opts.bufnr
		local name = opts.buf_name(opts.bufnr)
		local unique_path = ""
		-- check for same buffer names under different dirs
		local current
		for _, value in ipairs(vim.t.bufs or {}) do
			if name == opts.buf_name(value) and value ~= opts.bufnr then
				if not current then
					current = path_parts(opts.bufnr)
				end
				local other = path_parts(value)

				for i = #current - 1, 1, -1 do
					if current[i] ~= other[i] then
						unique_path = current[i] .. "/"
						break
					end
				end
			end
		end
		return status_utils.stylize(
			(
				opts.max_length > 0
				and #unique_path > opts.max_length
				and string.sub(unique_path, 1, opts.max_length - 2) .. get_icon("Ellipsis") .. "/"
			) or unique_path,
			opts
		)
	end
end

function M.fill()
	return "%="
end

function M.close_button(opts)
	opts = extend_tbl({ kind = "BufferClose" }, opts)
	return status_utils.stylize(get_icon(opts.kind), opts)
end

function M.tabnr()
	return function(self)
		return (self and self.tabnr) and "%" .. self.tabnr .. "T " .. self.tabnr .. " %T" or ""
	end
end

return M
