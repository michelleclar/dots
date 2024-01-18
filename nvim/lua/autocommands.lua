local M = {}
-- autocmd! remove all autocommands, if entered under a group it will clear that group
vim.api.nvim_exec_autocmds("User", { pattern = "FileOpened" })

vim.api.nvim_create_augroup("user", {})
local create_aucmd = vim.api.nvim_create_autocmd
vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

]]

local Log = require "log"
--- Clean autocommand in a group if it exists
--- This is safer than trying to delete the augroup itself
---@param name string the augroup name
function M.clear_augroup(name)
  -- defer the function in case the autocommand is still in-use
  Log:debug("request to clear autocmds  " .. name)
  vim.schedule(function()
    pcall(function()
      vim.api.nvim_clear_autocmds { group = name }
    end)
  end)
end

function M.disable_format_on_save()
  M.clear_augroup "lsp_format_on_save"
  Log:debug "disabled format-on-save"
end

local format_on_save = {
  ---@usage boolean: format on save (Default: false)
  enabled = false,
  ---@usage pattern string pattern used for the autocommand (Default: '*')
  pattern = "*",
  ---@usage timeout number timeout in ms for the format request (Default: 1000)
  timeout = 1000,
  ---@usage filter func to select client
  filter = require("util").format_filter,
}
function M.configure_format_on_save()
  if type(format_on_save) == "table" and format_on_save.enabled then
    M.enable_format_on_save()
  elseif format_on_save == true then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

local get_format_on_save_opts = function()
  local defaults = format_on_save
  -- accept a basic boolean `lvim.format_on_save=true`
  if type(format_on_save) ~= "table" then
    return defaults
  end

  return {
    pattern = format_on_save.pattern,
    timeout = format_on_save.timeout,
  }
end

function M.enable_format_on_save()
  local opts = get_format_on_save_opts()
  vim.api.nvim_create_augroup("lsp_format_on_save", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = "lsp_format_on_save",
    pattern = opts.pattern,
    callback = function()
      require("plugins.lsp.utils").format { timeout_ms = opts.timeout, filter = opts.filter }
    end,
  })
  vim.notify("enabled format-on-save")
end

create_aucmd("BufWinEnter", {
  group = "user",
  pattern = "*.md",
  desc = "beautify markdown",
  callback = function()
    vim.cmd [[set syntax=markdown]]
    require("plugins.ui.markdown_syn").set_syntax()
  end,
})



return M
