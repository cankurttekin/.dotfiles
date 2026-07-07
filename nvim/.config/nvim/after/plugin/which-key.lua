local wk = require("which-key")

wk.setup({
    preset = "modern",
    delay = function(ctx)
        return ctx.plugin and 0 or 200
    end,
    icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
        mappings = true,
        colors = true,
    },
    win = {
        no_overlap = true,
        padding = { 1, 2 },
        title = true,
        title_pos = "center",
        border = "single",
    },
    layout = {
        width = { min = 20 },
        spacing = 1,
    },
    sort = { "local", "order", "group", "alphanum", "mod" },
    plugins = {
        marks = true,
        registers = true,
        spelling = {
            enabled = true,
            suggestions = 20,
        },
        presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
        },
    },
    keys = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
    },
    show_help = true,
    show_keys = true,
})

wk.add({
    { "<leader>pv",       vim.cmd.Ex, desc = "Show directory" },
    { "<leader>s",        desc = "Replace word under cursor" },
    { "<leader>x",        desc = "Make it executable" },
    { "<leader>d",        desc = "Delete w/o replacing register", mode = { "n", "v" } },
    { "<leader><leader>", desc = "Source file" },
    { "<leader>pf",       desc = "Find file" },
    { "<leader>pg",       desc = "Git file search" },
    { "<leader>ps",       desc = "Grep string" },
    { "<leader>lg",       desc = "Live grep" },
    { "<leader>pr",       desc = "Recent files" },
    { "<leader>pc",       desc = "Git commits" },
    { "<leader>fk",       desc = "Search keymaps" },
    { "<leader>A",        desc = "Harpoon prepend to list" },
    { "<leader>h",        desc = "Harpoon toggle menu" },
    { "<leader>n",        desc = "Harpoon next" },
    { "<leader>t",        desc = "Harpoon previous" },
    { "<C-f>",            desc = "Tmux sessionizer" },
})

vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
