-- true to turn on tracing logs for dap
local debug = false

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- Creates a beautiful debugger UI
      -- TODO: set keymappings to jump into designated window
      'rcarriga/nvim-dap-ui',

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',

      -- Installs the debug adapters for you
      -- TODO: set this up need to see docs, also need to ensure mason loads before
      -- 'williamboman/mason.nvim',
      -- 'jay-babu/mason-nvim-dap.nvim',

      -- TODO: look into this, it's not working super well, rel issue: https://github.com/jbyuki/one-small-step-for-vimkind/issues/21
      { 'jbyuki/one-small-step-for-vimkind', version = '*' },
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      if debug then
        dap.set_log_level('TRACE')
      end

      ---@diagnostic disable-next-line: missing-fields
      require('dapui').setup({
        mappings = {
          expand = '<TAB>',
        },
      })

      -- automatically open and close dapui based on dap events
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'DAP UI toggle' })

      -- TODO: enable completion in repl, this is not currently working
      -- vim.cmd([[ au FileType dap-repl lua require('dap.ext.autocompl').attach() ]])

      -- TODO: need to look at this mapping as it should be file specific
      vim.keymap.set('n', '<leader>dv', function()
        require('osv').launch({ port = 8086, log = true })
      end, { desc = 'Start debugging neovim' })
      vim.keymap.set('n', '<leader>dV', function()
        require('osv').stop()
      end, { desc = 'Stop debugging neovim' })

      vim.keymap.set('n', '<leader>dc', require('dap').continue, { desc = 'DAP continue' })
      vim.keymap.set('n', '<leader>dn', require('dap').step_over, { desc = 'DAP step over' }) -- TODO: make this an easier mapping
      vim.keymap.set('n', '<leader>di', require('dap').step_into, { desc = 'DAP step into' })
      vim.keymap.set('n', '<leader>do', require('dap').step_out, { desc = 'DAP step out' })
      vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint, { desc = 'DAP toggle breakpoint' })
      vim.keymap.set('n', '<leader>dx', function()
        require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end, { desc = 'DAP toggle conditional breakpoint' })
      vim.keymap.set('n', '<leader>dr', require('dap').repl.open, { desc = 'DAP repl open' })
      vim.keymap.set('n', '<leader>dl', require('dap').run_last, { desc = 'DAP run last' })
      vim.keymap.set('n', '<leader>dR', require('dap').restart, { desc = 'DAP restart debug session' })
      vim.keymap.set('n', '<leader>dk', require('dap').terminate, { desc = 'DAP terminate' })

      vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
      -- TODO: create new highlight group for this, right now I used the string highlight group to make it green
      vim.fn.sign_define('DapStopped', { text = '→', texthl = 'String', linehl = '', numhl = '' })

      ------------------------
      -- DAP CONFIGURATIONS --
      ------------------------

      dap.configurations.lua = {
        {
          type = 'nlua',
          request = 'attach',
          name = 'Attach to running Neovim instance',
        },
      }

      --------------------
      ---- DAP ADAPTERS --
      --------------------
      dap.adapters.nlua = function(callback, config)
        callback({ type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 })
      end
    end,
  },
}
