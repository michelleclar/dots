local M = {}

local null_ls = require "null-ls"
local method = null_ls.methods.FORMATTING
local alternative_methods = {
  null_ls.methods.DIAGNOSTICS,
  null_ls.methods.DIAGNOSTICS_ON_OPEN,
  null_ls.methods.DIAGNOSTICS_ON_SAVE,
}

function M.list_registered_providers_names(filetype)
  local s = require "null-ls.sources"
  local available_sources = s.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for _method in pairs(source.methods) do
      registered[_method] = registered[_method] or {}
      table.insert(registered[_method], source.name)
    end
  end
  return registered
end

function M.list_registered(filetype)
	local registered_providers = M.list_registered_providers_names(filetype)
	return registered_providers[method] or {}
end

function M.list_registered_linters(filetype)
  local registered_providers = M.list_registered_providers_names(filetype)
  local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
    return registered_providers[m] or {}
  end, alternative_methods))

  return providers_for_methods
end

return M
