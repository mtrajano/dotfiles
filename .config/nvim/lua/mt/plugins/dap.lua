-- TODO: look into changing the sign for the point where the debugger currently is in, also make it green
local dap = require('dap')
local dapui = require('dapui')

local debug = false

if debug then
  dap.set_log_level('TRACE')
end

require('dapui').setup {
  mappings = {
    expand = '<TAB>',
  },
}

-- TODO: see if this is working
-- TODO: set keymappings to jump into designated window
-- automatically open and close dapui based on dap events
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

-- TODO: need to look at this mapping as it should be file specific
vim.keymap.set('n', '<leader>dd', require('osv').launch, { buffer = true, desc = 'Start debugging lua file' })

vim.keymap.set('n', '<leader>dc', require('dap').continue)
vim.keymap.set('n', '<leader>dn', require('dap').step_over)
vim.keymap.set('n', '<leader>di', require('dap').step_into)
vim.keymap.set('n', '<leader>do', require('dap').step_out)
vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint)
vim.keymap.set('n', '<leader>dx', function()
  require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)
vim.keymap.set('n', '<leader>dr', require('dap').repl.open)
vim.keymap.set('n', '<leader>dl', require('dap').run_last)
vim.keymap.set('n', '<leader>dk', require('dap').terminate)

vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

------------------------
-- DAP CONFIGURATIONS --
------------------------
dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = 'Attach to running Neovim instance',
    host = function()
      local value = vim.fn.input('Host [127.0.0.1]: ')
      if value ~= '' then
        return value
      end
      return '127.0.0.1'
    end,
    port = function()
      local val = tonumber(vim.fn.input('Port: '))
      assert(val, 'Please provide a port number')
      return val
    end,
  },
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- NOTE: For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require('dap.utils').pick_process,
  },
}

------------------
-- DAP ADAPTERS --
------------------
dap.adapters.nlua = function(callback, config)
  callback { type = 'server', host = config.host, port = config.port }
end

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { require('mason-core.path').package_prefix('node-debug2-adapter') .. '/out/src/nodeDebug.js' },
}
