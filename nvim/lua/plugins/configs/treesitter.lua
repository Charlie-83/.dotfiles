require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "cpp",
        "lua",
        "python",
        "glsl",
        "vimdoc",
        "rust",
        "zig",
        "dart",
        "kotlin",
        "markdown",
        "markdown_inline",
        "html",
    },
    sync_install = false,
    auto_install = false,
    ignore_install = {},
    modules = {},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})
