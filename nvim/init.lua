vim.g.mapleader = " "
--TODO
--On First Set Up
--Add Main_Dir
--Update /ignore/.fdignore_main

print("Test")

_G.Main_Dir = "/mnt/c/Users/edgar/"
_G.Setup_Status = true
_G.cwd = vim.fn.expand("%:p:h")

require("ega.core")
print("Complete Init")
if _G.Setup_Status then
	vim.cmd('call feedkeys("\\<CR>")')
end
