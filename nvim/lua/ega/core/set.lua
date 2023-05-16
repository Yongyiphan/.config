local options = {
	opt = {
		nu = true,
		rnu = true,
		autoindent = true,
		smarttab = true,
		tabstop = 2,
		shiftwidth = 2,
		hlsearch = false,
		incsearch = true,
		ignorecase = true,
		smartcase = true,
		scrolloff = 8,
		showcmd = true,
		mouse = "a",
		title = true,
		clipboard = "unnamedplus",
		backspace = "indent,eol,start",
		splitright = true,
		splitbelow = true,
	},
}

vim.g.toggleterm_terminal_mappings = 0

for scope, table in pairs(options) do
	for setting, value in pairs(table) do
		vim[scope][setting] = value
	end
end
