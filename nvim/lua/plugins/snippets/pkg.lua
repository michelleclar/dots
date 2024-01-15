local M = {}

M.plugins_list = {
  {
    "L3MON4D3/LuaSnip",
    config = function ()
      require("plugins.snippets.luasnip").config()
    end,
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
