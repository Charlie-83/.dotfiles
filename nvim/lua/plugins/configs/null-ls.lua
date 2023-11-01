local null_ls = require "null-ls"
local opts = {
    sources = {
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.dart_format,
        null_ls.builtins.formatting.black,
    },
}
return opts
