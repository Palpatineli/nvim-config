" LSP {
function SetupLSC()
    let g:LanguageClient_serverCommands = {
    \ 'python': ["~/.local/share/dotnet-sdk/dotnet", "exec", '~/.local/share/python-language-server/package/Python-Language-Server-linux-x64.0.1.80/Microsoft.Python.LanguageServer.dll'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'cpp': ['clangd-7'],
    \ 'c': ['clangd-7'],
    \ 'lua': ['lua-lsp', '--config', '~/.config/lualsprc'],
    \ 'r': ['R', '--quiet', '--slave', '-e', 'languageserver::run()'],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'dot': ["dot-language-server", "--stdio"],
    \ 'css': ["css-languageserver", "--stdio"],
    \ 'scss': ["css-languageserver", "--stdio"],
    \ }
    let g:lsp_log_verbose=1

    let g:LanguageClient_autoStart = 1
    let g:LanguageClient_selectionUI = "location-list"
    let g:LanguageClient_diagnosticsEnable = 1
    let g:LanguageClient_loggingLevel = 'DEBUG'
    set formatexpr=LanguageClient_textDocument_rangeFormatting()
    nnoremap <silent> K :call LanguageClient_textDocument_hover()<cr>
    nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
    nnoremap <silent> <leader>r :call LanguageClient_textDocument_rename()<cr>
    nnoremap <silent> <F3> :call LanguageClient_textDocument_references()<cr>
    nnoremap <silent> == :call LanguageClient_textDocument_formatting()<cr>
    " Denite LSP integration {
        nnoremap <leader>O :Denite -buffer-name=references references<cr>    
    " }
    let g:LanguageClient_completionPreferTextEdit=1
    nnoremap <silent> <leader>cr :LanguageClientStop<cr>:LanguageClientStart<cr>
endfunction
au FileType rust,c,cpp,lua,r,javascript,dot,css,scss call SetupLSC()
" } LSP
