local builtin = require('telescope.builtin')
require('telescope').setup {
    defaults = {
        --path_display = { "smart" },
        file_ignore_patterns = { "node_modules", ".git/" },
        layout_strategy = "vertical",
        layout_config = {
            width = 0.8,
            height = 0.99,
            preview_cutoff = 1,
        },
        border = true,
        borderchars = {
            prompt  = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            results = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        },
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
                ["<C-q>"] = "send_to_qflist",
            },
        },
    }
}

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>pg', builtin.git_files, { desc = 'Telescope git file search' })
vim.keymap.set('n', '<leader>ps', function()
    local query = vim.fn.input('Grep > ')
    if query == nil or query == '' then return end
    require('telescope.builtin').grep_string({ search = query })
end, { desc = 'Grep string' })
vim.keymap.set('n', '<leader>lg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>pr', builtin.oldfiles, { desc = 'Recent files' })
vim.keymap.set('n', '<leader>pc', builtin.git_commits, { desc = 'Git commits' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Search keymaps' })
