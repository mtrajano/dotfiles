let g:mapleader = "\<Space>"

call plug#begin('~/.config/nvim/plugged')

Plug 'Rigellute/rigel'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
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

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

" highlighting
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

if has('nvim')
  Plug 'antoinemadec/FixCursorHold.nvim'
endif

if has('nvim-0.5')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif

Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

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
  source $HOME/dotfiles/nvim/nnvim.vim
endif

" custom vim config for project
if filereadable(".vim.custom")
  so .vim.custom
endif
