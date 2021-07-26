set spell
nnoremap <buffer> <F6> :w<CR>:!pandoc -s -t odt --filter pandoc-citeproc -o %<.odt %<CR>:!libreoffice -env:UserInstallation="file:///tmp/LibO_Conversion" --headless --invisible --convert-to docx %<.odt; rm %<.odt; rm -rf /tmp/LibO_Conversion<CR>
nnoremap <buffer> <F7> :w<CR>:!pandoc -s -t html % > %<.html<CR>
let g:pandoc#syntax#conceal#use=0
let g:pandoc#after#modules#enabled=["neosnippet"]
let g:pandoc#biblio#bibs=['~/.pandoc/library.bib']

vnoremap <buffer> <c-b> <Esc>`>a**<Esc>`<i**<Esc>
vnoremap <buffer> <c-i> <Esc>`>a_<Esc>`<i_<Esc>
vnoremap <buffer> <C-A-u> <Esc>`>a^<Esc>`<i^<Esc>
vnoremap <buffer> <C-u> <Esc>`>a~<Esc>`<i~<Esc>

command! SSplit :s/\([\.!?]['"]\?\) /\1\r