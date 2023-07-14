local dap, dapui = _G.call("dap"), _G.call("dapui")
local utils = require('ega.core.utils')
if not dap then
	return
end
if not dapui then
	return
end

--vmap("n", "<leader>1", _G.dap_start, { noremap = true })
--vmap("n", "<leader>2", _G.dap_stop, { noremap = true })
utils.map("n", "<leader>db", dap.toggle_breakpoint, "Toggle Breakpoint")
utils.map("n", "<F5>", dap.continue, "Continue")
utils.map("n", "<leader>dc", "<cmd>Telescope dap configurations<CR>", "Configs")
utils.map("n", "<leader>dt", dap.terminate, "Terminate")
utils.map("n", "<F9>", dap.step_over, "Step-over")
utils.map("n", "<F10>", dap.step_into, "Step-into")
utils.map("n", "<F11>", dap.step_out, "Step-out")

--Dap UI
utils.map("n", "<leader>dut", dapui.toggle, "UI Toggle")
