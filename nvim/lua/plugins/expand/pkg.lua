local M = {}

M.plugins_list = {

  {
    "numToStr/Comment.nvim",
    config = function()
      require("plugins.expand.comment").config()
    end,
    -- lazy = false,
    enabled = true,
    event = "User FileOpened",
  }, -- 快速注释
  {
    -- Lazy loaded by Comment.nvim pre_hook
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.expand.project").config()
    end,
    event = "VimEnter",
    cmd = "Telescope projects",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("plugins.expand.treesitter").config()
    end,
    -- build = ":TSUpdate",
    dependencies = {
      "p00f/nvim-ts-rainbow", -- 配合treesitter，不同括号颜色区分
    },
    cmd = {
      "TSInstall",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
      "TSInstallInfo",
      "TSInstallSync",
      "TSInstallFromGrammar",
    },
    event = "User FileOpened",
  }, -- 语法高亮

  {
    "folke/which-key.nvim",
    config = function()
      require("plugins.expand.whichkey").config()
    end,
    cmd = "WhichKey",
    event = "VeryLazy",
  }, -- key tip

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
  -- { "echasnovski/mini.nvim", version = "*" },
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      { "plenary.nvim" },
      { "nvim-lua/popup.nvim" },
    },
  }, -- bookmark
  {
    "folke/todo-comments.nvim",
    config = function()
      require("plugins.expand.todo-comments").config()
    end,
    dependencies = "plenary.nvim",
    event = "BufRead",
  },
  {
    "phaazon/hop.nvim",
    config = function()
      require("plugins.expand.hop").config()
    end,
    event = "VeryLazy",
    cmd = { "HopChar1CurrentLineAC", "HopChar1CurrentLineBC", "HopChar2MW", "HopWordMW" },
  }, -- more cursor
  {
    "RishabhRD/nvim-cheat.sh",
    dependencies = "RishabhRD/popfix",
    config = function()
      vim.g.cheat_default_window_layout = "vertical_split"
    end,
    lazy = true,
    cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
    keys = "<leader>?",
    enabled = true,
  },

  -- {
  --   "windwp/nvim-spectre",
  --   lazy = true,
  --   config = function()
  --     require("user.spectre").config()
  --   end,
  -- },
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
