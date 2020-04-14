function SetupNeoterm()
    let g:neoterm_autoscroll='1'
    let g:neoterm_size=16
    nnoremap <silent> <leader>l TREPLSendLine()
    xnoremap <silent> <leader>R :<c-u>call neoterm#repl#selection()<cr>
endfunction
augroup Neoterm
    autocmd!
    autocmd FileType javascript,typescript call SetupNeoterm()
    autocmd FileType javascript,typescript nnoremap <silent> <leader>R ?^\/\*\/\*<cr>jV/^\/\*\/\*<cr>k:<c-u>call neoterm#repl#selection()<cr>nj:nohl<cr>
augroup END

