local M = {}
M.print = function()
  local msg = {
    i = 10
  }
  print(msg)
end
local _M = {}
_M.print = function()
  local msg = {
    b = 12
  }
  for _, value in ipairs(msg) do
    print(value)
  end
end
vim.tbl_deep_extend("force", _M,M)

M.print()
