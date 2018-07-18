" tern_for_vim and deoplete
if exists('g:plugs["tern_for_vim"]')
    let g:tern_show_argument_hints = 'on_hold'
    let g:tern_show_signature_in_pum = 1
    setlocal omnifunc=tern#Complete
endif
nnoremap <silent> <buffer> gb :TernDef<CR>
