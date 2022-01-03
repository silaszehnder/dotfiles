set nocompatible              " be iMproved, required
filetype off                  " required

" Disable polyglot for markdown
let g:polyglot_diabled = ['markdown', 'vimwiki']
" Disable reindenting polyglot
autocmd BufEnter * set indentexpr=

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" code completion and formatting
Plugin 'maralla/completor.vim'

" Asynchronous Lint Engine
Plugin 'dense-analysis/ale'

" Run flake8 on python files
Plugin 'nvie/vim-flake8'

" Python black plugin
Plugin 'psf/black'

" clang-format
" Plugin 'rhysd/vim-clang-format'

" File directory traverser
Plugin 'scrooloose/nerdtree'

" Adds useful info in a status bar at the bottom of the window
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" For traversing function definitions etc
Plugin 'taglist.vim'

" tag file autogeneration
Plugin 'ludovicchabant/vim-gutentags'

" comments with `gcc`
Plugin 'tpope/vim-commentary'

" LaTeX
Plugin 'xuhdev/vim-latex-live-preview'
" Plugin 'vim-latex/vim-latex'

" Hex colors
Plugin 'chrisbra/colorizer'

" Move between tmux and vim panes
Plugin 'christoomey/vim-tmux-navigator'

" note taking
Plugin 'vimwiki/vimwiki'

" colors
Plugin 'joshdick/onedark.vim'
Plugin 'flazz/vim-colorschemes'

" jinja2 syntax
Plugin 'glench/vim-jinja2-syntax'

" Language pack
Plugin 'sheerun/vim-polyglot'

call vundle#end()
filetype plugin indent on "enable indents

set backspace=indent,eol,start
set autoindent
set tabstop=4 "number of visual spaces per tab
set shiftwidth=4 "on pressing tab, insert 4 spaces
set softtabstop=4
set expandtab
set number "shows line numbers
set cursorline "highlights the current line
set showmatch "highlights the matching parenthesis you are currently on
set nohlsearch "highlights the matches during searches
set incsearch "live search as characters are entered
set ruler
set foldenable
set foldlevelstart=10
set foldmethod=indent
set showcmd

syntax enable "enables syntax colors
set t_Co=256

set background=dark
colorscheme onedark

" Alternative cursorline for default colorscheme
" hi CursorLine ctermbg=Black cterm=NONE
" hi CursorLineNr ctermbg=Black cterm=NONE

" vim-gutentags
set statusline+=%{gutentags#statusline()}

"NERDTree
let NERDTreeShowLineNumbers=1

" airline
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1

" Taglist
let Tlist_GainFocus_On_ToggleOpen = 1

" Completor
let g:completor_python_binary = '/usr/local/bin/python3'

" flake8 autorun on saving py file
autocmd BufWritePost *.py call flake8#Flake8()

" black autorun on saving py file
autocmd BufWritePost *.py call black#Black()

" vim-polyglot/markdown
let g:vim_markdown_conceal = 0

" vimwiki conceal
let g:vimwiki_conceallevel = 0

" Syntastic
let g:syntastic_cpp_checkers = ['clang_check', 'gcc', 'cppcheck']
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall"

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" vim-clang-format
let g:clang_format#detect_style_file = 1

" LaTeX preview with mupdf
let g:livepreview_previewer='mupdf'

" Color hex codes
let g:colorizer_auto_filetype='css,html'

" Change notetaking to md
let g:vimwiki_list = [{'path': '~/vimwiki-personal/', 'syntax': 'markdown',
            \ 'ext': '.md', 'custom_wiki2html': 'vimwiki_markdown',
            \ 'template_ext': '.tpl', 'template_path': '~/vimwiki/templates/',
            \ 'template_default': 'default', 'path_html': '~/vimwiki/site_html'}]
let g:vimwiki_global_ext = 0

" .conf files look like dosini files
au BufEnter,BufRead *.conf setf dosini

let mapleader=","

" Vimwiki
nmap <leader>nw <Plug>VimwikiIndex
nmap <leader>nt <Plug>VimwikiTabIndex
nmap <leader>ns <Plug>VimwikiUISelect
nmap <leader>ni <Plug>VimwikiDiaryIndex
nmap <leader>n<leader>n <Plug>VimwikiMakeDiaryNote
nmap <leader>n<leader>t <Plug>VimwikiTabMakeDiaryNote
nmap <leader>n<leader>y <Plug>VimwikiMakeYesterdayDiaryNote
nmap <leader>n<leader>m <Plug>VimwikiMakeTomorrowDiaryNote
nmap <leader>n<leader>i <Plug>VimwikiDiaryGenerateLinks

" inoremap
inoremap <C-J> <ESC><C-W><C-J>
inoremap <C-K> <ESC><C-W><C-K>
inoremap <C-L> <ESC><C-W><C-L>
inoremap <C-H> <ESC><C-W><C-H>
inoremap jj <ESC>

" tnoremap
tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>
tnoremap <leader>n <C-W>N

" nnoremap
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Make ctags show all options when multiple tags are available
nnoremap <C-]> g<C-]>

nnoremap <space> za
nnoremap <leader>w :w<CR>
nnoremap <leader>j Lzt
nnoremap <leader>k Hzb
nnoremap <leader>h :bp<CR>
nnoremap <leader>l :bn<CR>
nnoremap <leader>b $A {<CR>}<ESC>O
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>t :TlistToggle<CR>
nnoremap <leader>f :lopen<CR>
nnoremap <leader>g :lclose<CR>

" Silly wayland clipboard stuff
" xnoremap "+y y:call system("wl-copy", @")<cr>
" nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
" nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p
