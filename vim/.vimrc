" vim: nowrap fdm=marker

" Bundles {{{1
" Vundle init {{{2
set nocompatible
filetype off
set shell=/bin/bash

set rtp +=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage itself
Bundle "gmarik/vundle"

" General enhancements {{{2
Bundle "kien/ctrlp.vim"
Bundle "majutsushi/tagbar"
Bundle "Raimondi/delimitMate"
Bundle "scrooloose/nerdcommenter"
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-repeat"
Bundle "tpope/vim-sensible"
Bundle "tpope/vim-surround"
Bundle "tpope/vim-unimpaired.git"
Bundle "Yggdroot/indentLine"
Bundle "ervandew/supertab"
Bundle "scrooloose/syntastic"
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/nerdtree'
Bundle 'Xuyuanp/nerdtree-git-plugin'
Bundle 'dominikduda/vim_current_word'
" Needs lua, maybe replace.
""Bundle "Shougo/neocomplete.vim"

" Ultisnips
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Python enhancements {{{2
" Redo python setup once needed.
Bundle "klen/python-mode"
Bundle "davidhalter/jedi-vim"

" Go enhancements {{{2
Bundle "fatih/vim-go"

" Colourschemes {{{2
Bundle "altercation/vim-colors-solarized"
Bundle 'chriskempson/base16-vim'
Bundle 'nanotech/jellybeans.vim'

" Tmux stuff {{{2
Bundle 'edkolev/tmuxline.vim'
Bundle 'christoomey/vim-tmux-navigator'

" VIM settings {{{1

" Edit settings {{{2
" Enable filetype plugins and indention
" filetype on
filetype plugin on
filetype plugin indent on

" We want syntax highlighting
syntax on

" Show tabs and trailing spaces
set list!

" Highlight current line
set cursorline
set cursorcolumn

" Set colour column
set colorcolumn=80

" Turn on relative line numbers with absolute current line.
set nu
set rnu


" Better Search
set hlsearch
set smartcase

" Tab Settings
set tabstop=8
set shiftwidth=4
set softtabstop=4
set textwidth=79
set expandtab

" Code Folding, everything folded by default
set foldlevel=99
set foldenable
nnoremap <Space> za

" UTF-8 default encoding
set enc=utf-8
" UX settings {{{2
" Remap ; to : for speed.
nnoremap ; :

" Set <leader> to ',' and <localleader> to "\"
let mapleader=","
let maplocalleader="\\"

" Better modes. Remember where we are, support yankring
set viminfo=!,'100,\"100,:20,<50,s10,h,n~/.viminfo

" Toggle paste with <F3>
set pastetoggle=<F3>

" Enable hidden buffers.
set hidden

" Enable automatic title setting for terminals
set title
set titleold="Terminal"
set titlestring=%F\ -\ Vim

" Enable mouse in the Terminal 
set mouse=nv

" Customize the wildmenu
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*$py.class,*.class
set wildmode=list:full

" No annoying bell
set vb t_vb=

" Always show statusline
set laststatus=2


" Vimfile settings {{{2
" Move Backup Files to ~/.vim/sessions
set backupdir=~/.vim/sessions
set dir=~/.vim/sessions

" Turn off annoying swapfiles
set noswapfile

" Set persistent undo (v7.3 only)
set undodir=~/.vim/undodir
set undofile

" Colourscheme settings {{{2
set background=dark
set t_Co=256

let base16colorspace=256  " Access colors present in 256 colorspace"
let g:jellybeans_background_color_256='NONE'
colorscheme jellybeans

" Custom mappings {{{2
" Tagbar
nmap <F8> :TagbarToggle<CR>
nmap <leader>v :tabedit $MYVIMRC<CR>

" Autocommands {{{2
if has("autocmd")
    " The PC is fast enough, do syntax highlight syncing from start
    autocmd BufEnter * :syntax sync fromstart

    " Remember cursor position
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

    " Auto source vimrc
    autocmd BufWritePost .vimrc source $MYVIMRC

endif


" Plugin settings {{{1
" CtrlP settings. {{{2
let g:ctrlp_working_path_mode = 2
let g:ctrlp_switch_buffer = 2

" Indentline settings: {{{2
let g:indentLine_char = '┆'

" hide some files and remove stupid help {{{2
let g:netrw_list_hide='^\.,.\(pyc\|pyo\|o\)$'

" Python mode settings
" We use jedi-vim instead of rope
let g:pymode_rope = 0

" Delimitmate options
let delimitMate_expand_cr = 1

" Documentation stuff
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

" Linting
let g:pymode_lint = 0
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = 'b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Syntastic settings {{{2
let g:syntastic_always_populate_loc_list=1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" Airline settings {{{2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1

" Ultisnips options
let g:ultisnips_python_style = "sphinx"

" vim-go options
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
au BufRead,BufNewFile *.go set noet ts=4 sw=4

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" YAML settings
au FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" Neocomplete
let g:neocomplete#enable_at_startup = 1
