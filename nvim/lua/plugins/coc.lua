local u = require('utils')

vim.g.coc_global_extensions = {
  'coc-tsserver',
  'coc-json',
  'coc-html',
  'coc-css',
  'coc-phpls',
  'coc-pyright',
  'coc-lua'
}

vim.cmd([[ command! -nargs=0 Do call CocAction('codeAction') ]])
vim.cmd([[ command! -nargs=0 Fold call CocAction('fold') ]])
vim.cmd([[ command! -nargs=0 Foldc call CocAction('fold', 'comment') ]])
vim.cmd([[ command! -nargs=0 Foldi call CocAction('fold', 'imports') ]])

local Coc = {}

Coc.show_documentation = function()
  local filetype = vim.bo.filetype

  if u.contains({'vim', 'help'}, filetype) then
    vim.cmd('execute "h " .. expand("<cword>")')
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.cmd('call CocActionAsync("doHover")')
  else
    print('need to check this scenario')
    vim.cmd('execute "!" . &keywordprg . " " . expand("<cword>")')
  end
end

-- need to fix these
Coc.ac_next = function(key)
  return vim.fn.pumvisible() == 1 and '<C-n>' or key
end
Coc.ac_prev = function(key)
  return vim.fn.pumvisible() == 1 and '<C-p>' or key
end

return Coc
