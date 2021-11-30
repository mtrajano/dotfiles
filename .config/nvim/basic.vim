set nocompatible

" TEST: map S to NOP until get used to cc
nnoremap S <NOP>

set mouse=nvhr

set hidden
set noswapfile
set noerrorbells
set number relativenumber
set cursorline
set nowrap
set incsearch
set ignorecase
set smartcase
set termguicolors

" spacing
" TODO: look into moving some of these to language specfic indents
set shiftround " indenting rounds to multiple of shiftwidth
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smartindent
set expandtab

" decrease timeout b/w remaps
set timeoutlen=1000
" increase cursor hold frequency
set updatetime=1000

" display realtime substitute update
set inccommand=split

" popup menu
set completeopt=menuone,noselect
set pumheight=20

" horizontal/vertical cursor padding, move cursor 1 line at a time
set sidescrolloff=10
set sidescroll=1
set scrolloff=3
set scrolljump=1
set scroll=10

" natural split positions
set splitbelow
set splitright

" undo config
set undofile " persistent undo
set undodir=$XDG_CACHE_HOME/nvim/undo

set pyxversion=3

" unset octal format from <C-a>/<C-x> binding
set nrformats-=octal

" delay macro rendering until it's done for better perf
set lazyredraw

" don't continue comment on o/O operation
set formatoptions-=o

" wildmenu options, don't automatically fill result
set wildmode=longest:full,list:full

" display hidden chars
set list
set listchars=tab:>\ ,nbsp:·

" open quickfix result in last window
set switchbuf=uselast

" NOTE: also fixes the blanklines highlight issue
set colorcolumn=120

" find nested files
set path+=**
" TODO: move this to php config file
set wildignore+=vendor/**,.git/**,node_modules/**

" =============
" NORMAL REMAPS
" =============

" TODO: remove when install vim-pencil
nnoremap <buffer> j gj
nnoremap <buffer> k gk

" disable ex-mode
nnoremap Q <nop>

" toggle quickfix
nmap <leader>q <Plug>(qf_qf_toggle)

" resource files
nnoremap <silent> <leader>ed :tabe $DOTFILES <bar> tcd $DOTFILES<cr>
nnoremap <silent> <leader>sd :source $MYVIMRC <bar> echo "reloaded"<cr>

" swap 0 and ^
nnoremap 0 ^
nnoremap ^ 0

" last buffer/window
nnoremap <leader><space> <C-^>

nnoremap Y y$
nnoremap <leader>Y ^yy

nnoremap <leader>p "0p
vnoremap <leader>p "0p

" select last pasted
nnoremap gp `[v`]

" =============
" INSERT REMAPS
" =============
" overrides copy character below
inoremap <C-e> <C-o>$
" overrides insert last character
inoremap <C-a> <C-o>^

" =============
" VISUAL REMAPS
" =============

" search under selection
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>
vnoremap . :norm .<CR>

" ===============
" TERMINAL REMAPS
" ===============

" simulate insert register in terminal mode (and fzf prompt)
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" =====================
" COMMAND ABBREVIATIONS
" =====================

cnoreabbrev bd Bd
cnoreabbrev bw Bw

" ====================
" INSERT ABBREVIATIONS
" ====================
inoreabbrev todo: TODO:
inoreabbrev note: NOTE:
inoreabbrev test: TEST:
inoreabbrev hack: TEST:
inoreabbrev fixme: FIXME:

" TODO: move these somewhere else
inoreabbrev kb KB
inoreabbrev mb MB
inoreabbrev gb GB
inoreabbrev tb TB
inoreabbrev k12 K-12

inoreabbrev vscode VSCode
inoreabbrev unretriable unretryable
inoreabbrev Unretriable Unretryable
