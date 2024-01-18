### 1 Check Dependencies

```shell
must:
python3
curl
get
unzip
git
cargo
ripgrep

optional:
```

```
help init.lua -- to know config file path
help options -- 一些环境参数 shou line num

:Lexplore --打开文件树
 NOTE: fix checkhealth
live_grep (pacman -S ripgrep) --
fd (pacman -S fd)
tree-sitter (npm install tree-sitter-cli or cargo)
anaconda (pacman -S anaconda conda init pip install neovim greenley pynvim,if ERROR http(conda remove curl))

block
```

### Document introduction

```
 nvim
├──  doc
│  └──  plugins.md
├──  ftplugin
│  ├──  java.lua
│  └──  python.lua
├──  init.lua
├──  lsp-settings
│  ├──  gopls.json
│  ├──  jdtls.json
│  ├──  lua_ls.json
│  ├──  pyright.json
│  └──  rust_analyzer.json
├──  lua
│  ├──  _neodev.lua -- lua_ls 配置
│  ├──  autocommands.lua -- 自动命令
│  ├──  comment          -- 通用（icon..）
│  │  ├──  icons.lua
│  │  ├──  lsp_kind.lua
│  │  ├──  nerd_font.lua
│  │  ├──  text.lua
│  │  └──  theme.lua
│  ├──  core             -- options keymaps
│  │  ├──  init.lua
│  │  ├──  keymaps.lua
│  │  └──  options.lua
│  ├──  log              -- log print tool
│  │  └──  init.lua
│  ├──  plugins          -- 插件配置
│  │  ├──  cmp           -- 代码补全配置
│  │  │  ├──  autopairs.lua  -- 括号补全
│  │  │  ├──  cmp.lua        -- 补全主要配置
│  │  │  ├──  pkg.lua
│  │  │  └──  README.md
│  │  ├──  diagnostics       -- 诊断
│  │  │  ├──  pkg.lua
│  │  │  ├──  README.md
│  │  │  └──  trouble.lua    -- 可以快速定位错误，以便于 quick fix
│  │  ├──  expand            -- 一些不影响体验，但可以提升效率的插件
│  │  │  ├──  comment.lua    -- 快捷注释
│  │  │  ├──  hop.lua        -- 快速跳转
│  │  │  ├──  pkg.lua
│  │  │  ├──  project.lua    -- 项目管理
│  │  │  ├──  README.md
│  │  │  ├──  todo-comments.lua -- 标签增强 such TODO NOTE ..
│  │  │  ├──  treesitter.lua    -- 代码高亮
│  │  │  └──  whichkey.lua      -- 快捷键提示
│  │  ├──  file                 -- 文件增强插件
│  │  │  ├──  nvim-tree.lua     -- 文件树
│  │  │  ├──  pkg.lua
│  │  │  ├──  README.md
│  │  │  └──  telescope.lua     -- 代码高亮
│  │  ├──  init.lua             -- 加载插件
│  │  ├──  lsp                  -- lsp
│  │  │  ├──  config.lua        -- lsp 基础配置
│  │  │  ├──  init.lua
│  │  │  ├──  lsp_signature.lua -- 方法参数提示
│  │  │  ├──  manager.lua       -- lsp 管理
│  │  │  ├──  mason.lua         -- mason lsp 服务包管理
│  │  │  ├──  null_ls           -- 代码诊断 格式化
│  │  │  │  ├──  go.lua
│  │  │  │  ├──  helpers.lua
│  │  │  │  ├──  init.lua
│  │  │  │  └──  markdown.lua
│  │  │  ├──  pkg.lua
│  │  │  ├──  providers         -- 基础lsp配置
│  │  │  │  ├──  jsonls.lua
│  │  │  │  ├──  lua_ls.lua
│  │  │  │  ├──  tailwindcss.lua
│  │  │  │  └──  yamlls.lua
│  │  │  └──  utils.lua         -- lsp 共用方法抽取
│  │  ├──  snippets             -- 代码片段
│  │  │  ├──  luasnip.lua       -- 代码文档 快捷补全 such：sout == System.out.println("")
│  │  │  ├──  pkg.lua
│  │  │  └──  README.md
│  │  ├──  terminal             -- 终端
│  │  │  ├──  pkg.lua
│  │  │  ├──  README.md
│  │  │  ├──  toggleterm.lua    -- 浮动终端
│  │  └──  ui                   -- 界面美化
│  │     ├──  alpha.lua         -- 启动界面
│  │     ├──  bufferline.lua    -- 文件tab管理
│  │     ├──  colorizer.lua     -- 颜色实时预览
│  │     ├──  comment-box.lua   -- 注释框
│  │     ├──  fidget.lua        -- Dynamic Information
│  │     ├──  gitsigns.lua      -- 可以预览 git 变化
│  │     ├──  incline.lua       -- 浮动的状态栏
│  │     ├──  indentline.lua    -- 代码块
│  │     ├──  lualine.lua       -- 状态栏
│  │     ├──  navic.lua         -- 显示正在编辑方法
│  │     ├──  pkg.lua
│  │     ├──  README.md
│  │     ├──  symbols_outline.lua -- 显示正在编辑的文件大纲
│  │     └──  winbar.lua -- 显示正在编辑的方法
│  ├──  test
│  │  ├──  lua.log
│  │  └──  test.lua  -- 测试
│  └──  util         -- 工具
│     ├──  init.lua
│     ├──  null-ls.lua
│     └──  table.lua
└──  README.md
```
