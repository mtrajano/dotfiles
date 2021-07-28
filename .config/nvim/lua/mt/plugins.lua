local u = require'mt.utils'

u.nmap('<leader>I', ':PackerInstall<cr>')
u.nmap('<leader>U', ':PackerClean<cr>')

vim.cmd [[
augroup compile_onsave
  autocmd!
  autocmd BufWritePost */plugins/init.lua source <afile> | PackerCompile
augroup END
]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'Rigellute/rigel'
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require'mt.statusline'
    end
  }

  use {
    'mfussenegger/nvim-lint',
    config = function()
      require'mt.lint'.setup()
    end
  }

  use {
    'mhartington/formatter.nvim',
    config = function()
      require'mt.format'
    end
  }

  use {
    'jiangmiao/auto-pairs',
    config = function()
      vim.g.AutoPairsMapSpace = 0
    end
  }

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
  use {
    'romainl/vim-qf',
    config = function()
      vim.g.qf_mapping_ack_style = 1
    end
  }
  use 'moll/vim-bbye'
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
  use {
    'tpope/vim-dispatch',
    config = function()
      vim.g.dispatch_no_tmux_dispatch = 1 -- breaks zoomed panes
    end
  }
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
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }
  use 'junegunn/gv.vim'

  use 'lambdalisue/fern.vim'
  use 'lambdalisue/fern-hijack.vim'

  -- TODO try treesitter-text-objs and get rid of most of these
  local function install_textobj(repo)
    use { repo, requires = { 'kana/vim-textobj-user' }}
  end
  install_textobj('kana/vim-textobj-function')
  install_textobj('kana/vim-textobj-entire')
  install_textobj('glts/vim-textobj-comment')
  install_textobj('kana/vim-textobj-indent')
  use 'wellle/targets.vim'

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
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'ray-x/lsp_signature.nvim'
  use 'nvim-lua/lsp-status.nvim'
  use {
    'glepnir/lspsaga.nvim',
    config = function()
      require'lspsaga'.init_lsp_saga()
    end
  }
  use { 'nvim-telescope/telescope-fzy-native.nvim' }
  use {
    'nvim-telescope/telescope-frecency.nvim',
    config = function()
      require'telescope'.load_extension('frecency')
    end,
    requires = { 'tami5/sql.nvim' }
  }
end)
