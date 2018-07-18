let tex_fold_enabled = 1
set spell
" TeX-PDF {
    let g:tex_pdf_map_keys = 0
    noremap <silent> <F5> :w<CR>:BuildAndViewTexPdf<CR>
    "noremap <silent> <F6> :w<CR>:BuildTexPdf<CR>
" }
" latex-box {
"   let LatexBox_cite_pattern = '\c\\\a*cite\a*\*\?\_\s*{'
"   let LatexBox_autojump = 1
" }

"noremap <buffer> <F5> :w<CR>:!rubber --into ~/Desktop/temp --pdf --warn all %:r<CR>:!okular ~/Desktop/temp/%:t:r.pdf &<CR>
" clean the temp folder
noremap <buffer> <F6> :!rm *.aux *.log *.bbl *.blg<CR>:!echo 'cleared the intermediate files'<CR>
vnoremap <buffer> <c-i> y:'<,'>s/\(<c-r>"\)/{\\it \1}/<CR>
vnoremap <buffer> <c-b> y:'<,'>s/\(<c-r>"\)/{\\bf \1}/<CR>
vnoremap <buffer> <c-u> y:'<,'>s/\(<c-r>"\)/\\underline{\1}/<CR>
