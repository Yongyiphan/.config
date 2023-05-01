local telescope = {
	{
		"nvim-telescope/telescope.nvim",
		tag = '0.1.1',
		dependencies = {
			"nvim-lua/plenary.nvim",
			--"BurntSushi/ripgrep",
		},
		config = function()
			require("telescope").setup({})
		end
	},
	--extensions
	{ "nvim-telescope/telescope-file-browser.nvim" },
	{
		'nvim-telescope/telescope-media-files.nvim',
		dependencies = {
			'nvim-lua/popup.nvim',
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make"
	},
}



return telescope
