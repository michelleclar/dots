local M = {}

M.plugins_list = {
  -- LSP
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim", -- 这个相当于mason.nvim和lspconfig的桥梁
    "neovim/nvim-lspconfig",
    "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
    "RRethy/vim-illuminate",
  },
  {
    "ray-x/lsp_signature.nvim",
    event = { "BufRead", "BufNew" },

  },
}
return M
