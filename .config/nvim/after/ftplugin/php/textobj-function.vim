function! s:PhpSelect(object_type)
  return s:select_{a:object_type}()
endfunction

function! s:select_a()
  if getline('.') =~# '}'
    normal! k
  endif
  normal! ]M$
  let e = getpos('.')

  normal! [m
  call search(')', 'bW')
  normal! %0

  if getline(line('.')-1) =~# '*/'
    normal! [*
  endif

  normal! k

  let b = getpos('.')

  if 1 < e[1] - b[1]  " is there some code?
    return ['V', b, e]
  else
    return 0
  endif
endfunction

function! s:select_i()
  if getline('.') =~# '}'
    normal! k
  endif

  normal! ]M$
  normal! 2k
  let e = getpos('.')

  normal! [m
  normal! 2j
  let b = getpos('.')

  return ['V', b, e]
endfunction

let b:textobj_function_select = function('s:PhpSelect')
