set nocompatible
filetype off

" Setup vundle - bundler for vim
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" vundle needs to manage itself
Bundle 'gmarik/vundle'

" Require all other bundles using vundle and set them up
Bundle 'molokai'

" Syntax highlighting/indenting, along with some other niceties
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-liquid'
Bundle 'pangloss/vim-javascript'
Bundle 'plasticboy/vim-markdown'
Bundle 'eruby.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-bundler'
syntax enable
au! BufRead,BufNewFile *.erb          setfiletype eruby
au! BufRead,BufNewFile *.haml         setfiletype haml

" File tree
Bundle 'scrooloose/nerdtree'

" Buffer manager
Bundle 'bufexplorer.zip'

" Managing comments
Bundle 'scrooloose/nerdcommenter'

" Changing/deleting surrounding brackets/quotes
Bundle 'tpope/vim-surround'

" Repeat commands from plugins with .
Bundle 'tpope/vim-repeat'

" Extend % matching for lots of languages, and Ruby
Bundle 'matchit.zip'
Bundle 'ruby-matchit'

" Fancy nl stuff with words
Bundle 'tpope/vim-abolish'

" We want to load plugin + indent files
filetype plugin indent on

" Enable the colourscheme
colorscheme molokai

" Enables 256 colors
set t_Co=256

" Set the tab width to be 2 characters
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Apart from in python, where it should be 4
autocmd filetype python set tabstop=4
autocmd filetype python set shiftwidth=4
autocmd filetype python set softtabstop=4

" Turn tabs into spaces
set expandtab

" UTF-8 encoding
set encoding=utf-8

" Ensures there are always at least 3 lines visible above/below the cursor
set scrolloff=3

" Increase the number of lines of command line history remembered
set history=1000

" Increase the number of changes remembered
set undolevels=1000

" Very basic indentation to fall back to if a filetype indent file isn't used
set autoindent

" Show the current editing mode at the bottom of the window
set showmode

" Show the command currently being entered at the bottom of the window
set showcmd

" Show an onscreen bell rather then beeping
set visualbell

" Don't ring the bell on an error - reduces number of bells
set noerrorbells

" Highlight the line the cursor is on
set cursorline

" Increase smoothness of redrawing - it's not the 80s anymore
set ttyfast

" Show the location of the cursor in the file at the bottom of the window
set ruler

" Always show the status line at the bottom of the window
set laststatus=2

" Show line numbers along the side, but relative - e.g 14 on the lines 14
" lines above/below the current line
set relativenumber

" Save undo history to a file, so it persists across sessions
set undofile

" Allow buffers to have unsaved changes
set hidden

" Ignore case when searching, unless uppercase characters are used
set ignorecase
set smartcase

" Show current matches when typing a search string
set incsearch

" Briefly highlight the corresponding bracket when inserting a new bracket
set showmatch

" Highlight all search results until they're removed (./)
set hlsearch

" When <F2> is pressed, disable indenting, etc
set pastetoggle=<F2>

" Remap <F1> to <ESC> to stop accidental opening of help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Remap the arrow keys *in normal and visual modes* to move between windows
nnoremap <Up> :wincmd k<CR>
nnoremap <Down> :wincmd j<CR>
nnoremap <Left> :wincmd h<CR>
nnoremap <Right> :wincmd l<CR>
vnoremap <Up> :wincmd k<CR>
vnoremap <Down> :wincmd j<CR>
vnoremap <Left> :wincmd h<CR>
vnoremap <Right> :wincmd l<CR>

" Map ,/ to clear highlighting of search results
nmap <silent> ,/ :nohlsearch<CR>

" Map \ to leader
let mapleader = "\\"

" Map \d to toggle NERDTree (file tree)
nnoremap <leader>d :NERDTreeToggle<cr>

" Tab complete when opening files with :e
set wildmode=longest,list,full
set wildmenu