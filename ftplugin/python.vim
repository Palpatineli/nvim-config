"{ General
    set foldnestmax=2
    command! Undebug :%s/^\s*# debugging$\n^.*$\n//

    nnoremap <space> za
    vnoremap <space> zf
    nnoremap <buffer> <F5> :w<CR>:!python3 %<CR>
"}
"{ replsend
    "function! GetVisualSelection()
        "let [line_start, col_start] = getpos("'<")[1:2]
        "let [line_end, col_end] = getpos("'>")[1:2]
        "let lines = getline(line_start, line_end)
        "if len(lines) == 0
            "return ''
        "endif
        "let lines[-1] = lines[-1][: col_end - 2]
        "let lines[0] = lines[0][col_start - 1:]
        "return join(lines, '\r')
    "endfunction
    
    "augroup Terminal
        "au!
        "au TermOpen * let g:last_terminal_job_id = b:terminal_job_id
    "augroup END

    "function! REPLSend(lines)
        "call jobsend(g:last_terminal_job_id, a:lines)
    "endfunction

    "command! REPLSendSelection call REPLSend(GetVisualSelection())
    "vnoremap <silent> <leader>R :<C-U>REPLSendSelection<cr>
"}
"{ nvim-ipy
    function! IPyRunCode()
        let input_command = input('Enter Arbitrary Python Code: ')
        call IPyRun(input_command, 1)
    endfunction

    let g:ipy_set_ft = 1
    imap <silent> <C-F> <Plug>(IPy-Complete)
    vmap <silent> <leader>R  <Plug>(IPy-Run)
    map <leader>?  <Plug>(IPy-WordObjInfo)
    map <silent> <F7>  :IPython<cr>
    map <F9>  <Plug>(IPy-Terminate)
    nmap <leader>p :call IPyRunCode()<cr>
    nmap <silent> <leader>R <Plug>(IPy-RunCell)/^##<cr>j:nohl<cr>
"}
"{ iron.vim
    "syn match CellHeader "^.*## .*$"
    "let g:iron_map_defaults=0
    "let g:iron_repl_open_cmd="aboveleft split"
    "map <silent> <F7> :IronRepl<cr>
    "nmap <buffer> <leader>r <Plug>(iron-send-motion)
    "vmap <buffer> <leader>r <Plug>(iron-send-motion)
    "nmap <buffer> <leader>p <Plug>(iron-repeat-cmd)
    "map <silent> <C-B> ?^##<cr>jV/^##<cr>k<Plug>(iron-send-motion)<Plug>(iron-cr)<cr>nj:nohl<cr>
"}
"{ nvim-send-to-term
    "let g:send_disable_mapping = 1
    "vmap <leader>R <Plug>Send
    "nmap <silent> <leader>R ?^##<cr>jV/^##<cr>k<Plug>Send ?^##<cr>j:nohl<cr>
    "nmap <F7> :sp term://ptipython<cr>:SendHere ipy<cr><c-w>j
"}
