lua require('lsp')

hi def link LspReferenceText CursorLine
nnoremap <silent> <leader>d <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>i <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>k <cmd>lua vim.lsp.buf.signature_help()<CR>
