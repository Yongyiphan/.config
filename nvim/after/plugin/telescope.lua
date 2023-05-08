local telescope = _G.call("telescope")
if not telescope then
	return
end
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {},
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
							{ "fd", "--type", "f", "-HI", "--ignore-files", "~/.config/nvim/ignore/.general_ignore" }
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
	builtin.find_files()
end

_G.t_live_grep = function()
	builtin.live_grep()
end

telescope.load_extension("file_browser")
telescope.load_extension("media_files")
telescope.load_extension("fzf")
