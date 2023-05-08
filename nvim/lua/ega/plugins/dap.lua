local M = {
	{ "mfussenegger/nvim-dap" },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
	{ "theHamsta/nvim-dap-virtual-text" },
}
return M
