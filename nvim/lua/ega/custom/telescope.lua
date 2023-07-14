local M = {}
local utils = require("ega.core.utils")
local telescope = _G.call("telescope")
if not telescope then
	return
end
telescope.setup({
	defaults = {
		mappings = {
			n = {
				["<C-o>"] = utils.open_file,
			},
			i = {
				["<C-o>"] = utils.open_file,
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
						local cmd = {
							"fd",
							"--type",
							"f",
							"--ignore-file",
							"$HOME/.config/nvim/ignore/.general_ignore",
							"--ignore-file",
							"$HOME/.config/nvim/ignore/.tele_ignore",
						}
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

	},
})

function M.find_files()
	_G.cwd = vim.fn.expand("%:p:h")
	local builtin = require("telescope.builtin")
	builtin.find_files({
		find_command = { "fd", "--type", "f", "--ignore-file", "$HOME/.config/nvim/ignore/.tele_ignore" },
	})
end

function M.live_grep()
	local builtin = require("telescope.builtin")
	builtin.live_grep()
end

function M.file_browser()
	local file_browser = telescope.extensions.file_browser
	file_browser.file_browser()
end

telescope.load_extension("file_browser")
telescope.load_extension("media_files")
telescope.load_extension("ui-select")
telescope.load_extension("fzf")
telescope.load_extension("dap")
return M
