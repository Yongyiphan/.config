local telescope = _G.call("telescope")
if not telescope then
	return
end
local builtin = require("telescope.builtin")

_G.open_pdf = function(entry)
	local script_path = "$HOME/.config/nvim/bash/open_edge.sh"
	local selection = _G.convert_path_to_windows(entry)
	if selection then
		local cmd = string.format("%s %s", script_path, selection)
		local status = vim.fn.system(cmd)
		assert(status ~= 0, "Error: Open PDF: " .. vim.fn.fnamemodify(entry, ":t"))
	else
		print("Not a Windows file")
	end
end

local file_open = function(prompt_bufnr)
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
			_G.open_pdf(entry.path)
		end
		require("telescope.actions").close(prompt_bufnr)
	end
end

telescope.setup({
	defaults = {
		mappings = {
			n = {
				["<C-o>"] = file_open,
			},
			i = {
				["<C-o>"] = file_open,
			},
		},
	},
	pickers = {
		find_files = {
			mappings = {
				n = {
					--Move Out 1 directory and find files
					["<S-p>"] = function(prompt_bufnr)
						local finders = require("telescope.finders")
						local make_entry = require("telescope.make_entry")
						local action_state = require("telescope.actions.state")

						local opts = {}
						opts.entry_maker = make_entry.gen_from_file(opts)
						_G.cwd = vim.fn.fnamemodify(_G.cwd, ":h")
						opts.cwd = _G.cwd
						local cmd =
						{ "fd", "--type", "f", "-H", "--ignore-file", "~/.config/nvim/ignore/.general_ignore" }
						local current_picker = action_state.get_current_picker(prompt_bufnr)
						current_picker:refresh(finders.new_oneshot_job(cmd, opts), {})
					end,
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
_G.t_find_files = function()
	_G.cwd = vim.fn.expand("%:p:h")
	builtin.find_files({
		find_command = { "fd", "--type", "f", "-H", "--ignore-file", "$HOME/.config/nvim/ignore/.tele_ignore" },
	})
end

_G.t_live_grep = function()
	builtin.live_grep()
end

telescope.load_extension("file_browser")
telescope.load_extension("media_files")
telescope.load_extension("fzf")
