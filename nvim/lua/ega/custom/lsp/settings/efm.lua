local custom_lsp = require("ega.custom.lsp.lspconfig")
local M = {}
local lsp = require("lspconfig")

local stylua = {
	formatCommand = "stylua -s --stdin-filepath ${INPUT} -",
	formatStdin = true,
}

local black = {
	formatCommand = "black --fast ${-1:lineLength} -",
	formatStdin = true
}


local mypy = {
	lintCommand = "mypy --show-column-numbers --install-types --show-error-codes",
	lintFormats = {
		"%f:%l:%c: %trror: %m",
		"%f:%l:%c: %tarning: %m",
		"%f:%l:%c: %tote: %m",
	},
	lintSource = "mypy",
}

local efm_language = {
	lua = { stylua },
	python = { mypy, black },
}
M.setup = {
	root_dir = vim.loop.cwd,
	--cmd = { vim.fn.stdpath('data') .. "/mason/bin/efm-langserver" },
	on_attach = function(client, bufnr)
		custom_lsp.custom_attach(client, bufnr)
	end,
	capabilities = custom_lsp.capabilites,
	init_options = {
		documentFormatting = true,
		codeAction = true,
	},
	settings = {
		rootMarkers = { ".git/" },
		language = efm_language,
		lintDebounce = 100,
	},
	filetypes = vim.tbl_keys(efm_language),
}

return M
