"{ ale
    let g:ale_linters.json = ['jsonlint']
    let g:ale_fixers.json = ['fixjson']
    nnoremap <silent> <c-.> <Plug>(ale_next_wrap)
    nnoremap <silent> <c-,> <Plug>(ale_previsou_wrap)
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1
    let g:ale_open_list = 1
"}
