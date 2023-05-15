local cmp = _G.call("cmp")
if not cmp then
	return
end

local luasnip = _G.call("luasnip")
if not luasnip then
	return
end

local autopair = _G.call("nvim-autopairs")
if not autopair then
	return
end

autopair.setup({})

require("luasnip/loaders/from_vscode").lazy_load()
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "luasnip" },
	}),
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	},
})
