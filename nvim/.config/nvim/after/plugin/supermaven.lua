local supermaven = require("supermaven-nvim")

supermaven.setup({
        keymaps = {
                accept_suggestion = "<C-l>",
                clear_suggestion = "<C-]>",
                accept_word = "<C-j>",
        },
        ignore_filetypes = { cpp = true, markdown = true, },
        color = {
               -- suggestion_color = "#7aa2f7",
                cterm = 110,
        },
        log_level = "info",
        disable_inline_completion = false,
        disable_keymaps = false,
        condition = function() return false end,
})
