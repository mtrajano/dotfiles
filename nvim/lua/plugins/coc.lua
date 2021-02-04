local u = require('utils')

local cmd = vim.cmd
local api = vim.api
local fn = vim.fn

vim.g.coc_global_extensions = {
  'coc-tsserver',
  'coc-json',
  'coc-html',
  'coc-css',
  'coc-phpls',
  'coc-pyright',
  'coc-lua'
}

cmd([[ command! -nargs=0 Do call CocAction('codeAction') ]])
cmd([[ command! -nargs=0 Fold call CocAction('fold') ]])
cmd([[ command! -nargs=0 Foldc call CocAction('fold', 'comment') ]])
cmd([[ command! -nargs=0 Foldi call CocAction('fold', 'imports') ]])

local Coc = {}

Coc.show_documentation = function()
  local filetype = vim.bo.filetype
  local keywordprg = vim.o.keywordprg

  if u.contains({'vim', 'help'}, filetype) then
    fn.execute('h ' .. fn.expand('<cword>'))
  elseif api.nvim_eval('coc#rpc#ready()') then
    fn.CocActionAsync('doHover')
  else
    print('need to check this scenario')
    fn.execute('! ' ..  keywordprg .. fn.expand('<cword>'))
  end
end

-- need to fix these
Coc.ac_next = function(key)
  return fn.pumvisible() == 1 and '<C-n>' or key
end
Coc.ac_prev = function(key)
  return fn.pumvisible() == 1 and '<C-p>' or key
end

return Coc
