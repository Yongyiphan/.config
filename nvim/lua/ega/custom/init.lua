require("ega.custom.autocmp")
require("ega.custom.buffer")
require("ega.custom.cheatsheet")
require("ega.custom.git")
require("ega.custom.fugitive")
require("ega.custom.fzflua")
require("ega.custom.treesitter")
require("ega.custom.toggleterm")
require("ega.custom.statusline")
require("ega.custom.telescope")
require("ega.custom.lsp")
require("ega.custom.dap")

local M = {}
M.custom_setup = function()
	require("nvim-web-devicons").setup()
end

return M
