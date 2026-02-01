let mapleader = " "

nnoremap <leader>pv :Ex<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap J mzJ`z

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap n nzzzv
nnoremap N Nzzzv

" Paste without overwriting register
xnoremap <leader>p "_dP

" Delete without overwriting register
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Replace word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Make file executable
nnoremap <leader>x :!chmod +x %<CR>

" Start/end of line
nnoremap H ^
nnoremap L $

" source vimrc
nnoremap <leader><leader> :source $MYVIMRC<CR>

set clipboard=unnamedplus

" UI settings
set nu
set relativenumber
set guicursor=
set cursorline

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set nowrap

set noswapfile
set nobackup
" set undodir=~/.vim/undodir
" set undofile

set hlsearch
set incsearch

" set termguicolors

set scrolloff=8
set signcolumn=yes
set isfname+=@-@

set updatetime=50

set colorcolumn=80

set ignorecase
set smartcase

set autoread

set showmode

set numberwidth=2

" minimal netrw
let g:netrw_browse_split = 0
let g:netrw_banner = 0
let g:netrw_winsize = 25

