local builtin = require('telescope.builtin')
require('telescope').setup {
    defaults = {
        --path_display = { "smart" },
        file_ignore_patterns = { "node_modules", ".git/" },
        layout_strategy = "horizontal",
        layout_config = {
            width = 0.99,
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

local opts = { previewer = true }
vim.keymap.set('n', '<leader>pt', function()
    opts.previewer = not opts.previewer
    builtin.find_files(opts)
end, { desc = 'Toggle Telescope preview' })

vim.keymap.set('n', '<leader>cm', function()
    require('telescope.builtin').colorscheme({
        enable_preview = true,
        attach_mappings = function(prompt_bufnr, map)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            local function apply_color()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                if selection then
                    ColorMyWorld(selection.value)
                end
            end

            map('i', '<CR>', apply_color)
            map('n', '<CR>', apply_color)

            return true
        end,
    })
end, { desc = 'Pick colorscheme (ColorMyWorld)' })
