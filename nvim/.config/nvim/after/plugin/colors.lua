require('rose-pine').setup({
    disable_background = true
})

function ColorMyWorld(color, mode, transparent)
    color = color or "rose-pine-moon"
    mode = mode or "dark"
    transparent = transparent or true

    vim.cmd.colorscheme(color)
    vim.o.background = mode

    if transparent == true then
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
    end
end

ColorMyWorld()
