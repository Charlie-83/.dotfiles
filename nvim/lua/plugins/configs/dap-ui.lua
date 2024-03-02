local dap = require("dap")
local dapui = require("dapui")
dapui.setup({
    force_buffers = true,
    layouts = {
        {
            elements = {
                {
                    id = "repl",
                    size = 0.5,
                },
                {
                    id = "console",
                    size = 0.5,
                },
            },
            position = "bottom",
            size = 20,
        },
        {
            elements = {
                {
                    id = "stacks",
                    size = 0.5,
                },
                {
                    id = "breakpoints",
                    size = 0.5,
                },
            },
            position = "top",
            size = 10,
        },
        {
            elements = {
                {
                    id = "watches",
                    size = 0.25,
                },
                {
                    id = "scopes",
                    size = 0.75,
                },
            },
            position = "top",
            size = 10,
        },
    },
})
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
    dapui.close({ layout = 3 })
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
