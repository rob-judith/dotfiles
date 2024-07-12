" Vim plugin
"
call plug#begin('~/.vim/plugged')
call plug#end()

" Basic Settings
let mapleader=" "
let maplocalleader=" "

filetype indent plugin on
syntax on
set mouse=a
set background=light
set backspace=2 " make backspace work line a sane program.
set number
set relativenumber
set hidden
set visualbell
set hlsearch

" Highlight trailing white space.
nmap <c-a> /\s\+$<CR>
nmap <Esc> <cmd>nohlsearch<CR>
" Escape term mode
tmap <leader><Esc> <C-\\><C-n> 

" Delete current buffer without messing up windows
" nmap <c-q> :bp | bd # <CR>
" Remap window movement to ctrl-hjkl
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l


" not to break on words
set formatoptions=1
set linebreak


" Custom settings for python code settings
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set shiftround
" Somehow habamax
set bg=dark
colorscheme sorbet
" Colorschemes I like habamax, wildcharm, sorbet, zaibatsu, retrobox

autocmd FileType python set colorcolumn=80

highlight ColorColumn ctermbg=4
