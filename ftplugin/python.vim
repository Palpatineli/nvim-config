" General
set foldnestmax=2
command! Undebug :%s/^\s*# debugging$\n^.*$\n//

nnoremap <space> za
vnoremap <space> zf
nnoremap <buffer> <F5> :w<CR>:!python3 %<CR>
inoremap <buffer> <F6> import pdb; pdb.set_trace()

" vimcmdline
let g:cmdline_app = {"python": "python3.8 -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()' --no-autoindent"}
let cmdline_map_start           = '<F7>'
let cmdline_map_send            = '<localleader>r'
let cmdline_map_quit            = '<F9>'
nmap <silent> <leader>R ?^##<cr>jV/^##<cr>k<Esc>:call VimCmdLineSendSelection()<CR>jj:nohl<cr>
vmap <silent> <leader>R <Esc>:call VimCmdLineSendSelection()<CR>

lua require('python_config')
nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
