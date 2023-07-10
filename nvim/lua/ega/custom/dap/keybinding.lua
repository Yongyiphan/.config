local dap, dapui = _G.call("dap"), _G.call("dapui")
if not dap then
	return
end
if not dapui then
	return
end
local vmap = vim.keymap.set

--vmap("n", "<leader>1", _G.dap_start, { noremap = true })
--vmap("n", "<leader>2", _G.dap_stop, { noremap = true })
vmap("n", "<leader>db", dap.toggle_breakpoint, _G.KeyOpts("Toggle Breakpoint"))
vmap("n", "<F5>", dap.continue, _G.KeyOpts("Continue"))
vmap("n", "<leader>dc", "<cmd>Telescope dap configurations<CR>", _G.KeyOpts("Configs"))
vmap("n", "<leader>dt", dap.terminate, _G.KeyOpts("Terminate"))
vmap("n", "<F9>", dap.step_over, _G.KeyOpts("Step-over"))
vmap("n", "<F10>", dap.step_into, _G.KeyOpts("Step-into"))
vmap("n", "<F11>", dap.step_out, _G.KeyOpts("Step-out"))

--Dap UI
vmap("n", "<leader>dut", dapui.toggle, _G.KeyOpts("UI Toggle"))
