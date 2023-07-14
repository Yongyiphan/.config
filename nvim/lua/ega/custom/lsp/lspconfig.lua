local M = {}
local utils = require('ega.core.utils')
M.allowed_clients = { "efm" }
M.default_formatter = { "efm" }

M.custom_format = function(bufnr, allowed_clients)
	allowed_clients = allowed_clients or M.allowed_clients
	vim.lsp.buf.format({
		bufnr = bufnr,
	})
end

M.format_group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

M.format_on_save = function(bufnr, allowed_clients)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = M.format_group,
		buffer = bufnr,
		callback = function()
			M.custom_format(bufnr, allowed_clients)
		end,
	})
end


M.custom_attach = function(client, bufnr, formatter)
	formatter = formatter or M.default_formatter
	if vim.tbl_contains(formatter, client.name) then
		client.server_capabilities.documentFormattingProvider = true
		client.server_capabilities.documentRangeFormattingProvider = true
	end
	local opts = { buffer = bufnr, silent = true, noremap = true }

	if client.supports_method "textDocument/inlayHint" then
		require("lsp-inlayhints").on_attach(client, bufnr)
	end

	if client.supports_method "textDocument/documentSymbol" and client.name ~= "bashls" then
		require("nvim-navic").attach(client, bufnr)
	end

	utils.map("n", "<leader>iD", vim.lsp.buf.declaration, "Declaration", opts)
	utils.map("n", "<leader>id", vim.lsp.buf.definition, "Definition", opts)
	utils.map("n", "<leader>ih", vim.lsp.buf.hover, "Hover", opts)
	utils.map("n", "<leader>iI", vim.lsp.buf.implementation, "Implementation", opts)
	utils.map("n", "<leader>ir", vim.lsp.buf.references, "References", opts)
	utils.map("n", "<leader>if", function()
		M.custom_format(bufnr, formatter)
	end, "Format", opts)
	utils.map("n", "<leader>iH", function()
		require("telescope").load_extension("ui-select")
		vim.lsp.buf.code_action()
	end, "Code Actions", opts)

	M.format_on_save(bufnr, formatter)
	-- use omnifunc
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
	vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr"
end

M.capabilites = require("cmp_nvim_lsp").default_capabilities()
--M.capabilities = vim.lsp.protocol.make_client_capabilities()
--
--M.capabilities.textDocument.completion.completionItem = {
--	documentationFormat = { "markdown", "plaintext" },
--	snippetSupport = true,
--	preselectSupport = true,
--	insertReplaceSupport = true,
--	labelDetailsSupport = true,
--	deprecatedSupport = true,
--	commitCharactersSupport = true,
--	tagSupport = { valueSet = { 1 } },
--	resolveSupport = {
--		properties = {
--			"documentation",
--			"detail",
--			"additionalTextEdits",
--		},
--	},
--}
return M
