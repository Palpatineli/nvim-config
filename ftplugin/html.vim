" folding of my html presentation files
set nolist
set foldmethod=marker
" Set a nicer foldtext function
set foldtext=MyFoldText()
function! MyFoldText()
  let line = getline(v:foldstart+2)
  let line = substitute(line,'^\s*','    ','')
  let line = substitute(line,'</*h[1-6]>','','g')

  let n = v:foldend - v:foldstart + 1
  let info = "------" . n . " lines"
  return line . info
endfunction

" super, sub, italic and bold
vnoremap <buffer> <c-b> <Esc>`>a</b><Esc>`<i<b><Esc>
vnoremap <buffer> <c-i> <Esc>`>a</i><Esc>`<i<i><Esc>
vnoremap <buffer> <C-A-u> <Esc>`>a</sup><Esc>`<i<sup><Esc>
vnoremap <buffer> <C-u> <Esc>`>a</sub><Esc>`<i<sub><Esc>
