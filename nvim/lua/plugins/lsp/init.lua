local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end
local s = 'plugins.lsp.'
require "plugins.lsp.mason"
require("plugins.lsp.handlers").setup()
require "plugins.lsp.null-ls"
require 'plugins.lsp.lspKeymaps'
require (s .. 'lsp_signature')
