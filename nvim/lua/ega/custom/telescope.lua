local telescope = _G.call("telescope")
if not telescope then
	return
end
local builtin = require("telescope.builtin")
local Utils = require("ega.core.utils")
local M = {}
M.builtin = builtin
M.telescope = telescope

M.GetSelected = function(prompt_bufnr)
	local action_state = require("telescope.actions.state")
	local picker = action_state.get_current_picker(prompt_bufnr)
	local current_entry = action_state.get_selected_entry()
	local selections = {}
	table.insert(selections, current_entry)
	for _, entry in ipairs(picker:get_multi_selection()) do
		if not vim.tbl_contains(selections, entry) then
			table.insert(selections, entry)
		end
	end
	return selections
end

M.open_pdf = function(entry)
	local script_path = "$HOME/.config/nvim/bash/open_edge.sh"
	local selection = Utils.convert_path_to_windows(entry)
	if selection then
		local cmd = string.format("%s %s", script_path, selection)
		local status = vim.fn.system(cmd)
		assert(status ~= 0, "Error: Open PDF: " .. vim.fn.fnamemodify(entry, ":t"))
	else
		print("Not a Windows file")
	end
end

M.file_open = function(prompt_bufnr)
	local selections = M.GetSelected(prompt_bufnr)
	for _, entry in ipairs(selections) do
		if vim.fn.fnamemodify(entry.value, ":e") == "pdf" then
			M.open_pdf(entry.path)
		end
		require("telescope.actions").close(prompt_bufnr)
	end
end

M.unzip_file = function(prompt_bufnr)
	local function unzip_file(filename, destination)
		local command = string.format("unzip %s -d %s", vim.fn.shellescape(filename), vim.fn.shellescape(destination))
		vim.fn.system(command)
	end
	local selections = M.GetSelected(prompt_bufnr)
	for _, entry in ipairs(selections) do
		local current_file = vim.fn.fnamemodify(entry.path, ":t")
		local extension = current_file:match("%.([^%.]+)$")
		if extension == "zip" then
			local filename = current_file:gsub("%.[^.]*$", "")
			unzip_file(current_file, ".//" .. filename .. "//")
		end
	end
	require("telescope.actions").close(prompt_bufnr)
	M.file_explorer()
end

M.find_no_ignore = function(prompt_bufnr)
	local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
	local opts = {
		hidden = true,
		default_text = current_picker:_get_prompt(),
	}
	opts.no_ignore = true
	
	require("telescope.actions").close(prompt_bufnr)
	require("telescope.builtin").find_files(opts)
end

M.find_parent_directory = function(prompt_bufnr)
	--Move Out 1 directory and find files
	local opts = {}
	opts.find_command = {
		"fd",
		"--type",
		"f",
		"--ignore-file",
		"$HOME/.config/nvim/ignore/.general_ignore",
		"--ignore-file",
		"$HOME/.config/nvim/ignore/.tele_ignore",
	}
	_G.cwd = vim.fn.fnamemodify(_G.cwd, ":h")
	opts.cwd = _G.cwd
	require("telescope.actions").close(prompt_bufnr)
	require("telescope.builtin").find_files(opts)
end

-- UNUSED
--local finders = require("telescope.finders")
--local make_entry = require("telescope.make_entry")
--local action_state = require("telescope.actions.state")

--local opts = {}
--opts.entry_maker = make_entry.gen_from_file(opts)
--local cmd = {
--}
--local current_picker = action_state.get_current_picker(prompt_bufnr)
--current_picker:refresh(finders.new_oneshot_job(cmd, opts), {})
--
local tele_actions = require("telescope.actions")
telescope.setup({
	defaults = {
		mappings = {
			n = {
				["<C-o>"] = M.file_open,
			},
			i = {
				["<C-o>"] = M.file_open,
			},
		},
	},
	pickers = {
		find_files = {
			mappings = {
				n = {
					["<S-p>"] = M.find_parent_directory,
					["h"] = M.find_no_ignore,
				},
			},
		},
	},
	extensions = {
		file_browser = {
			initial_mode = "normal",
			multi_icon = "*",
			sorting_strategy = "ascending",
			layout_config = {
				prompt_position = "top",
			},
			display_stat = {
				date = true,
				size = false,
				mode = false,
			},
			grouped = true,
			git_status = false,
			hidden = true,
			use_fd = true,
			mappings = {
				["n"] = {
					["]"] = require("telescope._extensions.file_browser.actions").toggle_respect_gitignore,
					["z"] = M.unzip_file,
				},
			},
		},
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		media_files = {
			find_cmd = "rg",
		},
	},
})

M.t_find_files = function(cwd, opts)
	_G.cwd = vim.fn.expand("%:p:h")
	opts = opts or {
		cwd = cwd or vim.loop.cwd(),
	}
	opts.find_command = { "fd", "--type", "f", "--ignore-file", "$HOME/.config/nvim/ignore/.tele_ignore" }
	builtin.find_files(opts)
end

M.t_live_grep = function()
	builtin.live_grep()
end

M.file_explorer = function(browser_dir)
	local opts = {
		cwd = browser_dir or vim.loop.cwd(),
		hidden = true,
		respect_gitignore = false,
	}
	telescope.extensions.file_browser.file_browser(opts)
end

telescope.load_extension("file_browser")
telescope.load_extension("media_files")
telescope.load_extension("fzf")
telescope.load_extension("dap")
return M
