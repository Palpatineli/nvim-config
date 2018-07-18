"output as png files
map <buffer> <F5> :w<CR> :!dot -Tsvg % -o %<".svg" <CR>
