local vimgrep_arguments =
    { unpack(require("telescope.config").values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")
table.insert(vimgrep_arguments, "-L")

require("telescope").setup({
    defaults = {
        mappings = {
            n = {
                ["q"] = "close",
            },
        },
        layout_strategy = "vertical",
        vimgrep_arguments = vimgrep_arguments,
    },
    pickers = {
        find_files = {
            find_command = {
                "rg",
                "--files",
                "--glob",
                "!**/.git/*",
                "-L",
            },
        },
    },
})

require("telescope").load_extension("fzf")
