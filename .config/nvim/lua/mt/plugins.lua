local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('onedark').load()
      vim.cmd.colorscheme('onedark')
    end,
  },

  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },

  'tversteeg/registers.nvim',
  'ojroques/vim-oscyank',

  {
    'gbprod/yanky.nvim',
    opts = {
      highlight = {
        on_put = true, -- consider turning off if annoying
        timer = 300,
      },
    },
    keys = {
      -- overwrite paste methods
      -- theres also gp and gP for YankyGPutAfter and YankyGPutBefore which I have never used (see :h gp)
      -- setting these would overwrite gp which I have set to highlight last paste
      { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' } },
      { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' } },

      -- keyring
      { '<c-p>', '<Plug>(YankyPreviousEntry)', mode = 'n' },
      { '<c-n>', '<Plug>(YankyNextEntry)', mode = 'n' },

      -- unimpaired style plugins
      { ']p', '<Plug>(YankyPutIndentAfterLinewise)', mode = 'n' },
      { '[p', '<Plug>(YankyPutIndentBeforeLinewise)', mode = 'n' },
      { ']P', '<Plug>(YankyPutIndentAfterLinewise)', mode = 'n' },
      { '[P', '<Plug>(YankyPutIndentBeforeLinewise)', mode = 'n' },

      { '>p', '<Plug>(YankyPutIndentAfterShiftRight)', mode = 'n' },
      { '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', mode = 'n' },
      { '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', mode = 'n' },
      { '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', mode = 'n' },

      { '=p', '<Plug>(YankyPutAfterFilter)', mode = 'n' },
      { '=P', '<Plug>(YankyPutBeforeFilter)', mode = 'n' },
    },
  },

  {
    'danymat/neogen',
    opts = {},
    cmd = 'Neogen',
    keys = {
      { '<leader>ga', '<cmd>Neogen<cr>' },
    },
  },

  {
    'folke/which-key.nvim',
    opts = {},
  },
  {
    'hoob3rt/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('mt.plugins.lualine')
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async', 'nvim-treesitter/nvim-treesitter' },

    config = function()
      vim.o.foldcolumn = '0' -- '1' to show fold column
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      -- TODO: see if can set up `zm` and `zr` correclty
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      require('ufo').setup()
    end,

    -- opts = {
    --   provider_selector = function()
    --     return { 'treesitter', 'indent' }
    --   end,
    -- },
  },

  ------
  -- LSP
  ------
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'neovim/nvim-lspconfig',
    },
  },

  {
    'simrat39/symbols-outline.nvim',
    keys = {
      { '<leader>o', vim.cmd.SymbolsOutline },
    },
    cmd = 'SymbolsOutline',
    opts = {},
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = false,
    config = function()
      require('ibl').setup({
        exclude = { filetypes = { 'terminal', 'nofile', 'help', 'markdown', 'text', 'fugitive' } },
      })
    end,
  },

  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle undo tree' })
    end,
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  {
    'andymass/vim-matchup',
    config = function()
      -- should help with perf issues on large files
      vim.b.matchup_matchparen_deferred = 1

      -- on cursor over only highlight the tagname and not the properties
      vim.g.matchup_matchpref = {
        html = { tagnameonly = 1 },
        liquid = { tagnameonly = 1 },
        typescriptreact = { tagnameonly = 1 },
      }
    end,
  },

  {
    'christoomey/vim-tmux-navigator',
    keys = {
      { '<C-L>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Tmux Navigate Right' } },
      { '<C-K>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Tmux Navigate Up' } },
      { '<C-J>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Tmux Navigate Down' } },
      { '<C-H>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Tmux Navigate Left' } },
    },
    config = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  },
  {
    'mileszs/ack.vim',
    event = 'VeryLazy',
  },
  {
    'romainl/vim-qf',
    config = function()
      vim.g.qf_mapping_ack_style = 1
    end,
  },
  'moll/vim-bbye',
  {
    'Wansmer/treesj',
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      {
        'gs',
        function()
          require('treesj').split()
        end,
      },
      {
        'gJ',
        function()
          require('treesj').join()
        end,
      },
    },
  },

  'tpope/vim-sleuth', -- automatically detect space issue
  'tpope/vim-repeat',
  {
    'tpope/vim-projectionist',
    config = function()
      vim.keymap.set('n', '<leader>es', vim.cmd.Esource, { desc = 'Esource' })
      vim.keymap.set('n', '<leader>et', vim.cmd.Etest, { desc = 'Etest' })
    end,
  },
  'tpope/vim-commentary', -- TODO: install the nvim version
  {
    'tpope/vim-unimpaired',
    config = function()
      -- remap [oc, ]oc, yoc which usually toggles the cursorline to toggle conceal instead which is more useful for me
      local map = vim.keymap.set
      map('n', '[oc', function()
        vim.opt_local.conceallevel = 2
      end)
      map('n', ']oc', function()
        vim.opt_local.conceallevel = 0
      end)
      map('n', 'yoc', function()
        if vim.opt_local.conceallevel:get() > 0 then
          vim.opt_local.conceallevel = 0
        else
          vim.opt_local.conceallevel = 2
        end
      end)
    end,
  },
  'tpope/vim-abolish',
  'tpope/vim-speeddating',
  'tpope/vim-obsession', -- TODO: look into replacing with recession.nvim
  'tpope/vim-scriptease',
  {
    'tpope/vim-dispatch',
    cmd = { 'Dispatch', 'Make', 'Focus', 'Start' },
    config = function()
      vim.g.dispatch_no_tmux_dispatch = 1 -- breaks zoomed panes
    end,
  },

  { 'L3MON4D3/LuaSnip', event = 'InsertEnter', dependencies = {
    'honza/vim-snippets',
  } },

  {
    'sindrets/diffview.nvim',
    config = function()
      local actions = require('diffview.actions')
      vim.keymap.set('n', '<leader>D', vim.cmd.DiffviewOpen, { desc = 'DiffviewOpen' })
      require('diffview').setup({
        keymaps = {
          file_panel = {
            ['s'] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
          },
        },
      })
    end,
  },
  {
    'tpope/vim-fugitive',
    cmd = 'G',
    config = function()
      require('mt.plugins.fugitive')
    end,
    dependencies = { 'tpope/vim-rhubarb' },
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('mt.plugins.gitsigns')
    end,
  },

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    enabled = ENABLE_SLOW_PLUGINS, -- PERF: look into this, looks like WinScroll autocmd is causing perf issues for very large files
    config = function()
      require('todo-comments').setup({})

      vim.cmd.inoreabbrev('bug:', 'BUG:')
      vim.cmd.inoreabbrev('fixme:', 'FIXME:')
      vim.cmd.inoreabbrev('hack:', 'HACK:')
      vim.cmd.inoreabbrev('info:', 'INFO:')
      vim.cmd.inoreabbrev('note:', 'NOTE:')
      vim.cmd.inoreabbrev('perf:', 'PERF:')
      vim.cmd.inoreabbrev('test:', 'TEST:')
      vim.cmd.inoreabbrev('todo:', 'TODO:')
      vim.cmd.inoreabbrev('warn:', 'WARN:')
    end,
  },

  -- TODO: try treesitter-text-objs and get rid of most of these
  -- local function install_textobj(repo)
  --   use {, repo, dependencies = { 'kana/vim-textobj-user' } }
  -- end

  -- install_textobj('kana/vim-textobj-entire')
  -- install_textobj('glts/vim-textobj-comment')
  -- TODO: can this be replace with treesitter-text-objs?
  'wellle/targets.vim',

  -- for writing
  'preservim/vim-pencil',
  'junegunn/goyo.vim',
  {
    'dkarter/bullets.vim',
    ft = { 'nofile', 'text', 'markdown' },
  },
  {
    'plasticboy/vim-markdown',
    ft = { 'markdown' },
  },
  'godlygeek/tabular',

  {
    'windwp/nvim-ts-autotag',
    opts = {
      opts = {
        enable_rename = true,
      },
    },
  },
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',
  'folke/neodev.nvim',

  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('mt.telescope')
    end,
  },
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup({
        -- TODO: this doesn't seem to be working correctly, it doesnt seem to be permanent
        -- there seems to be something (like an autocmd) bringing it back
        toggle_key = '<C-K>',
      })
    end,
  },
  {
    'j-hui/fidget.nvim',
    opts = {},
  },
  {
    'nvimdev/lspsaga.nvim',
    opts = {
      lightbulb = {
        sign = false, -- causes view to shift on every cursor move if the space is not reserved on the sign column
      },
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },

  {
    'folke/trouble.nvim',
    config = function()
      vim.keymap.set('n', '<leader>tt', function()
        vim.cmd.Trouble('diagnostics')
      end)
      vim.keymap.set('n', '<leader>to', function()
        vim.cmd.Trouble('todo')
      end)

      vim.cmd([[
        hi link TroubleSignError DiagnosticSignError
        hi link TroubleTextError DiagnosticError
        hi link TroubleSignWarning DiagnosticSignWarning
        hi link TroubleTextWarning DiagnosticWarning
      ]])
      require('trouble').setup({
        auto_fold = true,
        auto_close = true,
        signs = {
          error = '',
          warning = '',
          hint = '',
          information = '',
          other = '﫠',
        },
      })
    end,
  },

  { import = 'plugins' },
}, {
  -- colorscheme for the auto install popup
  install = { colorscheme = { 'onedark' } },
})
