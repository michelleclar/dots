### nvim
dependencies
```
must:
neovide 
node
unzip
python3
git
cargo
ripgrep
optional:

```

```
help init.lua -- to know config file
help options -- 一些环境参数

:Lexplore --打开文件树
```
```
live_grep (pacman -S ripgrep)
fd (pacman -S fd)
tree-sitter (npm install tree-sitter-cli or cargo)
anaconda (pacman -S anaconda conda init pip install neovim greenley pynvim,if ERROR http(conda remove curl))
```
```
block
```
completion 
```lua
if add language -- https://github.com/topics/nvim-cmp
first add plugins
then add sources
-- plugins
    -- 自动补全
  "hrsh7th/nvim-cmp", -- completion plugin
  "hrsh7th/cmp-buffer", -- buffer
  "hrsh7th/cmp-path", -- 文件路径
  "hrsh7th/cmp-cmdline", -- cmdline
  "saadparwaiz1/cmp_luasnip", -- snippet engine
  "hrsh7th/cmp-nvim-lsp", 
  "hrsh7th/cmp-nvim-lua",  -- lua 提示 vim 

  "L3MON4D3/LuaSnip", -- snippets引擎，代码片段不装这个自动补全会出问题
  "rafamadriz/friendly-snippets",
---
-- 按照list 来顺序显示 super toggle
  -- TODO
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
```
lsp
```

```
> null-ls:需要先在cli验证cmd
telescope
```text
[nvim-telescope/telescope-media-files.nvim](https://github.com/nvim-telescope/telescope-media-files.nvim)
[Chafa](https://hpjansson.org/chafa/) (图片预览pacman -S Chafa)
[ImageMagick](https://imagemagick.org/index.php) (svg pacman -S imagemagick-full)
[ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer) (视频预览 )
[pdftoppm](https://linux.die.net/man/1/pdftoppm) （pdf pacman -S pdftopom）
[epub-thumbnailer](https://github.com/marianosimone/epub-thumbnailer) (epud pip install pillow sudo python3 install.py install)
[fontpreview](https://github.com/sdushantha/fontpreview) (字体预览)
```

git
```
Gitsigns preview_hunk
```

```
nvim
├── doc 文档
│  └── plugins.md 插件简介
├── init.lua
├── lazy-lock.json
├── lua
│  ├── core
│  │  ├── init.lua
│  │  ├── keymaps.lua 所有快捷键
│  │  └── options.lua 基础配置
│  ├── lsp
│  │  ├── handlers.lua
│  │  ├── init.lua
│  │  ├── mason.lua
│  │  ├── null-ls.lua
│  │  └── setting
│  │     ├── jsonls.lua
│  │     └── pyright.lua
│  ├── plugins
│  │  ├── alpha.lua
│  │  ├── autocommands.lua
│  │  ├── autopairs.lua
│  │  ├── bufferline.lua
│  │  ├── cmp.lua
│  │  ├── comment.lua
│  │  ├── gitsigns.lua
│  │  ├── indentline.lua
│  │  ├── init.lua
│  │  ├── lualine.lua
│  │  ├── nvim-tree.lua
│  │  ├── plugins-setup.lua
│  │  ├── project.lua
│  │  ├── telescope.lua
│  │  ├── toggleterm.lua
│  │  ├── treesitter.lua
│  │  └── whichkey.lua
│  └── themes
│     ├── darkplus.lua
│     ├── init.lua
│     ├── test.lua
│     └── tokyonight.lua
├── package-lock.json
├── package.json
└── README.md

```
