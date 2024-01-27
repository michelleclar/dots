local M = {}

M.plugins_list = {
  {
    "L3MON4D3/LuaSnip",
    -- config = function ()
    --   require("plugins.snippets.luasnip").config()
    -- end,
    config = function()
      local utils = require "util"
      local paths = {}
      paths[#paths + 1] = utils.join_paths(vim.fn.stdpath("data"), "lazy", "opt", "friendly-snippets")
      local user_snippets = utils.join_paths(vim.fn.stdpath("config"), "snippets")
      if utils.is_directory(user_snippets) then
        paths[#paths + 1] = user_snippets
      end
      require("luasnip.loaders.from_lua").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = paths,
      }
      require("luasnip.loaders.from_snipmate").lazy_load()
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
