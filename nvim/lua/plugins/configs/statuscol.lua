local builtin = require "statuscol.builtin"
require("statuscol").setup {
    relculright = true,
    segments = {
        { text = { "%s" }, click = "v:lua.ScSa", colwidth = 1 },
        {
            text = { builtin.foldfunc },
            condition = { true },
            click = "v:lua.ScFa",
            colwidth = 1,
        },
        {
            text = { builtin.lnumfunc },
            click = "v:lua.ScLa",
            colwidth = 1,
        },
    },
}
