vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldmethod = "expr"
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
vim.o.foldenable = False

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true,
-- }
-- require("ufo").setup()
