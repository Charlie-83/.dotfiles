require "autocommands.ft_mapping"

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.hpp",
    callback = function()
        if vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] ~= "#pragma once" then
            vim.api.nvim_buf_set_lines(0, 0, 0, false, { "#pragma once" })
        end
    end,
})
