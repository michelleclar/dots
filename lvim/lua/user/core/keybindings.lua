local M = {}

M.fzf_projects = function()
  local fzf_lua = require "fzf-lua"
  local history = require "project_nvim.utils.history"
  fzf_lua.fzf_exec(function(cb)
    local results = history.get_recent_projects()
    for _, e in ipairs(results) do
      cb(e)
    end
    cb()
  end, {
    actions = {
      ["default"] = {
        function(selected)
          fzf_lua.files { cwd = selected[1] }
        end,
      },
      ["ctrl-d"] = {
        function(selected)
          history.delete_project { value = selected[1] }
        end,
        fzf_lua.actions.resume,
      },
    },
  })
end

M.set_terminal_keymaps = function()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

M.set_hop_keymaps = function()
  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap("n", "s", ":HopChar2MW<cr>", opts)
  vim.api.nvim_set_keymap("n", "S", ":HopWordMW<cr>", opts)
  vim.api.nvim_set_keymap(
    "n",
    "f",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
    {}
  )
  vim.api.nvim_set_keymap(
    "n",
    "F",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
    {}
  )
  vim.api.nvim_set_keymap(
    "o",
    "f",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
    {}
  )
  vim.api.nvim_set_keymap(
    "o",
    "F",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
    {}
  )
  vim.api.nvim_set_keymap(
    "",
    "t",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
    {}
  )
  vim.api.nvim_set_keymap(
    "",
    "T",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
    {}
  )
end

M.set_hlslens_keymaps = function()
  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap(
    "n",
    "n",
    "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
    opts
  )
  vim.api.nvim_set_keymap(
    "n",
    "N",
    "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
    opts
  )
  vim.api.nvim_set_keymap("n", "*", "*<Cmd>lua require('hlslens').start()<CR>", opts)
  vim.api.nvim_set_keymap("n", "#", "#<Cmd>lua require('hlslens').start()<CR>", opts)
  vim.api.nvim_set_keymap("n", "g*", "g*<Cmd>lua require('hlslens').start()<CR>", opts)
  vim.api.nvim_set_keymap("n", "g#", "g#<Cmd>lua require('hlslens').start()<CR>", opts)
end

local function set_bufferline_keymaps()
  lvim.keys.normal_mode["<S-x>"] = "<Cmd>lua require('user.bufferline').delete_buffer()<CR>"
  lvim.keys.normal_mode["<S-l>"] = "<Cmd>BufferLineCycleNext<CR>"
  lvim.keys.normal_mode["<S-h>"] = "<Cmd>BufferLineCyclePrev<CR>"
  lvim.keys.normal_mode["[b"] = "<Cmd>BufferLineMoveNext<CR>"
  lvim.keys.normal_mode["]b"] = "<Cmd>BufferLineMovePrev<CR>"
  lvim.builtin.which_key.mappings["c"] = {}
  lvim.builtin.which_key.mappings.b = {
    name = " Buffer",
    ["1"] = { "<Cmd>BufferLineGoToBuffer 1<CR>", "goto 1" },
    ["2"] = { "<Cmd>BufferLineGoToBuffer 2<CR>", "goto 2" },
    ["3"] = { "<Cmd>BufferLineGoToBuffer 3<CR>", "goto 3" },
    ["4"] = { "<Cmd>BufferLineGoToBuffer 4<CR>", "goto 4" },
    ["5"] = { "<Cmd>BufferLineGoToBuffer 5<CR>", "goto 5" },
    ["6"] = { "<Cmd>BufferLineGoToBuffer 6<CR>", "goto 6" },
    ["7"] = { "<Cmd>BufferLineGoToBuffer 7<CR>", "goto 7" },
    ["8"] = { "<Cmd>BufferLineGoToBuffer 8<CR>", "goto 8" },
    ["9"] = { "<Cmd>BufferLineGoToBuffer 9<CR>", "goto 9" },
    c = { "<Cmd>BufferLinePickClose<CR>", "delete buffer" },
    p = { "<Cmd>BufferLineTogglePin<CR>", "toggle pin" },
    s = { "<Cmd>BufferLinePick<CR>", "pick buffer" },
    t = { "<Cmd>BufferLineGroupToggle docs<CR>", "toggle groups" },
    f = { "<cmd>Telescope buffers<cr>", "Find" },
    b = { "<cmd>b#<cr>", "Previous" },
    h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
    l = {
      "<cmd>BufferLineCloseRight<cr>",
      "Close all to the right",
    },
    D = {
      "<cmd>BufferLineSortByDirectory<cr>",
      "Sort by directory",
    },
    L = {
      "<cmd>BufferLineSortByExtension<cr>",
      "Sort by language",
    },
  }
