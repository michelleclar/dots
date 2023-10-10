" 使用vim的modeline来设置当前文件的textwidth,
" 避免输入超过78个字符时自动换行
" 使用:verbose set textwidth?命令可以看到vim默认
" 为vim配置脚本设置了textwidth为78,当输入超过78个字符
" 并按下空格键时会自动换行.将textwidth设成0关闭该功能
"" vim: tw=0 :

" 去掉有关vi一致性模式,避免操作习惯上的局限.
set nocompatible

" 让Backspace键可以往前删除字符.
" Debian系统自带的vim版本会加载一个debian.vim文件,
" 默认已经设置这一项,
" 可以正常使用Backspace键.如果使用自己编译的vim版本,
" 并自行配置.vimrc文件,可能就没有设置这一项,导致
" Backspace键用不了,或者时灵时不灵.所以主动配置.
set backspace=indent,eol,start

" 1=启动显示状态行, 2=总是显示状态行.
" 设置总是显示状态行,方便看到当前文件名.
set laststatus=2

" 设置ruler会在右下角显示光标所在的行号和列号,
" 不方便查看.改成设置状态栏显示内容
"" set ruler
" 设置编码格式，encoding 选项用于缓存的文本、寄存器、Vim 脚本文件等；fileencoding 选项是 Vim 写入文件时采用的编码类型；termencoding 选项表示输出到终端时采用的编码类型。
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
" 设置状态行显示的内容. %F: 显示当前文件的完整路径.
" %r: 如果readonly,会显示[RO]
" %B: 显示光标下字符的编码值,十六进制.
" %l:光标所在的行号. %v:光标所在的虚拟列号.
" %P: 显示当前内容在整个文件中的百分比.
" %H和%M是strftime()函数的参数,获取时间.
set statusline=%F%r\ [HEX=%B][%l,%v,%P]\ %{strftime(\"%H:%M\")}
 
" 显示还没有输入完整的命令.例如yy命令,输入第一个y会在右下角显示y.
set showcmd

" 使用Tab键补全时,在状态栏显示匹配的列表,
" 方便查看都有哪些命令符合补全条件.
set wildmenu

" 显示行号
set number

" 高亮显示匹配的括号
set showmatch

" 高亮显示所有搜索到的内容.后面用map映射
" 快捷键来方便关闭当前搜索的高亮.
set hlsearch

" 光标立刻跳转到搜索到内容
set incsearch

" 搜索到最后匹配的位置后,再次搜索不回到第一个匹配处
set nowrapscan

" 去掉输入错误时的提示声音
set noeb

" 默认按下Esc后,需要等待1秒才生效,
" 设置Esc超时时间为100ms,尽快生效
set ttimeout
set ttimeoutlen=100

" 设置文件编码,主要是避免中文乱码.
" 先注释,后续遇到中文乱码再打开
"" set fileencodings=utf-8,cp936,big5,latin1

" FIXME 在MS-DOS控制台打开vim时,控制台使用鼠标
" 右键来复制粘贴,设置全鼠标模式,鼠标右键被映射为
" visual mode,不能用来复制粘贴,不方便.但是如果不
" 设置鼠标模式,会无法使用鼠标滚轮来滚动界面.经过验证,
" 发现可以设成普通模式mouse=n来使用鼠标滚轮,也能使用
" 鼠标右键复制粘贴. mouse=c/mouse=i模式都不能用鼠标
" 滚轮. Linux下还是要设成 mouse=a
set mouse=n

" FIXME 在MS-DOS控制台打开vim,光标很小,不方便看到光标
" 在哪里.下面设置cursorline,高亮光标所在的行.
" cursorlineopt=number只高亮行号部分,不影响正文内容
" 的显示. 在其他容易看到光标的终端上可以去掉这两个设置.
set cursorline
set cursorlineopt=number

" 开启语法高亮
syntax enable

" 检测文件类型,并载入文件类型插件,
" 为特定文件类型载入相关缩进文件
filetype plugin indent on

" 设置自动补全的选项. longest表示只自动补全最大匹配的部分,
" 剩余部分通过CTRL-P/CTRL-N来选择匹配项进行补全. menu表示
" 弹出可补全的内容列表.如果有多个匹配,longest选项不会自动选中
" 并完整补全,要多按一次CTRL-P,比较麻烦,不做设置,保持默认设置,
" vim默认没有设置longest.
"" set completeopt=longest,menu

" 自动缩进.这个导致从外面拷贝多行以空格开头的内容时,
" 会有多的缩进,先不设置.
"" set autoindent

" 设置C风格的自动缩进.设置filetype indent on后,就会根据文件
" 类型自动缩进.按照vim用户手册'30.3 Automatic indenting'的
" 说明,可以不再单独设置cindent.
"" set cindent

" 自动缩进时,缩进长度为4
set shiftwidth=4

" 输入Tab字符时,自动替换成空格
set expandtab

" 设置softtabstop有一个好处是可以用Backspace键来一次
" 删除4个空格. softtabstop的值为负数,会使用shiftwidth
" 的值,两者保持一致,方便统一缩进.
set softtabstop=-1

" 设置颜色主题,适用于黑色背景.
colorscheme slate

" 创建一个新的 MyTabSpace 组,并设置它的颜色
highlight MyTabSpace ctermfg=darkgrey

" 指定tab字符和空格的颜色组为MyTabSpace,不同字符串
" 之间用|隔开,要使用\|转义.
match MyTabSpace /\t\| /

" 针对特定类型的代码文件,设置显示Tab键和行尾空格以便在
" 查看代码时注意到它们.
" TODO 后续查看代码如果体验不好再改成用map映射快捷键
" 开关list来动态切换显示.
autocmd FileType c,cpp,java,xml setlocal list | set listchars=tab:>~,trail:.

" 配置 gtags 插件,用于在函数之间跳转,方便查看源代码.
" 参考 gtags-cscopde.vim 的注释,添加下面语句来
" 使用 ':tag' 和 '<C-]>'
set cscopetag
" 设置 cscopetag 后,由于gtags-cscopde默认没有启动,
" 还需要进行下面的设置.结合这两个设置, gtags 就可以
" 使用Ctrl-]键来跳转到函数定义处.
let GtagsCscope_Auto_Load = 1
" 配置 GtagsCscope_Auto_Load = 1 后,在没有GTAGS文件
" 的目录下使用vim,会提示 Gtags-cscope: GTAGS not found.
" Press ENTER or type command to continue
" 需要按回车才会打开文件.如果要去掉这个报错,需要设置GtagsCscope_Quiet = 1
let g:GtagsCscope_Quiet = 1
" 设置只有一个匹配结果时,不显示quickfix窗口
let g:Gtags_Close_When_Single = 1
let mapleader=" "
" 配置 quickfix 相关命令的快捷键. 可以用:map命令
" 查看vim已有的快捷键映射.
" 普通模式
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-w> <C-w>w
nnoremap <F2> :cclose<CR>
nnoremap <F3> :cn<CR>
nnoremap <F4> :cp<CR>
nnoremap <leader>sv <C-w>v
nnoremap <leader>sh <C-w>s
nnoremap <leader><C-r> workbench.action.openRecent
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
" vim 用 map 命令来映射快捷键,它前面可以加一些前缀来对应
" 不同的场景.下面 map 前面的 nore 表示非递归. nore 前面
" 的n表示只在普通模式下生效.即,基于下面的配置,在插入模式下,
" 按F6没有这个映射效果.插入模式对应i. 下面配置cscope查找
" 文件命令的快捷键为F6,由于需要手动输入文件名,不要加<CR>
nnoremap <F6> :cs find f<Space>

" 如果要去掉高亮显示搜索到的内容,需要再次搜索一些不存在的字符串,
" 比较麻烦.可以在vim的命令行中执行nohlsearch命令去掉当前高亮.
" 下面的 nohlsearch 以 : 开头表示在命令行执行.
nnoremap <leader>nh :nohlsearch<CR>
" 插入模式下也用F9来去掉搜索高亮.下面的<C-o>表示CTRL-O.
" CTRL-O键可以在插入模式执行一次命令
" 插入模式
inoremap jk <ESC>
inoremap <F9> <C-o>:nohlsearch<CR>
" 可视化模式
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
