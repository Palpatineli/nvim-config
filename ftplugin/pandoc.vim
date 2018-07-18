set spell
" noremap <buffer> <F4> :VoomToggle pandoc<CR> "  for Voom to work in pandoc filetype, but I am using unite-outline now
nnoremap <buffer> <F5> :w<CR>:!pandoc -s -t odt --filter pandoc-citeproc -o %<.odt %<CR>:!libreoffice -env:UserInstallation="file:///tmp/LibO_Conversion" --headless --invisible --convert-to docx %<.odt; rm %<.odt; rm -rf /tmp/LibO_Conversion<CR>
nnoremap <buffer> <F6> :w<CR>:!gpp -H % > %<-full.md<CR>:!pandoc -s -t odt --filter pandoc-citeproc -o %<.odt %<-full.md<CR>:!rm %<-full.md<CR>:!libreoffice -env:UserInstallation="file:///tmp/LibO_Conversion" --headless  --invisible --convert-to docx %<.odt; rm %<.odt; rm -rf /tmp/LibO_Conversion<CR>

let g:pandoc#syntax#conceal#use=0
let g:pandoc#after#modules#enabled=["neosnippet"]
let g:pandoc#biblio#bibs=['/home/palpatine/.pandoc/library.bib']

nnoremap <leader>o :TOC<cr>
vnoremap <buffer> <c-b> <Esc>`>a**<Esc>`<i**<Esc>
vnoremap <buffer> <c-i> <Esc>`>a_<Esc>`<i_<Esc>
vnoremap <buffer> <C-A-u> <Esc>`>a^<Esc>`<i^<Esc>
vnoremap <buffer> <C-u> <Esc>`>a~<Esc>`<i~<Esc>
