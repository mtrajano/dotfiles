function! s:SetPsr4Map(pwd)
  lua require('plugins.ultisnips').update_psr4_map(vim.api.nvim_eval('a:pwd'))
endfunction

augroup SetNamespaceMap
  autocmd!
  autocmd DirChanged * call s:SetPsr4Map(get(v:event, 'cwd', ''))
augroup END
