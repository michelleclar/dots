local M = {}
local style_1 = {
  on_config_done = nil,

  -- A list of parser names, or "all"
  ensure_installed = { "comment", "markdown_inline", "regex" },

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  -- A directory to install the parsers into.
  -- By default parsers are installed to either the package dir, or the "site" dir.
  -- If a custom path is used (not nil) it must be added to the runtimepath.
  parser_install_dir = nil,

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  matchup = {
    enable = false, -- mandatory, false will disable the whole extension
    -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
    disable = function(lang, buf)
      if vim.tbl_contains({ "latex" }, lang) then
        return true
      end

      local status_ok, big_file_detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
      return status_ok and big_file_detected
    end,
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
  indent = { enable = true, disable = { "yaml", "python" } },
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
  textsubjects = {
    enable = false,
    keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
  },
  playground = {
    enable = false,
    disable = {},
    updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
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
  rainbow = {
    enable = false,
    extended_mode = true,  -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  },
}
local style_2 = {
  ensure_installed = {
    "vim",
    "lua",
    "markdown",
    "bash",
    "python",
    "java",
    "json",
    -- "javascript",
    "c",
    "cpp",
    "groovy"
  },                       -- put the language you want in this array
  -- ensure_installed = "all", -- one of "all" or a list of languages
  ignore_install = { "" }, -- List of parsers to ignore installing
  sync_install = false,    -- install languages synchronously (only applied to `ensure_installed`)

  highlight = {
    enable = true,       -- false will disable the whole extension
    disable = { "css" }, -- list of language that will be disabled
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
    updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
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
M.opts = style_1
M.config = function()
  local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end
  treesitter.setup(M.opts)

  -- handle deprecated API, https://github.com/windwp/nvim-autopairs/pull/324
  local ts_utils = require "nvim-treesitter.ts_utils"
  ts_utils.is_in_node_range = vim.treesitter.is_in_node_range
  ts_utils.get_node_range = vim.treesitter.get_node_range
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
