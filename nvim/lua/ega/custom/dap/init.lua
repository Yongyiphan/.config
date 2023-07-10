local dap, dapui = _G.call("dap"), _G.call("dapui")
if not dap then
	return
end
if not dapui then
	return
end

local ensure_installed = {
	"debugpy",
}
require("mason-nvim-dap").setup({
	ensure_installed = ensure_installed,
})

require("ega.custom.dap.settings.luad")
require("ega.custom.dap.settings.pythond")

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({
		reset = true,
	})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

require("ega.custom.dap.virtual_text")
