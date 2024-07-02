require("lazy_setup").setup(require("plugins"))

require("mappings")
require("options")
require("autocommands")
require("snippets")
require("lsp")

vim.cmd("colorscheme catppuccin")
