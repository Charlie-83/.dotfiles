local dap = require("dap")

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}

dap.configurations.cpp = {
    {
        name = "CPP",
        type = "codelldb",
        request = "launch",
        program = "${workspaceFolder}/build/main",
        cwd = "${workspaceFolder}",
    },
    {
        name = "aseprite",
        type = "codelldb",
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
