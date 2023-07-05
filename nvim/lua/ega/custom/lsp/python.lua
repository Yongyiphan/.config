local config = require("lspconfig")
M = {
	on_attach = config.on_attach,
	capabilities = config.capabilities,
	filetypes = {
		"python",
	},
}
return M
