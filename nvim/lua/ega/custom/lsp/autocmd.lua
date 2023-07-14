
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
--vim.api.nvim_create_autocmd("LspAttach", {
--	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--	callback = function(ev)
--		-- Enable completion triggered by <c-x><c-o>
--		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
--
--		-- Buffer local mappings.
--		-- See `:help vim.lsp.*` for documentation on any of the below functions
--		local opts = { buffer = ev.buf }
--		vim.keymap.set("n", "<leader>iD", vim.lsp.buf.declaration, _G.KeyOpts("Declaration", opts))
--		vim.keymap.set("n", "<leader>id", vim.lsp.buf.definition, _G.KeyOpts("Definition", opts))
--		vim.keymap.set("n", "<leader>ih", vim.lsp.buf.hover, _G.KeyOpts("Hover", opts))
--		vim.keymap.set("n", "<leader>iI", vim.lsp.buf.implementation, _G.KeyOpts("Implementation", opts))
--		vim.keymap.set("n", "<leader>ir", vim.lsp.buf.references, _G.KeyOpts("References", opts))
--		vim.keymap.set("n", "<leader>if", vim.lsp.buf.format, _G.KeyOpts("Format", opts))
--	end,
--})

vim.api.nvim_create_autocmd('User', {
    pattern = 'MasonUpdateAllComplete',
    callback = function()
        print('mason-update-all has finished')
    end,
})
