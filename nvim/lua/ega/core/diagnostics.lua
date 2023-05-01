vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	float = {
		source = "always",
		border = "single",
		format = function(diagnostic)
			return string.format("%s (%s) [%s]", diagnostic.message, diagnostic.source, diagnostic.code)
		end,
	},
})

function _G.close_diag_window(scope)
	-- If we find a floating window, close it.
	local found_float = false
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			vim.api.nvim_win_close(win, true)
			found_float = true
		end
	end
	if found_float then
		return
	end
	vim.diagnostic.open_float(nil, { focus = true, scope = scope })
end
