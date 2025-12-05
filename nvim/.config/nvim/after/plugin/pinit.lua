local pinit = require("pinit")

pinit:setup({
    notes_dir = "~/.pinitnotes",
    window = {
        type = "float",    -- optional: "float" | "split" (default: "float")
        width = 0.8,       -- optional: fraction or absolute size (default: 0.6)
        height = 0.8,      -- optional: fraction or absolute size (default: 0.6)
        border = "single", -- optional: "single" | "double" | "rounded" | "solid" | "shadow" (default: "single")
    },
})

vim.keymap.set("n", "<leader>pn", function()
    pinit:open()
end, { desc = "PinIt Toggle project notes" })
