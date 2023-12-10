local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  vim.notify("nvim-tree not find")
  return
end
--- 开启nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwplugin = 1
vim.opt.termguicolors = true
local map = vim.opt.keymap

local opts = { noremap = true, silent = true }
-- empty setup using defaults

-- 列表快捷键
local keymapList = {
  { key = { "o", "<CR>", "<2-LeftMouse>" }, action = "edit" },
  { key = "L",                              action = "cd" },
  { key = "h",                          action = "split" },
  { key = "v",                          action = "vsplit" },
  { key = "<C-t>",                          action = "tabnew" },
  { key = "h",                              action = "close_node" },
  { key = "<Tab>",                          action = "preview" },
  { key = "R",                              action = "refresh" },
  { key = "c",                              action = "create" },
  { key = "D",                              action = "trash" },
  { key = "r",                              action = "rename" },
  { key = "<C-r>",                          action = "full_rename" },
  { key = "d",                              action = "cut" },
  { key = "y",                              action = "copy" },
  { key = "p",                              action = "paste" },
  { key = "P",                              action = "bulk_move" },
  { key = "f",                              action = "live_filter" },
  { key = "-",                              action = "collapse_all" },
  { key = "gyn",                            action = "copy_name" },
  { key = "gyp",                            action = "copy_path" },
  {
    key = "gya",
    action = "copy_absolute_path",
  },
  { key = "H",       action = "dir_up" },
  { key = "s",       action = "system_open" },
  { key = "<Space>", action = "toggle_mark" },
  { key = "K",       action = "toggle_file_info" },
  { key = "<",       action = "first_sibling" },
  { key = ">",       action = "last_sibling" },
}

nvim_tree.setup({
  git = {
    enable = false,
  },
  -- project plugin
  update_cwd = true,
  update_focused_file = {

    enable = true,
    update_cwd = true,
  },
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
    side = "left",
    -- 不显示行数
    number = false,
    relativenumber = false,
    -- 显示图标
    signcolumn = "yes",
  },
  renderer = {
    group_empty = true,
  },
  -- 隐藏 .文件 和 node_modules 文件夹
  filters = {

    dotfiles = true,
    custom = {
      "node_modules",
    },
  },
  actions = {

    open_file = {

      -- 首次打开大小适配
      resize_window = true,
      -- 打开文件时关闭
      quit_on_open = false,
    },
  },
})
-- 自动关闭
-- vim.cmd([[
--   autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
-- ]])
