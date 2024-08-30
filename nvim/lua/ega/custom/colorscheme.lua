local nightfox_s, nightfox = pcall(require, nightfox)
if not nightfox_s then
	return
end

nightfox.setup({
	options = {
		terminal_colors = true,
	}
})
