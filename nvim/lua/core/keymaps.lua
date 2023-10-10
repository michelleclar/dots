-- 主键
vim.g.mapleader = " "

local keymap = vim.keymap

-- ------------插入模式----------------
-- 模式 输入命令 映射键位
keymap.set("i","jk","<ESC>")

-- ------------视觉模式----------------
keymap.set("v","K",":m '<-2<CR>gv=gv") -- 上移
keymap.set("v","J",":m '>+1<CR>gv=gv") -- 下移
keymap.set("v","Y","'+y")              -- 复制到系统寄存器
-- ------------正常模式----------------
-- 窗口
keymap.set("n","<leader>sv","<C-w>v>") -- 水平新增窗口
keymap.set("n","<leader>sh","<C-w>s>") -- 垂直新增窗口
keymap.set("n","<leader>w",":w<CR>") -- 保存
keymap.set("n","<leader>q",":q<CR>") -- 退出
keymap.set("n","H","^") -- 首行
keymap.set("n","L","$") --行尾

-- 取消高亮
keymap.set("n","<leader>nh",":nohl<CR>")
-- 切换buffer
keymap.set("n", "<c-L>", ":bnext<CR>")
keymap.set("n", "<c-H>", ":bprevious<CR>")
-- 插件
keymap.set("n","<leader>e", ":NvimTreeToggle<CR>")
