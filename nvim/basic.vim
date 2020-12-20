set nocompatible

syntax enable

set hidden
set noerrorbells
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set number relativenumber
set nowrap
set noswapfile
set ignorecase
set smartcase
set incsearch
set termguicolors

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

set pyxversion=3

" ========================
" ESC REMAP (EXPERIMENTAL)
" ========================
vnoremap <nowait> kj <esc>
inoremap <nowait> kj <esc>
tnoremap <nowait> kj <esc>
cnoremap <nowait> kj <C-c>

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
nnoremap <leader>sv :source $MYVIMRC<cr>

" save/close
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :qall!<cr>

" swap 0 and ^
nnoremap 0 ^
nnoremap ^ 0

" last buffer/window
nnoremap <leader><space> <C-^>

" split remaps
nnoremap <leader><right> :vertical resize +10<cr>
nnoremap <leader><left> :vertical resize -10<cr>
nnoremap <leader>= <C-W>=

" replace last search result
nnoremap <leader>rr :%s///g<left><left>
" append to last search result
nnoremap <leader>ra :%s/<C-r>/\zs//g<left><left>
" prepend to last search result
nnoremap <leader>ri :%s/\ze<C-r>///g<left><left>

nnoremap <silent> <leader>/ :noh<cr>

" easy method navigations
nnoremap <nowait> <C-n> $]m^zt
nnoremap <nowait> <C-p> [Mzb

" jump through quickfix results
nnoremap [q :cprev<cr>
nnoremap ]q :cnext<cr>

" easier navigation through buffer history
nnoremap <nowait> <leader>n :bnext<cr>
nnoremap <nowait> <leader>p :bprev<cr>

" clipboard integreation
nnoremap <leader>y "+yiw
vnoremap <leader>y "+y

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
