local M = {}
M.config = function()
  local kind = require("comment.lsp_kind").cmp_kind

  local status_ok, symout = pcall(require, "symbols-outline")
  if not status_ok then
    return
  end

  local opts = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false,
    position = "right",
    relative_width = true,
    width = 20,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = false,
    preview_bg_highlight = "Pmenu",
    keymaps = {                -- These keymaps can be a string or a table for multiple keys
      close = { "<Esc>", "q" },
      goto_location = "<Cr>",  -- 回车定位到符号位置，并焦点到目标窗口。
      focus_location = "o",    -- 定位到符号位置，但焦点保留在symbols-outline窗口。
      hover_symbol = "<C-space>", -- 显示对应符号的hover窗口
      toggle_preview = "K",    -- 打开当前符号的预览窗口。
      rename_symbol = "r",  -- 重命名
      code_actions = "a",   -- 
      fold = "h",   -- 折叠
      unfold = "l", -- 展开
      fold_all = "P", -- 折叠所有
      unfold_all = "U", -- 展开所有
      fold_reset = "Q", -- 重置折叠
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
    symbols = {
      File = { icon = kind.File, hl = "@text.uri" },
      Module = { icon = kind.Module, hl = "@namespace" },
      Namespace = { icon = kind.Namespace, hl = "@namespace" },
      Package = { icon = kind.Package, hl = "@namespace" },
      Class = { icon = kind.Class, hl = "@type" },
      Method = { icon = kind.Method, hl = "@method" },
      Property = { icon = kind.Property, hl = "@method" },
      Field = { icon = kind.Field, hl = "@field" },
      Constructor = { icon = kind.Constructor, hl = "@constructor" },
      Enum = { icon = kind.Enum, hl = "@type" },
      Interface = { icon = kind.Interface, hl = "@type" },
      Function = { icon = kind.Function, hl = "@function" },
      Variable = { icon = kind.Variable, hl = "@constant" },
      Constant = { icon = kind.Constant, hl = "@constant" },
      String = { icon = kind.String, hl = "@string" },
      Number = { icon = kind.Number, hl = "@number" },
      Boolean = { icon = kind.Boolean, hl = "@boolean" },
      Array = { icon = kind.Array, hl = "@constant" },
      Object = { icon = kind.Object, hl = "@type" },
      Key = { icon = kind.Key, hl = "@type" },
      Null = { icon = kind.Null, hl = "@type" },
      EnumMember = { icon = kind.EnumMember, hl = "@field" },
      Struct = { icon = kind.Struct, hl = "@type" },
      Event = { icon = kind.Event, hl = "@type" },
      Operator = { icon = kind.Operator, hl = "@operator" },
      TypeParameter = { icon = kind.TypeParameter, hl = "@parameter" },
    },
  }

  symout.setup(opts)
end
return M
