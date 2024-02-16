require("nvim-treesitter.configs").setup({
    ensure_installed = { "cpp", "lua", "python", "glsl" },
    highlight = {
        enable = true,
    },
})
