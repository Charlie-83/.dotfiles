vim.g.mapleader = " "

vim.keymap.set("t", "<Esc>", function()
    local cmd
    if vim.o.filetype == "lazyjj" then
        cmd = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    else
        cmd = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true)
    end
    vim.api.nvim_feedkeys(cmd, "n", false)
end, { desc = "Exit terminal mode" })

-- Highlights
vim.keymap.set("n", "<Esc>", ":noh <CR>", { desc = "Clear highlights" })

-- Line numbers
vim.keymap.set(
    "n",
    "<leader>n",
    "<cmd> set nu! <CR>",
    { desc = "Toggle line number" }
)
vim.keymap.set(
    "n",
    "<leader>rn",
    "<cmd> set rnu! <CR>",
    { desc = "Toggle relative number" }
)

-- Move through wrapped lines
vim.keymap.set(
    { "n", "v", "x" },
    "j",
    "v:count || mode(1)[0:1] == \"no\" ? \"j\" : \"gj\"",
    { desc = "Move down", expr = true }
)
vim.keymap.set(
    { "n", "v", "x" },
    "k",
    "v:count || mode(1)[0:1] == \"no\" ? \"k\" : \"gk\"",
    { desc = "Move up", expr = true }
)

--
vim.keymap.set("n", "n", "nzz", {})
vim.keymap.set("n", "N", "Nzz", {})

-- Build
vim.keymap.set(
    "n",
    "<leader>b",
    require("plugins.make").make,
    { desc = "Build with cmake" }
)

-- Buffers
vim.keymap.set("n", "<leader>x", function()
    if vim.bo.buftype == "quickfix" then
        vim.cmd("bn")
    end
    local force = false
    if vim.bo.buftype == "terminal" or vim.api.nvim_buf_get_name(0) == "" then
        force = true
    elseif vim.api.nvim_get_option_value("modified", {}) then
        vim.notify("Buffer is modified")
        return
    end
    local bufnr = vim.api.nvim_get_current_buf()
    local windows = vim.api.nvim_list_wins()
    for _, window in ipairs(windows) do
        if vim.api.nvim_win_get_buf(window) == bufnr then
            vim.fn.win_execute(window, "bn")
        end
    end
    if force then
        vim.cmd(string.format("bd! %d", bufnr))
    else
        vim.cmd(string.format("bd %d", bufnr))
    end
end, { desc = "Close buffer" })

-- Close all buffers
vim.keymap.set(
    "n",
    "<leader>qb",
    "<cmd> BufferLineCloseOthers <cr>",
    { desc = "Close all other buffers" }
)
vim.keymap.set(
    "n",
    "<leader>qB",
    "<cmd> BufferLineCloseOthers <cr> <leader>x",
    { desc = "Close all buffers", remap = true }
)

-- LSP
vim.keymap.set(
    { "n", "v" },
    "<leader>fm",
    vim.lsp.buf.format,
    { desc = "Format File" }
)

vim.keymap.set("n", "gD", function()
    vim.lsp.buf.declaration()
end, { desc = "LSP declaration" })
vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
end, { desc = "LSP definition" })
vim.keymap.set("n", "gr", function()
    vim.lsp.buf.references()
end, { desc = "LSP references" })
vim.keymap.set("n", "gi", function()
    vim.lsp.buf.implementation()
end, { desc = "LSP implementation" })

vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
end, { desc = "LSP hover" })
vim.keymap.set("n", "<leader>ls", function()
    vim.lsp.buf.signature_help()
end, { desc = "LSP signature help" })
vim.keymap.set("n", "<leader>D", function()
    vim.lsp.buf.type_definition()
end, { desc = "LSP definition type" })
vim.keymap.set({ "n", "v" }, "<leader>ca", function()
    vim.lsp.buf.code_action()
end, { desc = "LSP code action" })
vim.keymap.set("n", "<leader>cr", function()
    vim.lsp.buf.rename()
end, { desc = "LSP rename" })

-- Diagnostic
vim.keymap.set("n", "<leader>tK", function()
    vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "Floating diagnostic" })
vim.keymap.set("n", "[t", function()
    vim.diagnostic.goto_prev({ float = { border = "rounded" } })
end, {
    desc = "Goto previous diagnostic",
})
vim.keymap.set("n", "]t", function()
    vim.diagnostic.goto_next({ float = { border = "rounded" } })
end, {
    desc = "Goto next diagnostic",
})

