vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.hpp",
    callback = function()
        if vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] ~= "#pragma once" then
            vim.api.nvim_buf_set_lines(0, 0, 0, false, { "#pragma once" })
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    callback = function()
        -- When opening file with Telescope, it often starts in insert mode
        vim.cmd("stopinsert")
        -- Bit of a hack to make foldcolumn appear
        vim.cmd("norm zxzR")
        vim.o.foldlevel = 99
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "loclist", "Trouble" },
    callback = function()
        vim.wo.wrap = false
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.frag", "*.vert", "*.geom" },
    callback = function()
        vim.bo.filetype = "glsl"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.keymap.set("n", "dd", function()
            local current = vim.fn.line(".")
            local qf = vim.fn.getqflist()
            if #qf == 0 then
                return
            end
            table.remove(qf, current)
            vim.fn.setqflist(qf, "r")
            vim.cmd("copen")
            local new_position = current < #qf and current
                or math.max(current - 1, 1)
            vim.api.nvim_win_set_cursor(vim.fnwin_getid(), { new_position, 0 })
        end, { buffer = 0 })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lazygit",
    callback = function()
        vim.keymap.set("n", "q", "<cmd>q<CR>", { buffer = 0 })
    end,
})

vim.api.nvim_create_autocmd("Filetype", {
    pattern = "json",
    callback = function()
        vim.bo.shiftwidth = 2
    end,
})
