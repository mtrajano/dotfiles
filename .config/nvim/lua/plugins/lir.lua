local u = require 'mt.utils'
local actions = require 'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require 'lir.clipboard.actions'
local lir = require 'lir'

local cmd = vim.cmd

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


lir.setup {
  show_hidden_files = false,
  devicons_enable = true,
  mappings = {
    ['q'] = actions.quit,

    ['l'] = actions.edit,
    ['h'] = actions.up,
    ['d'] = actions.delete,
    ['r'] = actions.rename,

    ['y'] = clipboard_actions.copy,
    ['x'] = clipboard_actions.cut,
    ['p'] = clipboard_actions.paste,

    ['t'] = actions.tabedit,
    ['s'] = actions.split,
    ['v'] = actions.vsplit,

    ['K'] = actions.mkdir,
    ['N'] = actions.newfile,

    ['Y'] = actions.yank_path,

    ['.'] = actions.toggle_show_hidden,

    ['T'] = function()
      local context = lir.get_context()
      local current_context = context:current()

      cmd ('tcd ' .. current_context.fullpath)
    end,
    ['L'] = function()
      local context = lir.get_context()
      local current_context = context:current()

      cmd ('lcd ' .. current_context.fullpath)
    end,


    ['<tab>'] = function()
      mark_actions.toggle_mark()
      cmd [[ norm! j ]]
    end,
  }
}

u.nmap('<leader>hh', ':edit %:h<cr>')
