local null_ls = require("null-ls")
local opts = {
    sources = {
        null_ls.builtins.diagnostics.mypy.with({ prefer_local = ".venv/bin" }),
        null_ls.builtins.diagnostics.pylint.with({ prefer_local = ".venv/bin" }),
        null_ls.builtins.formatting.black.with({ prefer_local = ".venv/bin" }),
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.dart_format,
    },
}
return opts
