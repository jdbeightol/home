set nocompatible

" execute pathogen#infect()

filetype plugin indent on
syntax on

" Feature sets
set backspace=indent,eol,start
set clipboard=unnamed
set grepprg=grep\ -nH\ $*
set showmode
set showcmd
set autoindent
set hlsearch
set showmatch
set cursorline
set mouse=a

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set autoread
set ruler

set dictionary=/usr/share/dict/words

set title
set number
set relativenumber

set shell=/bin/bash
set lazyredraw
set matchtime=3

let mapleader = ","

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
"set gdefault
set incsearch
set showmatch
set hlsearch

set wrap
set textwidth=79
set formatoptions=qrn1

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

au VimResized * :wincmd =

set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn " Version Controls"
set wildignore+=*.aux,*.out,*.toc "Latex Indermediate files"
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Binary Imgs"
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
set wildignore+=*.spl "Compiled spelling word list"
set wildignore+=*.sw? "Vim swap files"
set wildignore+=*.DS_Store "OSX File"
set wildignore+=*.luac "Lua byte code"
set wildignore+=migrations "Django migrations"
set wildignore+=*.pyc "Python Object codes"
set wildignore+=*.orig "Merge resolution files"

augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ execute 'normal! g`"zvzz' |
        \ endif
augroup END

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

set rtp+=/usr/local/opt/fz

let g:airline_theme = 'minimalist'

let g:jsonnet_fmt_on_save = 0

autocmd FileType hcl setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType nix setlocal tabstop=2 shiftwidth=2 softtabstop=2
