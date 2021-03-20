set rtp+=~/.vim/bundle/vim-plug/
call plug#begin('~/.vim/bundle')

Plug 'anyakichi/vim-surround'
Plug 'vim-jp/vimdoc-ja'
Plug 'vim-scripts/Align', {'on': 'Align'}
Plug 'daylilyfield/sexyscroll.vim'
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'morhetz/gruvbox'
Plug 'kchmck/vim-coffee-script', {'for': 'coffee'}
Plug 'groenewege/vim-less', {'for': 'less'}
Plug 'plasticboy/vim-markdown', {'for': 'md'}
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'wavded/vim-stylus', {'for': 'styl'}
Plug 'nathanaelkane/vim-indent-guides'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/DirDiff.vim'
Plug 'rking/ag.vim', {'on': 'Ag'}
Plug 'vim-scripts/TaskList.vim', {'on': 'TaskList'}
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'leafOfTree/vim-svelte-plugin', { 'for': 'svelte' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

syntax on

let mapleader = "\<Space>"

" Mappings

inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

nmap <silent> <Esc><Esc> :nohlsearch<CR>

nnoremap <C-j> 5j
nnoremap <C-h> 5h
nnoremap <C-k> 5k
nnoremap <C-l> 5l

nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

vnoremap <C-j> 5j
vnoremap <C-h> 5h
vnoremap <C-k> 5k
vnoremap <C-l> 5l

vnoremap k gk
vnoremap j gj
vnoremap gk k
vnoremap gj j

vnoremap v ^$h

" Color Scheme

set termguicolors
let g:gruvbox_sign_column = 'dark0'
let g:airline_theme='gruvbox'
colorscheme gruvbox

" Options

set t_Co=256
set background=dark
colorscheme gruvbox

set encoding=UTF-8
set autoread
set hlsearch
set ignorecase
set smartcase
set wrapscan
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set smarttab
set expandtab
set backspace=indent,eol,start
set fillchars+=vert:│
set wildmenu
set formatoptions+=mM
set infercase
set fileformat=unix
set fileformats=unix,mac,dos
set ambiwidth=single
set clipboard+=unnamed
set showmatch
set cpoptions-=m
set matchtime=3
set matchpairs+=<:>
set showmode
set modeline
set hidden
set number
set ruler
set nolist
set wrap
set signcolumn=yes
set laststatus=2
set cmdheight=2
set showcmd
set notitle
set cursorline
set guioptions=erL
set foldenable
set foldmethod=marker
set shortmess=aTI
set history=100
set nowritebackup
set nobackup
set noswapfile

set undofile

if !isdirectory(expand('~/.vimundo'))
    call mkdir(expand('~/.vimundo'))
endif

set undodir=~/.vimundo

set autoindent
set smartindent

set mouse=a
set ttymouse=xterm2

" File Type Triggers

augroup vimrc
autocmd!

autocmd BufNewFile,BufRead *.xml setlocal ts=2 sts=2 sw=2
autocmd BufNewFile,BufRead *.html setlocal ts=2 sts=2 sw=2
autocmd BufNewFile,BufRead *.jade setlocal ts=2 sts=2 sw=2
autocmd BufNewFile,BufRead *.go setlocal noexpandtab

augroup END

" Custom Commands

command! -nargs=0 CopyFilePath call s:copy_file_path()
command! -nargs=0 CopyFileName call s:copy_file_name()

  function! s:copy_file_path()
    let l:p = expand('%:p')
    let @* = l:p
    let @" = l:p
    echo l:p
  endf

  function! s:copy_file_name()
    let l:n = expand('%:t')
    let @* = l:n
    let @" = l:n
    echo l:n
  endf

" Plugin Settings

let g:plugin_dicwin_disable = 1

" align settings
let g:Align_xstrlen=3

" NERDTree
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMarkBookmarks = 0
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeStatusLine = -1
let g:NERDTreeHighlightCursorline = 0

" airline
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ""
let g:airline_right_sep = ""
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#readonly#enabled = 1

" markdown vim mode
let g:vim_markdown_folding_disabled = 1

" indent-guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" vim-js-indent
let g:js_indent_typescript = 1

" Coc
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <C-Space> coc#refresh()

imap <C-@> <C-Space>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)

let g:coc_global_extensions = ['coc-tailwindcss', 'coc-spell-checker', 'coc-prettier', 'coc-json', 'coc-highlight', 'coc-git', 'coc-eslint', 'coc-xml', 'coc-tsserver', 'coc-svg', 'coc-svelte', 'coc-stylelint', 'coc-sql', 'coc-markdownlint', 'coc-go', 'coc-css', 'coc-angular']

" Devicon
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1

" fzf.vim
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'border': 'left' } }
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'Normal'],
  \ 'bg+':     ['bg', 'Normal'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Normal'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nmap <Leader><Space>b :Buffers<CR>
nmap <Leader><Space>f :Files<CR>

" EasyMotion
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" vim-svelte-plugin
let g:vim_svelte_plugin_use_typescript = 1
