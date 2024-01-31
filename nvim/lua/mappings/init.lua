vim.g.mapleader = " "
vim.g.maplocalleader = ","
-- Highlights
vim.keymap.set("n", "<Esc>", ":noh <CR>", { desc = "Clear highlights" })

-- Line numbers
vim.keymap.set("n", "<leader>n", "<cmd> set nu! <CR>", { desc = "Toggle line number" })
vim.keymap.set("n", "<leader>rn", "<cmd> set rnu! <CR>", { desc = "Toggle relative number" })

-- Move through wrapped lines
vim.keymap.set(
    { "n", "v", "x" },
    "j",
    'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
    { desc = "Move down", expr = true }
)
vim.keymap.set(
    { "n", "v", "x" },
    "k",
    'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
    { desc = "Move up", expr = true }
)
vim.keymap.set(
    { "n", "v", "x" },
    "<Up>",
    'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
    { desc = "Move up", expr = true }
)
vim.keymap.set(
    { "n", "v", "x" },
    "<Down>",
    'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
    { desc = "Move down", expr = true }
)

-- Formatting
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "Format File" })

-- Build
vim.keymap.set(
    "n",
    "<leader>b",
    "<cmd> term cmake --build build <CR> <cmd> execute ':file Build' strftime('%H:%M:%S')  <CR>",
    { desc = "Build with cmake" }
)

-- Buffers
vim.keymap.set("n", "<leader>x", "<cmd> bp<bar>sp<bar>bn<bar>bd <CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>x", function()
    if vim.bo.buftype == "terminal" then
        vim.cmd "bd!"
        return
    elseif vim.api.nvim_buf_get_option(0, "modified") then
        vim.notify "Buffer is modified"
        return
    else
        local bufnr = vim.api.nvim_get_current_buf()
        local windows = vim.api.nvim_list_wins()
        for _, window in ipairs(windows) do
            if vim.api.nvim_win_get_buf(window) == bufnr then
                vim.fn.win_execute(window, "bn")
            end
        end
        vim.cmd(string.format("bd %d", bufnr))
    end
end, { desc = "Close buffer" })

-- Close all buffers
vim.keymap.set("n", "<leader>qb", "<cmd> BufferLineCloseOthers <cr>", { desc = "Close all other buffers" })
vim.keymap.set(
    "n",
    "<leader>qB",
    "<cmd> BufferLineCloseOthers <cr> <leader>x",
    { desc = "Close all buffers", remap = true }
)

-- LSP
vim.keymap.set("n", "gD", function()
    vim.lsp.buf.declaration()
end, { desc = "LSP declaration" })
vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
end, { desc = "LSP definition" })
vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
end, { desc = "LSP hover" })
vim.keymap.set("n", "gi", function()
    vim.lsp.buf.implementation()
end, { desc = "LSP implementation" })
vim.keymap.set("n", "<leader>ls", function()
    vim.lsp.buf.signature_help()
end, { desc = "LSP signature help" })
vim.keymap.set("n", "<leader>D", function()
    vim.lsp.buf.type_definition()
end, { desc = "LSP definition type" })
vim.keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
end, { desc = "LSP code action" })
vim.keymap.set("n", "gr", function()
    vim.lsp.buf.references()
end, { desc = "LSP references" })
vim.keymap.set("n", "<leader>f", function()
    vim.diagnostic.open_float { border = "rounded" }
end, { desc = "Floating diagnostic" })
vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev { float = { border = "rounded" } }
end, {
    desc = "Goto previous diagnostic",
})
vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next { float = { border = "rounded" } }
end, {
    desc = "Goto next diagnostic",
})
vim.keymap.set("n", "<leader>wa", function()
    vim.lsp.buf.add_workspace_folder()
end, { desc = "Add workspace folder" })
vim.keymap.set("n", "<leader>wr", function()
    vim.lsp.buf.remove_workspace_folder()
end, {
    desc = "Remove workspace folder",
})
vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List workspace folders" })
vim.keymap.set("v", "<leader>ca", function()
    vim.lsp.buf.code_action()
end, { desc = "LSP code action" })

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "Help page" })
vim.keymap.set("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Find oldfiles" })
vim.keymap.set("n", "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "Find in current buffer" })
vim.keymap.set("n", "<leader>ma", "<cmd> Telescope marks <CR>", { desc = "telescope bookmarks" })
vim.keymap.set(
    "n",
    "<leader>fW",
    ":lua require'telescope.builtin'.live_grep{ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u' } } <CR>",
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
    vim.cmd "WhichKey"
end, { desc = "Which-key all keymaps" })
vim.keymap.set("n", "<leader>wk", function()
    local input = vim.fn.input "WhichKey: "
    vim.cmd("WhichKey " .. input)
end, { desc = "Which-key query lookup" })

-- gitsigns
vim.keymap.set("n", "]h", function()
    if vim.wo.diff then
        return "]h"
    end
    vim.schedule(function()
        require("gitsigns").next_hunk()
    end)
    return "<Ignore>"
end, { desc = "Jump to next hunk", expr = true })
vim.keymap.set("n", "[h", function()
    if vim.wo.diff then
        return "[h"
    end
    vim.schedule(function()
        require("gitsigns").prev_hunk()
    end)
    return "<Ignore>"
end, { desc = "Jump to prev hunk", expr = true })
vim.keymap.set("n", "<leader>hs", function()
    require("gitsigns").stage_hunk()
end, { desc = "Stage Hunk" })
vim.keymap.set("v", "<leader>hs", function()
    require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "Stage Hunk" })
