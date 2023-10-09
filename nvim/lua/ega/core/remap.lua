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
	l = { name = "LSP" },
}

-- Initial Load of all Custom configs
local Custom = require("ega.custom")
local Utils = require("ega.core.utils")

vmap("n", "Q", "<nop>", KeyOpts())
vmap("v", "J", ":m '>+1<CR>gv=gv", KeyOpts())
vmap("v", "K", ":m '<-2<CR>gv=gv", KeyOpts())
vmap("v", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", KeyOpts("Rename"))

vmap("x", "<leader>p", '"_dP', KeyOpts("Paste & Keep"))
vmap("n", "<leader>w", [[:w<CR>]], KeyOpts("Write"))
vmap("n", "<leader>q", [[:q<CR>]], KeyOpts("Quit"))
vmap("n", "<leader>y", "ggVGy<C-o>", KeyOpts("Yank Yall"))

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
vmap("n", "<leader>ia", "<cmd>Telescope diagnostics<CR>", KeyOpts("Diagnostics"))
vmap("n", "<leader>i[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", KeyOpts("Prev Error"))
vmap("n", "<leader>i]", "<cmd>lua vim.diagnostic.goto_next()<CR>", KeyOpts("Next Error"))
vmap("n", "<leader>ic", Custom.diagnostics.close_diag_at_cursor, KeyOpts("At Cursor"))
vmap("n", "<leader>il", Custom.diagnostics.close_diag_at_line, KeyOpts("At Line"))
vmap("n", "<leader>im", "<cmd>messages<CR>", KeyOpts("Sys Messages"))

MapGroup["<leader>l"] = sections.l
vmap("n", "<leader>ll", "<cmd>LspLog<CR>", KeyOpts("LSP Log"))
vmap("n", "<leader>li", "<cmd>LspInfo<CR>", KeyOpts("Lsp Info"))
vmap("n", "<leader>lr", "<cmd>LspRestart<CR>", KeyOpts("Lsp Restart"))

--
--Config
--
MapGroup["<leader>c"] = sections.c
vmap("n", "<leader>cf", Custom.config.t_core_files, KeyOpts("Telescope Config"))
vmap("n", "<leader>cs", Custom.config.t_share_files, KeyOpts("Telescope Share Files"))
vmap("n", "<leader>ce", Custom.config.b_core_files, KeyOpts("Browse Core Files"))
vmap("n", "<leader>cE", Custom.config.b_share_files, KeyOpts("Browse Share Files"))
--
--Find
--
MapGroup["<leader>f"] = sections.f
vmap("n", "<leader>fm", Custom.fzflua.main_fzf_files, KeyOpts("From C:"))
vmap("n", "<leader>ff", Custom.telescope.t_find_files, KeyOpts("Project File"))
vmap("n", "<leader>fw", Custom.telescope.t_live_grep, KeyOpts("Word"))
vmap("n", "<leader>fo", Custom.telescope.builtin.oldfiles, KeyOpts("Old Files"))
vmap("n", "<leader>fg", Custom.git.G_git_files, KeyOpts("Git Files"))
vmap("n", "<leader>fl", Utils.CurrentLoc, KeyOpts("File Loc"))

--
--Git Stuffs
--
MapGroup["<leader>g"] = sections.g
vmap("n", "<leader>gt", Custom.git._lazygit_toggle, KeyOpts("Git Terminal"))

--
--File Explorer Stuffs
--
--MapGroup["<leader>e"] = sections.e
vmap("n", "<leader>e", Custom.telescope.file_explorer, KeyOpts(sections.e.name))

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
-- ` <bs>/` : Goes to parent dir if prompt is empty, otherwise acts normally
-- '   <>/]': Ignore .gitignore

--
--Buffer
--
MapGroup["<leader>b"] = sections.b
vmap("n", "<leader>bx", "<cmd>:BDelete this<CR>", KeyOpts("Clear this  buf"))
vmap("n", "<leader>bX", "<cmd>:BDelete! this<CR>", KeyOpts("Clear this  buf"))
vmap("n", "<leader>bo", "<cmd>:BWipeout other<CR>", KeyOpts("Clear other buf"))
vmap("n", "<leader>ba", "<cmd>:BWipeout all<CR>", KeyOpts("Clear *ALL* buf"))
vmap("n", "<leader>bA", "<cmd>:BWipeout! all<CR>", KeyOpts("Clear *ALL* buf"))
vmap("n", "<leader>bb", Custom.telescope.builtin.buffers, KeyOpts("List Buffers"))
vmap("n", "<leader>bl", Utils.CurrentLoc, KeyOpts("Filepath"))

utils.map("n", "<tab>", "<cmd>:BufferLineCycleNext<CR>", "Next buffer")
utils.map("n", "<S-tab>", "<cmd>:BufferLineCyclePrev<CR>", "Prev buffer")

--
--Help
--
MapGroup["<leader>h"] = sections.h
vmap("n", "<leader>hc", Custom.cs.cheatsheet_toggle, KeyOpts("Cheat Sheet"))
vmap("n", "<leader>hk", Custom.telescope.builtin.keymaps, KeyOpts("Key Maps"))

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
