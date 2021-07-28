" General
set foldnestmax=2

nnoremap <buffer> <F5> :w<CR>:!python3 %<CR>
inoremap <buffer> <F6> import pdb; pdb.set_trace()

" vimcmdline
let g:cmdline_app = {"python": 'python3 -c "import IPython; IPython.terminal.ipapp.launch_new_instance()" --no-autoindent'}
packadd vimcmdline
packadd vim-python-pep8-indent
nnoremap <silent><buffer> <F7> :call VimCmdLineStartApp()<CR>
nnoremap <silent><buffer> <F9> :call VimCmdLineQuit("python")<CR>
nnoremap <silent> <leader>R ?^##<cr>jV/^##<cr>k<Esc>:call VimCmdLineSendSelection()<CR>jj:nohl<cr>
vnoremap <silent> <leader>R <Esc>:call VimCmdLineSendSelection()<CR>
