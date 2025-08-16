-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

    -- ui and appearance
    use "camgunz/amber"
    use "ellisonleao/gruvbox.nvim"
    use "rose-pine/neovim"
	use "maxmx03/solarized.nvim"
    use "nvim-lualine/lualine.nvim"
    -- use { "nvim-tree/nvim-web-devicons" }

    -- utilities and core
    use "nvim-lua/plenary.nvim"
    use "mbbill/undotree"
    use "tpope/vim-fugitive"
    use "lewis6991/gitsigns.nvim"
    use "MunifTanjim/nui.nvim"
    use "echasnovski/mini.icons"
    use "stevearc/dressing.nvim"
    use "folke/which-key.nvim"
    use "cankurttekin/pinit-nvim"
    use "ThePrimeagen/vim-be-good"

    -- fuzzy finder and navigation
    use {
            'nvim-telescope/telescope.nvim', tag = '0.1.8',
            requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
            "ThePrimeagen/harpoon",
            branch = "harpoon2",
            requires = { {"nvim-lua/plenary.nvim"} }
    }

    -- syntax highlighting
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "MeanderingProgrammer/render-markdown.nvim"

    -- lsp and autocompletion
    use "neovim/nvim-lspconfig"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "rafamadriz/friendly-snippets"
    use "mfussenegger/nvim-jdtls"

    -- debugging and dev tools
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"

    -- ai shit
    use "github/copilot.vim"
    use({
            "CopilotC-Nvim/CopilotChat.nvim",
            branch = "main",
            requires = {
                    { "github/copilot.vim" },
                    { "nvim-lua/plenary.nvim" },
                    { "nvim-telescope/telescope.nvim" }
            },
            config = function()
                    require("CopilotChat").setup({
                            -- optional settings
                            debug = false,
                    })
            end,
    })
    use "supermaven-inc/supermaven-nvim"
    use {
            "yetone/avante.nvim",
            branch = "main",
            run = "make"
    }
end)
