local M = {}
function M.edit_nvim()
	require("telescope.builtin").find_files({
		cwd = "~/.config/nvim",
	})
end

function M.convert_path_to_windows(path)
	-- Replace /mnt/c with C:\
	if string.sub(path, 1, 6) == "/mnt/c" then
		path = string.gsub(path, "^/mnt/(%w)/", "%1:/")

		-- Replace remaining forward slashes with backslashes
		path = string.gsub(path, "/", "\\\\")
		return path
	end
	return false
end

function M.map(mode, keybind, cmd, desc, opts)
	opts = vim.tbl_deep_extend("force", {
		noremap = true,
		silent = true,
		expr = false,
		nowait = false,
	}, opts or {})
	opts.desc = desc or ""
	vim.keymap.set(mode, keybind, cmd, opts)
end

function M.open_pdf(entry)
	local script_path = "$HOME/.config/bash_sh/open_edge.sh"
	local selection = M.convert_path_to_windows(entry)
	if selection then
		local cmd = string.format("%s %s", script_path, selection)
		local status = vim.fn.system(cmd)
		assert(status ~= 0, "Error: Open PDF: " .. vim.fn.fnamemodify(entry, ":t"))
	else
		print("Not a Windows file")
	end
end

function M.open_file(prompt_bufnr)
	local action_state = require("telescope.actions.state")
	local picker = action_state.get_current_picker(prompt_bufnr)
	local current_entry = action_state.get_selected_entry(prompt_bufnr)
	local selections = {}
	table.insert(selections, current_entry)
	for _, entry in ipairs(picker:get_multi_selection()) do
		if not vim.tbl_contains(selections, entry) then
			table.insert(selections, entry)
		end
	end
	for _, entry in ipairs(selections) do
		if vim.fn.fnamemodify(entry.value, ":e") == "pdf" then
			M.open_pdf(entry.path)
		end
		require("telescope.actions").close(prompt_bufnr)
	end
end

function M.source_curr_file()
	--local config_dir = os.getenv("HOME") .. "/.config"
	local config_dir = vim.fn.stdpath("config")
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

function M.reload_nvim()
	for name, _ in ipairs(package.loaded) do
		if name:match("^ega") then
			package.loaded[name] = nil
			print(name)
		end
	end
	dofile(vim.env.MYVIMRC)
	vim.notify("Reload T Nvim Config!", vim.log.levels.INFO)
end

function M.nvim_files()
	print("Doing nothing atm")
end

function _G.call(plugin)
	local plugin_status, result = pcall(require, plugin)
	if not plugin_status then
		_G.Setup_Status = false
		print("Fail to call " .. plugin)
		return plugin_status
	end
	return result
end

_G.log = function(string)
	local file, err = io.open(vim.fn.stdpath('cache') .. "/testlog.log", "w")
	if file then
		file:write(tostring(string))
		file:close()
	else
		print("Error: ", err)
	end
end

_G.test_this = function(to_test)
	M.map("n", "<leader>t", function() to_test() end, "Test")
end

return M
