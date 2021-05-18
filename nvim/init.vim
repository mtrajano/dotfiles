let g:mapleader = "\<Space>"

if v:false
  profile start /tmp/startprof
  profile func *
  profile file *

  map <leader>D :<C-u>profile stop <bar> edit /tmp/startprof<cr>
endif

call plug#begin($XDG_CONFIG_HOME . '/nvim/plugged')

Plug 'Rigellute/rigel'

Plug 'vim-test/vim-test'
Plug 'benmills/vimux'
Plug 'voldikss/vim-floaterm'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-projectionist'
Plug 'romainl/vim-qf'
Plug 'moll/vim-bbye'
Plug 'dense-analysis/ale'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'AndrewRadev/splitjoin.vim'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'mhinz/vim-signify'
Plug 'stsewd/fzf-checkout.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'itchyny/lightline.vim'

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function' " Coc func object seems to be pretty hacky
Plug 'kana/vim-textobj-entire'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-indent'

if has('nvim')
  Plug 'antoinemadec/FixCursorHold.nvim'
endif

" remove when switch to native lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 0.4.4 plugins
" js highlighting is handled by treesitter
" lsp is handled by native lsp vs coc
if !has('nvim-0.5')
  " js highlighting
  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'maxmellon/vim-jsx-pretty'
endif

if has('nvim-0.5')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  " Plug 'neovim/nvim-lspconfig'

  " lua dev
  Plug 'nvim-lua/plenary.nvim'
endif

call plug#end()

source $XDG_CONFIG_HOME/nvim/basic.vim
source $XDG_CONFIG_HOME/nvim/commands.vim
source $XDG_CONFIG_HOME/nvim/theme.vim
source $XDG_CONFIG_HOME/nvim/plugins/coc.vim
source $XDG_CONFIG_HOME/nvim/plugins/fzf.vim
source $XDG_CONFIG_HOME/nvim/plugins/ultisnips.vim
source $XDG_CONFIG_HOME/nvim/plugins/unix.vim

lua require'plenary.reload'.reload_module('init')
if has('nvim-0.5')
  lua require('init')
endif
