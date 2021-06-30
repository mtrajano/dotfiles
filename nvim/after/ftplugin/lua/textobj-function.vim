function! s:LuaSelect(object_type)
  return s:select_{a:object_type}()
endfunction

let s:FIRST_TYPE_FUNCTION_PATTERNS = {
\   'begin': '\v^(local )?<function>',
\   'end': '\v^<end>',
\ }

let s:SECOND_TYPE_FUNCTION_PATTERNS = {
\   'begin': '\v^(local )?(\w|\.)+\s\=\s<function>',
\   'end': '\v^<end>',
\ }

function! s:select_a()
  norm mm
  let r = s:select_a_of(s:FIRST_TYPE_FUNCTION_PATTERNS)
  norm `m
  return r is 0 ? s:select_a_of(s:SECOND_TYPE_FUNCTION_PATTERNS) : r
endfunction


function! s:select_a_of(patterns)
  if getline('.') !~# a:patterns.end
    if searchpair(a:patterns.begin, '', a:patterns.end, 'W') <= 0
      " The cursor seems not to be placed on any function.
      return 0
    endif
  end

  normal! $
  let e = getpos('.')

  normal! 0
  call searchpair(a:patterns.begin, '', a:patterns.end, 'bW')

  let b = getpos('.')

  if b[1] != e[1] && getline('.') !~# a:patterns.end
    normal! k
    let b = getpos('.')
    return ['V', b, e]
  else
    return 0
  endif
endfunction

function! s:select_i()
  let range = s:select_a()
  if range is 0
    return 0
  endif

  let [_, ba, ea] = range
  if ea[1] - ba[1] <= 1  " The function doesn't contain any code.
    return 0
  endif

  call setpos('.', ba)
  normal! jj0
  let bi = getpos('.')
  call setpos('.', ea)
  normal! k$
  let ei = getpos('.')
  return ['V', bi, ei]
endfunction

let b:textobj_function_select = function('s:LuaSelect')
