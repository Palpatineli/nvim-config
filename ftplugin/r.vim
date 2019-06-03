"{ nvim-r
nmap <F7> <Plug>RStart
nmap <F9> <Plug>RClose
vmap <leader>R <Plug>RESendSelection
nmap <leader>R <Plug>REDSendMBlock
nmap <leader>c <Plug>RClearAll
"}
map <buffer> <F5> :w<CR> :!R CMD BATCH %<CR> :!mv %.Rout rout/<CR>