end

local function set_harpoon_keymaps()
  lvim.keys.normal_mode["<C-Space>"] = "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>"
  lvim.keys.normal_mode["tu"] = "<cmd>lua require('harpoon.term').gotoTerminal(1)<CR>"
  lvim.keys.normal_mode["te"] = "<cmd>lua require('harpoon.term').gotoTerminal(2)<CR>"
  lvim.keys.normal_mode["cu"] = "<cmd>lua require('harpoon.term').sendCommand(1, 1)<CR>"
  lvim.keys.normal_mode["ce"] = "<cmd>lua require('harpoon.term').sendCommand(1, 2)<CR>"
  lvim.builtin.which_key.mappings["a"] = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "󰃅 Add Mark" }
  lvim.builtin.which_key.mappings["<leader>"] = {
    "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
    " Harpoon",
  }

  local whk_status, whk = pcall(require, "which-key")
  if not whk_status then
    return
  end
  whk.register {
    ["<leader>1"] = { "<CMD>lua require('harpoon.ui').nav_file(1)<CR>", "󰎤 goto1" },
    ["<leader>2"] = { "<CMD>lua require('harpoon.ui').nav_file(2)<CR>", "󰎧 goto2" },
    ["<leader>3"] = { "<CMD>lua require('harpoon.ui').nav_file(3)<CR>", "󰎪 goto3" },
    ["<leader>4"] = { "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", "󰎭 goto4" },
  }
end

M.set_task_runner_keymaps = function()
  if lvim.builtin.task_runner == "async_tasks" then
    lvim.builtin.which_key.mappings["m"] = {
      name = " Make",
      f = { "<cmd>AsyncTask file-build<cr>", "File" },
      p = { "<cmd>AsyncTask project-build<cr>", "Project" },
      e = { "<cmd>AsyncTaskEdit<cr>", "Edit" },
      l = { "<cmd>AsyncTaskList<cr>", "List" },
    }
    lvim.builtin.which_key.mappings["r"] = {
      name = " Run",
      f = { "<cmd>AsyncTask file-run<cr>", "File" },
      p = { "<cmd>AsyncTask project-run<cr>", "Project" },
    }
  elseif lvim.builtin.task_runner == "overseer" then
    lvim.builtin.which_key.mappings["m"] = {
      name = " Tasks",
      l = { "<cmd>OverseerLoadBundle<CR>", "Load Bundle" },
      s = { "<cmd>OverseerSaveBundle<CR>", "Save Bundle" },
      n = { "<cmd>OverseerBuild<CR>", "New Task" },
      q = { "<cmd>OverseerQuickAction<CR>", "Quick Action" },
      f = { "<cmd>OverseerTaskAction<CR>", "Task Action" },
      t = { "<cmd>OverseerToggle<cr>", "Toggle Output" },
    }
    lvim.builtin.which_key.mappings["r"] = {
      name = " Run",
      f = { "<cmd>OverseerRun<cr>", "Run" },
      p = { "<cmd>OverseerRunCmd<cr>", "Run with Cmd" },
      t = { "<cmd>OverseerToggle<cr>", "Toggle" },
    }
  else
    lvim.builtin.which_key.mappings["m"] = "Make"
    lvim.builtin.which_key.mappings["r"] = "Run"
    require("user.core.autocommands").make_run()
  end
end

M.set_lsp_lines_keymap = function()
  lvim.builtin.which_key.mappings["v"] = {
    "<cmd>lua require('lsp_lines').toggle()<CR>",
    " LSP Lines",
  }
end

