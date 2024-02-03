local builtin = require("statuscol.builtin")
require("statuscol").setup({
    bt_ignore = { "terminal" },
    ft_ignore = {
        "dap-repl",
        "dapui_console",
        "dapui_watches",
        "dapui_stacks",
        "dapui_breakpoints",
        "dapui_scopes",
    },
    relculright = true,
    segments = {
        { sign = { name = { "Marks_.*" }, colwidth = 1 } },
        { sign = { name = { "DiagnosticSign.*" }, colwidth = 1 } },
        {
            text = { builtin.foldfunc },
            colwidth = 1,
        },
        { sign = { namespace = { "gitsigns.*" }, colwidth = 1 } },
        {
            text = { builtin.lnumfunc },
            colwidth = 0.5,
        },
    },
})
