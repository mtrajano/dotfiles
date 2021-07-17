return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'Rigellute/rigel'
  use 'itchyny/lightline.vim'

  use 'jiangmiao/auto-pairs'
  use 'vim-test/vim-test'
  use 'benmills/vimux'
  use 'voldikss/vim-floaterm'
  use {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end
  }
  use 'mileszs/ack.vim'
  use 'romainl/vim-qf'
  use 'moll/vim-bbye'
  use {
    'dense-analysis/ale',
    ft = { 'php', 'lua' }
  }
  use {
    'AndrewRadev/splitjoin.vim',
    config = function()
      -- split join, each method call in a different line
      vim.g.splitjoin_php_method_chain_full = 1
    end
  }
  use 'gcmt/taboo.vim'
  use {
    'plasticboy/vim-markdown',
    ft = { 'markdown' }
  }
  use 'wsdjeg/vim-fetch'

  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-abolish'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-projectionist'
  use 'tpope/vim-obsession'

  use {
    'SirVer/ultisnips',
    ft = { 'php', 'python', 'vim', 'zsh' }
  }
  use {
    'honza/vim-snippets',
    ft = { 'python', 'vim', 'zsh' }
  }

  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'mhinz/vim-signify'
  use 'junegunn/gv.vim'

  use 'lambdalisue/fern.vim'
  use 'lambdalisue/fern-hijack.vim'

  -- TODO try treesitter-text-objs and get rid of most of these
  use 'wellle/targets.vim'
  use 'kana/vim-textobj-user'
  use 'kana/vim-textobj-function'
  use 'kana/vim-textobj-entire'
  use 'glts/vim-textobj-comment'
  use 'kana/vim-textobj-indent'

  -- Need this until https://github.com/neovim/neovim/issues/12587 gets resolved
  use 'antoinemadec/FixCursorHold.nvim'

  -- NVIM SPECIFIC
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'ray-x/lsp_signature.nvim'
  use 'glepnir/lspsaga.nvim'
  use {
    'nvim-telescope/telescope-frecency.nvim',
    config = function()
      require"telescope".load_extension("frecency")
    end
  }
  use 'tami5/sql.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
end)
