local dap_running_flag = false
M = {
    options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        globalstatus = true,
    },
    sections = {
        lualine_c = {
            {
                "filename",
                path = 1,
                symbols = {
                    modified = "󰷥",
                    readonly = "󰷤",
                },
                color = function(section)
                    if dap_running_flag then
                        return { bg = "#b03215" }
                    end
                    return nil
                end,
            },
        },
        lualine_x = {},
        lualine_y = { "filetype" },
    },
}
local dap = require("dap")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dap_running_flag = true
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dap_running_flag = false
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dap_running_flag = false
end
return M
