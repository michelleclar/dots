local M = {}

M.plugins_list = {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("plugins.file.nvim-tree").config()
    end,
    -- dependencies = {
    --   "nvim-tree/nvim-web-devicons", -- 文档树图标
    -- },                            -- 文档树
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
    event = "User DirOpened",
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- toggleterm 文件检索
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("plugins.file.telescope").config()
    end,
    dependencies = {
      "nvim-telescope/telescope-media-files.nvim", -- 图片等预览
    },
    build = "make",
    lazy = true,
  },
}
return M
