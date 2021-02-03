let g:mapleader = "\<Space>"

call plug#begin('~/.config/nvim/plugged')

Plug 'Rigellute/rigel'

Plug 'SirVer/ultisnips'
Plug 'vim-test/vim-test'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'romainl/vim-qf'
Plug 'moll/vim-bbye'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-unimpaired'

Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

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
  " Plug 'neovim/nvim-lspconfig'
endif

call plug#end()

source $HOME/dotfiles/nvim/basic.vim
source $HOME/dotfiles/nvim/commands.vim
source $HOME/dotfiles/nvim/theme.vim
source $HOME/dotfiles/nvim/plugins/coc.vim
source $HOME/dotfiles/nvim/plugins/fugitive.vim
source $HOME/dotfiles/nvim/plugins/ultisnips.vim
source $HOME/dotfiles/nvim/plugins/fzf.vim
source $HOME/dotfiles/nvim/plugins/test.vim
source $HOME/dotfiles/nvim/plugins/fern.vim
source $HOME/dotfiles/nvim/plugins/ack.vim
source $HOME/dotfiles/nvim/plugins/signifiy.vim

if has('nvim-0.5')
  lua require('init')
endif
