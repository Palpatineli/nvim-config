" folding of my html presentation files
let g:deoplete#disable_auto_complete=1
syn keyword htmlTagName contained slide header content footer
syntax region htmlFold start="<\z(p\|h\d\|i\?frame\|table\|colgroup\|thead\|tfoot\|tbody\|t[dhr]\|pre\|[diou]l\|li\|span\|div\|head\|script\|style\|blockquote\|form\)\%(\_s*\_[^/]\?>\|\_s\_[^>]*\_[^>/]>\)" end="</\z1\_s*>" fold transparent keepend extend containedin=htmlHead
syn sync fromstart
set nolist smartindent noexpandtab tabstop=4 shiftwidth=4
set foldmethod=marker
set foldmarker=<slide\>,</slide>
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
