vim.api.nvim_create_autocmd("Filetype", {
    pattern = "cpp",
    callback = function()
        require "mappings.cpp"
    end,
})
