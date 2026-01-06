local harpoon = require("harpoon")

harpoon:setup({
        settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
                key = function()
                        return vim.loop.cwd()
                end,
        },
})
vim.keymap.set("n", "<leader>A", function() harpoon:list():prepend() end, { desc = "Harpoon prepend to list" })
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add to list" })
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon toggle menu" })

vim.keymap.set("n", "<M-1>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<M-2>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<M-3>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<M-4>", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<M-5>", function() harpoon:list():select(5) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>t", function() harpoon:list():prev() end, { desc = "Harpoon previous" })
vim.keymap.set("n", "<leader>n", function() harpoon:list():next() end, { desc = "Harpoon next" })
