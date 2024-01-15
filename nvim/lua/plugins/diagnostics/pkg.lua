local M = {}

M.plugins_list = {

  {
    "folke/trouble.nvim",
    config = function()
      -- require("plugins.diagnostics.trouble").config()
      require("trouble").setup {
        auto_open = false,
        auto_close = true,
        padding = false,
        height = 10,
        use_diagnostic_signs = true,
      }
    end,
    event = "VeryLazy",
    enable = false,
    cmd = "Trouble",
  },
  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   event = "LspAttach",
  --   enable = false,
  --   lazy = true,
  --   config = function()
  --     require("lsp_lines").setup()
  --   end,
  -- },
}
return M
