require('rose-pine').setup({ disable_background = true })
require("black-metal").setup({ transparent = true, })
require("black-metal").load()

function ColorMyWorld(color, mode, transparent)
    color = color or "rose-pine-moon"
    mode = mode or "dark"
    transparent = transparent or true

    vim.cmd.colorscheme(color)
    vim.o.background = mode

    if transparent then
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })

        --vim.api.nvim_set_hl(0, "Delimiter", { link = "Normal" })
        --vim.api.nvim_set_hl(0, "@punctuation.delimiter", { link = "Normal" })
        --vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "Normal" })
    end
end

ColorMyWorld()
