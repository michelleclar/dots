local M = {}
M.plugins_list = {
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("plugins.debug.dap").config()
    end,
    lazy = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    enabled = true,
  },

  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("plugins.debug.dap").setup_ui()
    end,
    lazy = true,
    enabled = true,
  },
  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    config = function()
      require("plugins.debug.vim_test").config()
    end,
    enabled = true,
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
      require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
      require("dap-python").test_runner = "pytest"
    end,
    ft = "python",
    event = { "BufRead", "BufNew" },
    enabled = true,
  },
  {
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup()
    end,
    ft = { "go", "gomod" },
    event = { "BufRead", "BufNew" },
    enabled = true,
  },
  {
    "nvim-neotest/neotest",
    config = function()
      require("plugins.debug.neotest").config()
    end,
    dependencies = {
      { "nvim-neotest/neotest-plenary" },
    },
    event = { "BufReadPost", "BufNew" },
    enabled = true,
  },
  { "nvim-neotest/neotest-go",     event = { "BufEnter *.go" } },
  { "nvim-neotest/neotest-python", event = { "BufEnter *.py" } },
  { "rouge8/neotest-rust",         event = { "BufEnter *.rs" } },

}

return M