vim.keymap.set("n", "<leader>hr", function()
    require("gitsigns").reset_hunk()
end, { desc = "Reset Hunk" })
vim.keymap.set("v", "<leader>hr", function()
    require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "Reset Hunk" })
vim.keymap.set("n", "<leader>hS", function()
    require("gitsigns").stage_buffer()
end, { desc = "Stage Buffer" })
vim.keymap.set("n", "<leader>hR", function()
    require("gitsigns").reset_buffer()
end, { desc = "Reset Buffer" })
vim.keymap.set("n", "<leader>hu", function()
    require("gitsigns").undo_stage_hunk()
end, { desc = "Undo Stage Hunk" })
vim.keymap.set("n", "<leader>hp", function()
    require("gitsigns").preview_hunk()
end, { desc = "Preview Hunk" })
vim.keymap.set("n", "<leader>hb", function()
    require("gitsigns").blame_line { full = true }
end, { desc = "Blame Line" })
vim.keymap.set("n", "<leader>hB", function()
    require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle Line Blame" })
vim.keymap.set("n", "<leader>hd", function()
    require("gitsigns").diffthis()
end, { desc = "Diff Against Index" })
vim.keymap.set("n", "<leader>hD", function()
    require("gitsigns").diffthis "~"
end, { desc = "Diff Against Last Commit" })
vim.keymap.set("n", "<leader>hx", function()
    require("gitsigns").toggle_deleted()
end, { desc = "Toggle Deleted Hunks" })

-- vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "window left" })
-- vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "window right" })
-- vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "window down" })
-- vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "window up" })
vim.keymap.set("n", "<C-h>", "<cmd> KittyNavigateLeft<CR>", { desc = "window left" })
vim.keymap.set("n", "<C-l>", "<cmd> KittyNavigateRight<CR>", { desc = "window right" })
vim.keymap.set("n", "<C-j>", "<cmd> KittyNavigateDown<CR>", { desc = "window down" })
vim.keymap.set("n", "<C-k>", "<cmd> KittyNavigateUp<CR>", { desc = "window up" })
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- DAP
vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint to line" })
vim.keymap.set("n", "<leader>dc", "<cmd> DapContinue <CR>", { desc = "Start or continue the debugger" })
vim.keymap.set("n", "<leader>dt", "<cmd> DapTerminate <CR>", { desc = "Terminate the debugger" })
vim.keymap.set("n", "<leader>dj", "<cmd> DapStepInto <CR>", { desc = "Step in" })
vim.keymap.set("n", "<leader>dk", "<cmd> DapStepOut <CR>", { desc = "Step out" })
vim.keymap.set("n", "<leader>dl", "<cmd> DapStepOver <CR>", { desc = "Step over" })
vim.keymap.set("n", "<leader>dr", "<cmd> DapToggleRepl <CR>", { desc = "Toggle repl" })
vim.keymap.set("n", "<leader>dp", "<cmd> DapPause <CR>", { desc = "Pause debugger" })
vim.keymap.set("n", "<leader>du", function()
    require("dapui").toggle { reset = true }
end, { desc = "Toggle Dap UI" })

