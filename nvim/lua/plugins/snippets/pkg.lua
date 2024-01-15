local M = {}

M.plugins_list = {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "friendly-snippets",
    },
    event = "InsertEnter"
  }, -- snippets引擎
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
  },
}
return M
