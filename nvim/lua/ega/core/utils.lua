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

_G.log = function(string)
	local file, err = io.open("io.txt", "w")
	if file then
		file:write(tostring(string))
		file:close()
	else
		print("Error: ", err)
	end
end

_G.convert_path_to_windows = function(path)
	-- Replace /mnt/c with C:\
	if string.sub(path, 1, 6) == "/mnt/c" then
		path = string.gsub(path, "^/mnt/(%w)/", "%1:/")

		-- Replace remaining forward slashes with backslashes
		path = string.gsub(path, "/", "\\\\")
		return path
	end
	return false
end

_G.test_this = function(to_test)
	vim.keymap.set("n", "<leader>t", function()
		to_test()
	end, { desc = "Test" })
end
