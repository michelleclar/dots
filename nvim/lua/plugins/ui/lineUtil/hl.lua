--- ### AstroNvim Status Highlighting
--
-- Statusline related highlighting utilities
--
-- This module can be loaded with `local hl = require "astronvim.utils.status.hl"`
--
-- @module astronvim.utils.status.hl
-- @copyright 2023
-- @license GNU General Public License v3.0

local M = {}

local env = require "plugins.ui.lineUtil.env"
M.attributes ={
  buffer_active = { bold = true, italic = true },
  buffer_picker = { bold = true },
  macro_recording = { bold = true },
  git_branch = { bold = true },
  git_diff = { bold = true },
}
function M.get_attributes(name, include_bg)
  local hl = M.attributes[name] or {}
  hl.fg = name .. "_fg"
  if include_bg then hl.bg = name .. "_bg" end
  return hl
end

function M.file_icon(name)
  local hl_enabled = env.icon_highlights.file_icon[name]
  return function(self)
    if hl_enabled == true or (type(hl_enabled) == "function" and hl_enabled(self)) then
      return M.filetype_color(self)
    end
  end
end
function M.mode_bg() return env.modes[vim.fn.mode()][2] end
function M.lualine_mode(mode, fallback)
  if not vim.g.colors_name then return fallback end
  local lualine_avail, lualine = pcall(require, "lualine.themes." .. vim.g.colors_name)
  local lualine_opts = lualine_avail and lualine[mode]
  return lualine_opts and type(lualine_opts.a) == "table" and lualine_opts.a.bg or fallback
end
return M
