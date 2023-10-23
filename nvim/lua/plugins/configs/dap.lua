local dap = require "dap"
dap.configurations.cpp = {
    {
        name = "CPP",
        type = "codelldb",
        request = "launch",
        program = "${workspaceFolder}/build/main",
        cwd = "${workspaceFolder}",
    },
    {
        name = "caecil",
        type = "codelldb",
        request = "launch",
        program = "${workspaceFolder}/build/main",
        cwd = "${workspaceFolder}",
    },
}

dap.configurations.python = {
    {
        name = "All files",
        type = "python",
        request = "launch",
        program = "${file}",
        justMyCode = false,
    }
}
