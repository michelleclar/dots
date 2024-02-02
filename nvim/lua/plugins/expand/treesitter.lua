local M = {}
M.opts = {
  ensure_installed = {
    "vim",
    "lua",
    "markdown",
    "bash",
    "python",
    "java",
    "json",
    "javascript",
    "c",
    "cpp",
    "groovy"
  },                         -- put the language you want in this array
  -- ensure_installed = "all", -- one of "all" or a list of languages
  ignore_install = { "" },   -- List of parsers to ignore installing
  sync_install = false,      -- install languages synchronously (only applied to `ensure_installed`)

  highlight = {
    enable = true,         -- false will disable the whole extension
    disable = { "css" },   -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = { "python", "css" } },
  -- 不同括号颜色区分
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000,
  },
  -- 启用增量选择模块
  incremental_selection = {

    enable = true,
    keymaps = {

      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      -- Languages that have a single comment style
      typescript = "// %s",
      css = "/* %s */",
      scss = "/* %s */",
      html = "<!-- %s -->",
      svelte = "<!-- %s -->",
      vue = "<!-- %s -->",
      json = "",
    },
  },
  autotag = { enable = false },
  textobjects = {
    swap = {
      enable = false,
      -- swap_next = textobj_swap_keymaps,
    },
    -- move = textobj_move_keymaps,
    select = {
      enable = false,
      -- keymaps = textobj_sel_keymaps,
    },
  },
  playground = {
    enable = false,
    disable = {},
    updatetime = 25,           -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false,   -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
  textsubjects = {
    enable = false,
    keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
  },
}

M.config = function()
  local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end
  treesitter.setup(M.opts)
  -- local status, ts_context_commentstring = pcall(require, "ts_context_commentstring")
  -- if not status then
  --   return
  -- end
  --
  -- ts_context_commentstring.setup({
  --   enable_autocmd = false,
  --
  --   enable = true,
  --   --[[ languages = { ]]
  --   --[[   typescript = '// %s', ]]
  --   --[[ }, ]]
  -- })
end

return M
