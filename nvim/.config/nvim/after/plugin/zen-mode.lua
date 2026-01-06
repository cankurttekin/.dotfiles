-- wide zen
vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").setup({
        plugins = { tmux = { enabled = false }, },
    })
    require("zen-mode").toggle({
        window = { width = 90 },
    })
    vim.wo.wrap = false
    vim.wo.number = true
    vim.wo.rnu = true
    ColorMyWorld()
end, { desc = "Zen Mode wide" })

-- light zen
vim.keymap.set("n", "<leader>zl", function()
    require("zen-mode").setup({
        plugins = { tmux = { enabled = true }, },
    })
    require("zen-mode").toggle({
        window = { width = 90 },
    })
    vim.wo.wrap = false
    vim.wo.number = true
    vim.wo.rnu = true
    ColorMyWorld("solarized", "light", false)
end, { desc = "Zen Mode Solarized light" })

-- narrow zen
vim.keymap.set("n", "<leader>zZ", function()
    require("zen-mode").setup({
        plugins = { tmux = { enabled = true }, },
    })
    require("zen-mode").toggle({
        window = { width = 75 },
    })
    vim.wo.wrap = false
    vim.wo.number = false
    vim.wo.rnu = false
    vim.opt.colorcolumn = "0"
    ColorMyWorld()
end, { desc = "Zen Mode narrow" })
