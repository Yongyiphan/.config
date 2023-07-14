local lspconfig = require("ega.custom.lsp.lspconfig")
local capabilities = lspconfig.capabilities

local M = {}
M.setup = {
	on_attach = function(client, bufnr)
		lspconfig.custom_attach(client, bufnr, {"efm"})
	end ,
	capabilities = capabilities,
	filetypes = { "python" },
}

local findmypy_config = function()
	local env_name = "env"
	local mypy_config = {
		ini = _G.cwd .. "/mypy.ini",
		py = _G.cwd .. "/" .. env_name .. "/bin/python",
	}
	return mypy_config
end

M.mypy = {
	args = {
		"--install-types",
	},
}

return M
