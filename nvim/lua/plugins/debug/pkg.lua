local M = {}
 M.plugins_list = {
-- Debugging
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

  -- Debugger user interface
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("plugins.debug.dap").setup_ui()
    end,
    lazy = true,
    enabled = true,
  }
}

return M
