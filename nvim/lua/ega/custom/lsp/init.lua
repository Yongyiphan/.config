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

lsp_zero.ensure_installed({
	"clangd",
	"lua_ls",
})

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

local function read_file(path)
	local file = io.open(path, "r")
	if not file then
		return {}
	end
	local contents = file:read("*all")
	file:close()
	return vim.split(contents, "\n")
end

local clangd_cmd = {
	"clangd",
	"--background-index",
	"--compile-commands-dir=.",
	"--compile-commands-dir=..",
	--"--compile-flags=compile_flags.txt",
	read_file(vim.loop.cwd() .. "/compile_flags.txt"),
}

clangd_cmd = vim.tbl_flatten({
	clangd_cmd,
	read_file(vim.loop.cwd() .. "/compile_flags.txt"),
})

require("clangd_extensions").setup({
	server = {
		cmd = clangd_cmd,
		filetypes = { "c", "cpp", "tpp", "h", "hpp" },
		root_dir = lspconfig_utils.root_pattern("compile_flags.txt"),
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	},
})

require("ega.custom.lsp.null_ls")
require("ega.custom.lsp.null_ls")
