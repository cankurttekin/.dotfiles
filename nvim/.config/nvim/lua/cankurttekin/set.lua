vim.opt.clipboard = "unnamedplus"

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.ignorecase = true -- ignore case for search
vim.opt.smartcase = true -- but not if caps used

vim.o.autoread = true

vim.opt.cursorline = true

vim.g.netrw_browse_split = 0 -- open files in the same window
vim.g.netrw_banner = 0 -- hide the netrw banner
vim.g.netrw_winsize = 25 -- width of the netrw window
--vim.g.netrw_liststyle = 1

vim.opt.showmode = false -- dont needed due to statusline
vim.opt.numberwidth = 2
