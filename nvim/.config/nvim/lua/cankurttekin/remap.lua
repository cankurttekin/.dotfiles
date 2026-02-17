vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Show directory" })

-- move lines up/down with J/K 
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- stay in visual select while indenting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- join lines and return the cursor where it was
vim.keymap.set("n", "J", "mzJ`z")

-- half page scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- n = next match, zz = center the screen, zv = open folds
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP",
    { desc = "Paste without replacing register" })
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d",
    { desc = "Delete without replacing register" })

-- replace every word that is under cursor currently
vim.keymap.set("n", "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word under cursor" })

-- make the file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>",
    { silent = true, desc = "Make it executable" })

vim.keymap.set('n', 'H', '^', { desc = 'Start of line' })
vim.keymap.set('n', 'L', '$', { desc = 'End of line' })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- duplicate a line and comment out the first line
vim.keymap.set("n", "yc", "yygccp", {remap=true})

-- tmux mappings for prime's sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<M-o>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>")
vim.keymap.set("n", "<M-O>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")
