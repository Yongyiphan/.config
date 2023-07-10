local dap = _G.call("dap")
if not dap then
	return
end
local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
require("dap-python").setup(path)

if vim.fn.filereadable(".vscode/launch.json") then
	require("dap.ext.vscode").load_launchjs()
end

--table.insert(dap.configurations.python, {
--
--	type = "python",
--	request = "launch",
--	name = "Python Debug Config",
--	program = "${file}",
--	cwd = "${workspaceFolder}",
--})
