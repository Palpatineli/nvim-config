let g:semshi#error_sign=v:false
au FileType python call CustomSemshiHi()
function CustomSemshiHi()
    hi semshiLocal           ctermfg=3   guifg=#906c33
    hi semshiGlobal          ctermfg=2   guifg=#4d7f43
    hi semshiImported        ctermfg=2   guifg=#4d7f43 cterm=bold gui=bold
    hi semshiParameter       ctermfg=4   guifg=#2b7ab2
    hi semshiParameterUnused ctermfg=4   guifg=#2b7ab2 cterm=underline gui=underline
    hi semshiFree            ctermfg=0   guifg=#fbffff ctermbg=6 guibg=#008483
    hi semshiBuiltin         ctermfg=1   guifg=#ae5865
    hi semshiAttribute       ctermfg=6   guifg=#008483
    hi semshiSelf            ctermfg=7   guifg=#535c65
    hi semshiUnresolved      ctermfg=5   guifg=#8f63a2 cterm=underline gui=underline
    hi semshiSelected        ctermfg=0   guifg=#fbffff ctermbg=5 guibg=#8f63a2
    hi semshiErrorChar       ctermfg=0   guifg=#fbffff ctermbg=1 guibg=#ae5865
endfunction
