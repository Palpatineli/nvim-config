set spell
" clean the temp folder
noremap <buffer> <F6> :!rm *.aux *.log *.bbl *.blg<CR>:!echo 'cleared the intermediate files'<CR>
vnoremap <buffer> <c-i> y:'<,'>s/\(<c-r>"\)/{\\it \1}/<CR>
vnoremap <buffer> <c-b> y:'<,'>s/\(<c-r>"\)/{\\bf \1}/<CR>
vnoremap <buffer> <c-u> y:'<,'>s/\(<c-r>"\)/\\underline{\1}/<CR>
