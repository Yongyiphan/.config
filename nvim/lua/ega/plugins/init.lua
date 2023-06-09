return {
	{ 'tpope/vim-fugitive' },
	{ 'tpope/vim-rhubarb' },
	{ 'tpope/vim-surround', },
	{ 'inkarkat/vim-ReplaceWithRegister' },
	--tmux & split window navigation
	{ 'christoomey/vim-tmux-navigator', },
	--maximizes and restore current window
	{ 'szw/vim-maximizer' },
	{ 'numToStr/Comment.nvim', },
	{ "nvim-tree/nvim-web-devicons", },
	--Auto Completion
	{ 'hrsh7th/nvim-cmp' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	--Auto closing
	{ 'windwp/nvim-autopairs' },
	--snippets
	{ 'L3MON4D3/Luasnip' },
	{ "saadparwaiz1/cmp_luasnip" }, -- for autocompletion
	{ "rafamadriz/friendly-snippets" },
	{
		'folke/which-key.nvim',
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 200
			require("which-key").setup({
				icons = {
					group = "",
				},
			})
		end
	},
	{ "EdenEast/nightfox.nvim",         opts = {} },
	--formatting & linting
	{ "jose-elias-alvarez/null-ls.nvim" }, -- configure formatters & linters
	{ "jayp0521/mason-null-ls.nvim" },    -- bridges gap b/w mason & null-ls
	--toggle terminal
	{ 'akinsho/toggleterm.nvim',        version = "*", config = true }
}
