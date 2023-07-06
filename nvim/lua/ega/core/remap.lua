local MapGroup = _G.Core.MapGroup
local vmap = vim.keymap.set
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

vmap("n", "Q", "<nop>", KeyOpts())
vmap("v", "J", ":m '>+1<CR>gv=gv", KeyOpts())
vmap("v", "K", ":m '<-2<CR>gv=gv", KeyOpts())
vmap("v", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", KeyOpts("Rename"))

vmap("x", "<leader>p", '"_dP', KeyOpts("Paste & Keep"))
vmap("n", "<leader>w", [[:w<CR>]], KeyOpts("Write"))
vmap("n", "<leader>q", [[:q<CR>]], KeyOpts("Quit"))

--
--Splits (Default = <C-w>)
--
MapGroup["<leader>s"] = sections.s
vmap("n", "<leader>sv", "<C-w>v", KeyOpts("Split vert"))
vmap("n", "<leader>sh", "<C-w>s", KeyOpts("Split hort"))
vmap("n", "<leader>se", "<C-w>=", KeyOpts("Equal split size"))
vmap("n", "<leader>sx", ":close<CR>", KeyOpts("Close curr split"))
vmap("n", "<leader>sj", "<C-w>j", KeyOpts("Move to Above Split"))
vmap("n", "<leader>sk", "<C-w>k", KeyOpts("Move to Below Split"))
vmap("n", "<leader>sh", "<C-w>h", KeyOpts("Move to Left  Split"))
vmap("n", "<leader>sl", "<C-w>l", KeyOpts("Move to Right Split"))

--Diagnostics
MapGroup["<leader>i"] = sections.i
vmap("n", "<leader>ia", "<cmd>Telescope diagnostics<CR>", KeyOpts("Diagnostics"))
vmap("n", "<leader>i[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", KeyOpts("Prev Error"))
vmap("n", "<leader>i]", "<cmd>lua vim.diagnostic.goto_next()<CR>", KeyOpts("Next Error"))
vmap("n", "<leader>iL", "<cmd>LspLog<CR>", KeyOpts("Next Error"))

vmap("n", "<leader>ii", function()
	_G.close_diag_window("c")
end, KeyOpts("At Cursor"))

vmap("n", "<leader>il", function()
	_G.close_diag_window("l")
end, KeyOpts("At Line"))

--
--Config
--
MapGroup["<leader>c"] = sections.c
vmap("n", "<leader>cv", "<cmd>lua _G.edit_nvim()<CR>", KeyOpts("Config Nvim"))
local save_source = function()
	local config_dir = os.getenv("HOME") .. "/.config"
	local current_file = vim.fn.expand("%:p")
	local filetype = vim.fn.fnamemodify(current_file, ":e")
	if string.find(current_file, config_dir) and filetype == "lua" then
		vim.cmd("w " .. current_file)
		vim.cmd("luafile " .. current_file)
		print("Sourced " .. current_file)
	else
		print("Not a .config lua file")
	end
end
vmap("n", "<leader>cs", save_source, KeyOpts("Source"))
local reload_config = function()
	for name, _ in ipairs(package.loaded) do
		if name:match("^ega") then
			package.loaded[name] = nil
			print(name)
		end
	end
	dofile(vim.env.MYVIMRC)
	vim.notify("Reload T Nvim Config!", vim.log.levels.INFO)
end
vmap("n", "<leader>cr", reload_config, KeyOpts("Reload Config"))
--
--Find
--
MapGroup["<leader>f"] = sections.f
vmap("n", "<leader>fm", _G.main_fzf_files, KeyOpts("From C:"))

--Project
MapGroup["<leader>p"] = sections.p
vmap("n", "<leader>pf", _G.t_find_files, KeyOpts("Curr Project"))
vmap("n", "<leader>pw", _G.t_live_grep, KeyOpts("Word"))

--
--Git Stuffs
--
MapGroup["<leader>g"] = sections.g
vmap("n", "<leader>gf", _G.G_git_files, KeyOpts("Find Files"))
vmap("n", "<leader>gs", vim.cmd.Git, KeyOpts("Git"))
vmap("n", "<leader>gt", "<cmd>lua _G._lazygit_toggle()<CR>", KeyOpts("Git Terminal"))

--
--File Explorer Stuffs
--
--MapGroup["<leader>e"] = sections.e
local file_browser = telescope.extensions.file_browser
vmap("n", "<leader>e", function()
	file_browser.file_browser()
end, KeyOpts(sections.e.name))

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
vmap("n", "<leader>bx", "<cmd>:BDelete this<CR>", KeyOpts("Clear this  buf"))
vmap("n", "<leader>bX", "<cmd>:BDelete! this<CR>", KeyOpts("Clear this  buf"))
vmap("n", "<leader>bo", "<cmd>:BWipeout other<CR>", KeyOpts("Clear other buf"))
vmap("n", "<leader>ba", "<cmd>:BWipeout all<CR>", KeyOpts("Clear *ALL* buf"))
vmap("n", "<leader>bA", "<cmd>:BWipeout! all<CR>", KeyOpts("Clear *ALL* buf"))
local telescope_builtin = require("telescope.builtin")
vmap("n", "<leader>bb", telescope_builtin.buffers, KeyOpts("List Buffers"))

vmap("n", "<tab>", "<cmd>:BufferLineCycleNext<CR>", KeyOpts("Next buffer"))
vmap("n", "<S-tab>", "<cmd>:BufferLineCyclePrev<CR>", KeyOpts("Prev buffer"))

--
--Help
--
MapGroup["<leader>h"] = sections.h
vmap("n", "<leader>hc", _G.cheatsheet_toggle, KeyOpts("Cheat Sheet"))

--
--Debug
--
local dap = _G.call("dap")
if not dap then
	return
end
MapGroup["<leader>d"] = sections.d
MapGroup["<leader>du"] = sections.u
require("ega.custom.dap.keybinding")
--
--Register Key Groups
--
whichkey.register(MapGroup)
