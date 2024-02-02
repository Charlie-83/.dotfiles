local builtin = require "statuscol.builtin"
require("statuscol").setup {
    bt_ignore = { "terminal" },
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
}
