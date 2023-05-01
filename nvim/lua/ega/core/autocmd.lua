--
--Save when escape is press
--vim.cmd(
--	"autocmd FocusLost,InsertLeave * if &buftype == '' && &filetype != 'telescope' | silent! write | else | echom 'Skipping non-file buffer' | endif"
--)
--

vim.api.nvim_create_autocmd({ "FocusLost", "InsertLeave", "CursorMoved" }, {
	group = vim.api.nvim_create_augroup("Autosave", { clear = true }),
	pattern = "*",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
		local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
		if buftype == "" and filetype ~= "telescope" then
			print("Saving " .. vim.fn.expand("%:p"))
			vim.cmd("silent! write")
		else
			vim.api.nvim_echo({ { "Skipping non-file buffer", "WarningMsg" } }, true, {})
		end
	end,
})
