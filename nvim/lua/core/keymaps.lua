local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-'>", "zfi{", opts)
keymap("n", "<C-a>", "ggVG", opts)
-- zfi{      # 折叠光标当前所在的大括号{里面的文本
-- zfa{      # 折叠光标当前所在的大括号{里面的文本和大括号本身
-- zfG       # 从当前光标所在行开始，折叠到文件尾
-- zf10j     # 从当前光标所在行开始，继续向下折叠10行
-- zfip      # 折叠内部段落
-- za    # 切换(alternative)折叠状态,只能用在已折叠/未折叠的行
-- zR    # 展开所有折叠
-- zM    # 收缩所有折叠
-- keymap("n", "<leader>sh", "<C-w>s>") -- 垂直新增窗口 vertical
-- keymap("n", "<leader>sv", "<C-w>v>") -- 水平新增窗口 Horizontal
-- Resize with arrows
-- keymap("n", "<leader>e",":lex 30<cr>",opts)
-- keymap("n", "<leader>nh", ":nohl<CR>")
-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
keymap("i", "<A-h>", "<ESC>I", opts)
keymap("i", "<A-l>", "<ESC>A", opts)
-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":m '>+1<CR>gv=gv", opts)
keymap("x", "K", ":m '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
-- plugins --
-- keymap("n", "<leader>e", ":NvimTreeToggle<CR>") -- 打开文件树
-- keymap(
-- 	"n",
-- 	"<leader>ff",
-- 	"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
-- 	opts
-- ) -- 查找文件
-- keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts) -- 查找文本
-- keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts) -- 查找已经打开的buffers
-- keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts) -- 查找帮助文档
keymap("n", "<A-q>", "<cmd>lua require('util').delete_buffer()<cr>", opts) -- close buffer
keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<F7>", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<F8>", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<F6>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
-- d = {
--       name = "Debug",
--       t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
--       b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
--       c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
--       C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
--       d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
--       g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
--       i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
--       o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
--       u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
--       p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
--       r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
--       s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
--       q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
--       U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
--     },
-- Lua
--[[ vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end) ]]
--[[ vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end) ]]
--[[ vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end) ]]
--[[ vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end) ]]
--[[ vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end) ]]
--[[ vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end) ]]

