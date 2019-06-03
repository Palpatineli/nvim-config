"output as png files
map <buffer> <F5> :w<CR> :!dot -Tsvg % -o %<.svg <CR>
map <buffer> <F6> :w<CR> :!neato -Tsvg % -o %<.svg <CR>
map <buffer> <F7> :w<CR> :!sfdp -Tsvg % -o %<.svg <CR>
