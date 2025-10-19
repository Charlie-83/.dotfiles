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
        -- Bit of a hack to make foldcolumn appear
        vim.cmd("norm zxzR")
        vim.o.foldlevel = 99
        -- When opening file with Telescope, it often starts in insert mode
        vim.cmd("stopinsert")
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
            vim.api.nvim_win_set_cursor(vim.fn.win_getid(), { new_position, 0 })
        end, { buffer = 0 })
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "markdown", "tex" },
    callback = function()
        vim.wo.spell = true
        vim.wo.linebreak = true
    end,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "*",
    callback = function()
        if vim.bo.filetype ~= "markdown" and vim.bo.filetype ~= "tex" then
            vim.wo.spell = false
            vim.wo.linebreak = false
        end
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ higroup = "Visual", timeout = 300 })
    end,
})
