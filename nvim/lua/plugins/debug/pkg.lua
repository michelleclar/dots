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
      "theHamsta/nvim-dap-virtual-text",
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
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enable_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        filter_references_pattern = '<module',
        virt_text_pos = 'eol',
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil
      })
    end,
    lazy = true,
    enabled = true,
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    lazy = true,
    event = { "BufReadPre", "BufNew" },
    config = function()
      require("dap-vscode-js").setup {
        debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
        debugger_cmd = { "js-debug-adapter" },
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      }
    end,
    enabled = true,
  },

}

return M
