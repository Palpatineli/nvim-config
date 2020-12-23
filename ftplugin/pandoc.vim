set spell
nnoremap <buffer> <F6> :w<CR>:!pandoc -s -t odt --filter pandoc-citeproc -o %<.odt %<CR>:!libreoffice -env:UserInstallation="file:///tmp/LibO_Conversion" --headless --invisible --convert-to docx %<.odt; rm %<.odt; rm -rf /tmp/LibO_Conversion<CR>
nnoremap <buffer> <F7> :w<CR>:!pandoc -s -t html % > %<.html<CR>
let g:pandoc#syntax#conceal#use=0
let g:pandoc#after#modules#enabled=["neosnippet"]
let g:pandoc#biblio#bibs=['/home/palpatine/.pandoc/library.bib']

nnoremap <leader>o :TOC<cr>
vnoremap <buffer> <c-b> <Esc>`>a**<Esc>`<i**<Esc>
vnoremap <buffer> <c-i> <Esc>`>a_<Esc>`<i_<Esc>
vnoremap <buffer> <C-A-u> <Esc>`>a^<Esc>`<i^<Esc>
vnoremap <buffer> <C-u> <Esc>`>a~<Esc>`<i~<Esc>

command! SSplit :s/\([\.!?]['"]\?\) /\1\r
let g:mkdp_command_for_global=1
" let g:mkdp_browser='flatpak run org.mozilla.firefox'
nnoremap <F4> :call mkdp#util#open_preview_page()<cr>
nnoremap <F5> :call mkdp#util#stop_preview()<cr>
