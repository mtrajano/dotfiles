" =============
" NORMAL REMAPS
" =============

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

vnoremap > >gv
vnoremap < <gv

" ===============
" TERMINAL REMAPS
" ===============

" simulate insert register in terminal mode (and fzf prompt)
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
