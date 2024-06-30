local dap = require("dap")

-- dap.adapters.codelldb = {
--     type = "server",
--     port = "${port}",
--     executable = {
--         command = "codelldb",
--         args = { "--port", "${port}" },
--     },
-- }
local dap = require("dap")
dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "/home/charlie/external/extension/debugAdapters/bin/OpenDebugAD7",
}

dap.configurations.cpp = {
    {
        name = "CPP",
        type = "cppdbg",
        request = "launch",
        program = "${workspaceFolder}/build/main",
        cwd = "${workspaceFolder}",
    },
    {
        name = "aseprite",
        type = "cppdbg",
        request = "launch",
        program = "${workspaceFolder}/build/bin/aseprite",
    },
}

dap.configurations.python = {
    {
        name = "All files",
        type = "python",
        request = "launch",
        program = "${file}",
        justMyCode = false,
    },
}
