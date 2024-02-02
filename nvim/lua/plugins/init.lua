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
                    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
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
    },
    {
        "numToStr/Comment.nvim",
        config = true,
    },
    {
        "nvim-tree/nvim-tree.lua",
        config = true,
        opts = require("plugins.configs.nvim-tree"),
    },
    {
        "nvim-telescope/telescope.nvim",
        config = true,
        opts = {
            defaults = {
                mappings = {
                    n = {
                        ["q"] = "close",
                    },
                },
                layout_strategy = "vertical",
            },
        },
    },
    { "folke/which-key.nvim", config = true, event = "VeryLazy" },
    {
        "knubie/vim-kitty-navigator",
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = "mfussenegger/nvim-dap",
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
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.configs.lspconfig")
        end,
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
        "kylechui/nvim-surround",
        version = "*",
        config = true,
    },
    {
        "Charlie-83/catppuccin-nvim",
        name = "catppuccin",
        priority = 1000,
        config = true,
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
        "kevinhwang91/nvim-ufo",
        config = function()
            require("plugins.configs.ufo")
        end,
        dependencies = { "kevinhwang91/promise-async" },
    },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim" },
        ft = { "norg" },
        config = function()
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {},
                    ["core.concealer"] = {},
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            },
                        },
                    },
                    ["core.summary"] = {},
                },
            })
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
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {},
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
        },
    },
}
return plugins
