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
  { "tamago324/nlsp-settings.nvim",           cmd = "LspSettings", lazy = true },
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
    opts = {
      custom_filetypes = {
        "tsx", "css", "html"
      }
    } -- your configuration
  }

}
return M
