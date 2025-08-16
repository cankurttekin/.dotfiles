require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "pyright", "html", "cssls", "jdtls", "jsonls", "bashls", "dockerls", "gopls", "rust_analyzer" },
  automatic_installation = true,
}

