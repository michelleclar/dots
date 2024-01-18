local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- base
  {
    "nvim-lua/plenary.nvim",
    cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" },
    lazy = true
  },

  { "Tastyep/structlog.nvim", lazy = true },
  -- "nvim-lua/popup.nvim",
  -- theme
  --[[ "lunarvim/darkplus.nvim", ]]
  --[[ "folke/tokyonight.nvim", -- 主题 ]]
  -- "nvim-tree/nvim-web-devicons", -- 文档树图标
  -- git gui
  "kdheepak/lazygit.nvim",
}
local components = {
  "cmp",
  "diagnostics",
  "expand",
  "ui",
  "file",
  "git",
  "snippets",
  "terminal",
  "lsp",
}
for _, completion in pairs(components) do
  --[[ vim.notify("loading " .. completion) ]]
  local require_ok, pls = pcall(require, "plugins." .. completion .. ".pkg")
  if require_ok then
    table.insert(plugins, pls.plugins_list)
  end
end
local opts = {} -- 注意要定义这个变量

require("lazy").setup(plugins, opts)
require("plugins.lsp").setup()
require("autocommands")
require("_neodev")
