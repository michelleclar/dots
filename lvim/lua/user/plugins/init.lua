local M = {}

M.config = function()
	lvim.plugins = {
		{
			"folke/tokyonight.nvim",
			config = function()
				require("user.theme").tokyonight()
				local _time = os.date("*t")
				if (_time.hour >= 9 and _time.hour < 17) and lvim.builtin.time_based_themes then
					lvim.colorscheme = "tokyonight-moon"
				end
			end,
		},
		-- 主题
		{
			"rose-pine/neovim",
			name = "rose-pine",
			config = function()
				require("user.theme").rose_pine()
				lvim.colorscheme = "rose-pine"
			end,
			cond = function()
				local _time = os.date("*t")
				return (_time.hour >= 1 and _time.hour < 9) and lvim.builtin.time_based_themes
			end,
		},
		-- 主题
		{
			"catppuccin/nvim",
			name = "catppuccin",
			config = function()
				require("user.theme").catppuccin()
				local _time = os.date("*t")
				if (_time.hour >= 17 and _time.hour < 21) and lvim.builtin.time_based_themes then
					lvim.colorscheme = "catppuccin-mocha"
				end
			end,
		},
		-- 主题
		{
			"rebelot/kanagawa.nvim",
			config = function()
				require("user.theme").kanagawa()
				lvim.colorscheme = "kanagawa"
			end,
			cond = function()
				local _time = os.date("*t")
				return ((_time.hour >= 21 and _time.hour < 24) or (_time.hour >= 0 and _time.hour < 1))
					and lvim.builtin.time_based_themes
			end,
		},
		-- UI
		{
			"folke/noice.nvim",
			event = "VeryLazy",
			config = function()
				require("user.ui.noice").config()
			end,
			dependencies = {
				"rcarriga/nvim-notify",
			},
			enabled = lvim.builtin.noice.active,
		},
		{
			"sidebar-nvim/sidebar.nvim",
			config = function()
				require("user.ui.sidebar").config()
			end,
			-- event = "BufRead",
			enabled = lvim.builtin.sidebar.active,
		},
		{
			"ThePrimeagen/harpoon",
			dependencies = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-lua/popup.nvim" },
			},
			enabled = lvim.builtin.harpoon.active,
		},
		{
			"Wansmer/symbol-usage.nvim",
			event = "LspAttach",
			enabled = lvim.builtin.symbols_usage.active,
			config = function()
				require("user.ui.symbol_use").config()
			end,
		},
		{
			"OXY2DEV/markview.nvim",
			lazy = false,
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
				"nvim-tree/nvim-web-devicons",
			},
			config = function()
				local presets = require("markview.presets")

				require("markview").setup({
					checkboxes = presets.checkboxes.nerd,
					headings = presets.headings.glow,
				})
			end,
			enabled = lvim.builtin.markdown.active,
		},
		-- database 面板
		{
			"kristijanhusak/vim-dadbod-completion",
			enabled = lvim.builtin.sql_integration.active,
		},
		{
			"scalameta/nvim-metals",
			dependencies = { "nvim-lua/plenary.nvim" },
			enabled = lvim.builtin.metals.active,
		},
		{
			"sindrets/diffview.nvim",
			lazy = true,
			cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
			keys = { "<leader>gd", "<leader>gh" },
			config = function()
				require("user.expand.diffview").config()
			end,
			enabled = lvim.builtin.fancy_diff.active,
		},
		{
			"mrjones2014/legendary.nvim",
			config = function()
				require("user.expand.legendary").config()
			end,
			event = "VimEnter",
			enabled = lvim.builtin.legendary.active,
		},
		{
			"nvim-telescope/telescope-file-browser.nvim",
			enabled = lvim.builtin.file_browser.active,
		},
		{
			"Selyss/mind.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				require("user.ui.mind").config()
			end,
			event = "VeryLazy",
			enabled = lvim.builtin.mind.active,
		},
		{
			"folke/trouble.nvim",
			config = function()
				require("user.lsp.troubl").config()
			end,
			event = "VeryLazy",
			cmd = "Trouble",
			enabled = lvim.builtin.trouble.active,
		},
		{
			"hrsh7th/cmp-cmdline",
			enabled = lvim.builtin.fancy_wild_menu.active,
		},
		{
			"piersolenski/wtf.nvim",
			dependencies = {
				"MunifTanjim/nui.nvim",
			},
			event = "VeryLazy",
			opts = {
				popup_type = "vertical",
			},
			keys = {
				{
					"gw",
					mode = { "n" },
					function()
						require("wtf").ai()
					end,
					desc = "Debug diagnostic with AI",
				},
				{
					mode = { "n" },
					"gW",
					function()
						require("wtf").search()
					end,
					desc = "Search diagnostic with Google",
				},
			},
			enabled = lvim.builtin.sell_your_soul_to_devil.openai,
		},
		{
			"olexsmir/gopher.nvim",
			config = function()
				require("gopher").setup({
					commands = {
						go = "go",
						gomodifytags = "gomodifytags",
						gotests = "gotests",
						impl = "impl",
						iferr = "iferr",
					},
				})
			end,
			ft = { "go", "gomod" },
			event = { "BufRead", "BufNew" },
			enabled = lvim.builtin.go_programming.active,
		},

		-- 显示方法参数
		{
			"ray-x/lsp_signature.nvim",
			config = function()
				require("user.lsp.signature").config()
			end,
			event = { "BufRead", "BufNew" },
		},
		-- 可以记住最后一个文件打开位置
		{
			"vladdoster/remember.nvim",
			config = function()
				require("remember").setup({})
			end,
			enabled = lvim.builtin.lastplace.active,
		},

		-- 标签高亮
		{
			"folke/todo-comments.nvim",
			dependencies = "nvim-lua/plenary.nvim",
			config = function()
				require("user.expand.todo_comments").config()
			end,
			event = "BufRead",
		},
		-- lsp 诊断
		{
			"folke/trouble.nvim",
			config = function()
				require("user.lsp.troubl").config()
			end,
			event = "VeryLazy",
			cmd = "Trouble",
			enabled = lvim.builtin.trouble.active,
		},

		-- 可以树状展示方法和属性
		{
			"simrat39/symbols-outline.nvim",
			config = function()
				require("user.symbols_outline").config()
			end,
			event = "BufReadPost",
			enabled = lvim.builtin.tag_provider == "symbols-outline",
		},
		-- 代码提示
		{
			"tzachar/cmp-tabnine",
			build = "./install.sh",
			dependencies = "hrsh7th/nvim-cmp",
			config = function()
				local tabnine = require("cmp_tabnine.config")
				tabnine:setup({
					max_lines = 1000,
					max_num_results = 10,
					sort = true,
				})
			end,
			lazy = true,
			event = "InsertEnter",
			-- enabled = lvim.builtin.tabnine.active,
		},
		-- 再zen模式下高亮所编辑的代码，其他代码变暗
		{
			"folke/twilight.nvim",
			lazy = true,
			config = function()
				require("user.expand.twilight").config()
			end,
		},
		{
			"hedyhli/outline.nvim",
			config = function()
				require("user.ui.outline").config()
			end,
			event = "BufReadPost",
			enabled = lvim.builtin.tag_provider == "outline",
		},
		-- 复制历史
		{
			"AckslD/nvim-neoclip.lua",
			config = function()
				require("user.neoclip").config()
			end,
			lazy = true,
			keys = "<leader>y",
			dependencies = { "kkharji/sqlite.lua" },
			enabled = lvim.builtin.neoclip.active,
		},
		-- 滚动
		{
			"declancm/cinnamon.nvim",
			config = function()
				require("cinnamon").setup({
					keymaps = { basic = true, extra = false },
					options = {
						mode = "window",
					},
				})
			end,
			event = "BufRead",
			enabled = lvim.builtin.smooth_scroll == "cinnamon",
		},

		{ "mtdl9/vim-log-highlighting", ft = { "text", "log" } },
		-- 增强对括号操作
		{
			"abecodes/tabout.nvim",
			config = function()
				require("user.expand.tabout").config()
			end,
		},
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			cmd = "Neotree",
			dependencies = {
				"MunifTanjim/nui.nvim",
			},
			config = function()
				require("user.expand.neotree").config()
			end,
			enabled = lvim.builtin.tree_provider == "neo-tree",
		},
		{
			"vimpostor/vim-tpipeline",
			enabled = lvim.builtin.tmux_lualine,
		},
		-- database beg
		{
			"kristijanhusak/vim-dadbod-completion",
			enabled = lvim.builtin.sql_integration.active,
		},
		-- NOTE: debug test 的ui
		{
			"kristijanhusak/vim-dadbod-ui",
			cmd = {
				"DBUIToggle",
				"DBUIAddConnection",
				"DBUI",
				"DBUIFindBuffer",
				"DBUIRenameBuffer",
			},
			init = function()
				vim.g.db_ui_use_nerd_fonts = 1
				vim.g.db_ui_show_database_icon = 1
			end,
			dependencies = {
				{
					"tpope/vim-dadbod",
					lazy = true,
				},
			},
			lazy = true,
			enabled = lvim.builtin.sql_integration.active,
		},
		-- end

		-- deylop

		{
			"nvim-neotest/neotest",
			config = function()
				require("user.expand.ntest").config()
			end,
			dependencies = {
				{ "nvim-neotest/neotest-plenary" },
			},
			event = { "BufReadPost", "BufNew" },
			enabled = (lvim.builtin.test_runner.active and lvim.builtin.test_runner.runner == "neotest"),
		},
		{ "nvim-neotest/neotest-go", event = { "BufEnter *.go" } },
		{ "nvim-neotest/neotest-python", event = { "BufEnter *.py" } },
		{ "rouge8/neotest-rust", event = { "BufEnter *.rs" } },
		{ "lawrence-laz/neotest-zig", event = { "BufEnter *.zig" } },
		{
			"akinsho/flutter-tools.nvim",
			dependencies = "nvim-lua/plenary.nvim",
			config = function()
				require("user.lsp.flutter.tools").config()
			end,
			ft = "dart",
		},

		-- react beg
		{
			"pmizio/typescript-tools.nvim",
			ft = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			lazy = true,
			config = function()
				require("user.lsp.react.typtools").config()
			end,
			enabled = (
				lvim.builtin.web_programming.active
				and lvim.builtin.web_programming.extra == "typescript-tools.nvim"
			),
		},
		-- 可以展示package.json 最新版本
		{
			"vuki656/package-info.nvim",
			config = function()
				require("package-info").setup()
			end,
			lazy = true,
			event = { "BufReadPre", "BufNew" },
			enabled = lvim.builtin.web_programming.active,
		},
		{
			"mxsdev/nvim-dap-vscode-js",
			ft = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			lazy = true,
			event = { "BufReadPre", "BufNew" },
			config = function()
				require("dap-vscode-js").setup({
					debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
					debugger_cmd = { "js-debug-adapter" },
					adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
				})
			end,
			enabled = lvim.builtin.web_programming.active,
		},
		{
			"luckasRanarison/tailwind-tools.nvim",
			dependencies = { "nvim-treesitter/nvim-treesitter" },
			---@type TailwindTools.Option
			opts = {
				document_color = {
					enabled = true, -- can be toggled by commands
					kind = "inline", -- "inline" | "foreground" | "background"
					inline_symbol = "󰝤 ", -- only used in inline mode
					debounce = 200, -- in milliseconds, only applied in insert mode
				},
				conceal = {
					enabled = false, -- can be toggled by commands
					min_length = nil, -- only conceal classes exceeding the provided length
					symbol = "󱏿", -- only a single character is allowed
					highlight = { -- extmark highlight options, see :h 'highlight'
						fg = "#38BDF8",
					},
				},
				custom_filetypes = {}, -- see the extension section to learn how it works
			}, -- your configuration
		},
		{
			"luckasRanarison/tailwind-tools.nvim",
			dependencies = { "nvim-treesitter/nvim-treesitter" },
			---@type TailwindTools.Option
			opts = {
				document_color = {
					enabled = true, -- can be toggled by commands
					kind = "background", -- "inline" | "foreground" | "background"
					inline_symbol = "󰝤 ", -- only used in inline mode
					debounce = 200, -- in milliseconds, only applied in insert mode
				},
				conceal = {
					enabled = false, -- can be toggled by commands
					min_length = nil, -- only conceal classes exceeding the provided length
					symbol = "󱏿", -- only a single character is allowed
					highlight = { -- extmark highlight options, see :h 'highlight'
						fg = "#38BDF8",
					},
				},
				custom_filetypes = {}, -- see the extension section to learn how it works
			}, -- your configuration
		},

		-- end
	}
end
return M
