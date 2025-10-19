vim.diagnostic.config({ virtual_text = false })
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
    pattern = { "cpp", "c" },
    callback = function()
        local root_dir =
            vim.fs.dirname(vim.fs.find({ ".git", ".jj" }, { upward = true })[1])
        local client = vim.lsp.start({
            name = "clangd",
            cmd = { "clangd", "--clang-tidy" },
            root_dir = root_dir,
        })
        if client == nil then
            print("Failed to start clangd")
            return
        end
        vim.lsp.buf_attach_client(0, client)
    end,
})

autocmd("FileType", {
    pattern = "python",
    callback = function()
        local root_dir =
            vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1])
        local jedi = vim.lsp.start({
            name = "Jedi",
            cmd = { "jedi-language-server" },
            root_dir = root_dir,
        })
        if jedi == nil then
            print("Failed to start jedi")
            return
        end
        vim.lsp.buf_attach_client(0, jedi)
        local ruff = vim.lsp.start({
            name = "Ruff",
            cmd = { "ruff", "server" },
            root_dir = root_dir,
            init_options = {
                settings = {
                    format = {
                        args = { "--line-length=87" },
                    },
                },
            },
        })
        if ruff == nil then
            print("Failed to start ruff")
            return
        end
        vim.lsp.buf_attach_client(0, ruff)
    end,
})

autocmd("FileType", {
    pattern = "lua",
    callback = function()
        local root_dir =
            vim.fs.dirname(vim.fs.find({ "lazy-lock.json" }, {})[1])
        local client = vim.lsp.start({
            name = "lua-ls",
            cmd = { "lua-language-server" },
            root_dir = root_dir,
            on_init = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider =
                    false
            end,
            settings = {
                Lua = {
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                },
            },
        })
        if client == nil then
            print("Failed to start lua-ls")
            return
        end
        vim.lsp.buf_attach_client(0, client)
    end,
})

autocmd("FileType", {
    pattern = "zig",
    callback = function()
        local root_dir = vim.fs.dirname(
            vim.fs.find({ ".git", "build.zig" }, { upward = true })[1]
        )
        local client = vim.lsp.start({
            name = "zls",
            cmd = { "zls" },
            root_dir = root_dir,
        })
        if client == nil then
            print("Failed to start zls")
            return
        end
        vim.lsp.buf_attach_client(0, client)
    end,
})

autocmd("FileType", {
    pattern = "glsl",
    callback = function()
        local root_dir =
            vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1])
        local client = vim.lsp.start({
            name = "glsl-language-server",
            cmd = { "glslls", "--stdin" },
            root_dir = root_dir,
        })
        if client == nil then
            print("Failed to start glsl-ls")
            return
        end
        vim.lsp.buf_attach_client(0, client)
    end,
})

autocmd("FileType", {
    pattern = "rust",
    callback = function()
        local root_dir =
            vim.fs.dirname(vim.fs.find({ "Cargo.toml" }, { upward = true })[1])
        local client = vim.lsp.start({
            name = "rust-analyzer",
            cmd = { "rust-analyzer" },
            root_dir = root_dir,
        })
        if client == nil then
            print("Failed to start rust-analyzer")
            return
        end
        vim.lsp.buf_attach_client(0, client)
    end,
})

autocmd("FileType", {
    pattern = "kotlin",
    callback = function()
        local root_dir =
            vim.fs.dirname(vim.fs.find({ ".jj" }, { upward = true })[1])
        local client = vim.lsp.start({
            name = "kotlin-language-server",
            cmd = { "kotlin-language-server" },
            root_dir = root_dir,
        })
        if client == nil then
            print("Failed to start kotlin-language-server")
            return
        end
        vim.lsp.buf_attach_client(0, client)
    end,
})

autocmd("FileType", {
    pattern = "dart",
    callback = function()
        local root_dir =
            vim.fs.dirname(vim.fs.find({ ".jj" }, { upward = true })[1])
        local client = vim.lsp.start({
            name = "dart-ls",
            cmd = { "dart", "language-server", "--protocol=lsp" },
            root_dir = root_dir,
        })
        if client == nil then
            print("Failed to start dart-ls")
            return
        end
        vim.lsp.buf_attach_client(0, client)
    end,
})



local languages = {
    python = { require("efmls-configs.linters.mypy") },
    lua = { require("efmls-configs.formatters.stylua") },
    glsl = { require("efmls-configs.formatters.clang_format") },
    json = {
        require("efmls-configs.formatters.jq"),
        require("efmls-configs.linters.jq"),
    },
    css = {
        {
            formatCommand = "prettier",
        },
    },
}
autocmd("FileType", {
    pattern = vim.tbl_keys(languages),
    callback = function()
        local root_dir =
            vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1])
        local client = vim.lsp.start({
            name = "efm-langserver",
            cmd = { "efm-langserver" },
            root_dir = root_dir,
            settings = {
                languages = languages,
            },
            init_options = {
                documentFormatting = true,
                documentRangeFormatting = true,
            },
        })
        if client == nil then
            print("Failed to start efm-langserver")
            return
        end
        vim.lsp.buf_attach_client(0, client)
    end,
})

vim.api.nvim_create_user_command("LspInfo", function()
    local bufnr = vim.api.nvim_create_buf(false, true)
    local lines = {}
    for _, client in ipairs(vim.lsp.get_clients()) do
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
    vim.api.nvim_set_option_value("bufhidden", "delete", { buf = bufnr })
end, {})
