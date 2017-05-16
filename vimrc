set nocompatible " be iMproved
" For vundle
filetype on
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" Dependencies of snipmate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/vim-snippets"

" Snippets for our use :)
Bundle 'garbas/vim-snipmate'
" Git tools
Bundle 'tpope/vim-fugitive'
" Dependency managment
Bundle 'gmarik/vundle'
" Rails :/
Bundle 'tpope/vim-rails.git'
" Commenting and uncommenting stuff
Bundle 'tpope/vim-commentary'
" Molokai theme
Bundle 'tomasr/molokai'
" Vim Ruby
Bundle 'vim-ruby/vim-ruby'
Bundle 'janx/vim-rubytest'
" Vim Rspec
Bundle 'skwp/vim-rspec'
" Surround your code :)
Bundle 'tpope/vim-surround'
" Every one should have a pair (Autogenerate pairs for "{[( )
Bundle 'jiangmiao/auto-pairs'
" Tab completions
Bundle 'ervandew/supertab'
" Fuzzy finder for vim (CTRL+P)
Bundle 'kien/ctrlp.vim'
" Navigation tree
Bundle 'scrooloose/nerdtree'
" Dispatching the test runner to tmux pane
Bundle 'tpope/vim-dispatch'
Bundle 'yggdroot/indentline'

Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

Bundle 'airblade/vim-gitgutter'
Bundle 'wakatime/vim-wakatime'
Bundle 'vim-airline/vim-airline'
Bundle 'mxw/vim-jsx'
Bundle 'pangloss/vim-javascript'
Bundle 'ngmy/vim-rubocop'
Bundle 'jeetsukumaran/vim-filesearch'

set tags=./tags; " Set tags directory

set autoindent " Auto indention should be on

" Ruby stuff: Thanks Ben :)
" ================
syntax on		  " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

augroup myvimrc
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*	  lwindow
augroup END

augroup myfiletypes
    " Clear old autocmds in group
    autocmd!
    " autoindent with two spaces, always expand tabs
    autocmd FileType ruby setlocal et sts=0 sw=2 ts=2
    autocmd FileType eruby setlocal et sts=0 sw=2 ts=2
    autocmd FileType yaml setlocal et sts=0 sw=2 ts=2
    autocmd FileType markdown setlocal et sts=0 sw=2 ts=2
    autocmd Filetype javascript setlocal et sts=0 sw=2 ts=2
    autocmd FileType ruby,eruby,yaml,javascript autocmd BufWritePre <buffer> %s/\s\+$//e
    autocmd FileType ruby compiler ruby
augroup END

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" ================

" Syntax highlighting and theme
syntax enable
" JSX config
let g:jsx_ext_required = 0

" Configs to make Molokai look great
set background=light
colorscheme solarized
" let g:molokai_original=1
" let g:rehash256=1
" set t_Co=256
" colorscheme molokai
set guifont=Monaco:h17
set anti " antialiased fonts
set stal=2

" Show trailing whitespace and spaces before a tab:
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\\t/

" Lovely linenumbers
set nu

" My leader key
let mapleader=","
" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
" Remove highlights with leader + enter
nmap <Leader><CR> :nohlsearch<cr>

" Buffer switching
map <leader>p :bp<CR> " ,p previous buffer
map <leader>n :bn<CR> " ,n next buffer
map <leader>d :bd<CR> " ,d delete buffer
map <leader>D :%bd<CR> " ,D delete all buffers

map <Leader>c :call <CR>
" nmap <silent> <leader>c :TestFile<CR>
" nmap <silent> <leader>s :TestNearest<CR>

" map <leader>t :A<CR> " \t to jump to test file
" map <leader>r :r<cr> " \r to jump to related file
" RSpec.vim mappings
map <Leader>r :call RunSpec()<CR>
" map <Leader>s :call RunNearestSpec()<CR>
" map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR>

"" ctrlp.vim
noremap <leader>b :CtrlPBuffer<CR>

set laststatus=2

" highlight the current line
set cursorline
" Highlight active column
" set cuc cul"

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Ruby hash syntax conversion
nnoremap <F12> :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<return>

nmap <Leader><CR> :nohlsearch<cr>

" NERDTree configuration
let g:NERDTreeQuitOnOpen = 1
map <C-n> :NERDTreeToggle<CR>
map <F6> :NERDTreeFind<CR>

set clipboard=unnamed

" The Silver Searcher
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

""""""""""""""""""""""""""""""""""""""""
" BACKUP / TMP FILES
""""""""""""""""""""""""""""""""""""""""
if isdirectory($HOME . '/.vim/backup') == 0
    :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" " If you have .vim-swap in the current directory, it'll use that.
" " Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
    :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap/
set directory+=~/.vim/swap/
set directory+=~/tmp/
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
    " undofile - This allows you to use undos after exiting and restarting
    " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
    " :help undo-persistence
    " This is only present in 7.3+
    if isdirectory($HOME . '/.vim/undo') == 0
	:silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
    endif
    set undodir=./.vim-undo//
    set undodir+=~/.vim/undo//
    set undofile
endif

