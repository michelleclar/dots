local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- base
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "ahmedkhalf/project.nvim",            -- project mananger
  "lukas-reineke/indent-blankline.nvim", --code line effect for while
  "goolord/alpha-nvim",                 -- 简介
  "folke/which-key.nvim",               -- key tip
  --[[ 'lewis6991/impatient.nvim', -- fast run lua model if neovim > 0.9 , delelt it ]]
  -- theme
  "lunarvim/darkplus.nvim",
  --[[ "folke/tokyonight.nvim", -- 主题 ]]

  "nvim-lualine/lualine.nvim",  -- 状态栏
  "nvim-tree/nvim-tree.lua",    -- 文档树
  "nvim-tree/nvim-web-devicons", -- 文档树图标

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "p00f/nvim-ts-rainbow", -- 配合treesitter，不同括号颜色区分
    },
  },                       -- 语法高亮

  -- LSP
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim", -- 这个相当于mason.nvim和lspconfig的桥梁
    "neovim/nvim-lspconfig",
    "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
    "RRethy/vim-illuminate",
  },
  -- cmp
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
  },                         -- completion plugin
  "hrsh7th/cmp-buffer",      -- buffer
  "hrsh7th/cmp-path",        -- 文件路径
  "hrsh7th/cmp-cmdline",     -- cmdline
  "saadparwaiz1/cmp_luasnip", -- snippet engine
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",    -- lua 提示 vim
  -- snippets
  "L3MON4D3/LuaSnip",        -- snippets引擎
  "rafamadriz/friendly-snippets",

  -- options
  {
    "onsails/lspkind-nvim",
    "octaltree/cmp-look",
    "hrsh7th/cmp-calc",
  },
  -- Comment
  "numToStr/Comment.nvim", -- gcc和gc注释
  "JoosepAlviste/nvim-ts-context-commentstring",
  "windwp/nvim-autopairs", -- 自动补全括号

  -- buffer
  "akinsho/bufferline.nvim", -- buffer分割线
  "moll/vim-bbye",

  -- git
  "lewis6991/gitsigns.nvim", -- 左则git提示
  "akinsho/toggleterm.nvim", -- 浮动终端
  "kdheepak/lazygit.nvim",

  -- toggleterm 文件检索
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-media-files.nvim", -- 图片等预览
  {
    "keaising/im-select.nvim",
    config = function()
      require("im_select").setup({})
    end,
  },
  --[[ -- markdown preview ]]
  --[[ { ]]
  --[[ 	"iamcco/markdown-preview.nvim", ]]
  --[[ 	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }, ]]
  --[[ 	build = "cd app && npm install", ]]
  --[[ 	init = function() ]]
  --[[ 		vim.g.mkdp_filetypes = { "markdown" } ]]
  --[[ 	end, ]]
  --[[ 	ft = { "markdown" }, ]]
  --[[ }, ]]
}
local opts = {} -- 注意要定义这个变量

require("lazy").setup(plugins, opts)