-- Telescope
vim.keymap.set(
    "n",
    "<leader>ff",
    "<cmd> Telescope find_files <CR>",
    { desc = "Find files" }
)
vim.keymap.set(
    "n",
    "<leader>fw",
    "<cmd> Telescope live_grep <CR>",
    { desc = "Live grep" }
)
vim.keymap.set(
    "n",
    "<leader>fb",
    "<cmd> Telescope buffers <CR>",
    { desc = "Find buffers" }
)
vim.keymap.set(
    "n",
    "<leader>fh",
    "<cmd> Telescope help_tags <CR>",
    { desc = "Help page" }
)
vim.keymap.set(
    "n",
    "<leader>fo",
    "<cmd> Telescope oldfiles <CR>",
    { desc = "Find oldfiles" }
)
vim.keymap.set(
    "n",
    "<leader>fz",
    "<cmd> Telescope current_buffer_fuzzy_find <CR>",
    { desc = "Find in current buffer" }
)
vim.keymap.set(
    "n",
    "<leader>ma",
    "<cmd> Telescope marks <CR>",
    { desc = "telescope bookmarks" }
)
vim.keymap.set(
    "n",
    "<leader>fW",
    ":lua require'telescope.builtin'.live_grep{ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u', '-L'} } <CR>",
    { desc = "Live grep all" }
)
vim.keymap.set(
    "n",
    "<leader>fF",
    ":lua require'telescope.builtin'.find_files({hidden = true, no_ignore = true, no_ignore_parent = true}) <CR>",
    { desc = "Find files all" }
)

-- Which
vim.keymap.set("n", "<leader>wK", function()
    vim.cmd("WhichKey")
end, { desc = "Which-key all keymaps" })
vim.keymap.set("n", "<leader>wk", function()
    local input = vim.fn.input("WhichKey: ")
    vim.cmd("WhichKey " .. input)
end, { desc = "Which-key query lookup" })

-- jjsigns
vim.keymap.set("n", "]h", function()
    if vim.wo.diff then
        return "]h"
    end
    vim.cmd("JJSignsNext")
end, { desc = "Jump to next hunk", expr = true })
vim.keymap.set("n", "[h", function()
    if vim.wo.diff then
        return "[h"
    end
    vim.cmd("JJSignsPrevious")
end, { desc = "Jump to prev hunk", expr = true })

vim.keymap.set("n", "<leader>hr", function()
    vim.cmd("JJSignsRestoreHunk")
end, { desc = "Reset Hunk" })
vim.keymap.set("n", "<leader>hR", function()
    -- TODO
end, { desc = "Reset Buffer" })

vim.keymap.set("n", "<leader>hx", function()
    vim.cmd("JJSignsToggleVirtualLines")
end, { desc = "Toggle Deleted Hunks" })

-- KittyNavigate
vim.keymap.set(
    "n",
    "<C-h>",
    "<cmd> KittyNavigateLeft<CR>",
    { desc = "window left" }
)
vim.keymap.set(
    "n",
    "<C-l>",
    "<cmd> KittyNavigateRight<CR>",
    { desc = "window right" }
)
vim.keymap.set(
    "n",
    "<C-j>",
    "<cmd> KittyNavigateDown<CR>",
    { desc = "window down" }
)
vim.keymap.set(
    "n",
    "<C-k>",
    "<cmd> KittyNavigateUp<CR>",
    { desc = "window up" }
)

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- GDB
vim.keymap.set(
    "n",
    "<leader>db",
    "<cmd>GdbBreakpointToggle<CR>",
    { desc = "Add breakpoint to line" }
)
vim.keymap.set(
    "n",
    "<leader>dx",
    "<cmd>GdbBreakpointClearAll<CR>",
    { desc = "Clear breakpoints" }
)
vim.keymap.set(
    "n",
    "<leader>dc",
    "<cmd>GdbContinue<CR>",
    { desc = "Continue the debugger" }
)
vim.keymap.set(
    "n",
    "<leader>dr",
    "<cmd>Gdb r<CR>",
    { desc = "(Re)start the program" }
)
vim.keymap.set(
    "n",
    "<leader>dt",
    "<cmd>GdbDebugStop<CR>",
    { desc = "Stop debugger" }
)
vim.keymap.set("n", "<leader>dj", "<cmd>GdbStep<CR>", { desc = "Step in" })
vim.keymap.set("n", "<leader>dk", "<cmd>GdbFinish<CR>", { desc = "Step out" })
vim.keymap.set("n", "<leader>dl", "<cmd>GdbNext<CR>", { desc = "Step over" })
vim.keymap.set(
    "n",
    "<leader>do",
    "<cmd>Gdb up<CR>",
    { desc = "Up one stack frame" }
)
vim.keymap.set(
    "n",
    "<leader>di",
    "<cmd>Gdb down<CR>",
    { desc = "Down one stack frame" }
)
vim.keymap.set(
    "n",
    "<leader>dp",
    "<cmd>GdbInterrupt<CR>",
    { desc = "Pause debugger" }
)
vim.keymap.set(
    "n",
    "<leader>dz",
    "<cmd>GdbFrame<CR>",
    { desc = "Jump to current" }
)
vim.keymap.set(
    "n",
    "<leader>dK",
    "<cmd>GdbEvalWord<CR>",
    { desc = "Evaluate word under cursor" }
)
vim.keymap.set(
    "v",
    "<leader>dK",
    "<Esc><cmd>'<,'>GdbEvalRange<CR>",
    { desc = "Evaluate visual selection" }
)
vim.keymap.set(
    "n",
    "<leader>dqb",
    "<cmd>GdbLopenBreakpoints<CR>",
    { desc = "List breakpoints" }
)
vim.keymap.set(
    "n",
    "<leader>dqt",
    "<cmd>GdbLopenBacktrace<CR>",
    { desc = "List trace" }
)

