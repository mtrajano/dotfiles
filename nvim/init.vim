let g:mapleader = "\<Space>"

call plug#begin('~/.config/nvim/plugged')

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

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'mhinz/vim-signify'
Plug 'stsewd/fzf-checkout.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function' " Coc func object seems to be pretty hacky
Plug 'kana/vim-textobj-entire'
Plug 'glts/vim-textobj-comment'

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

source $HOME/dotfiles/nvim/basic.vim
source $HOME/dotfiles/nvim/commands.vim
source $HOME/dotfiles/nvim/theme.vim
source $HOME/dotfiles/nvim/plugins/coc.vim
source $HOME/dotfiles/nvim/plugins/fzf.vim
source $HOME/dotfiles/nvim/plugins/ultisnips.vim

lua require'plenary.reload'.reload_module('mappings')
lua require'plenary.reload'.reload_module('init')
if has('nvim-0.5')
  lua require('init')
endif
