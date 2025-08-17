local on_attach = function(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
  end

  local builtin = require("telescope.builtin")

  -- Navigation
  map("n", "gd", builtin.lsp_definitions, "Go to definition")
  map("n", "gr", builtin.lsp_references, "References")
  map("n", "gi", builtin.lsp_implementations, "Go to implementation")
  map("n", "gt", builtin.lsp_type_definitions, "Go to type definition")

  -- Info
  map("n", "K", vim.lsp.buf.hover, "Hover info")
  map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

  -- Refactor
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code actions")

  -- Diagnostics
  map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
  map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic float")
  map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics list")

  -- Formatting (only if supported)
  if client.server_capabilities.documentFormattingProvider then
    map("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, "Format document")
  end
end

-- Capabilities (for nvim-cmp)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Global diagnostics config
vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = "●" },
  float = { border = "rounded" },
  severity_sort = true,
})

-- Add borders to LSP popups
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = "rounded" }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = "rounded" }
)

-- Setup servers
local lspconfig = require("lspconfig")

local servers = {
  "pyright",
  "ts_ls",
  "jdtls",
  "angularls",
  "gopls",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

-- Lua
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

-- Go
lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
})
