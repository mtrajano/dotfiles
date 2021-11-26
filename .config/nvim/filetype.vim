if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile composer.lock    setfiletype json
  au! BufRead,BufNewFile */git/config     setfiletype gitconfig
  au! BufRead,BufNewFile *.snippets       setfiletype snippets
  au! BufRead,BufNewFile *.tmux           setfiletype tmux
augroup END
