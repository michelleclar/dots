local M = {}

M.plugins_list = {
  {
    "goolord/alpha-nvim",
    config = function()
      require("plugins.ui.alpha").config()
    end,
    event = "VimEnter",
  }, -- 简介
  -- buffer
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("plugins.ui.bufferline").config()
    end,
    --[[ dependencies = { ]]
    --[[ 	"moll/vim-bbye", ]]
    --[[ }, ]]
    event = "User FileOpened",
    enabled = true,
  }, -- buffer分割线

  {
    "LudoPinelli/comment-box.nvim",
    config = function()
      require("plugins.ui.comment-box").config()
    end,
    event = "InsertEnter",
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.ui.gitsigns").config()
    end,
    event = "User FileOpened",
    cmd = "Gitsigns",
  }, -- 左则git提示
  -- "rebelot/heirline.nvim",
  --code line effect for while

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.ui.indentline").config()
    end,
    name = "new-indent",
    main = "ibl",
    enabled = true,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.ui.lualine").config()
    end,
    event = "VimEnter",
  }, -- 状态栏
  -- "SmiteshP/nvim-navic",

  {
    "catppuccin/nvim",
    config = function()
      require("comment.theme").catppuccin()
    end,
    name = "catppuccin",
    priority = 1000,
  },
  -- "onsails/lspkind-nvim",
  {
    "b0o/incline.nvim",
    config = function()
      require("plugins.ui.incline").config()
    end,
  }, -- 浮动状态拦
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("plugins.ui.colorizer").config()
    end,
    event = "BufReadPre",
  }, -- proview color
  {
    "j-hui/fidget.nvim",
    config = function()
      require("plugins.ui.fidget").config()
    end,
    branch = "legacy",
  }, -- dynamic Information
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("plugins.ui.symbols_outline").config()
    end,
    event = "BufReadPost",
  },
  {
    "fgheng/winbar.nvim",
    config = function()
      require("plugins.ui.winbar").config()
    end,
    event = { "InsertEnter", "CursorHoldI" },
    enabled = false,
  },
  {
    "folke/noice.nvim",
    enabled = true,
    lazy = true,
    event = "VeryLazy",
    dependencies = { "rcarriga/nvim-notify", "MunifTanjim/nui.nvim" },
    config = function()
      require("noice").setup({
        lsp = {
          progress = {
            enabled = false,
          },
        },
        presets = {
          bottom_search = false,
          -- command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = true,
        },
        messages = {
          enabled = true,
          view = "notify",
          view_error = "notify",
          view_warn = "notify",
          view_history = "messages",
          view_search = "virtualtext",
        },
        health = {
          checker = false,
        },
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "static",
      render = "compact",
      max_width = "30",
      fps = 5,
      level = 1,
      timout = 1000,
    }
  }
}
return M
