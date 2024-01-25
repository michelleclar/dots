local M = {}
M.config = function()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    vim.notify("alpha is error")
    return
  end
  local kind = require("comment.lsp_kind")

  local plugins = ""
  if vim.fn.has "linux" == 1 or vim.fn.has "mac" == 1 then
    local handle = io.popen 'fd -d 2 . $HOME"/.local/share/nvim/lazy" | grep pack | wc -l | tr -d "\n" '
    plugins = handle:read "*a"
    handle:close()

    plugins = plugins:gsub("^%s*(.-)%s*$", "%1")
  else
    plugins = "N/A"
  end
  local plugin_count = {
    type = "text",
    val = "└─ "
        .. kind.cmp_kind.Module
        .. " "
        .. string.format("% 4d", plugins)
        .. " plugins 󰚥 "
        .. vim.version().major
        .. "."
        .. vim.version().minor
        .. "."
        .. vim.version().patch
        .. " ─┘",
    opts = {
      position = "center",
      hl = "String",
    },
  }

  local dashboard = require("alpha.themes.dashboard")
  dashboard.section.header.val = require("plugins.ui.alpha.banners").dashboard()
  local function footer()
    -- NOTE: requires the fortune-mod package to work
    -- local handle = io.popen("fortune")
    -- local fortune = handle:read("*a")
    -- handle:close()
    -- return fortune
    return "carlmichelle493@gmail.com"
  end

  dashboard.section.footer.val = footer()

  dashboard.section.footer.opts.hl = "Type"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Keyword"
  dashboard.section.plugin_count = plugin_count

  dashboard.opts.opts.noautocmd = true
  -- vim.cmd([[autocmd User AlphaReady echo 'ready']])
  local header = {
    type = "text",
    val = require("plugins.ui.alpha.banners").dashboard(),
    opts = {
      position = "center",
      hl = "Comment",
    },
  }
  local buttons = {
    type = "group",
    val = {
      dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
      dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
      dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
      dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
      dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
    }
    ,
    opts = {
      spacing = 1,
    },
  }

  local date = os.date "%a %d %b"
  local empty_space = ""
  local heading = {
    type = "text",
    val = "┌─ " .. kind.icons.calendar .. empty_space .. " Today is " .. date .. " ─┐",
    opts = {
      position = "center",
      hl = "String",
    },
  }

  local minor_len = string.len(vim.version().minor)
  for i = 1, minor_len do
    empty_space = empty_space .. " "
  end

  local fortune = require "alpha.fortune" ()
  local footer = {
    type = "text",
    val = fortune,
    opts = {
      position = "center",
      hl = "Comment",
      hl_shortcut = "Comment",
    },
  }

  local section = {
    header = header,
    buttons = buttons,
    plugin_count = plugin_count,
    heading = heading,
    footer = footer
  }
  local opts = {
    layout = {
      { type = "padding", val = 1 },
      section.header,
      { type = "padding", val = 2 },
      section.heading,
      section.plugin_count,
      { type = "padding", val = 1 },
      -- section.top_bar,
      section.buttons,
      -- section.bot_bar,
      -- { type = "padding", val = 1 },
      section.footer,
    },
    opts = {
      margin = 5,
    },
  }
  alpha.setup(opts)
end
return M
