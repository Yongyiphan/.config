local MapGroup = _G.Core.MapGroup
local utils = require("ega.core.utils")
local telescope = _G.call("telescope")
if not telescope then
	return
end
local whichkey = _G.call("which-key")
if not whichkey then
	return
end

local sections = {
	f = { name = "Find" },
	c = { name = "Config" },
	i = { name = "Info" },
	e = { name = "Explorer" },
	b = { name = "Buffers" },
	p = { name = "Project" },
	g = { name = "Git" },
	s = { name = "Split" },
	h = { name = "Help" },
	d = { name = "Debug" },
	u = { name = "UI" },
}

utils.map("n", "Q", "<nop>")
utils.map("v", "J", ":m '>+1<CR>gv=gv")
utils.map("v", "K", ":m '<-2<CR>gv=gv")
utils.map("v", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
utils.map("x", "<leader>p", '"_dP', "Paste & Keep")
utils.map("n", "<leader>w", [[:w<CR>]], "Write")
utils.map("n", "<leader>q", [[:q<CR>]], "Quit")

--
--Splits (Default = <C-w>)
--
MapGroup["<leader>s"] = sections.s
utils.map("n", "<leader>sv", "<C-w>v", "Split vert")
utils.map("n", "<leader>sh", "<C-w>s", "Split hort")
utils.map("n", "<leader>se", "<C-w>=", "Equal split size")
utils.map("n", "<leader>sx", ":close<CR>", "Close curr split")
utils.map("n", "<leader>sj", "<C-w>j", "Move to Above Split")
utils.map("n", "<leader>sk", "<C-w>k", "Move to Below Split")
utils.map("n", "<leader>sh", "<C-w>h", "Move to Left  Split")
utils.map("n", "<leader>sl", "<C-w>l", "Move to Right Split")

--Diagnostics
MapGroup["<leader>i"] = sections.i
local diagnostics = require("ega.core.diagnostics")
utils.map("n", "<leader>ia", "<cmd>Telescope diagnostics<CR>", "Diagnostics")
utils.map("n", "<leader>i[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev Error")
utils.map("n", "<leader>i]", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Error")
utils.map("n", "<leader>iL", "<cmd>LspLog<CR>", "Lsp Logs")

utils.map("n", "<leader>ii", function()
	diagnostics.close_diag_window("c")
end, "At Cursor")

utils.map("n", "<leader>il", function()
	diagnostics.close_diag_window("l")
end, "At Line")

--
--Config
--
MapGroup["<leader>c"] = sections.c
utils.map("n", "<leader>cv", "<cmd>lua _G.edit_nvim()<CR>", "Config Nvim")
utils.map("n", "<leader>cs", utils.source_curr_file, "Source")
utils.map("n", "<leader>cr", utils.reload_nvim, "Reload Config")
utils.map("n", "<leader>cf", utils.nvim_files, "Find Files")

--
--Find
--
MapGroup["<leader>f"] = sections.f
local FZF = require("ega.custom.fzflua")
utils.map("n", "<leader>fm", FZF.main_fzf_files, "From C:")

--Project
MapGroup["<leader>p"] = sections.p
local Tele = require("ega.custom.telescope")
utils.map("n", "<leader>pf", Tele.find_files, "Find Files")
utils.map("n", "<leader>pw", Tele.live_grep, "Find Word")

--
--Git Stuffs
--
MapGroup["<leader>g"] = sections.g
local Git = require('ega.custom.git')
utils.map("n", "<leader>gf", Git.G_git_files, "Find Files")
utils.map("n", "<leader>gs", vim.cmd.Git, "Git")
utils.map("n", "<leader>gt", Git.toggle_lazygit, "Git Terminal")

--
--File Explorer Stuffs
--
--MapGroup["<leader>e"] = sections.e
utils.map("n", "<leader>e", Tele.file_browser, sections.e.name)

-- Default keymaps in insert/normal mode:
-- `<cr>`: opens the currently selected file, or navigates to the currently selected directory
-- `<A-c>/c`: Create file/folder at current `path` (trailing path separator creates folder)
-- `<A-r>/r`: Rename multi-selected files/folders
-- `<A-m>/m`: Move multi-selected files/folders to current `path`
-- `<A-y>/y`: Copy (multi-)selected files/folders to current `path`
-- `<A-d>/d`: Delete (multi-)selected files/folders
-- `<C-o>/o`: Open file/folder with default system application
-- `<C-g>/g`: Go to parent directory
-- `<C-e>/e`: Go to home directory
-- `<C-w>/w`: Go to current working directory (cwd)
-- `<C-t>/t`: Change nvim's cwd to selected folder/file(parent)
-- `<C-f>/f`: Toggle between file and folder browser
-- `<C-h>/h`: Toggle hidden files/folders
-- `<C-s>/s`: Toggle all entries ignoring `./` and `../`
-- `<bs>/` : Goes to parent dir if prompt is empty, otherwise acts normally

--
--Buffer
--
MapGroup["<leader>b"] = sections.b
utils.map("n", "<leader>bx", "<cmd>:BDelete this<CR>", "Clear this  buf")
utils.map("n", "<leader>bX", "<cmd>:BDelete! this<CR>", "Clear this  buf")
utils.map("n", "<leader>bo", "<cmd>:BWipeout other<CR>", "Clear other buf")
utils.map("n", "<leader>ba", "<cmd>:BWipeout all<CR>", "Clear *ALL* buf")
utils.map("n", "<leader>bA", "<cmd>:BWipeout! all<CR>", "Clear *ALL* buf")
local telescope_builtin = require("telescope.builtin")
utils.map("n", "<leader>bb", telescope_builtin.buffers, "List Buffers")

utils.map("n", "<tab>", "<cmd>:BufferLineCycleNext<CR>", "Next buffer")
utils.map("n", "<S-tab>", "<cmd>:BufferLineCyclePrev<CR>", "Prev buffer")

--
--Help
--
MapGroup["<leader>h"] = sections.h
utils.map("n", "<leader>hc", _G.cheatsheet_toggle, "Cheat Sheet")

--
--Debug
--
MapGroup["<leader>d"] = sections.d
MapGroup["<leader>du"] = sections.u
require("ega.custom.dap.keybinding")
--
--Register Key Groups
--
whichkey.register(MapGroup)
