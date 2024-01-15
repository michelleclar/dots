local M = {}

M.plugins_list = {
  {
    "windwp/nvim-autopairs",
    config = function ()
      require("plugins.cmp.autopairs").config()
    end,
    event = "InsertEnter",
    dependencies = { "nvim-treesitter", "nvim-cmp" },
  }, -- 自动补全括号
  {
    "hrsh7th/nvim-cmp",
    config = function ()
      require("plugins.cmp.cmp").config()
    end,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "cmp-nvim-lsp",
      "cmp_luasnip",
      "cmp-buffer",
      "cmp-path",
      "cmp-cmdline",
    },
    -- dependencies = {
    --   -- "octaltree/cmp-look",
    --   -- "hrsh7th/cmp-calc",
    --   -- "hrsh7th/cmp-emoji",
    --   -- "jc-doyle/cmp-pandoc-references",
    --   -- "kdheepak/cmp-latex-symbols",
    --   "hrsh7th/cmp-buffer", -- buffer
    --   "hrsh7th/cmp-path", -- 文件路径
    --   "hrsh7th/cmp-cmdline", -- cmdline
    --   "hrsh7th/cmp-nvim-lsp",
    --   -- "hrsh7th/cmp-nvim-lua", -- lua 提示 vim
    -- },
  }, -- completion plugin
  { "hrsh7th/cmp-nvim-lsp",     lazy = true },
  { "saadparwaiz1/cmp_luasnip", lazy = true },
  { "hrsh7th/cmp-buffer",       lazy = true },
  { "hrsh7th/cmp-path",         lazy = true },
  {
    "hrsh7th/cmp-cmdline",
    lazy = true,
  },
  {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
    config = function()
      local tabnine = require "cmp_tabnine.config"
      tabnine:setup {
        max_lines = 1000,
        max_num_results = 10,
        sort = true,
      }
    end,
    lazy = true,
    event = "InsertEnter",
    enabled = true,
  },
}
return M