M.config = function()
  -- Additional keybindings
  -- =========================================
  -- lvim.keys.normal_mode["<CR>"] = {
  --   "<cmd>lua require('user.core.options').maximize_current_split()<CR>",
  --   { noremap = true, silent = true, nowait = true },
  -- }
  lvim.keys.insert_mode["<A-a>"] = "<ESC>ggVG<CR>"
  lvim.keys.insert_mode["jk"] = "<ESC>:w<CR>"
  if lvim.builtin.noice.active then
    lvim.keys.insert_mode["<C-s>"] = function()
      local params = vim.lsp.util.make_position_params(0, "utf-16")
      vim.lsp.buf_request(0, "textDocument/signatureHelp", params, function(err, result, ctx)
        require("noice.lsp").signature(err, result, ctx, {
          trigger = true,
        })
      end)
    end
  else
    lvim.keys.insert_mode["<C-s>"] = "<cmd>lua vim.lsp.buf.signature_help()<CR>"
  end
  lvim.keys.insert_mode["<A-s>"] =
    "<cmd>lua require('telescope').extensions.luasnip.luasnip(require('telescope.themes').get_cursor({}))<CR>"
  lvim.keys.command_mode["w!!"] = "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!"
  lvim.keys.normal_mode["]d"] = "<cmd>lua vim.diagnostic.goto_next()<cr>"
  lvim.keys.normal_mode["[d"] = "<cmd>lua vim.diagnostic.goto_prev()<cr>"
  lvim.keys.normal_mode["<C-a>"] = "ggVG"
  lvim.keys.normal_mode["<A-x>"] = "<C-x>"
  lvim.keys.normal_mode["<C-,>"] = "<cmd>lua require('neogen').jump_next()<CR>"
  lvim.keys.normal_mode["<C-n>i"] = { "<C-i>", { noremap = true } }
  if vim.fn.has "mac" == 1 then
    lvim.keys.normal_mode["gx"] =
      [[<cmd>lua os.execute("open " .. vim.fn.shellescape(vim.fn.expand "<cWORD>")); vim.cmd "redraw!"<cr>]]
  elseif vim.fn.has "linux" then
    lvim.keys.normal_mode["gx"] =
      [[<cmd>lua os.execute("xdg-open " .. vim.fn.shellescape(vim.fn.expand "<cWORD>")); vim.cmd "redraw!"<cr>]]
  end
  if lvim.builtin.bufferline.active then
    set_bufferline_keymaps()
  end
  if lvim.builtin.sidebar.active then
    lvim.keys.normal_mode["E"] = ":SidebarNvimToggle<cr>"
  end
  lvim.keys.normal_mode["<esc><esc>"] = "<cmd>nohlsearch<cr>"
  lvim.keys.normal_mode["Y"] = "y$"
  lvim.keys.normal_mode["gd"] =
    "<cmd>vsplit | lua vim.lsp.buf.definition({on_list = function(items) vim.fn.setqflist({}, 'r', items) vim.cmd('cfirst') end})<cr>"
  if lvim.builtin.harpoon.active then
    set_harpoon_keymaps()
  end
  lvim.keys.visual_mode["<C-a>"] = "ggVG"
  lvim.keys.visual_mode["p"] = [["_dP]]
  lvim.keys.visual_mode["ga"] = "<esc><Cmd>lua vim.lsp.buf.range_code_action()<CR>"
  lvim.keys.visual_mode["<leader>st"] = "<Cmd>lua require('user.expand.telescope').grep_string_visual()<CR>"

  -- WhichKey keybindings
  -- =========================================
  M.set_task_runner_keymaps()
  local status_ok_comment, cmt = pcall(require, "Comment.api")
  if status_ok_comment and cmt["toggle"] ~= nil then
    lvim.builtin.which_key.mappings["/"] = {
      "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
      "󰆉 Comment",
    }
  else
    lvim.builtin.which_key.mappings["/"] = { "<Plug>(comment_toggle_linewise_current)", " Comment" }
  end
  lvim.builtin.which_key.mappings[";"] = { "<cmd>Alpha<CR>", "󰕮 Dashboard" }
  if lvim.builtin.dap.active then
    lvim.builtin.which_key.mappings["de"] = { "<cmd>lua require('dapui').eval()<cr>", "Eval" }
    lvim.builtin.which_key.mappings["dU"] = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle UI" }
  end
  
  if lvim.builtin.fancy_diff.active then
    lvim.builtin.which_key.mappings["gv"] = { "<cmd>DiffviewOpen<cr>", "diffview: diff HEAD" }
    lvim.builtin.which_key.mappings["gh"] = { "<cmd>DiffviewFileHistory<cr>", "diffview: filehistory" }
  else
    lvim.builtin.which_key.mappings["gh"] = { "<cmd>Telescope git_bcommits<cr>", "file history" }
  end
  if lvim.builtin.lsp_lines then
    M.set_lsp_lines_keymap()
  end
  if lvim.builtin.tree_provider == "neo-tree" then
    lvim.builtin.which_key.mappings["e"] = { "<cmd>Neotree toggle<CR>", "󰀶 Explorer" }
  end
  lvim.builtin.which_key.mappings["F"] = {
    name = " Find",
    b = { "<cmd>lua require('user.expand.telescope').builtin()<cr>", "Builtin" },
    f = { "<cmd>lua require('user.expand.telescope').curbuf()<cr>", "Current Buffer" },
    g = { "<cmd>lua require('user.expand.telescope').git_files()<cr>", "Git Files" },
    i = { "<cmd>lua require('user.expand.telescope').installed_plugins()<cr>", "Installed Plugins" },
    l = {
      "<cmd>lua require('telescope.builtin').resume()<cr>",
      "Last Search",
    },
    p = { "<cmd>lua require('user.expand.telescope').project_search()<cr>", "Project" },
    s = { "<cmd>lua require('user.expand.telescope').git_status()<cr>", "Git Status" },
    z = { "<cmd>lua require('user.expand.telescope').search_only_certain_files()<cr>", "Certain Filetype" },
  }
  if lvim.builtin.legendary.active then
    lvim.builtin.which_key.mappings["C"] =
      { "<cmd>lua require('legendary').find('commands')<cr>", " Command Palette" }
    lvim.keys.normal_mode["<c-P>"] = "<cmd>lua require('legendary').find()<cr>"
  end

  if lvim.builtin.file_browser.active then
    lvim.builtin.which_key.mappings["se"] = { "<cmd>Telescope file_browser<cr>", "File Browser" }
  end
  lvim.builtin.which_key.mappings["H"] = "󰞋 Help"
  lvim.builtin.which_key.mappings["h"] = { "<cmd>nohlsearch<CR>", "󰸱 No Highlight" }
  lvim.builtin.which_key.mappings.g.name = " Git"
  lvim.builtin.which_key.mappings["I"] =
    { "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>", " Toggle Inlay" }
  lvim.builtin.which_key.mappings.l.name = " LSP"
  lvim.builtin.which_key.mappings["f"] = {
    require("user.expand.telescope").find_project_files,
    " Find File",
  }
  local ok, _ = pcall(require, "vim.diagnostic")
  if ok then
    lvim.builtin.which_key.mappings["l"]["j"] = {
      "<cmd>lua vim.diagnostic.goto_next({float = {border = 'rounded', focusable = false, source = 'always'}, severity = {min = vim.diagnostic.severity.WARN}})<cr>",
      "Next Diagnostic",
    }
    lvim.builtin.which_key.mappings["l"]["k"] = {
      "<cmd>lua vim.diagnostic.goto_prev({float = {border = 'rounded', focusable = false, source = 'always'}, severity = {min = vim.diagnostic.severity.WARN}})<cr>",
      "Prev Diagnostic",
    }
  end

  if status_ok_comment and cmt["toggle"] ~= nil then
    lvim.builtin.which_key.vmappings["/"] =
      { "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "Comment" }
  end

  if lvim.builtin.noice.active then
    lvim.builtin.which_key.mappings["l"]["r"] = { ":IncRename ", "Rename" }
    lvim.builtin.which_key.mappings["l"]["R"] = {
      function()
        return ":IncRename " .. vim.fn.expand "<cword>"
      end,
      "Rename keep",
      expr = true,
    }
  else
    lvim.builtin.which_key.vmappings["l"] = {
      name = "+Lsp",
      r = { "<ESC><CMD>lua vim.lsp.buf.rename()<CR>", "Rename" },
    }
  end
  lvim.builtin.which_key.mappings["lp"] = {
    name = "Peek",
    d = { "<cmd>lua require('user.expand.peek').Peek('definition')<cr>", "Definition" },
    t = { "<cmd>lua require('user.expand.peek').Peek('typeDefinition')<cr>", "Type Definition" },
    i = { "<cmd>lua require('user.expand.peek').Peek('implementation')<cr>", "Implementation" },
  }
  lvim.builtin.which_key.mappings["lh"] = {
    "<cmd>hi LspReferenceRead cterm=bold ctermbg=red guibg=#24283b<cr><cmd>hi LspReferenceText cterm=bold ctermbg=red guibg=#24283b<cr><cmd>hi LspReferenceWrite cterm=bold ctermbg=red guibg=#24283b<cr>",
    "Clear HL",
  }
  if lvim.builtin.mind.active then
    M.set_mind_keymaps()
  end
  if lvim.builtin.persistence then
    lvim.builtin.which_key.mappings["q"] = {
      name = "󰗼 Quit",
      d = { "<cmd>SessionDelete<cr>", "Delete Session" },
      l = { "<cmd>SessionLoad<cr>", "Load Session" },
      s = { "<cmd>SessionSave<cr>", "Save Session" },
      q = { "<cmd>confirm q<CR>", "Quit" },
    }
  end
  lvim.builtin.which_key.mappings["n"] = {
    name = " Neogen",
    c = { "<cmd>lua require('neogen').generate({ type = 'class'})<CR>", "Class Documentation" },
    f = { "<cmd>lua require('neogen').generate({ type = 'func'})<CR>", "Function Documentation" },
    t = { "<cmd>lua require('neogen').generate({ type = 'type'})<CR>", "Type Documentation" },
    F = { "<cmd>lua require('neogen').generate({ type = 'file'})<CR>", "File Documentation" },
  }
  lvim.builtin.which_key.mappings["N"] = { "<cmd>Telescope file_create<CR>", " Create new file" }
  if lvim.builtin.tag_provider == "symbols-outline" then
    lvim.builtin.which_key.mappings["o"] = { "<cmd>SymbolsOutline<cr>", " Symbol Outline" }
  elseif lvim.builtin.tag_provider == "vista" then
    lvim.builtin.which_key.mappings["o"] = { "<cmd>Vista!!<cr>", "Vista" }
  elseif lvim.builtin.tag_provider == "outline" then
    lvim.builtin.which_key.mappings["o"] = { "<cmd>Outline<cr>", " Outline" }
  end
  lvim.builtin.which_key.mappings.L.name = " LunarVim"
  lvim.builtin.which_key.mappings.p.name = " Lazy"
  lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", " Projects" }
  lvim.builtin.which_key.mappings["R"] = {
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
  }
  lvim.builtin.which_key.mappings.s.name = " Search"
  lvim.builtin.which_key.mappings["sM"] = { "<cmd>Telescope man_pages sections=ALL<cr>", "Man Pages" }
  lvim.builtin.which_key.mappings["ss"] = {
    "<cmd>Telescope live_grep theme=ivy<cr>",
    "String",
  }
  if lvim.builtin.test_runner.active then
    if lvim.builtin.test_runner.runner == "neotest" then
      lvim.builtin.which_key.mappings["t"] = {
        name = "󰙨 Test",
        f = {
          "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), env=require('user.expand.ntest').get_env()})<cr>",
          "File",
        },
        o = { "<cmd>lua require('neotest').output.open({ enter = true, short = false })<cr>", "Output" },
        r = { "<cmd>lua require('neotest').run.run({env=require('user.expand.ntest').get_env()})<cr>", "Run" },
        a = { "<cmd>lua require('user.expand.ntest').run_all()<cr>", "Run All" },
        c = { "<cmd>lua require('user.expand.ntest').cancel()<cr>", "Cancel" },
        R = { "<cmd>lua require('user.expand.ntest').run_file_sync()<cr>", "Run Async" },
        s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
        n = { "<cmd>lua require('neotest').jump.next({ status = 'failed' })<cr>", "jump to next failed" },
        p = { "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<cr>", "jump to previous failed" },
        d = { "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<cr>", "Dap Run" },
        x = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
        w = { "<cmd>lua require('neotest').watch.watch()<cr>", "Watch" },
      }
    else
      lvim.builtin.which_key.mappings["t"] = {
        name = "󰙨 Test",
        f = { "<cmd>Ultest<cr>", "File" },
        n = { "<cmd>UltestNearest<cr>", "Nearest" },
        s = { "<cmd>UltestSummary<cr>", "Summary" },
      }
    end
  end
  if lvim.builtin.trouble.active then
    lvim.builtin.which_key.mappings["T"] = {
      name = " Trouble",
      d = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Diagnostics" },
      f = { "<cmd>Trouble lsp_definitions toggle<cr>", "Definitions" },
      l = { "<cmd>Trouble loclist toggle<cr>", "LocationList" },
      q = { "<cmd>Trouble quickfix toggle<cr>", "QuickFix" },
      r = { "<cmd>Trouble lsp_references toggle<cr>", "References" },
      t = { "<cmd>TodoLocList <cr>", "Todo" },
      w = { "<cmd>Trouble diagnostics toggle<cr>", "Workspace Diagnostics" },
    }
  end
  lvim.builtin.which_key.mappings["z"] = { "<cmd>ZenMode<cr>", " Zen" }
  lvim.builtin.which_key.mappings["w"] = { "<cmd>w!<CR>", " Save" }
  lvim.builtin.which_key.vmappings["g"] = {
    name = " Git",
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
  }
  lvim.builtin.which_key.vmappings["r"] = {
    function()
      require("ssr").open()
    end,
    "Structural replace",
  }

  if lvim.builtin.symbols_usage.active then
    lvim.builtin.which_key.mappings["Y"] = { "<cmd>lua require('symbol-usage').toggle()<cr>", "󰫦 Toggle Symbols" }
  end

  -- My wezterm is weird
  -- =========================================
  -- Navigate merge conflict markers
  local whk_status, whk = pcall(require, "which-key")
  if not whk_status then
    return
  end
  whk.register {
    ["]n"] = { "[[:call search('^(@@ .* @@|[<=>|]{7}[<=>|]@!)', 'W')<cr>]]", "next merge conflict" },
    ["[n"] = { "[[:call search('^(@@ .* @@|[<=>|]{7}[<=>|]@!)', 'bW')<cr>]]", "prev merge conflict" },
  }
end

M.set_mind_keymaps = function()
  local mind = require "mind"
  lvim.builtin.which_key.mappings["M"] = {
    name = " Mind",
    c = {
      function()
        mind.wrap_smart_project_tree_fn(function(args)
          mind.commands.create_node_index(args.get_tree(), mind.node.MoveDir.INSIDE_END, args.save_tree, args.opts)
        end)
      end,
      "Create node index",
    },
    C = {
      function()
        mind.wrap_main_tree_fn(function(args)
          mind.commands.create_node_index(args.get_tree(), mind.node.MoveDir.INSIDE_END, args.save_tree, args.opts)
        end)
      end,
      "Create node index",
    },
    i = {
      function()
        vim.notify "initializing project tree"
        mind.wrap_smart_project_tree_fn(function(args)
          local tree = args.get_tree()

          local _, tasks = mind.node.get_node_by_path(tree, "/Tasks", true)
          tasks.icon = " "

          local _, backlog = mind.node.get_node_by_path(tree, "/Tasks/Backlog", true)
          backlog.icon = " "

          local _, on_going = mind.node.get_node_by_path(tree, "/Tasks/On-going", true)
          on_going.icon = " "

          local _, done = mind.node.get_node_by_path(tree, "/Tasks/Done", true)
          done.icon = "󱍧 "

          local _, cancelled = mind.node.get_node_by_path(tree, "/Tasks/Cancelled", true)
          cancelled.icon = " "

          local _, notes = mind.node.get_node_by_path(tree, "/Notes", true)
          notes.icon = " "

          args.save_tree()
        end)
      end,
      "Initialize project tree",
    },
    l = {
      function()
        mind.wrap_smart_project_tree_fn(function(args)
          mind.commands.copy_node_link_index(args.get_tree(), nil, args.opts)
        end)
      end,
      "Copy node link index",
    },
    L = {
      function()
        mind.wrap_main_tree_fn(function(args)
          mind.commands.copy_node_link_index(args.get_tree(), nil, args.opts)
        end)
      end,
      "Copy node link index",
    },
    j = {
      function()
        mind.wrap_main_tree_fn(function(args)
          local tree = args.get_tree()
          local path = vim.fn.strftime "/Journal/%Y/%b/%d"
          local _, node = mind.node.get_node_by_path(tree, path, true)

          if node == nil then
            vim.notify("cannot open journal 🙁", vim.log.levels.WARN)
            return
          end

          mind.commands.open_data(tree, node, args.data_dir, args.save_tree, args.opts)
          args.save_tree()
        end)
      end,
      "Open journal",
    },
    M = { "<cmd>MindOpenMain<CR>", "Open main tree" },
    z = { "<cmd>MindClose<CR>", "Close" },
    m = { "<cmd>MindOpenSmartProject<CR>", "Open smart project tree" },
    s = {
      function()
        mind.wrap_smart_project_tree_fn(function(args)
          mind.commands.open_data_index(args.get_tree(), args.data_dir, args.save_tree, args.opts)
        end)
      end,
      "Open data index",
    },
    S = {
      function()
        mind.wrap_main_tree_fn(function(args)
          mind.commands.open_data_index(args.get_tree(), args.data_dir, args.save_tree, args.opts)
        end)
      end,
      "Open data index",
    },
  }
end

return M
