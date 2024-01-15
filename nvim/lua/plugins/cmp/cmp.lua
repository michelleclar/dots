local M = {}
M.config = function()
  local cmp_status_ok, cmp = pcall(require, "cmp")
  if not cmp_status_ok then
    return
  end

  local snip_status_ok, luasnip = pcall(require, "luasnip")
  if not snip_status_ok then
    return
  end
  require("luasnip.loaders.from_vscode").lazy_load({
    paths = { "/home/carl/.local/share/nvim/lazy/friendly-snippets/snippets" },
  })
  local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
  end
  local cmp_types = require("cmp.types.cmp")

  local ConfirmBehavior = cmp_types.ConfirmBehavior
  local kind = require("comment.lsp_kind")
  local icons = require("comment.icons")
  local source_names = {
    nvim_lsp = "(LSP)",
    emoji = "(Emoji)",
    path = "(Path)",
    calc = "(Calc)",
    cmp_tabnine = "(Tabnine)",
    vsnip = "(Snippet)",
    luasnip = "(Snippet)",
    buffer = "(Buffer)",
    tmux = "(TMUX)",
    copilot = "(Copilot)",
    treesitter = "(TreeSitter)",
  }
  local duplicates = {
    buffer = 1,
    path = 1,
    nvim_lsp = 0,
    luasnip = 1,
  }
  local formatting = {
    fields = { "kind", "abbr", "menu" },
    max_width = 0,
    kind_icons = kind.cmp_kind,
    source_names = source_names,
    duplicates = duplicates,
    duplicates_default = 0,
    format = function(entry, vim_item)
      local max_width = 0
      local use_icons = true
      if max_width ~= 0 and #vim_item.abbr > max_width then
        vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. kind.ui.Ellipsis
      end
      if use_icons then
        vim_item.kind = kind.cmp_kind[vim_item.kind]

        if entry.source.name == "copilot" then
          vim_item.kind = icons.git.Octoface
          vim_item.kind_hl_group = "CmpItemKindCopilot"
        end

        if entry.source.name == "cmp_tabnine" then
          vim_item.kind = icons.misc.Robot
          vim_item.kind_hl_group = "CmpItemKindTabnine"
        end

        if entry.source.name == "crates" then
          vim_item.kind = icons.misc.Package
          vim_item.kind_hl_group = "CmpItemKindCrate"
        end

        if entry.source.name == "lab.quick_data" then
          vim_item.kind = icons.misc.CircuitBoard
          vim_item.kind_hl_group = "CmpItemKindConstant"
        end

        if entry.source.name == "emoji" then
          vim_item.kind = icons.misc.Smiley
          vim_item.kind_hl_group = "CmpItemKindEmoji"
        end
      end
      vim_item.menu = source_names[entry.source.name]
      vim_item.dup = duplicates[entry.source.name] or 0
      return vim_item
    end,
  }
  local cmp_window = require("cmp.config.window")
  cmp.setup({
    active = true,
    completion = {
      keyword_length = 1,
    },
    enabled = function()
      local buftype = vim.api.nvim_buf_get_option(0, "buftype")
      if buftype == "prompt" then
        return false
      end
      return true
    end,
    confirm_opts = {
      behavior = ConfirmBehavior.Replace,
      select = false,
    },
    experimental = {
      ghost_text = false,
      native_menu = false,
    },
    mapping = {
      ["<C-k>"] = cmp.mapping.select_prev_item(),                     -- 上一个建议
      ["<C-j>"] = cmp.mapping.select_next_item(),                     -- 下一个建议
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }), -- documents 向下滚动
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }), -- documents 向上滚动
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- 显示所有可用的建议
      ["<C-y>"] = cmp.config.disable,                                 -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }), -- 关闭代码提示
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
    formatting = formatting,

    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp_window.bordered(),
      documentation = cmp_window.bordered(),
    },
    sources = {
      {
        name = "copilot",
        -- keyword_length = 0,
        max_item_count = 3,
        trigger_characters = {
          {
            ".",
            ":",
            "(",
            "'",
            '"',
            "[",
            ",",
            "#",
            "*",
            "@",
            "|",
            "=",
            "-",
            "{",
            "/",
            "\\",
            "+",
            "?",
            " ",
            -- "\t",
            -- "\n",
          },
        },
      },
      {
        name = "nvim_lsp",
        entry_filter = function(entry, ctx)
          local _kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
          if _kind == "Snippet" and ctx.prev_context.filetype == "java" then
            return false
          end
          return true
        end,
      },

      { name = "path" },
      { name = "luasnip" },
      { name = "cmp_tabnine" },
      { name = "nvim_lua" },
      { name = "buffer" },
      { name = "calc" },
      { name = "emoji" },
      { name = "treesitter" },
      { name = "crates" },
      { name = "tmux" },
    },
  })
  local cmdline = {
    enable = true,
    options = {
      {
        type = ":",
        sources = {
          { name = "path" },
          { name = "cmdline" },
        },
      },
      {
        type = { "/", "?" },
        sources = {
          { name = "buffer" },
        },
      },
    },
  }
  -- / 查找模式使用 buffer 源
  if cmdline.enable then
    for _, option in ipairs(cmdline.options) do
      cmp.setup.cmdline(option.type, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = option.sources,
      })
    end
  end
end
return M
