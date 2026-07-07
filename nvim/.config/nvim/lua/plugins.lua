return {
  -- UI and appearance
  --{ "rktjmp/lush.nvim" },
  --{ "nvim-lualine/lualine.nvim" },
  --{ "folke/zen-mode.nvim" },

  -- Colorschemes
  { "rose-pine/neovim" },
  --{ "maxmx03/solarized.nvim" },

  -- Utilities
  { "nvim-lua/plenary.nvim" },
  { "mbbill/undotree" },
  { "tpope/vim-fugitive" },
  { "lewis6991/gitsigns.nvim" },
  { "MunifTanjim/nui.nvim" },
  --{ "echasnovski/mini.icons" },
  { "stevearc/dressing.nvim" },
  { "folke/which-key.nvim" },
  { "cankurttekin/pinit-nvim" },

  -- Navigation
  { 'nvim-telescope/telescope.nvim', version = '0.2.1', dependencies = { 'nvim-lua/plenary.nvim',
          { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      }
  },
  { "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Syntax
  { "nvim-treesitter/nvim-treesitter", tag = "v0.10.0", build = ":TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "nvim-treesitter/nvim-treesitter-context" },
  { "MeanderingProgrammer/render-markdown.nvim" },

  -- Colorizer
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
      })
    end,
  },

  -- LSP and autocompletion
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "rafamadriz/friendly-snippets" },
  { "mfussenegger/nvim-jdtls" },

  -- Debugging
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },

  -- AI
  { "github/copilot.vim" },
  --{ "zbirenbaum/copilot.lua", dependencies = { "copilotlsp-nvim/copilot-lsp" } },
  { "CopilotC-Nvim/CopilotChat.nvim", 
  dependencies = { { "nvim-lua/plenary.nvim", branch = "master" }, },
  build = "make tiktoken", },
}
