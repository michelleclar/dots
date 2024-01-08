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
return M
