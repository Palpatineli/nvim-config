hi User1 ctermfg=NONE ctermbg=251 guifg=NONE guibg=#c6c6c6 cterm=NONE gui=NONE
hi User2 ctermfg=NONE ctermbg=254 guifg=NONE guibg=#e4e4e4 cterm=NONE gui=NONE
hi User3 ctermfg=NONE ctermbg=248 guifg=NONE guibg=#a8a8a8 cterm=NONE gui=NONE

function! LSPStatus() abort
    if LanguageClient#isServerRunning()
        let l:diagnosticsDict = LanguageClient#statusLineDiagnosticsCounts()
        let stats = '歷'
        let l:errors = get(l:diagnosticsDict,'E',0)
        if l:errors != 0
            let stats .= ' ﲅ: '.l:errors
        endif
        let l:warnings = get(l:diagnosticsDict,'W',0)
        if l:warnings != 0
            let stats .= ' : '.l:warnings
        endif
        let l:informations = get(l:diagnosticsDict,'I',0)
        if l:informations != 0
            let stats .= ' : '.l:informations
        endif
        let l:hints = get(l:diagnosticsDict,'H',0)
        if l:hints != 0
            let stats .= ' : '.l:hints
        endif
        return stats
    else
        return '轢'
    endif
endfunction

function! GitStatus() abort
    let stats = FugitiveStatusline()
    if stats == ''
        return stats
    endif
    return ' '.stats[4:-2]
endfunction

set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#Visual#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#Error#%{(mode()=='R')?'\ \ REPLACE\ ':''}
set statusline+=%#WarningMsg#%{(mode()=='v')?'\ \ ISUAL\ ':''}
set statusline+=%#DiffText#%{(mode()=='c')?'\ \ COMMAND\ ':''}
set statusline+=%1*\ %{pathshorten(expand('%:p'))}%m\ %2*\ %{&fileformat}\ \|
set statusline+=\ %{GitStatus()}\ 
set statusline+=%=
set statusline+=%1*\ %p%%\ 
set statusline+=%3*\ %l:%c\ %{LSPStatus()}
