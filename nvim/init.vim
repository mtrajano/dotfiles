let g:mapleader = "\<Space>"

call plug#begin('~/.config/nvim/plugged')

Plug 'Rigellute/rigel'

Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'vim-test/vim-test'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

if has("nvim")
  Plug 'antoinemadec/FixCursorHold.nvim'
endif

call plug#end()

source $HOME/dotfiles/nvim/basic.vim
source $HOME/dotfiles/nvim/commands.vim
source $HOME/dotfiles/nvim/theme.vim
source $HOME/dotfiles/nvim/plugins/coc.vim
source $HOME/dotfiles/nvim/plugins/fugitive.vim
source $HOME/dotfiles/nvim/plugins/nerdcommenter.vim
source $HOME/dotfiles/nvim/plugins/ultisnips.vim
source $HOME/dotfiles/nvim/plugins/fzf.vim
source $HOME/dotfiles/nvim/plugins/test.vim
source $HOME/dotfiles/nvim/plugins/fern.vim

" custom vim config for project
if filereadable(".vim.custom")
  so .vim.custom
endif
