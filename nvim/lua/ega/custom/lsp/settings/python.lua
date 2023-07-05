local config = require("ega.custom.lsp.lspconfig")
local on_attach = config.on_attach
local capabilities = config.capabilities

local M = {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "python" },
}

return M
