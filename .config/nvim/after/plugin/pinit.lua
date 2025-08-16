local pinit = require("pinit")

pinit:setup({
   notes_dir = "~/.pinitnotes"
})

vim.keymap.set("n", "<leader>pn", function()
  pinit:open()
end, { desc = "Toggle project notes" })
