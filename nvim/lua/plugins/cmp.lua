local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = {
	Text = "󰉿",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = " ",
	Variable = "󰀫",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = " ",
	Misc = " ",
}
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
local format = function(entry, vim_item)
	-- fancy icons and a name of kind
	vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. ""
	-- set a name for each source
	vim_item.menu = ({
		nvim_lsp = "",
		ultisnips = "[UltiSnips]",
		nvim_lua = "[Lua]",
		cmp_tabnine = "[TabNine]",
		look = "[Look]",
		path = "[Path]",
		spell = "[Spell]",
		calc = "[Calc]",
		emoji = "[Emoji]",
		buffer = "[Buffer]",
	})[entry.source.name]
	return vim_item
end

cmp.setup({
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
		--[[ fields = { "kind", "abbr", "menu" }, ]]
		format = format,
	},
	-- 按照list 来顺序显示 super toggle
	-- TODO
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip", option = { show_autosnippets = true } },
		{
			name = "buffer",
			Keyword_length = 3,
			option = {
				get_bufnrs = function()
					-- code
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "path" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		-- 文档 flase 将不进行展示
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	},
	experimental = {
		-- 提示
		ghost_text = true,
		native_menu = false,
	},
})
-- / 查找模式使用 buffer 源
cmp.setup.cmdline("/", {

	mapping = cmp.mapping.preset.cmdline(),
	sources = {

		{
			name = "buffer",
		},
	},
})

-- : 命令行模式中使用 path 和 cmdline 源.
cmp.setup.cmdline(":", {

	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({

		{
			name = "path",
		},
	}, {

		{
			name = "cmdline",
		},
	}),
})
