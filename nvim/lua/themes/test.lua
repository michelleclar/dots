local servers = {

	"lua_ls",
	-- "cssls",
	-- "html",
	-- "tsserver",
	"pyright",
	-- "bashls",
	"jsonls",
	"marksman",
	"jdtls",
	-- "yamlls",
}

for name, server in pairs(servers) do
	print("before:" .. server)
	print("name:" .. name)
	--[[ server = vim.split(server, "@")[1] ]]
	--[[  print('after' .. server) ]]
end
