syntax enable
set background=dark
colorscheme brogrammer

set tabstop=4 " number of spaces that <Tab> in file uses
set softtabstop=4 " number of spaces that <Tab> uses while editing
set expandtab " use spaces when <Tab> is inserted
set autoindent " take indent for new line from previous line
set shiftwidth=4 " number of spaces to use for (auto)indent step 

set number " print the line number in front of each line
set showcmd " show (partial) command in status line
set wildmenu " use menu for command line completion
set lazyredraw " don't redraw while executing macros
set showmatch " briefly jump to matching bracket if insert one

set ignorecase " ignore case in search patterns
set incsearch " highlight match while typing search pattern
set hlsearch " highlight matches with last search pattern

set clipboard=unnamed " use the clipboard as the unnamed register

autocmd BufEnter * lcd %:p:h " set working directory to current file's directory

" Begin Vim Plug

call plug#begin('~/.vim/vim-plug')

" Functional
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Visual
Plug 'leafgarland/typescript-vim'

call plug#end()

" NERDTree
cnoreabbrev n NERDTreeToggle
let g:NERDTreeShowHidden=1
let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeWinSize=50

" FZF
cnoreabbrev f Ag
cnoreabbrev ff AgFile

" End Vim Plug
