local telescope = _G.call("telescope")
if not telescope then
	return
end
local telebuiltin = require("telescope.builtin")

local toggleterm = _G.call("toggleterm")
if not toggleterm then
	return
end

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	direction = "float",
	hidden = true,
	count = 2,
	float_opts = {
		border = "double",
	},
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<cr>", { noremap = true, silent = true })
	end,
	on_close = function(term)
		vim.cmd("startinsert!")
	end,
})

function _G._lazygit_toggle()
	lazygit:toggle()
end

function _G.G_git_files()
	telebuiltin.git_files()
end
