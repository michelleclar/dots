local M = {}
M.print = function()
	local msg = {
		i = 10,
	}
	for _, value in ipairs(msg) do
    require("util").writeFile(nil,value)
	end
end
local _M = {}
_M.print = function()
	local msg = {
		b = 12,
	}
end
M.run = function()
	vim.tbl_deep_extend("force", M, _M)
  M.print()
end

M.home = function ()

  local s = vim.env.HOME .. "/.vale.ini"
  print(s)
end
local uv = vim.loop
local path_sep = uv.os_uname().version:match "Windows" and "\\" or "/"
---Join path segments that were passed as input
---@return string
function M.join_paths(...)
  local result = table.concat({ ... }, path_sep)
  return result
end
return M
