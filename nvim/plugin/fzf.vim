" Default :Rg command defined in fzf except it exclues the filenames from the
" results
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \    "rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1,
      \    {'options': '--delimiter : --nth 4..'}, <bang>0)

" Like the :Files command but does not ignore vcs files from .gitignore
command! -bang -nargs=? FilesAll
      \ call fzf#vim#files(
      \     <q-args>,
      \     fzf#vim#with_preview({'source': 'fd . --type f --no-ignore --hidden'}), <bang>0)

" TODO: remove preview and move to quickfix window
" TODO: either make an abbrev or command that calls help if arg is passed
" TODO: see if can pass filtered list to fzf
command! -nargs=0 H :Helptags
