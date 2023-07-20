--return {
--	{
--		"VonHeikemen/lsp-zero.nvim",
--		branch = "v2.x",
--		dependencies = {
--			-- LSP Support
--			{ "neovim/nvim-lspconfig" }, -- Required
--			{
--				-- Optional
--				"williamboman/mason.nvim",
--				build = function()
--					pcall(vim.cmd, "MasonUpdate")
--				end,
--				cmd = { "Mason", "MasonInstall", "MasonUpdate" },
--			},
--			{ "williamboman/mason-lspconfig.nvim" }, -- Optional
--
--		},
--	},
--	{ "p00f/clangd_extensions.nvim" },
--}
--
local P = {
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
	},
	{ "williamboman/mason-lspconfig.nvim" }, -- Optional
	--Auto Completion
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	--C++ extensions
	{ "p00f/clangd_extensions.nvim" },
	{ "microsoft/vscode-codicons" },
	--formatting & linting
	{ "jose-elias-alvarez/null-ls.nvim" }, -- configure formatters & linters
	{
		"jayp0521/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	}, -- bridges gap b/w mason & null-ls
}

return P
