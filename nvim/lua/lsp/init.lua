vim.diagnostic.config({ virtual_text = false })
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
    pattern = "cpp",
    callback = function()
        local root_dir =
            vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1])
        local client = vim.lsp.start({
            name = "clangd",
            cmd = { "clangd", "--clang-tidy" },
            root_dir = root_dir,
        })
        vim.lsp.buf_attach_client(0, client)
    end,
})
autocmd("FileType", {
    pattern = "python",
    callback = function()
        local root_dir =
            vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1])
        local client = vim.lsp.start({
            name = "Jedi",
            cmd = { "jedi-language-server" },
            root_dir = root_dir,
        })
        vim.lsp.buf_attach_client(0, client)
    end,
})

autocmd("FileType", {
    pattern = "lua",
    callback = function()
        local root_dir = vim.fs.dirname(
            vim.fs.find({ "lazy-lock.json" }, { upward = true })[1]
        )
        local client = vim.lsp.start({
            before_init = require("neodev.lsp").before_init,
            name = "lua-ls",
            cmd = { "lua-language-server" },
            root_dir = root_dir,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })
        vim.lsp.buf_attach_client(0, client)
    end,
})

function LspInfo()
    local bufnr = vim.api.nvim_create_buf(false, true)
    local lines = {}
    for i, client in ipairs(vim.lsp.get_active_clients()) do
        table.insert(lines, string.format("ID: %s", client.id))
        table.insert(lines, string.format("Name: %s", client.name))
        table.insert(lines, "Config: ")
        for line in vim.inspect(client.config):gmatch("[^\r\n]+") do
            table.insert(lines, line)
        end
        table.insert(lines, "Capabilities: ")
        for line in vim.inspect(client.server_capabilities):gmatch("[^\r\n]+") do
            table.insert(lines, line)
        end
        table.insert(lines, "-------------------------------------")
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    vim.api.nvim_command("split")
    vim.api.nvim_command("b" .. bufnr)
    vim.api.nvim_buf_set_option(bufnr, "bufhidden", "delete")
end

vim.api.nvim_command("command! LspInfo lua LspInfo()")
