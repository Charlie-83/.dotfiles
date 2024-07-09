Stack = {}

local function jump_function(previous, start, surrounding_only)
    if surrounding_only == nil then
        surrounding_only = true
    end
    function cpp_surrounding_function()
        local current = vim.treesitter.get_node()
        if current == nil then
            print("ERROR: Not at node")
            return
        end
        while current:type() ~= "function_definition" do
            current = current:parent()
            if current == nil then
                print("ERROR: No function_definition parent")
                return
            end
        end
        return current
    end
    if previous and start then
        if vim.o.filetype == "cpp" and surrounding_only then
            local surrounding = cpp_surrounding_function()
            if surrounding == nil then
                return
            end
            local row, col = surrounding
                :field("declarator")[1]
                :field("declarator")[1]
                :field("name")[1]
                :start()
            vim.api.nvim_win_set_cursor(0, { row + 1, col })
        else
            vim.cmd("norm [m")
        end
    elseif previous and not start then
    elseif not previous and start then
    elseif not previous and not start then
        if vim.o.filetype == "cpp" and surrounding_only then
            local surrounding = cpp_surrounding_function()
            if surrounding == nil then
                return
            end
            local _, _, row, col = surrounding:range()
            vim.api.nvim_win_set_cursor(0, { row + 1, col })
        else
            vim.cmd("norm ]M")
        end
    end
end
vim.keymap.set("n", "[m", function()
    jump_function(true, true, true)
end, { desc = "Current function start" })
vim.keymap.set("n", "]M", function()
    jump_function(false, false, true)
end, { desc = "Current function end" })

local function up()
    if #Stack == 0 then
        table.insert(Stack, {
            filename = vim.fn.expand("%"),
            lnum = vim.fn.line("."),
            text = vim.api.nvim_get_current_line(),
        })
    end

    jump_function(true, true, true)

    vim.lsp.buf.references(nil, {
        on_list = function(options)
            local references = options["items"]
            -- TODO: Filter out self
            local references_text = {}
            for _, item in ipairs(references) do
                table.insert(
                    references_text,
                    item["filename"]
                        .. ": "
                        .. item["lnum"]
                        .. ": "
                        .. item["text"]
                )
            end
            vim.ui.select(references_text, {}, function(_, idx)
                table.insert(Stack, 1, {
                    filename = references[idx]["filename"],
                    lnum = references[idx]["lnum"],
                    text = references[idx]["text"],
                })
                vim.cmd(
                    "e"
                        .. references[idx]["filename"]
                        .. "|"
                        .. references[idx]["lnum"]
                )
                local winnr = vim.api.nvim_get_current_win()
                vim.fn.setqflist(Stack)
                vim.cmd("copen")
                vim.api.nvim_set_current_win(winnr)
            end)
        end,
    })
end

vim.api.nvim_create_user_command("Up", up, {})
vim.api.nvim_create_user_command("ClearLadder", function()
    Stack = {}
end, {})
