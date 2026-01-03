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

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add to list" })
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon toggle menu" })

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon select 1" })
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon select 2" })
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon select 3" })
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon select 4" })
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "Harpoon select 5" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>t", function() harpoon:list():prev() end, { desc = "Harpoon previous" })
vim.keymap.set("n", "<leader>n", function() harpoon:list():next() end, { desc = "Harpoon next" })