-- LazyGit
vim.keymap.set("n", "<leader>gg", "<cmd> LazyGit<cr>", { desc = "LazyGit" })

-- Trouble
vim.keymap.set(
    "n",
    "<leader>tw",
    "<cmd> TroubleToggle workspace_diagnostics<CR>",
    { desc = "Toggle Trouble (workspace)" }
)
vim.keymap.set(
    "n",
    "<leader>td",
    "<cmd> TroubleToggle document_diagnostics<CR>",
    { desc = "Toggle Trouble (document)" }
)

-- tabufline
vim.keymap.set("n", "<S-l>", "<cmd> bn <CR>", { desc = "Goto next buffer" })
vim.keymap.set("n", "<S-h>", "<cmd> bp <CR>", { desc = "Goto prev buffer" })

-- flash
-- vim.keymap.set("n", "<leader>mt", function() require("flash").treesitter_search() end, {desc="Treesitter Search",})

-- leap
vim.keymap.set({ "n", "x", "o" }, "m", "<Plug>(leap-forward-to)", { desc = "Leap forward" })
vim.keymap.set({ "n", "x", "o" }, "M", "<Plug>(leap-backward-to)", { desc = "Leap backward" })
vim.keymap.set({ "n" }, ",", "m", { desc = "Place mark" })

-- treesj
vim.keymap.set("n", "<leader>tt", "<cmd> TSJToggle <CR>", { desc = "Toggle split/join block" })
vim.keymap.set("n", "<leader>tj", "<cmd> TSJJoint <CR>", { desc = "Join block" })
vim.keymap.set("n", "<leader>sj", "<cmd> TSJSplit <CR>", { desc = "Split block" })

-- nvimtree
vim.keymap.set("n", "<leader>e", function()
    local path
    if vim.bo.filetype == "norg" then
        path = require("neorg.modules.core.dirman.module").public.get_current_workspace()[2]
    else
        path = vim.fn.getcwd()
    end
    require("nvim-tree.api").tree.toggle { find_file = true, path = path }
end, { desc = "Focus nvimtree" })

-- term
vim.keymap.set("t", "<Esc>", function()
    if string.sub(vim.api.nvim_buf_get_name(0), -7, -1) == "lazygit" then
        return "<Esc>"
    else
        return [[<C-\><C-n>]]
    end
end, { desc = "Terminal normal mode", expr = true })
vim.keymap.set("n", "<leader>th", "<cmd> term <CR>", { desc = "Open terminal in current pane" })
vim.keymap.set("n", "<leader>ts", "<cmd> split term://fish <CR>", { desc = "Open terminal horizontal" })
vim.keymap.set("n", "<leader>tv", "<cmd> vsplit term://fish <CR>", { desc = "Open terminal vertical" })

-- oil
vim.keymap.set("n", "<leader>o", require("oil").toggle_float, { desc = "Toggle Oil" })

-- Neorg
vim.keymap.set("n", "<leader><leader>i", "<cmd> Neorg index <CR>", { desc = "Neorg index" })
vim.keymap.set("n", "<leader><leader>r", "<cmd> Neorg return <CR>", { desc = "Neorg index" })
vim.keymap.set("n", "<leader><leader>n", "<cmd> Neorg workspace notes <CR>", { desc = "Neorg workspace notes" })

-- Snippets
vim.keymap.set("i", "<C-CR>", function()
    local ls = require "luasnip"
    if ls.jumpable(1) then
        ls.jump(1)
        return
    else
        return "<C-CR>"
    end
end, {})
