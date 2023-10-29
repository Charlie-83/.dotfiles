local dap = require("dap")
local dapui = require("dapui")
dapui.setup({
    force_buffers = true,
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