-- Trouble
vim.keymap.set(
    "n",
    "<leader>tw",
    "<cmd> Trouble diagnostics toggle<CR>",
    { desc = "Toggle Trouble diagnostics (workspace)" }
)
vim.keymap.set(
    "n",
    "<leader>td",
    "<cmd> Trouble diagnostics toggle filter.buf=0<CR>",
    { desc = "Toggle Trouble diagnostics (document)" }
)
vim.keymap.set(
    "n",
    "<leader>ts",
    "<cmd> Trouble symbols toggle <CR>",
    { desc = "Toggle Trouble symbols" }
)

-- tabufline
vim.keymap.set(
    "n",
    "<S-l>",
    "<cmd> BufferLineCycleNext <CR>",
    { desc = "Goto next buffer" }
)
vim.keymap.set(
    "n",
    "<S-h>",
    "<cmd> BufferLineCyclePrev <CR>",
    { desc = "Goto prev buffer" }
)

-- leap
vim.keymap.set(
    { "n", "x", "o" },
    "m",
    "<Plug>(leap-forward-to)",
    { desc = "Leap forward" }
)
vim.keymap.set(
    { "n", "x", "o" },
    "M",
    "<Plug>(leap-backward-to)",
    { desc = "Leap backward" }
)

-- treesj
vim.keymap.set(
    "n",
    "<leader>tt",
    "<cmd> TSJToggle <CR>",
    { desc = "Toggle split/join block" }
)
vim.keymap.set(
    "n",
    "<leader>tj",
    "<cmd> TSJJoint <CR>",
    { desc = "Join block" }
)
vim.keymap.set(
    "n",
    "<leader>sj",
    "<cmd> TSJSplit <CR>",
    { desc = "Split block" }
)

-- oil
vim.keymap.set(
    "n",
    "<leader>o",
    require("oil").toggle_float,
    { desc = "Toggle Oil" }
)

-- Snippets
vim.keymap.set("i", "<C-CR>", function()
    local ls = require("luasnip")
    if ls.jumpable(1) then
        ls.jump(1)
        return
    else
        return "<C-CR>"
    end
end, {})

-- Marks
vim.keymap.set("n", ",", "<Plug>(Marks-set)", { desc = "Set mark" })
vim.keymap.set("n", ",,,", "<Plug>(Marks-setnext)", { desc = "Set next mark" })
vim.keymap.set("n", ",,t", "<Plug>(Marks-toggle)", { desc = "Toggle mark" })
vim.keymap.set(
    "n",
    ",,dd",
    "<Plug>(Marks-deleteline)",
    { desc = "Delete mark" }
)
vim.keymap.set(
    "n",
    ",,db",
    "<Plug>(Marks-deletebuf)",
    { desc = "Delete all marks in buf" }
)
vim.keymap.set("n", ",,p", "<Plug>(Marks-preview)", { desc = "Preview mark" })
vim.keymap.set("n", "],", "<Plug>(Marks-next) zz", { desc = "Next mark" })
vim.keymap.set("n", "[,", "<Plug>(Marks-prev) zz", { desc = "Previous mark" })
vim.keymap.set(
    "n",
    ",,b",
    "<cmd> MarksListBuf <CR>",
    { desc = "List buffer marks" }
)
vim.keymap.set(
    "n",
    ",,a",
    "<cmd> MarksListAll <CR>",
    { desc = "List all marks" }
)

