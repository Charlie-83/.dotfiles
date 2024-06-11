local plugins = {
    { "nvim-tree/nvim-web-devicons", config = true },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = { show_start = false, show_end = false },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("plugins.configs.treesitter")
        end,
    },
    { "lewis6991/gitsigns.nvim", config = true },
    {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = true,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)
                    local cmp_autopairs =
                        require("nvim-autopairs.completion.cmp")
                    require("cmp").event:on(
                        "confirm_done",
                        cmp_autopairs.on_confirm_done()
                    )
                end,
            },
            {
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            },
        },
        opts = function()
            return require("plugins.configs.cmp-conf")
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
        event = "InsertEnter",
    },
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("plugins.configs.telescope")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
            },
        },
    },
    { "folke/which-key.nvim", config = true, event = "VeryLazy" },
    {
        "knubie/vim-kitty-navigator",
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            require("plugins.configs.dap-ui")
        end,
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("plugins.configs.dap")
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        opts = function()
            return require("plugins.configs.null-ls")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "folke/neodev.nvim",
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = true,
        opts = {
            options = {
                custom_filter = function(buf_number, buf_numbers)
                    if vim.bo[buf_number].buftype == "quickfix" then
                        return false
                    end
                    return true
                end,
            },
        },
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "ggandor/flit.nvim",
        dependencies = {
            "ggandor/leap.nvim",
            "tpope/vim-repeat",
        },
        opts = {
            keys = { f = "f", F = "F", t = "t", T = "T" },
            labeled_modes = "vn",
            multiline = true,
            opts = {},
        },
    },
    {
        "ggandor/leap.nvim",
        config = true,
    },
    {
        "ggandor/leap-spooky.nvim",
        config = true,
        dependencies = {
            "ggandor/leap.nvim",
        },
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        config = true,
    },
    -- https://github.com/datyin/theme-ocean-green/blob/main/themes/dark-color-theme.json
    {
        "Charlie-83/catppuccin-nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            color_overrides = {
                all = {
                    base = "#111d1e",
                    mantle = "#0d1617",
                    crust = "#0d1617",
                    surface1 = "#274145",
                    blue = "#19d19d",
                    green = "#40cf6d",
                    yellow = "#d68951",
                    red = "#dc553a",
                    maroon = "#db7772",
                },
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", "rcarriga/nvim-dap-ui" },
        config = true,
        opts = function()
            return require("plugins.configs.lualine")
        end,
    },
    {
        "stevearc/oil.nvim",
        opts = {
            view_options = {
                show_hidden = true,
            },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            require("plugins.configs.statuscol")
        end,
    },
    {
        "jakemason/ouroboros.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        ft = { "cpp" },
    },
    {
        "chentoast/marks.nvim",
        commit = "e0909e4868671d158a7dce1bc7872fd7a1f7d656",
        opts = {
            default_mappings = false,
            builtin_marks = { ".", "<", ">", "^" },
            excluded_buftypes = { "terminal" },
            excluded_filetypes = {
                "dap-repl",
                "dapui_console",
                "dapui_watches",
                "dapui_stacks",
                "dapui_breakpoints",
                "dapui_scopes",
            },
        },
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "mikesmithgh/kitty-scrollback.nvim",
        enabled = true,
        lazy = true,
        cmd = {
            "KittyScrollbackGenerateKittens",
            "KittyScrollbackCheckHealth",
        },
        event = { "User KittyScrollbackLaunch" },
        config = true,
    },
    {
        "gbprod/yanky.nvim",
        config = true,
    },
}
return plugins
