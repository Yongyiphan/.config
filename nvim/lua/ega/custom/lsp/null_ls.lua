local mason_null_ls = _G.call("mason-null-ls")
if not mason_null_ls then
	return
end

local null_ls = _G.call("null-ls")
if not null_ls then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

--to setup format on save

--local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

mason_null_ls.setup({
	ensure_installed = {
		--linter
		"mypy",
		"ruff",
		"cpplint",
		--formatter
		"black",
		"stylua",
		"clang_format",
	},
	automatic_installation = true,
})

null_ls.setup({
	sources = {
		diagnostics.ruff,
		diagnostics.mypy,
		diagnostics.cpplint,

		formatting.stylua,
		formatting.clang_format,
		formatting.black,
	},
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					--vim.lsp.buf.format({
					--	filter = function(client)
					--		--  only use null-ls for formatting instead of lsp server
					--		return client.name == "null-ls"
					--	end,
					--	bufnr = bufnr,
					--})
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
