hi User1 ctermfg=NONE ctermbg=251 guifg=NONE guibg=#c6c6c6 cterm=NONE gui=NONE
hi User2 ctermfg=NONE ctermbg=254 guifg=NONE guibg=#e4e4e4 cterm=NONE gui=NONE
hi User3 ctermfg=NONE ctermbg=248 guifg=NONE guibg=#a8a8a8 cterm=NONE gui=NONE
hi User4 ctermfg=254 ctermbg=240 guifg=#e4e4e4 guibg=#585858 cterm=NONE gui=NONE

function! LSPStatus() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
        return luaeval("require('lsp-status').status()")
    endif
    return ''
endfunction

function! GitStatus() abort
    let stats = FugitiveStatusline()
    if stats == ''
        return stats
    endif
    return ' '.stats[5:-3]
endfunction

set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#Visual#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#Error#%{(mode()=='R')?'\ \ REPLACE\ ':''}
set statusline+=%#WarningMsg#%{(mode()=='v')?'\ \ ISUAL\ ':''}
set statusline+=%#DiffText#%{(mode()=='c')?'\ \ COMMAND\ ':''}
set statusline+=%1*\ %{pathshorten(expand('%:p'))}%m\ %2*
set statusline+=\ %{GitStatus()}\ 
set statusline+=%=
set statusline+=%{LSPStatus()}\ 
set statusline+=%1*\ %y\ 
set statusline+=%3*\ %p%%\ 
set statusline+=%4*\ %l:%c\ 
