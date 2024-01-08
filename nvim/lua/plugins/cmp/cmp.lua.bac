local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local compare = require("cmp.config.compare")
--[[ require("luasnip/loaders/from_vscode").lazy_load() ]]
require("luasnip.loaders.from_vscode").lazy_load({
	paths = { "/home/carl/.local/share/nvim/lazy/friendly-snippets/snippets" },
})
local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end
local str = require("cmp.utils.str")
local lspkind = require("lspkind")
local types = require("cmp.types")
-- find more here: https://www.nerdfonts.com/cheat-sheet
--[[ local format = function(entry, vim_item) ]]
--[[ 	-- Kind icons ]]
--[[ 	vim_item.kind = string.format("%s", kind_icons[vim_item.kind]) ]]
--[[ 	-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind ]]
--[[ 	vim_item.menu = ({ ]]
--[[ 		nvim_lua = "[Lua]", ]]
--[[ 		nvim_lsp = "[LSP]", ]]
--[[ 		luasnip = "[Snippet]", ]]
--[[ 		buffer = "[Buffer]", ]]
--[[ 		path = "[Path]", ]]
--[[ 	})[entry.source.name] ]]
--[[ 	return vim_item ]]
--[[ end ]]
-- 最简洁
--[[ local format = function(entry, vim_item) ]]
--[[ 	vim_item.kind = require("lspkind").presets.default[vim_item.kind] ]]
--[[ 	return vim_item ]]
--[[ end ]]

--[[ local format = function(entry, vim_item) ]]
--[[ 	-- fancy icons and a name of kind ]]
--[[ 	vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind ]]
--[[ 	-- set a name for each source ]]
--[[ 	vim_item.menu = ({ ]]
--[[ 		nvim_lua = "[Lua]", ]]
--[[ 		nvim_lsp = "[LSP]", ]]
--[[ 		ultisnips = "[UltiSnips]", ]]
--[[ 		buffer = "[Buffer]", ]]
--[[ 		cmp_tabnine = "[TabNine]", ]]
--[[ 		look = "[Look]", ]]
--[[ 		path = "[Path]", ]]
--[[ 		spell = "[Spell]", ]]
--[[ 		calc = "[Calc]", ]]
--[[ 		emoji = "[Emoji]", ]]
--[[ 	})[entry.source.name] ]]
--[[ 	return vim_item ]]
--[[ end ]]
--[[]]
-- local format = function(entry, vim_item)
-- 	-- fancy icons and a name of kind
-- 	vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. ""
-- 	-- set a name for each source
-- 	vim_item.menu = ({
-- 		nvim_lsp = "",
-- 		ultisnips = "[UltiSnips]",
-- 		nvim_lua = "[Lua]",
-- 		cmp_tabnine = "[TabNine]",
-- 		look = "[Look]",
-- 		path = "[Path]",
-- 		spell = "[Spell]",
-- 		calc = "[Calc]",
-- 		emoji = "[Emoji]",
-- 		buffer = "[Buffer]",
-- 	})[entry.source.name]
-- 	return vim_item
-- end
local format = lspkind.cmp_format({
	with_text = false,
	before = function(entry, vim_item)
		-- Get the full snippet (and only keep first line)
		local word = entry:get_insert_text()
		if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
			word = vim.lsp.util.parse_snippet(word)
		end
		word = str.oneline(word)

		-- concatenates the string
		-- local max = 50
		-- if string.len(word) >= max then
		-- 	local before = string.sub(word, 1, math.floor((max - 3) / 2))
		-- 	word = before .. "..."
		-- end

		if
			entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
			and string.sub(vim_item.abbr, -1, -1) == "~"
		then
			word = word .. "~"
		end
		vim_item.abbr = word

		return vim_item
	end,
})
cmp.setup({
	completion = {
		-- 自动选中第一条
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		scrollbar = "║",
		completeopt = "menu,menuone,noinsert",
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(), -- 上一个建议
		["<C-j>"] = cmp.mapping.select_next_item(), -- 下一个建议
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }), -- documents 向下滚动
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }), -- documents 向上滚动
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- 显示所有可用的建议
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
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
	formatting = {
		fields = {
			cmp.ItemField.Kind,
			cmp.ItemField.Abbr,
			cmp.ItemField.Menu,
		},
		--[[ fields = { "kind", "abbr", "menu" }, ]]
		format = format,
	},
	-- 按照list 来顺序显示 super toggle
	-- TODO
	sources = {
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "luasnip", option = { show_autosnippets = true }, priority = 500 },
		{
			name = "buffer",
			Keyword_length = 5,
			max_item_count = 5,
			option = {
				get_bufnrs = function()
					-- code
					return vim.api.nvim_list_bufs()
				end,
			},
			priority = 100,
		},
		{ name = "pandoc_references", priority = 725 },
		{ name = "latex_symbols", priority = 700 },
		{ name = "emoji", priority = 700 },
		{ name = "calc", priority = 650 },
		{ name = "path", priority = 200 },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		-- 文档 flase 将不进行展示
		-- documentation = {
		-- 	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		-- },
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			scrollbar = "║",
		},
	},

	experimental = {
		-- 提示
		ghost_text = true,
		native_menu = false,
	},
	sorting = {
		comparators = {
			compare.offset,
			compare.exact,
			compare.score,
			compare.recently_used,
			function(entry1, entry2)
				local _, entry1_under = entry1.completion_item.label:find("^_+")
				local _, entry2_under = entry2.completion_item.label:find("^_+")
				entry1_under = entry1_under or 0
				entry2_under = entry2_under or 0
				if entry1_under > entry2_under then
					return false
				elseif entry1_under < entry2_under then
					return true
				end
			end,
			compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
		},
	},
})
-- / 查找模式使用 buffer 源
cmp.setup.cmdline("/", {

	-- mapping = cmp.mapping.preset.cmdline(),
	sources = {

		{
			name = "buffer",
		},
	},
})

-- : 命令行模式中使用 path 和 cmdline 源.
cmp.setup.cmdline(":", {

	-- mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({

		{
			name = "path",
		},
	}, {

		{
			name = "cmdline",
			Keyword_length = 2,
		},
	}),
})
