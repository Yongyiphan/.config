local lsp = _G.call("lsp-zero")
if not lsp then
	return
end
lsp.preset("recommended")

lsp.ensure_installed({
	"clangd",
	"lua_ls",
})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
	lsp.buffer_autoformat()
	--print(client)
	vim.keymap.set({ "n", "x" }, "gq", function()
		vim.lsp.buf.format({ async = false, timeout_ms = 100000 })
	end)
	--Contained Keymaps
	--	local builtin = require("telescope.builtin")
	--	require("which-key").register({
	--		["<leader>f"]  = { name = "Find" },
	--		["<leader>fr"] = { builtin.lsp_references, "References" },
	--		["<leader>fd"] = { builtin.lsp_definitions, "Definition" },
	--		["<leader>ft"] = { builtin.lsp_type_definitions, "Type Def" },
	--	})
end)

lsp.set_sign_icons({
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

--lsp.skip_server_setup({""})
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local mason_null_ls = _G.call("mason-null-ls")
if not mason_null_ls then
	return
end
mason_null_ls.setup({
	ensure_installed = {
		"cpplint",
		"clang-format",
		"stylua",
	},
})

--Adding Custom servers
--require('lspconfig.configs').my_new_lsp = {
--  default_config = {
--    name = 'my-new-lsp',
--    cmd = {'my-new-lsp'},
--    filetypes = {'my-filetype'},
--    root_dir = require('lspconfig.util').root_pattern({'some-config-file'})
--  }
--}
--
--require('lspconfig').my_new_lsp.setup({})
