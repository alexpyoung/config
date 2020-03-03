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

" Highlight statusline of active window
hi StatusLine   ctermfg=15  ctermbg=239 cterm=bold gui=bold
hi StatusLineNC ctermfg=249 ctermbg=235 cterm=none gui=none

call plug#begin('~/.vim/vim-plug')

" Navigation
Plug 'scrooloose/nerdtree' 

" Search
Plug '/usr/local/opt/fzf' " Homebrew installation
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'

" Git
Plug 'tpope/vim-fugitive'

" Intellisense
Plug 'vim-scripts/SyntaxComplete'

" TypeScript
Plug 'HerringtonDarkholme/yats.vim' " syntax highlighting
Plug 'Quramy/tsuquyomi' " client for TSServer

call plug#end()

" NERDTree
cnoreabbrev nt NERDTree
cnoreabbrev ntc NERDTreeClose
cnoreabbrev ntr NERDTreeVCS 

let g:NERDTreeShowHidden=1
let g:NERDTreeNodeDelimiter="\u00a0"
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeWinSize=50

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

" open NERDTree if vim is invoked with no file
autocmd VimEnter * call StartUp()

" FZF
cnoreabbrev f Files

" Quick directories
cnoreabbrev cd cd ~/q/

