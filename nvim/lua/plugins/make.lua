local M = {}

local function split(str)
    local out = {}
    for word in str:gmatch("%S+") do
        table.insert(out, word)
    end
    return out
end

function M.make()
    local win = vim.api.nvim_get_current_win()
    vim.cmd("copen")
    local qf_win = vim.api.nvim_get_current_win()
    vim.cmd("cexpr []")
    vim.api.nvim_set_current_win(win)
    local qf_id = vim.fn.getqflist({ id = 0 }).id

    local makeprg = vim.api.nvim_get_option_value("makeprg", {})
    local cmd = vim.fn.expandcmd(makeprg)

    local function handle_output(err, data)
        local lines
        if err then
            lines = err
        elseif data then
            lines = data
        else
            return
        end
        vim.schedule(function()
            vim.fn.setqflist({}, "a", {
                id = qf_id,
                title = cmd,
                lines = { lines },
            })
            local qf_buf = vim.api.nvim_win_get_buf(qf_win)
            local line_count = vim.api.nvim_buf_line_count(qf_buf)
            vim.api.nvim_win_set_cursor(qf_win, { line_count, 0 })
        end)
    end

    local function handle_exit(out)
        vim.schedule(function()
            vim.fn.setqflist({}, "a", { lines = { "==Done==" } })
            local qf_buf = vim.api.nvim_win_get_buf(qf_win)
            local line_count = vim.api.nvim_buf_line_count(qf_buf)
            vim.api.nvim_win_set_cursor(qf_win, { line_count, 0 })
        end)
    end

    vim.system(
        split(cmd),
        { stdout = handle_output, stderr = handle_output },
        handle_exit
    )
end

return M
