function _G.edit_nvim()
	require("telescope.builtin").find_files({
		cwd = "~/.config/nvim",
	})
end

_G.plugins = {}
function _G.call(plugin)
	if _G.plugins[plugin] ~= nil then
		return _G.plugins[plugin]
	else
		local plugin_status, result = pcall(require, plugin)
		if not plugin_status then
			_G.Setup_Status = false
			print("Fail to call " .. plugin)
			return plugin_status
		end
		_G.plugins[plugin] = result
		return result
	end
end
