"{ General
    set foldnestmax=2
    command! Undebug :%s/^\s*# debugging$\n^.*$\n//

    nnoremap <space> za
    vnoremap <space> zf
    nnoremap <buffer> <F5> :w<CR>:!python3 %<CR>
"}
"{ nvim-ipy
    function! IPyRunCode()
        let input_command = input('Enter Arbitrary Python Code: ')
        call IPyRun(input_command, 1)
    endfunction

    let g:ipy_set_ft = 1
    imap <silent> <C-F> <Plug>(IPy-Complete)
    map <silent> <leader>R  <Plug>(IPy-Run)
    map <leader>?  <Plug>(IPy-WordObjInfo)
    map <silent> <F7>  :IPython<cr>
    map <F9>  <Plug>(IPy-Terminate)
    nmap <leader>p :call IPyRunCode()<cr>
    nmap <silent> <C-B> <Plug>(IPy-RunCell)/^##<cr>j:nohl<cr>
    "syn match CellHeader "^.*## .*$"
    "let g:iron_map_defaults=0
    "let g:iron_repl_open_cmd="aboveleft split"
    "map <silent> <F7> :IronRepl<cr>
    "nmap <buffer> <leader>r <Plug>(iron-send-motion)
    "vmap <buffer> <leader>r <Plug>(iron-send-motion)
    "nmap <buffer> <leader>p <Plug>(iron-repeat-cmd)
    "map <silent> <C-B> ?^##<cr>jV/^##<cr>k<Plug>(iron-send-motion)<Plug>(iron-cr)<cr>nj:nohl<cr>
"}
