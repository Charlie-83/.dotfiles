local plugins = {
    { "nvim-tree/nvim-web-devicons", config = true },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        main = "ibl",
        opts = {
            scope = { show_start = false, show_end = false },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        config = function()
            require "plugins.configs.treesitter"
        end,
    },
    { "lewis6991/gitsigns.nvim", config = true },
    { "williamboman/mason.nvim", lazy = false, config = true },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                opts = { history = true, updateevents = "TextChanged,TextChangedI" },
                config = true,
            },
            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)
                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },
            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            },
        },
        opts = function()
            return require "plugins.configs.cmp-conf"
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = true,
        keys = {
            { "gcc", mode = "n", desc = "Comment toggle current line" },
            { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
            { "gbc", mode = "n", desc = "Comment toggle current block" },
            { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
            { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        config = true,
        cmd = { "NvimTreeToggle" },
        opts = require "plugins.configs.nvim-tree",
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        config = true,
        opts = {
            defaults = {
                mappings = {
                    n = {
                        ["q"] = "close",
                    },
                },
            },
        },
    },
    { "folke/which-key.nvim", config = true, event = "VeryLazy" },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            require "plugins.configs.dap-ui"
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            handlers = {},
        },
    },
    {
        "mfussenegger/nvim-dap",
        config = function(_, _)
            require "plugins.configs.dap"
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        opts = function()
            return require "plugins.configs.null-ls"
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "clangd",
                "clang-format",
                "codelldb",
                "pyright",
                "pylint",
                "mypy",
                "debugpy",
                "stylua",
                "dart-debug-adapter",
                "lua-language-server",
            },
        },
    },
    {
        "mhartington/formatter.nvim",
        cmd = { "Format", "FormatWrite", "FormatLock", "FormatWriteLock" },
        config = function(_, _)
            require("formatter").setup {
                filetype = {
                    cpp = {
                        require("formatter.filetypes.cpp").clangformat,
                    },
                    lua = {
                        require("formatter.filetypes.lua").stylua,
                    },
                    dart = {
                        require("formatter.filetypes.dart").dartformat,
                    },
                },
            }
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = { "LazyGit" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = true,
        lazy = false,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "TroubleToggle",
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
    },
    {
        "ggandor/flit.nvim",
        dependencies = {
            "ggandor/leap.nvim",
            "tpope/vim-repeat",
        },
        keys = { "f", "F", "t", "T" },
        opts = {
            keys = { f = "f", F = "F", t = "t", T = "T" },
            labeled_modes = "vn",
            multiline = true,
            opts = {},
        },
    },
    {
        "ggandor/leap.nvim",
        lazy = false,
        config = true,
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function(_, _)
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end,
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = true,
    },
    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        keys = { "<leader>tt", "<leader>ts", "<leader>tj" },
        config = true,
    },
    {
        "Charlie-83/catppuccin-nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = true,
    },
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true,
        opts = require "plugins.configs.lualine",
    },
    {
        "sitiom/nvim-numbertoggle",
        event = "VeryLazy",
    },
    {
        "kevinhwang91/nvim-ufo",
        event = "VeryLazy",
        config = function()
            require "plugins.configs.ufo"
        end,
        dependencies = { "kevinhwang91/promise-async" },
    },
    {
        "chrisgrieser/nvim-origami",
        event = "BufReadPost",
        opts = { keepFoldsAcrossSessions = false },
    },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        config = function()
            require("neorg").setup {
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
            }
        end,
    },
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Oil",
        keys = "<leader>o",
    },
    {
        "luukvbaal/statuscol.nvim",
        lazy = false,
        config = function()
            require "plugins.configs.statuscol"
        end,
    },
}
return plugins
