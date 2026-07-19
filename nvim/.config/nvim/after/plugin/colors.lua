require('rose-pine').setup({ styles = { transparency =true} })

function ColorMyWorld(color, mode, transparent)
    color = color or "rose-pine-moon"
    mode = mode or "dark"
    transparent = transparent or true

    vim.cmd.colorscheme(color)
    vim.o.background = mode

    if transparent then
        --vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
        --vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none", bold=true })

        --vim.api.nvim_set_hl(0, "Delimiter", { link = "Normal" })
        --vim.api.nvim_set_hl(0, "@punctuation.delimiter", { link = "Normal" })
        --vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "Normal" })
    end
end

ColorMyWorld()

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
