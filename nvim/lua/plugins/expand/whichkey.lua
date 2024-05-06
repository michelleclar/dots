local M = {}
local ui = require("comment.icons").ui
M.opts = {
  ---@usage disable which-key completely [not recommended]
  active = true,
  on_config_done = nil,
  setup = {
    plugins = {
      marks = false,     -- shows a list of your marks on ' and `
      registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true,
        suggestions = 20,
      }, -- use which-key for spelling hints
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false,    -- adds help for operators like d, y, ...
        motions = false,      -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false,      -- default bindings on <c-w>
        nav = false,          -- misc bindings to work with windows
        z = false,            -- bindings for folds, spelling and others prefixed with z
        g = false,            -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = "Comments" },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      -- ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    icons = {
      breadcrumb = ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
      separator = ui.BoldArrowRight,      -- symbol used between a key and it's label
      group = ui.Plus,                    -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },
    window = {
      border = "single",        -- none, single, double, shadow
      position = "bottom",      -- bottom, top
      margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 },                                             -- min and max height of the columns
      width = { min = 20, max = 50 },                                             -- min and max width of the columns
      spacing = 3,                                                                -- spacing between columns
      align = "left",                                                             -- align columns left, center or right
    },
    ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true,                                                             -- show help message on the command line when the popup is visible
    show_keys = true,                                                             -- show the currently pressed key and its label as a message in the command line
    triggers = "auto",                                                            -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
    -- disable the WhichKey popup for certain buf types and file types.
    -- Disabled by default for Telescope
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  },

  opts = {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  },
  vopts = {
    mode = "v",     -- VISUAL mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  },
  -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
  -- see https://neovim.io/doc/user/map.html#:map-cmd
  vmappings = {
    ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    },
  },
  mappings = {
    ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
    ["B"] = {
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Buffers",
    },
    ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>confirm quitall<CR>", "Quit" },
    -- ["c"] = { "<cmd>lua require('util').delete_buffer()<cr>", "Close Buffer" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    ["F"] = {
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Find files",
    },
    ["N"] = { "<cmd>NoiceTelescope<cr>", "Show Noice" },
    ["S"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
    ["o"] = { "<cmd>SymbolsOutline<cr>", " Symbol Outline" },
    ["H"] = { "<cmd>Telescope help_tags<cr>", "find help doc" },
    ["?"] = { "<cmd>Cheat<cr>", "Cheat" },
    c = {
      name = " □  Boxes",
      b = { "<Cmd>CBccbox<CR>", "Box Title" },
      t = { "<Cmd>CBllline<CR>", "Titled Line" },
      l = { "<Cmd>CBline<CR>", "Simple Line" },
      m = { "<Cmd>CBllbox14<CR>", "Marked" },
    },
    L = {
      name = "+Lazy",
      b = { "<cmd>Lazy build<cr>", "build" },
      i = { "<cmd>Lazy install<cr>", "Install" },
      s = { "<cmd>Lazy sync<cr>", "Sync" },
      h = { "<cmd>Lazy health<cr>", "health" },
      u = { "<cmd>Lazy update<cr>", "Update" },
    },
    f = {
      name = "+Find",

      s = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
      h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      C = { "<cmd>Telescope commands<cr>", "Commands" },
      X = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics (Trouble)" },
      x = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics (Trouble)" },
      o = { "<cmd>lua require 'harpoon.ui'.toggle_quick_menu()<cr>", 'show file list by your mark' },
      l = { "<cmd>TodoTelescope<cr>", "label" }
    },
    g = {
      name = "+Git",
      g = { "<cmd>LazyGit<CR>", "Lazygit" },
      j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        "Undo Stage Hunk",
      },
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      d = {
        "<cmd>Gitsigns diffthis HEAD<cr>",
        "Diff",
      },
    },

    l = {
      name = "+LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      d = {
        "<cmd>Telescope lsp_document_diagnostics<cr>",
        "Document Diagnostics",
      },
      w = {
        "<cmd>Telescope lsp_workspace_diagnostics<cr>",
        "Workspace Diagnostics",
      },
      f = { "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
      j = {
        "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
        "Next Diagnostic",
      },
      k = {
        "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
        "Prev Diagnostic",
      },
      l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        "Workspace Symbols",
      },
      R = { "<cmd>lua require('plugins.lsp').generate_templates()<cr>","gen templates" },
    },
    s = {
      name = "+Split",
      h = { "<C-w>s", "垂直新增窗口" },
      v = { "<C-w>v", "水平新增窗口" },
    },

    t = {
      name = "+Test",
      f = {
        "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), env=require('user.ntest').get_env()})<cr>",
        "File",
      },
      o = { "<cmd>lua require('neotest').output.open({ enter = true, short = false })<cr>", "Output" },
      r = { "<cmd>lua require('neotest').run.run({env=require('user.ntest').get_env()})<cr>", "Run" },
      a = { "<cmd>lua require('plugins.debug.neotest').run_all()<cr>", "Run All" },
      c = { "<cmd>lua require('plugins.debug.neotest').cancel()<cr>", "Cancel" },
      R = { "<cmd>lua require('plugins.debug.neotest').run_file_sync()<cr>", "Run Async" },
      s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
      n = { "<cmd>lua require('neotest').jump.next({ status = 'failed' })<cr>", "jump to next failed" },
      p = { "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<cr>", "jump to previous failed" },
      d = { "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<cr>", "Dap Run" },
      x = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
      w = { "<cmd>lua require('neotest').watch.watch()<cr>", "Watch" },
    },
    u = {
      name = "+UI",
      D = { "<cmd>require 'lsp_lines'.toggle<cr>", "Toggle lsp_lines" },
      l = { "<cmd>Lazy<cr>", "Lazy" },
    },
    no = {
      name = "+Notify",
      D = { "<cmd>NoiceDisable<cr>", "Noice Disable" },
      e = { "<cmd>NoiceEnable<cr>", "Noice Enable" },
      t = { "<cmd>Noice telescope<cr>", "Show Notifications in Telescope" },
      n = { "<cmd>Notifications<cr>", "Show Notifications" }
    },
    m = {
      name = "+Mark",
      a = { "<cmd>lua require 'harpoon.mark'.add_file()<cr>", "add Mark file" },
      l = { "<cmd>lua require 'harpoon.ui'.toggle_quick_menu()<cr>", "show all Mark" },
    },
    R = {
      name = " Replace",
      f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Current Buffer" },
      p = { "<cmd>lua require('spectre').open()<cr>", "Project" },
      w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
      s = {
        function()
          require("ssr").open()
        end,
        "Structural replace",
      },
    },
    d = {
      name = "Debug",
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
      p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
      s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
      U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
    },
  },
}

M.register_normal = function(map)
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    return
  end
  local opts = M.opts.opts
  which_key.register(map, opts)
end
M.register_visual = function(map)
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    return
  end
  local opts = M.opts.vopts
  which_key.register(map, opts)
end
M.config = function()
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    return
  end
  which_key.setup(M.opts.setup)

  local opts = M.opts.opts
  local vopts = M.opts.vopts


  local mappings = M.opts.mappings
  local vmappings = M.opts.vmappings

  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)
end
return M
