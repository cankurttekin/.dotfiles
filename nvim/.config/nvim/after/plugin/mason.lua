require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "pyright",
    "ts_ls",
    "jdtls",
    "angularls",
    "gopls",
    "html",
    "cssls",
    "jsonls",
    "bashls",
    "dockerls",
    "rust_analyzer",
  },
  automatic_installation = true,
})
