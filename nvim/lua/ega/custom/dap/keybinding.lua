local dap, dapui = _G.call("dap"), _G.call("dapui")
if not dap then
	return
end
if not dapui then
	return
end
local vmap = vim.keymap.set

vmap("n", "<leader>1", _G.dap_start, { noremap = true })
vmap("n", "<leader>2", _G.dap_stop, { noremap = true })
vmap("n", "<leader>db", dap.toggle_breakpoint, _G.KeyOpts("Toggle Breakpoint"))
vmap("n", "<leader>dc", dap.continue, _G.KeyOpts("Continue"))
vmap("n", "<F9>", dap.step_over, _G.KeyOpts("Step-over"))
vmap("n", "<F10>", dap.step_into, _G.KeyOpts("Step-into"))
vmap("n", "<S-F10>", dap.step_into, _G.KeyOpts("Step-out"))
vmap("n", "<leader>ds", [[:lua require"osv".launch({port = 8086})<CR>]], _G.KeyOpts("Start"))
vmap("n", "<leader>dS", [[:lua require"osv".stop()<CR>]], _G.KeyOpts("Stop"))
vmap("n", "<leader>dr", [[:lua require"osv".run_this({log = true})<CR>]], _G.KeyOpts("Run"))

--Dap UI
vmap("n", "<leader>dut", dapui.toggle, _G.KeyOpts("UI Toggle"))
--vmap("n", "<leader>ta", function()
--	local osv = require("osv")
--	osv.launch({ log = true })
--	print("Test")
--end)
--
--vmap("n", "<leader>tb", function()
--	local osv = require("osv")
--	print(osv.is_running())
--end)
--
--vmap("n", "<leader>tc", function()
--	local osv = require("osv")
--	osv.stop()
--end)
--local test = "T1"

print(dap)
