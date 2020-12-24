function SetupLSC()
    let g:LanguageClient_serverCommands = {
    \ 'c': ['clangd-7'],
    \ 'cpp': ['clangd-7'],
    \ 'css': ["css-languageserver", "--stdio"],
    \ 'dot': ["dot-language-server", "--stdio"],
    \ 'html': ["html-languageserver", "--stdio"],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'json': ['vscode-json-languageserver', '--stdio'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'lua': ['lua-lsp', '--config', '~/.config/lualsprc'],
    \ 'python': ['node', '/usr/local/lib/node_modules/pyright/langserver.index.js', '--stdio'],
    \ 'r': ['R', '--quiet', '--slave', '-e', 'languageserver::run()'],
    \ 'rust': ['rust-analyser'],
    \ 'scss': ["css-languageserver", "--stdio"],
    \ 'yaml': ['yaml-language-server', '--stdio'],
    \ 'vim': ['node', '/usr/local/lib/node_modules/vim-language-server/bin/index.js', '--stdio'],
    \ }
    let g:LanguageClient_autoStart = 1
    let g:LanguageClient_selectionUI = "location-list"
    let g:LanguageClient_diagnosticsEnable = 1
    let g:LanguageClient_loggingLevel = 'DEBUG'
    let g:LanguageClient_settingsPath = "~/.config/nvim/settings.json"
    set formatexpr=LanguageClient_textDocument_rangeFormatting()
    nnoremap <silent> K :call LanguageClient#textDocument_hover()<cr>
    nnoremap <silent> gd :call LanguageClient#textDocument_definition()<cr>
    nnoremap <silent> <leader>t :call LanguageClient#textDocument_typeDefinition()<CR>
    nnoremap <silent> <leader>r :call LanguageClient#textDocument_rename()<cr>
    nnoremap <silent> <F3> :call LanguageClient#textDocument_references()<cr>
    nnoremap <silent> == :call LanguageClient_textDocument_formatting()<cr>
    nnoremap <silent> <leader>m :call LanguageClient_contextMenu()<CR>
    " Denite LSP integration {
    "   nnoremap <leader>O :Denite -buffer-name=references references<cr>    
    "   nnoremap <leader>o :Denite -buffer-name=symbols -start-filter documentSymbol<cr>
    " }
    let g:LanguageClient_completionPreferTextEdit=1
    nnoremap <silent> <leader>cr :LanguageClientStop<cr>:LanguageClientStart<cr>
endfunction
augroup LSP
    autocmd!
    autocmd FileType c,cpp,css,dot,html,javascript,typescript,lua,python,r,rust,scss,yaml,vim call SetupLSC()
augroup END

