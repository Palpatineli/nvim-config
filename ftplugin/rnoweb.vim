let g:tex_fold_enabled=1
map <buffer> <F4> :w<CR>:!rubber --into=~/Desktop/temp --pdf --warn all %:r<CR>:!okular ~/Desktop/temp/%:t:r.pdf &<CR>
map <buffer> <F5> :w<CR>:!cd ~/Desktop/temp;R CMD Sweave %:p;rubber --into ~/Desktop/temp --pdf --warn all %:r<CR>:!okular ~/Desktop/temp/%:t:r.pdf &<CR>
