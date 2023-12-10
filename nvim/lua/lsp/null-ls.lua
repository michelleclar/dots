local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
--[[ local diagnostics = null_ls.builtins.diagnostics ]]

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.uncrustify.with({
			filetypes = { "java" },
		}),
		formatting.stylua,
		-- diagnostics.flake8
		-- java 代码格式校验
		-- diagnostics.checkstyle.with({extra_args = {"-c","~/Workspace/java/env/checkstyle/checkstyle-10.12.5-all.jar"}}),
		--[[ diagnostics.npm_groovy_lint -- 格式化和自动修复 Groovy、Jenkinsfile 和 Gradle 文件。 ]]
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {

				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