-- Quickfix
vim.keymap.set("n", "[c", "<cmd> cprevious <CR>", { desc = "Previous QF item" })
vim.keymap.set("n", "]c", "<cmd> cnext <CR>", { desc = "Next QF item" })
vim.keymap.set("n", "[l", "<cmd> lprevious <CR>", { desc = "Previous LL item" })
vim.keymap.set("n", "]l", "<cmd> lnext <CR>", { desc = "Next LL item" })
vim.keymap.set(
    "n",
    "<leader>qa",
    "<cmd> caddexpr expand('%') .. ':' .. line('.') .. ':' .. getline('.') "
        .. "| copen <CR> | <C-w>k"
)

-- Yanky
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set("n", "[y", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "]y", "<Plug>(YankyNextEntry)")
vim.keymap.set("n", "<leader>fy", "<cmd> Telescope yank_history <CR>")

-- Window resizing
vim.keymap.set("n", "<leader>wt", function()
    local count = vim.v.count1
    vim.cmd("resize +" .. count)
end, { desc = "Make window taller" })
vim.keymap.set("n", "<leader>ws", function()
    local count = vim.v.count1
    vim.cmd("resize -" .. count)
end, { desc = "Make window shorter" })
vim.keymap.set("n", "<leader>ww", function()
    local count = vim.v.count1
    vim.cmd("vertical resize +" .. count)
end, { desc = "Make window wider" })
vim.keymap.set("n", "<leader>wn", function()
    local count = vim.v.count1
    vim.cmd("vertical resize -" .. count)
end, { desc = "Make window narrower" })

-- Toggle wrap
vim.keymap.set("n", "<leader>wr", function()
    vim.cmd("set wrap!")
end, { desc = "Toggle line wrapping" })

-- Keyword search
vim.keymap.set("n", "*", function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local cmd
    if cursor[2] == 0 then
        cmd = vim.api.nvim_replace_termcodes(
            "yiwk$/\\<<C-R>\"\\><CR>",
            true,
            false,
            true
        )
    else
        cmd = vim.api.nvim_replace_termcodes(
            "yiwlbh/\\<<C-R>\"\\><CR>",
            true,
            false,
            true
        )
    end
    vim.api.nvim_feedkeys(cmd, "n", true)
end)
vim.keymap.set("n", "#", function()
    local cmd = vim.api.nvim_replace_termcodes(
        "yiwhel?\\<<C-R>\"\\><CR>",
        true,
        false,
        true
    )
    vim.api.nvim_feedkeys(cmd, "n", true)
end)

vim.keymap.set(
    "n",
    "<leader>cs",
    "<cmd> Ouroboros <CR>",
    { desc = "Switch header/sources" }
)

vim.keymap.set("n", "<leader>dd", function()
    local search_command = vim.api.nvim_replace_termcodes(
        "q:?GdbStart gdb <CR><CR>",
        true,
        false,
        true
    )
    vim.api.nvim_feedkeys(search_command, "n", true)
end, { desc = "Run most recent gdb command" })

vim.keymap.set("v", "<leader>_", function()
    local lines = math.abs(vim.fn.line(".") - vim.fn.lind("v")) + 1
    vim.cmd("resize " .. lines)
    vim.cmd("norm zb")
end, { desc = "Crop window to visual selection" })

vim.api.nvim_create_user_command("GdbStartName", function(opts)
    vim.system({ "pgrep", opts.fargs[1] }, {
        stdout = function(_, text)
            if text then
                vim.schedule_wrap(vim.cmd)("GdbStart rust-gdb -p " .. text)
            end
        end,
    })
end, { nargs = 1 })

-- Thesaurus
vim.keymap.set(
    "n",
    "<leader>th",
    "<cmd>Telescope thesaurus lookup<CR>",
    { desc = "Thesaurus lookup" }
)

-- LazyJJ
vim.keymap.set("n", "<leader>jj", "<cmd>LazyJJ<CR>", { desc = "LazyJJ" })

vim.keymap.set("v", "<leader>_", function()
    local lines = math.abs(vim.fn.line(".") - vim.fn.line("v")) + 1
    vim.cmd("resize " .. lines)
    vim.cmd("norm zb")
end, { desc = "Crop window to visual selection" })
