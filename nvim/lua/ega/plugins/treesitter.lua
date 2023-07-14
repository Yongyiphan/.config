local ts = {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	},
	{
		"creativenull/efmls-configs-nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
	},
	{
		"numirias/semshi",
	},
}
return ts
