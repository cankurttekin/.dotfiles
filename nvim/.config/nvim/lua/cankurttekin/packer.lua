-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

    -- ui and appearance
    use { 'rktjmp/lush.nvim' }
    use { 'nvim-lualine/lualine.nvim' }
    use { 'metalelf0/black-metal-theme-neovim' }
    use { 'folke/zen-mode.nvim' }
    -- use { 'nvim-tree/nvim-web-devicons' }
    -- colorschemes
    use { 'catppuccin/nvim', as = 'catppuccin' }
    use { 'ellisonleao/gruvbox.nvim' }
    use { 'loganswartz/selenized.nvim' }
    use { 'maxmx03/solarized.nvim' }
    use { 'bluz71/vim-moonfly-colors' }
    use { 'Shatur/neovim-ayu' }
    use { 'rose-pine/neovim' }

    -- utilities and core
    use { 'nvim-lua/plenary.nvim' }
    use { 'mbbill/undotree' }
    use { 'tpope/vim-fugitive' }
    use { 'lewis6991/gitsigns.nvim' }
    use { 'MunifTanjim/nui.nvim' }
    use { 'echasnovski/mini.icons' }
    use { 'stevearc/dressing.nvim' }
    use { 'folke/which-key.nvim' }
    use { 'cankurttekin/pinit-nvim' }
    use { 'ThePrimeagen/vim-be-good' }

    -- fuzzy finder and navigation
    use {
            'nvim-telescope/telescope.nvim', tag = '0.1.8',
            requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
            'ThePrimeagen/harpoon',
            branch = 'harpoon2',
            requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- syntax
    use { 'nvim-treesitter/nvim-treesitter', branch = 'master',  run = ':TSUpdate' }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }
    use { 'MeanderingProgrammer/render-markdown.nvim' }
    --[[
    use {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }
    --]]
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require("colorizer").setup({ "*" }, {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                names = true, -- "Name" codes like Blue
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            })
        end
    }

    -- lsp and autocompletion
    use { 'neovim/nvim-lspconfig' }
    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim' }
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'L3MON4D3/LuaSnip' }
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'rafamadriz/friendly-snippets' }
    use { 'mfussenegger/nvim-jdtls' }

    -- debugging and dev tools
    use { 'mfussenegger/nvim-dap' }
    use { 'rcarriga/nvim-dap-ui' }

    -- ai shit
    use { 'github/copilot.vim' }
    use({
            'CopilotC-Nvim/CopilotChat.nvim',
            branch = 'main',
            requires = {
                    { 'github/copilot.vim' },
                    { 'nvim-lua/plenary.nvim' },
                    { 'nvim-telescope/telescope.nvim' }
            },
            config = function()
                    require('CopilotChat').setup({
                            debug = false,
                    })
            end,
    })
    use { 'supermaven-inc/supermaven-nvim' }
end)
