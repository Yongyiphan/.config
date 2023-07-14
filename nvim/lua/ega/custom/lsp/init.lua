local mason, mason_lsp, lsp = _G.call("mason"), _G.call("mason-lspconfig"), _G.call("lspconfig")
if not mason or not mason_lsp or not lsp then
	return
end

require("ega.custom.lsp.handlers")
vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "DiagnosticError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "DiagnosticWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", numhl = "DiagnosticInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", numhl = "DiagnosticHint" })


vim.filetype.add({
	extension = {
		tpp = "cpp",
	},
	pattern = {
		[".*.tpp"] = "cpp",
	},
})

--Mason Calls
mason.setup()
mason_lsp.setup({
	ensure_installed = {
		"clangd",
		"cmake",
		"lua_ls",
		"pyright",
		"efm",
	}
})

require("cmp").setup({
	sources = {
		{ name = "nvim_lsp" },
	},
})


lsp.lua_ls.setup(require("ega.custom.lsp.settings.lua_ls").setup)

lsp.pyright.setup(require("ega.custom.lsp.settings.python").setup)

--Special Setup call uing clangd_extensions
require("ega.custom.lsp.settings.cpp")

--Formatters, Linters using EFM-language-server
lsp.efm.setup(require('ega.custom.lsp.settings.efm').setup)

--Autocmds
require("ega.custom.lsp.autocmd")
