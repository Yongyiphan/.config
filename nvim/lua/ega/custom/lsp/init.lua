local lsp_zero = _G.call("lsp-zero")
if not lsp_zero then
	return
end
local lspconfig = _G.call("lspconfig")
if not lspconfig then
	return
end
local lspconfig_utils = require("lspconfig/util")
lsp_zero = lsp_zero.preset({})

local test = "hello"

lsp_zero.ensure_installed({
	"clangd",
	"lua_ls",
})
local test2 = "Hello2"

lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })
	lsp_zero.buffer_autoformat()
	vim.keymap.set({ "n", "x" }, "gq", function()
		vim.lsp.buf.format({ async = false, timeout_ms = 100000 })
	end)
end)

lsp_zero.set_sign_icons({
	error = "✘",
	hint = "▲",
	warn = "⚑",
	info = "»",
})

vim.filetype.add({
	extension = {
		tpp = "cpp",
	},
	pattern = {
		[".*.tpp"] = "cpp",
	},
})

lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())
lsp_zero.skip_server_setup({ "clangd" })

lsp_zero.setup()

local function compile_flags(path)
	path = path or vim.loop.cwd()
	path = path .. "/compile_flags.txt"
	local flags = {}
	for line in io.lines("compile_flags.txt") do
		table.insert(flags, line)
	end
	return table.concat(flags, " ")
end

local clangd_cmd = {
	"clangd",
	"--background-index",
	"--clang-tidy",
	"--compile-commands-dir=.",
}

require("clangd_extensions").setup({
	server = {
		cmd = clangd_cmd,
		on_attach = function(client, bufnr)
			-- Enable completion
			require("completion").on_attach(client, bufnr)
		end,
	},
})

require("ega.custom.lsp.null_ls")
