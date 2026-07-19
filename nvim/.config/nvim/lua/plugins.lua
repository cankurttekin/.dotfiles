return {
  -- UI and appearance
  --{ "rktjmp/lush.nvim" },
  --{ "nvim-lualine/lualine.nvim" },
  --{ "folke/zen-mode.nvim" },

  -- Colorschemes
  { "rose-pine/neovim" },

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
  --{ "nvim-treesitter/nvim-treesitter", tag = "v0.10.0", build = ":TSUpdate" },
  --{ "nvim-treesitter/nvim-treesitter-textobjects" },
  --{ "nvim-treesitter/nvim-treesitter-context" },
  { "MeanderingProgrammer/render-markdown.nvim" },
  { "catgoose/nvim-colorizer.lua", event = "BufReadPre", opts = {} },

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
