local builtin = require('telescope.builtin')
require('telescope').setup{
        defaults = {
                path_display = { "smart" },
                file_ignore_patterns = { "node_modules", ".git/" },
                layout_strategy = "horizontal",
                layout_config = {
                        width = 0.9,
                        preview_cutoff = 120,
                },
        }
}

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
--vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope git file search' })
vim.keymap.set('n', '<leader>pg', builtin.git_files, { desc = 'Telescope git file search' })
vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input('grep >  ') })
end)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- toggle preview 
local opts = { previewer = true }

vim.keymap.set('n', '<leader>pt', function()
        opts.previewer = not opts.previewer
        builtin.find_files(opts)
end, { desc = 'Toggle Telescope preview' })
