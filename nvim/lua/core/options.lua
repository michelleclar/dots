local o = vim.opt
o.backup = false                          -- creates a backup file
o.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard,允许neovim访问系统剪切板
o.cmdheight = 1                           -- more space in the neovim command line for displaying messages,为显示消息显示更多空间
o.completeopt = { "menuone", "noselect" } -- mostly just for cmp,menuone(当只有一个匹配项时也会弹出菜单),noselect(在选择前不会插入任何文本)
o.conceallevel = 0                        -- so that `` is visible in markdown files
o.charconvert = 'utf-8'
--[[ o.fileencoding = "utf-8" -- the encoding written to a file ]]
o.hlsearch = true       -- highlight all matches on previous search pattern,高亮显示所有匹配项
o.ignorecase = true     -- ignore case in search patterns,忽略大小写（search）
o.mouse = "a"           -- allow the mouse to be used in neovim,允许使用鼠标
o.pumheight = 10        -- pop up menu height,弹出的菜单高度
o.showmode = false      -- we don't need to see things like -- INSERT -- anymore
o.showtabline = 1       -- always show tabs
o.smartcase = true      -- smart case,智能大小写
o.smartindent = true    -- make indenting smarter again,智能缩进
o.splitbelow = true     -- force all horizontal splits to go below current window,水平分割强制在下方
o.splitright = true     -- force all vertical splits to go to the right of current window,垂直分割强制在右方
o.swapfile = false      -- creates a swapfile
o.termguicolors = true  -- set term gui colors (most terminals support this)
o.timeoutlen = 300      -- time to wait for a mapped sequence to complete (in milliseconds)
o.undofile = true       -- enable persistent undo,启动永久撤销
o.updatetime = 300      -- faster completion (4000ms default)
o.writebackup = false   -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited,允许两个程序同时编辑
o.expandtab = true      -- convert tabs to spaces
o.shiftwidth = 2        -- the number of spaces inserted for each indentation
o.tabstop = 2           -- insert 2 spaces for a tab,tap宽度
o.cursorline = true     -- highlight the current line
o.cursorlineopt = { "number", "screenline" }
o.number = true         -- set numbered lines
o.relativenumber = true -- set relative numbered lines,设置相对行编号
o.numberwidth = 4       -- set number column width to 2 {default 4},数字列宽设为2

o.signcolumn = "auto"   -- yes|auto -- always show the sign column, otherwise it would shift the text each time,始终显示符号列
o.wrap = false          -- display lines as one long line
o.linebreak = true      -- companion to wrap, don't split words
o.scrolloff = 8         -- minimal number of screen lines to keep above and below the cursor,保持光标上下至少8行屏幕
o.sidescrolloff = 8     -- minimal number of screen columns either side of cursor if wrap is `false`
o.guifont = "FiraCode Nerd Font:h13"
-- o.guifont = "monospace:h17" -- the font used in graphical neovim applications
o.whichwrap = "bs<>[]hl" -- which "horizontal" keys are allowed to travel to prev/next line
o.mousemoveevent = true
-- vim.opt.shortmess = "ilmnrx"                        -- flags to shorten vim messages, see :help 'shortmess',缩短Vim消息
o.shortmess:append("c")                         -- don't give |ins-completion-menu| messages
o.iskeyword:append("-")                         -- hyphenated words recognized by searches
o.formatoptions:remove({ "c", "r", "o" })       -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
o.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use
o.timeout = true
o.wildmenu = true
-- NOTE:this is fix checkhealth (0:disabled | $path)
vim.g.transparent_background = true -- 透明背景
vim.g.loaded_perl_provider = 0
-- -- vim.g.ruby_host_prog = "/home/carl/.local/share/gem/ruby/3.0.0/bin/neovim-ruby-host"
-- vim.g.python3_host_prog = '/home/carl/.conda/envs/pynvim/bin/python'
vim.g.loaded_node_provider = "/home/carl/.nvm/versions/node/v18.18.1/bin/npm"
-- end
