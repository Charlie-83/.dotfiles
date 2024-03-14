require("lazy_setup")

require("mappings")
require("options")
require("autocommands")
require("snippets")
require("lsp")

os.execute("git -C /home/charlie/notes pull")
vim.cmd("colorscheme catppuccin")
