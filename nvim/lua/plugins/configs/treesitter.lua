require("nvim-treesitter.configs").setup({
    ensure_installed = { "cpp", "lua", "python", "glsl", "vimdoc" },
    sync_install = false,
    auto_install = false,
    ignore_install = {},
    modules = {},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})
