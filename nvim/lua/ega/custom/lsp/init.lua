local mason, mason_lsp, lspconfig = _G.call("mason"), _G.call("mason-lspconfig"), _G.call("lspconfig")
if not mason or not mason_lsp or not lspconfig then
	return
end 

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    -- Create your keybindings here...
  end
})

mason.setup()

local to_install = {
	"lua-language-server",
	"clangd",
	"cmake",
	"lua_ls",
}
		

mason_lsp.setup({
	ensure_installed = to_install
})


require("cmp").setup{
	sources = {
		{name = "nvim_lsp"}
	}
}

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities() 
local get_servers = mason_lsp.get_installed_servers

for _, server_name in ipairs(get_servers()) do
  lspconfig[server_name].setup({
    capabilities = lsp_capabilities,
  })
end
