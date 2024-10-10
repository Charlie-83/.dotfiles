local builtin = require("statuscol.builtin")
vim.o.foldcolumn = "1"
vim.o.fillchars = "foldclose:,foldopen:"
require("statuscol").setup({
    bt_ignore = { "terminal" },
    relculright = true,
    segments = {
        { sign = { name = { "Gdb*", "Marks_.*" }, colwidth = 1 } },
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
