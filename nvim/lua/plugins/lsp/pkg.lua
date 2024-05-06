local M = {}

M.plugins_list = {
  -- LSP
  {
    "folke/neodev.nvim",
    -- config = function()
    --   require("neodev").setup({})
    --   -- require("plugins.lsp._neodev").config()
    -- end,
    lazy = true,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = { "mason-lspconfig.nvim", "nlsp-settings.nvim" },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup(require("plugins.lsp.config").installer.setup)
      local settings = require "mason-lspconfig.settings"
      settings.current.automatic_installation = false
    end,
    cmd = { "LspInstall", "LspUninstall" },
    lazy = true,
    event = "User FileOpened",
    dependencies = "mason.nvim",
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    config = function()
      require("plugins.lsp.mason").setup()
    end,
    build = function()
      pcall(function()
        require("mason-registry").refresh()
      end)
    end,
    event = "User FileOpened",
    lazy = true,
  },
  { "tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true },
  {
    "nvimtools/none-ls.nvim",
    -- config = function()
    --   require("plugins.lsp.null_ls").config()
    -- end,
    lazy = true,
  },
  {
    "RRethy/vim-illuminate",
    event = "User FileOpened",
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("plugins.lsp.lsp_signature").config()
    end,
    event = { "BufRead", "BufNew" },
  },

  {
    "mfussenegger/nvim-jdtls",
    ft = "java"
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^3",
    init = function()
      require("plugins.lsp.rust_tools").config()
    end,
    ft = { "rust", "rs" },
    enabled = true,
  },
  -- { "maxmellon/vim-jsx-pretty" },
  {
    "pmizio/typescript-tools.nvim",
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    lazy = true,
    config = function()
      require("plugins.lsp.typtools").config()
    end,
    enabled = true,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = ---@type TailwindTools.Option
    {
      document_color = {
        enabled = true, -- can be toggled by commands
        kind = "background", -- "inline" | "foreground" | "background"
        inline_symbol = "󰝤 ", -- only used in inline mode
        debounce = 200, -- in milliseconds, only applied in insert mode
      },
      conceal = {
        enabled = false, -- can be toggled by commands
        min_length = nil, -- only conceal classes exceeding the provided length
        symbol = "󱏿", -- only a single character is allowed
        highlight = { -- extmark highlight options, see :h 'highlight'
          fg = "#38BDF8",
        },
      },
      custom_filetypes = {} -- see the extension section to learn how it works
    }                       -- your configuration
  },
  {
    "trunk-io/neovim-trunk",
    lazy = false,
    -- optionally pin the version
    -- tag = "v0.1.1",
    -- these are optional config arguments (defaults shown)
    config = {
      -- trunkPath = "trunk",
      -- lspArgs = {},
      -- formatOnSave = true,
      -- formatOnSaveTimeout = 10, -- seconds
      -- logLevel = "info"
    },
    main = "trunk",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    enabled = false
  }

}
return M
