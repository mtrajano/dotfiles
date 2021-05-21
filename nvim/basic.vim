set nocompatible
filetype plugin on

syntax enable

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
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smartindent
set expandtab

" decrease timeout b/w remaps
set timeoutlen=500

" display realtime substitute update
set inccommand=split

" horizontal/vertical cursor padding, move cursor 1 line at a time
set sidescrolloff=3
set sidescroll=1
set scrolloff=3
set scrolljump=1

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

" =============
" INSERT REMAPS
" =============

" autoindent blocks
inoremap <silent> {<cr> {<cr>}<esc>O
inoremap <silent> (<cr> (<cr>)<esc>O
inoremap <silent> [<cr> [<cr>]<esc>O

" =============
" NORMAL REMAPS
" =============

" disable ex-mode
nnoremap Q <nop>

" toggle quickfix
nmap <leader>q <Plug>(qf_qf_toggle)

" resource files
nnoremap <silent> <leader>ev :tabe $DOTFILES <bar> tcd $DOTFILES<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC <bar> echo "reloaded"<cr>

" swap 0 and ^
nnoremap 0 ^
nnoremap ^ 0

" last buffer/window
nnoremap <leader><space> <C-^>

" split remaps
nnoremap <leader><right> :vertical resize +10<cr>
nnoremap <leader><left> :vertical resize -10<cr>
nnoremap <leader>= <C-W>=

nnoremap <silent> <leader>/ :noh<cr>

" clipboard integreation
nnoremap Y y$
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "0p
vnoremap <leader>p "0p

" null register deletes
nnoremap <leader>x "_d
nnoremap <leader>xx "_dd
vnoremap <leader>x "_d

" =============
" VISUAL REMAPS
" =============

" search under selection
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

" ===============
" TERMINAL REMAPS
" ===============

" simulate insert register in terminal mode (and fzf prompt)
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" =====================
" HELPFUL ABBREVIATIONS
" =====================
inoreabbrev todo TODO
