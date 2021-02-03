set nocompatible

syntax enable

set hidden
set noerrorbells
set smartindent
set number relativenumber
set nowrap
set noswapfile
set ignorecase
set smartcase
set incsearch
set termguicolors

" spacing
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" decrease timeout b/w remaps
set timeoutlen=500

" display realtime substitute update
set inccommand=split

" horizontal/vertical cursor padding, move cursor 1 line at a time
set sidescrolloff=5
set sidescroll=1
set scrolloff=5
set scrolljump=1

" natural split positions
set splitbelow
set splitright

" undo config
set undofile " persistent undo
set undodir=$XDG_CACHE_HOME/nvim/undo

set pyxversion=3

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

" resource files
nnoremap <silent> <leader>sv :source $MYVIMRC <bar> echo "reloaded"<cr>

" save/close
nnoremap gq :q<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>Q :qall!<cr>

nnoremap <leader>DD :profile start /tmp/temp_prof <bar> :profile func * <bar> :profile file * <cr>
nnoremap <leader>Do :profile stop <bar> :e /tmp/temp_prof <cr>

" swap 0 and ^
nnoremap 0 ^
nnoremap ^ 0

" last buffer/window
nnoremap <leader><space> <C-^>

" split remaps
nnoremap <leader><right> :vertical resize +10<cr>
nnoremap <leader><left> :vertical resize -10<cr>
nnoremap <leader>= <C-W>=

" append to last search result
nnoremap <leader>ra :%s/<C-r>/\zs//g<left><left>
" prepend to last search result
nnoremap <leader>ri :%s/\ze<C-r>///g<left><left>

nnoremap <silent> <leader>/ :noh<cr>

" clipboard integreation
nnoremap <leader>y "+y
vnoremap <leader>y "+y

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
