vim.g.mapleader = " "
vim.g.rnu = true

vim.o.wrap = true

require("lazy_setup").setup({
    {
        "knubie/vim-kitty-navigator",
    },
    {
        "ggandor/leap.nvim",
        config = true,
    },
})

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
