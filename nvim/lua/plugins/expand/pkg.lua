local M = {}

M.plugins_list = {

  "numToStr/Comment.nvim", -- gcc和gc注释

  "JoosepAlviste/nvim-ts-context-commentstring",

  "ahmedkhalf/project.nvim", -- project mananger
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "p00f/nvim-ts-rainbow", -- 配合treesitter，不同括号颜色区分
    },
  },                          -- 语法高亮

  "folke/which-key.nvim",     -- key tip

  {
    "gbprod/cutlass.nvim",
    config = function()
      require("cutlass").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        cut_key = "x",
        override_del = nil,
        exclude = {},
        registers = {
          select = "s",
          delete = "d",
          change = "c",
        },
      })
    end,
  }, -- strengthen clipboard
  -- auto change input
  {
    "keaising/im-select.nvim",
    config = function()
      require("im_select").setup({})
    end,
  },
  { "echasnovski/mini.nvim", version = "*" },
  "ThePrimeagen/harpoon", -- bookmark
  {
    "folke/todo-comments.nvim",
  }, -- 标签
  {
    "phaazon/hop.nvim",
    event = "VeryLazy",
    cmd = { "HopChar1CurrentLineAC", "HopChar1CurrentLineBC", "HopChar2MW", "HopWordMW" },
  }, -- more cursor
  --[[ { ]]
  --[[ 	"iamcco/markdown-preview.nvim", ]]
  --[[ 	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }, ]]
  --[[ 	build = "cd app && npm install", ]]
  --[[ 	init = function() ]]
  --[[ 		vim.g.mkdp_filetypes = { "markdown" } ]]
  --[[ 	end, ]]
  --[[ 	ft = { "markdown" }, ]]
  --[[ }, ]]
}
return M
