local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  vim.notify("nvim-tree not find")
  return
end
--- 开启nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwplugin = 1
vim.opt.termguicolors = true




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
