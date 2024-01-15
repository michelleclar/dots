-- 插件
require("plugins")
-- core keymap optional
require("core")
require("autocommands")
require("_neodev")
-- this is fix ruby_host_prog
vim.g.loaded_perl_provider = 0
vim.g.ruby_host_prog = "/home/carl/.local/share/gem/ruby/3.0.0/bin/neovim-ruby-host"
--[[ vim.g.python3_host_prog = '/home/carl/.conda/envs/pynvim/bin/python' ]]
