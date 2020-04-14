" Denite
" {
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
            \ ['--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#map('_', '<C-j>', '<denite:move_to_next_line>')
    call denite#custom#map('_', '<C-k>', '<denite:move_to_previous_line>')
    au FileType denite call s:denite_settings()
    function! s:denite_settings() abort
        hi! link CursorLine Visual
        nnoremap <silent><buffer><expr> q       denite#do_map("quit")
        nnoremap <silent><buffer><expr> <Esc>   denite#do_map("quit")
        nnoremap <silent><buffer><expr> <CR>    denite#do_map("do_action")
        nnoremap <silent><buffer><expr> i       denite#do_map("open_filter_buffer")
        nnoremap <silent><buffer><expr> st      denite#do_map("do_action", "tabopen")
        nnoremap <silent><buffer><expr> sv      denite#do_map("do_action", "vsplit")
        nnoremap <silent><buffer><expr> sg      denite#do_map("do_action", "split")
        nnoremap <silent><buffer><expr> a       denite#do_map("do_action", "add")
        nnoremap <silent><buffer><expr> d       denite#do_map("do_action", "delete")
        nnoremap <silent><buffer><expr> <tab>   denite#do_map("choose_action")
    endfunction

    au FileType denite-filter call s:denite_filter_settings()
    function! s:denite_filter_settings() abort
        nnoremap <silent><buffer><expr> <Esc>   denite#do_map("quit")
        nnoremap <silent><buffer><expr> q       denite#do_map("quit")
        inoremap <silent><buffer><expr> <C-c>   denite#do_map("quit")
        nnoremap <silent><buffer><expr> <C-c>   denite#do_map("quit")
        inoremap <silent><buffer> <C-j> <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
        inoremap <silent><buffer> <C-k> <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
    endfunction

    call denite#custom#alias('source', 'file/rec/git', 'file/rec')
    call denite#custom#var('file/rec/git', 'command', ['git', 'ls-files', '--exclude-standard', ':/'])
    nnoremap <silent> <leader>f :Denite -start-filter `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>
    "hi def link MyTodo Todo
    nnoremap <leader>T :Denite -buffer-name=TODO grep:::TODO<cr>
    nnoremap <leader>a :DeniteProjectDir -start-filter tag<cr>
    nnoremap <leader>d :Denite -buffer-name=tags tag -input=`expand('<cword>')`<cr>
    nnoremap <leader>b :Denite -start-filter -buffer-name=buffer buffer<cr>
    "nnoremap <leader>o :Denite -buffer-name=outline outline<cr>
    "nnoremap <leader><c-g> :Denite -buffer-name=gitlog gitlog:all<cr>
    "nnoremap <leader>g :DeniteProjectDir -buffer-name=grep grep:::`expand('<cword>')`<cr>
    "vnoremap <leader>g y:DeniteProjectDir -buffer-name=grep grep:::`expand('<C-R>"')`<cr>
    nnoremap <leader>G :Denite -buffer-name=gitchanged gitchanged<cr>
    nnoremap <leader>y :Denite -buffer-name=yank-history neoyank<cr>
" }
" Denite-dirmark
" {
    call dirmark#set_cache_directory_path("~/Sync/backup/denite-dirmark")
    nnoremap <silent> <leader>ma :Denite -buffer-name=dirmark dirmark/add<cr>
    nnoremap <silent> <leader>ml :Denite -buffer-name=dirmark dirmark<cr>
" }

