local dap, dapui = _G.call("dap"), _G.call("dapui")
if not dap then
	return
end
if not dapui then
	return
end

local test = "DB"
dap.configurations.lua = {
	{
		type = "nlua",
		request = "attach",
		name = "Attach to running Neovim instance",
	},
}

dap.adapters.nlua = function(callback, config)
	callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end

local cpp_tools_path = "C:\\Users\\edgar\\.vscode\\extensions\\ms-vscode.cpptools-1.15.4\\debugAdapters\\bin"

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

_G.dap_run = function() end

_G.dap_start = function()
	print("Starting Dap")
end

_G.dap_stop = function()
	print("Stopping Dap")
	dap.close()
end

dapui.setup()

require("ega.custom.dap.virtual_text")
