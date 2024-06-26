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
      local utils = require "util"
      local path = utils.join_paths(vim.call("stdpath", "data"), "site", "pack", "lazy", "opt", "nvim-treesitter")
      vim.opt.rtp:prepend(path) -- treesitter needs to be before nvim's runtime in rtp
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
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = {     -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
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
    lazy = true,
    event = "BufRead"
  }, -- strengthen clipboard
  -- auto change input
  -- {
  --   "keaising/im-select.nvim",
  --   config = function()
  --     require("im_select").setup({})
  --   end,
  --   lazy = true,
  --   event = "InsertEnter",
  -- },
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

  {
    "windwp/nvim-spectre",
    lazy = true,
    config = function()
      require("plugins.expand.spectre").config()
    end,
  },

  {
    "ThePrimeagen/refactoring.nvim",
    lazy = true,
    ft = { "typescript", "javascript", "lua", "c", "cpp", "go", "python", "java", "php" },
    event = "BufReadPost",
    config = function()
      require("refactoring").setup {}
    end,
    enabled = true,
  },
  {
    "kylechui/nvim-surround",
    lazy = true,
    keys = { "cs", "ds", "ys" },
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    opts = require("plugins.expand.leetcode").opts
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = { "<leader>gd", "<leader>gh" },
    config = function()
      require("plugins.expand.diffview").config()
    end,
    enabled = true,
  },
  {
    "SmiteshP/nvim-gps",
    module_pattern = { "gps", "nvim-gps" },
    config = function()
      require("plugins.expand.gps").config()
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = { "InsertEnter", "CursorHoldI" },
    enabled = false,
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          -- Defaults
          enable_close = true,          -- Auto close tags
          enable_rename = true,         -- Auto rename pairs of tags
          enable_close_on_slash = false -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
          ["html"] = {
            enable_close = false
          }
        }
      })
    end

  }

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
