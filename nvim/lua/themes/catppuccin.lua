local status_ok, them = pcall(require, "catppuccin")
if status_ok then
	them.setup({
		flavour = "mocha", -- latte, frappe, macchiato, mocha
		background = { -- :h background
			light = "latte",
			dark = "mocha",
		},
		transparent_background = false, -- disables setting the background color.
		show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
		term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
		dim_inactive = {
			enabled = false, -- dims the background color of inactive window
			shade = "dark",
			percentage = 0.15, -- percentage of the shade to apply to the inactive window
		},
		no_italic = false, -- Force no italic
		no_bold = false, -- Force no bold
		no_underline = false, -- Force no underline
		styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
			comments = { "italic" }, -- Change the style of comments
			conditionals = { "italic" },
			loops = {},
			functions = {},
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = {},
			operators = {},
		},
		color_overrides = {
			mocha = {
				text = "#F4CDE9",
				subtext1 = "#DEBAD4",
				subtext0 = "#C8A6BE",
				overlay2 = "#B293A8",
				overlay1 = "#9C7F92",
				overlay0 = "#866C7D",
				surface2 = "#705867",
				surface1 = "#5A4551",
				surface0 = "#44313B",

				base = "#352939",
				mantle = "#211924",
				crust = "#1a1016",
			},
		},
		custom_highlights = {},
		integrations = {
			alpha = true,
			aerial = true,
			dap = { enabled = true, enable_ui = true },
			mason = true,
			neotree = true,
			notify = true,
			nvimtree = false,
			semantic_tokens = true,
			symbols_outline = true,
			telescope = true,
			ts_rainbow = false,
			which_key = true,
			cmp = true,
			gitsigns = true,
			treesitter = true,
      lsp_trouble = true,
			mini = {
				enabled = true,
				indentscope_color = "",
			},
			-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
		},
	})
	vim.cmd.colorscheme("catppuccin")
end
