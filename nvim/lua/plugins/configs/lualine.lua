M = {
    options = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
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
            },
        },
        lualine_x = {},
        lualine_y = { "filetype" }
    },
}
return M
