let g:mapleader = "\<Space>"

if v:false
  profile start /tmp/startprof
  profile func *
  profile file *

  map <leader>D :<C-u>profile stop <bar> edit /tmp/startprof<cr>
endif

call plug#begin($XDG_CONFIG_HOME . '/nvim/plugged')

Plug 'Rigellute/rigel'
Plug 'itchyny/lightline.vim'

Plug 'jiangmiao/auto-pairs'
Plug 'vim-test/vim-test'
Plug 'benmills/vimux'
Plug 'voldikss/vim-floaterm'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mileszs/ack.vim'
Plug 'romainl/vim-qf'
Plug 'moll/vim-bbye'
Plug 'dense-analysis/ale', { 'for': ['php', 'lua'] }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'gcmt/taboo.vim'
Plug 'plasticboy/vim-markdown', { 'for' : 'markdown' }
Plug 'wsdjeg/vim-fetch'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-obsession' " TODO look into ignore session files and creating an alias to open vim with the session

Plug 'SirVer/ultisnips', { 'for': 'php' }
Plug 'honza/vim-snippets', { 'for': ['python', 'vim'] }

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'mhinz/vim-signify'
Plug 'junegunn/gv.vim'

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

" TODO try treesitter-text-objs and get rid of most of these
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-entire'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-indent'

" Need this until https://github.com/neovim/neovim/issues/12587 gets resolved
Plug 'antoinemadec/FixCursorHold.nvim'

" NVIM SPECIFIC
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

call plug#end()

source $XDG_CONFIG_HOME/nvim/basic.vim
source $XDG_CONFIG_HOME/nvim/commands.vim
source $XDG_CONFIG_HOME/nvim/utils/theme.vim
source $XDG_CONFIG_HOME/nvim/work.vim

lua require'plenary.reload'.reload_module('init')
lua require('init')
