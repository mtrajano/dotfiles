" TODO: make these to a plugin, need to improve handling errors etc

function s:newFile(filename) abort
  exec "edit %:h/" . a:filename
endfunction

function s:copyAndEdit(filename) abort
  exec "silent !cp % %:h/" . a:filename
  exec "edit %:h/" . a:filename
endfunction

function s:deleteFile() abort
  let l:filename = expand('%')
  exec "silent Bwipeout " . l:filename
  exec "!rm " . l:filename
endfunction

" unix file helpers
command! -nargs=1 -bang Enew call s:newFile(<f-args>)
command! -nargs=1 -bang Cp call s:copyAndEdit(<f-args>)
command! -nargs=0 -bang Rm call s:deleteFile()
