local M = {}
_G.plugins = {}
function _G.call(plugin)
	-- if _G.plugins[plugin] ~= nil then
	-- 	return _G.plugins[plugin]
	-- else
	local plugin_status, result = pcall(require, plugin)
	if not plugin_status then
		_G.Setup_Status = false
		print("Fail to call " .. plugin)
		return plugin_status
	end
	_G.plugins[plugin] = result
	return result
	-- end
end

_G.KeyOpts = function(desc, opts)
	opts = opts or {
		noremap = true,
		silent = true,
		desc = "",
	}
	opts.desc = desc
	return opts
end

M.CurrentLoc = function()
	print(vim.fn.expand("%:p"))
end

M.convert_path_to_windows = function(path)
	-- Replace /mnt/c with C:\
	if string.sub(path, 1, 6) == "/mnt/c" then
		path = string.gsub(path, "^/mnt/(%w)/", "%1:/")

		-- Replace remaining forward slashes with backslashes
		path = string.gsub(path, "/", "\\\\")
		return path
	end
	return false
end

return M
