local M = {}

local icons = require("comment.icons")
M.opts = {
  auto_reload_on_write = false,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  sort_by = "name",
  root_dirs = {},
  prefer_startup_root = false,
  sync_root_with_cwd = true,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  on_attach = "default",
  select_prompts = false,
  view = {
    adaptive_size = false,
    centralize_selection = true,
    width = 30,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    float = {
      enable = false,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = true,
    full_name = false,
    highlight_opened_files = "none",
    root_folder_label = ":t",
    indent_width = 2,
    indent_markers = {
      enable = false,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = icons.ui.Text,
        symlink = icons.ui.FileSymlink,
        bookmark = icons.ui.BookMark,
        folder = {
          arrow_closed = icons.ui.TriangleShortArrowRight,
          arrow_open = icons.ui.TriangleShortArrowDown,
          default = icons.ui.Folder,
          open = icons.ui.FolderOpen,
          empty = icons.ui.EmptyFolder,
          empty_open = icons.ui.EmptyFolderOpen,
          symlink = icons.ui.FolderSymlink,
          symlink_open = icons.ui.FolderOpen,
        },
        git = {
          unstaged = icons.git.FileUnstaged,
          staged = icons.git.FileStaged,
          unmerged = icons.git.FileUnmerged,
          renamed = icons.git.FileRenamed,
          untracked = icons.git.FileUntracked,
          deleted = icons.git.FileDeleted,
          ignored = icons.git.FileIgnored,
        },
      },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    symlink_destination = true,
  },
  hijack_directories = {
    enable = false,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    debounce_delay = 15,
    update_root = true,
    ignore_list = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    show_on_open_dirs = true,
    debounce_delay = 50,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = icons.diagnostics.BoldHint,
      info = icons.diagnostics.BoldInformation,
      warning = icons.diagnostics.BoldWarning,
      error = icons.diagnostics.BoldError,
    },
  },
  filters = {
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    custom = { "node_modules", "\\.cache" },
    exclude = {},
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {},
  },
  git = {
    enable = true,
    ignore = false,
    show_on_dirs = true,
    show_on_open_dirs = true,
    timeout = 200,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = {},
    },
    file_popup = {
      open_win_config = {
        col = 1,
        row = 1,
        relative = "cursor",
        border = "shadow",
        style = "minimal",
      },
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        picker = "default",
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  tab = {
    sync = {
      open = false,
      close = false,
      ignore = {},
    },
  },
  notify = {
    threshold = vim.log.levels.INFO,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
  system_open = {
    cmd = nil,
    args = {},
  },
}
function M.start_telescope(telescope_mode)
  local node = require("nvim-tree.lib").get_node_at_cursor()
  local abspath = node.link_to or node.absolute_path
  local is_folder = node.open ~= nil
  local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
  require("telescope.builtin")[telescope_mode] {
    cwd = basedir,
  }
end
local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function telescope_find_files(_)
    require("plugins.file.nvim-tree").start_telescope "find_files"
  end

  local function telescope_live_grep(_)
    require("plugins.file.nvim-tree").start_telescope "live_grep"
  end

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  local useful_keys = {
    ["l"] = { api.node.open.edit, opts "Open" },
    ["o"] = { api.node.open.edit, opts "Open" },
    ["<CR>"] = { api.node.open.edit, opts "Open" },
    ["v"] = { api.node.open.vertical, opts "Open: Vertical Split" },
    ["h"] = { api.node.navigate.parent_close, opts "Close Directory" },
    ["C"] = { api.tree.change_root_to_node, opts "CD" },
    ["gtg"] = { telescope_live_grep, opts "Telescope Live Grep" },
    ["gtf"] = { telescope_find_files, opts "Telescope Find File" },
  }

  require("util").load_mode("n", useful_keys)
end

M.config = function()
  local status_ok, nvim_tree = pcall(require, "nvim-tree")
  if not status_ok then
    vim.notify("nvim-tree not find")
    return
  end
  --- 开启nvim-tree
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwplugin = 1
  vim.opt.termguicolors = true
  -- NOTE:need project plugin
  M.opts.respect_buf_cwd = true
  -- M.opts.update_cmd = true
  M.opts.update_focused_file.enable = true

  M.opts.on_attach = on_attach


  nvim_tree.setup(M.opts)
end
return M
