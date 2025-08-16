-- Set up keymaps when LSP attaches to buffer
local on_attach = function(_, bufnr)
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
	end
    --	map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    --	map("n", "gr", vim.lsp.buf.references, "References")
    local builtin = require("telescope.builtin")
    map("n", "gd", builtin.lsp_definitions, "Go to definition")
    map("n", "gr", builtin.lsp_references, "References")
	map("n", "K", vim.lsp.buf.hover, "Hover info")
	map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
	map("n", "<leader>ca", vim.lsp.buf.code_action, "Code actions")
	map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
	map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
    map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic in float")
end

-- Enable LSP servers
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Lua
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
})

-- Python
lspconfig.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- TypeScript/JavaScript
lspconfig.ts_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Java
lspconfig.jdtls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.angularls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
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
