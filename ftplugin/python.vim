" General
set foldnestmax=2
command! Undebug :%s/^\s*# debugging$\n^.*$\n//

nnoremap <space> za
vnoremap <space> zf
nnoremap <buffer> <F5> :w<CR>:!python3 %<CR>
inoremap <buffer> <F6> import pdb; pdb.set_trace()

" vimcmdline
nmap <silent><buffer> <F7> :call VimCmdLineStartApp()<CR>
nmap <silent><buffer> <F9> :call VimCmdLineQuit("python")<CR>
nmap <silent> <leader>R ?^##<cr>jV/^##<cr>k<Esc>:call VimCmdLineSendSelection()<CR>jj:nohl<cr>
vmap <silent> <leader>R <Esc>:call VimCmdLineSendSelection()<CR>
